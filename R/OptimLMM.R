#' Discover what is the best random variable for your data set
#'
#' @name Optim.LMM
#' @description This function allows to find best \code{LMM} for a specific data.
#'
#' @param response A character object that contain the name of response variable about which a researcher is asking a question. \code{"Y"}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param randomatributtecandidate a character vector, or \code{NULL}. The default value is \code{NULL},the function tests with all those categorical variables in the data. The default option is nor recommended. Because the decision must be made according to the objective of statistical modeling. But it can serve as orientation.
#' @param ... arguments passed to \code{\link[lme4]{lmer}}
#'
#'
#' @return
#'   For \code{Optim.LMM}, an object of  \code{"Optim"}. Items of interest in 3 the output are:
#'   \item{Models }{a data.frame to summary all models tested}
#'   \item{Model }{a list of the models generated from  \code{\link[lme4]{lmer}}}
#'   \item{ }{A data.frame whose content summarize the different models generated}

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

Optim.LMM <- function (response, data,randomatributtecandidate=NULL,...)
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

  trainingdummy  <- model.matrix(~.,data[,-which(colnames(data)==response)])
  trainingdummy <- trainingdummy[,-1]
  thresholdsused <- seq(0,1,0.05)
  Names  <- as.numeric(names(table(as.numeric(data[ , response_variable]))))
  AIC <- newformula <- Fixed_selected <- models <- rmse <- mc_threshold <- predicts <- thresholds_tested <- mc<- list()
  while(k < K){
    k <- k+1
    random_selected <- randomatributtecandidate[k]
    Fixed_selected[[k]] <- colnames(trainingdummy)[-grep(random_selected,colnames(trainingdummy))]
    Z <- data[,random_selected]
    current_data <- data.frame(Y=data[,response],trainingdummy[,Fixed_selected[[k]]], Z)
    colnames(current_data)[which(colnames(current_data)=="Z")] <- random_selected
    newformula[[k]] <- as.formula(paste0("as.numeric(Y)~",paste0(Fixed_selected[[k]],collapse = "+"),"+(1|",random_selected,")"))
    models[[k]] <- lme4::lmer(formula = newformula[[k]], data = current_data, REML=TRUE)
    AIC[[k]] <- AIC(models[[k]])
  }
  model_output <- data.frame(Random_Variable=randomatributtecandidate,
                           AIC=unlist(AIC),List_Position=c(1:length(AIC)))

  models_output <- OrderModels(model_output,"AIC",desc=FALSE)

  ans <- list(Types="LMM",
              Models=models_output[,-3],
              Model=models[models_output$List_Position])
  class(ans) <- "Optim"
  ans
}

