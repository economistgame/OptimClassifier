#' Discover what is the best random variable for your data set
#'
#' @name Optim.LMM
#' @description This function allows to find best \code{LMM} for a specific data.
#'
#' @param response A character object that contain the name of response variable about which a researcher is asking a question. \code{"Y"}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param criteria This variable selects the criteria to select the best threshold. The default value is \code{success_rate}
#' @param randomatributtecandidate a character vector, or \code{NULL}. The default value is \code{NULL},the function tests with all those categorical variables in the data. The default option is nor recommended. Because the decision must be made according to the objective of statistical modeling. But it can serve as orientation.
#' @param includedata logicals. If TRUE the training and testing datasets are returned.
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[lme4]{lmer}}
#'
#'
#' @return An object of class \code{Optim}. See \code{\link{Optim.object}}

#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#' ## Generate a model
#' modelFit <- Optim.LMM("Y", AustralianCredit, p = 0.7, seed=2018)
#' modelFit
#' }
#'
#'@importFrom "stats" "anova"

#' @export

Optim.LMM <- function(response, data,p,criteria=c("success_rate","error_ti","error_tii"),randomatributtecandidate=NULL, includedata=FALSE,seed=NULL,...)
{
  if (!requireNamespace("lme4", quietly = TRUE)) {
    stop(crayon::bold(crayon::red("lme4 package needed for this function to work. Please install it.")),
         call. = FALSE)
  }
  Variables <- colnames(data)
  Variables <- Variables[-which(Variables==response)]
  if(is.null(randomatributtecandidate)==TRUE){
    Classes <- sapply(data,class)
    randomatributtecandidate <- names(Classes[Classes=="factor"])
    randomatributtecandidate <- randomatributtecandidate[-which(randomatributtecandidate==response)]
  }
  response_variable <- response
  k <- 0
  K <- length(randomatributtecandidate)

  data <- sampler(data, p, seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)
  trainingdummy  <- model.matrix(~.,training[,-which(colnames(training)==response)])
  trainingdummy <- trainingdummy[,-1]

  testingdummy  <- model.matrix(~.,testing[,-which(colnames(testing)==response)])
  testingdummy <- testingdummy[,-1]
  thresholdsused <- seq(0,1,0.05)
  Names  <- as.numeric(names(table(as.numeric(training[ , response_variable]))))
  AIC <- BIC <- newformula <- Fixed_selected <- models <- rmse <- best_threshold <- mc_threshold <- predicts <- thresholds_tested <- mc<- list()
  k <- 0
  while(k < K){
    k <- k+1

    # Select the random
    random_selected <- randomatributtecandidate[k]
    Z <- training[,random_selected]
    Z2 <- testing[,random_selected]

    #Select the Fixed elements
    Fixed_selected[[k]] <- colnames(trainingdummy)[-grep(random_selected,colnames(trainingdummy))]

    #Create the current data
    current_data <- data.frame(Y=training[,response],trainingdummy[,Fixed_selected[[k]]], Z)
    colnames(current_data)[which(colnames(current_data)=="Z")] <- random_selected

    ## Create the formula
    newformula[[k]] <- as.formula(paste0("as.numeric(Y)~",paste0(Fixed_selected[[k]],collapse = "+"),"+(1|",random_selected,")"))

    #Create the model
    models[[k]] <- lme4::lmer(formula = newformula[[k]], data = current_data, REML=TRUE)

    #### Evaluation process ####
    AIC[[k]] <- AIC(models[[k]])
    BIC[[k]] <- BIC(models[[k]])

    current_testing <- data.frame(Y=testing[,response],testingdummy[,Fixed_selected[[k]]], Z2)
    colnames(current_testing)[which(colnames(current_testing)=="Z2")] <- random_selected
    predicts[[k]] <- predict(models[[k]],current_testing)
    rmse[[k]] <- RMSE(yhat =  predicts[[k]], y=testing[ , response_variable])

    ##Evaluar un lapply
    results_threshold <- lapply(thresholdsused,threshold,y=testing[ , response_variable], yhat=predicts[[k]], categories=Names)

    ##Para cortar los datos de corte
    thresholds_tested[[k]] <- do.call("rbind",sapply(results_threshold, function(x) utils::head(x, 1)))
    thresholds_tested[[k]] <-  OrderThresholds(thresholds_tested[[k]], criteria)
    best_threshold[[k]] <- thresholds_tested[[k]][1,]
    ##Para sacar las matrices
    mc_threshold[[k]] <- lapply(results_threshold, function(x) utils::tail(x, 1))

  }
  model_output <- data.frame(Random_Variable=randomatributtecandidate,
                             aic=unlist(AIC),bic=unlist(BIC),rmse=unlist(rmse), do.call("rbind",best_threshold),List_Position=c(1:length(AIC)))

  models_output <- OrderModels(model_output,"aic",desc=FALSE)

  ans <- list(Type="LMM",
              Models=models_output[,-9],
              Model=models[models_output$List_Position],
              Predict=predicts[models_output$List_Position],
              Thresholds=thresholds_tested[models_output$List_Position],
              Confussion_Matrixs=mc_threshold[models_output$List_Position],
              Data=NULL)

  class(ans) <- "Optim"
  ans
}

