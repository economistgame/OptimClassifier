#' Discover the best SVM for your data
#'
#' @name Optim.SVM
#' @description This function allows to find the best kernel for tune your support vector machine (SVM).
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param criteria This variable selects the criteria to select the best threshold. The default value is \code{success_rate}.
#' @param includedata logicals. If TRUE the training and testing datasets are returned.
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[e1071]{svm}}
#'
#' @return An object of class \code{Optim}. See \code{\link{Optim.object}}

#' @examples
#' if(interactive()){
#'
#' ## Load a Dataset
#' data(AustralianCredit)
#'
#' ## Generate a model
#' modelFit <- Optim.SVM(Y~., AustralianCredit, p = 0.7, seed=2018)
#' modelFit
#'
#' }
#'
#' @export
Optim.SVM <- function (formula, data,p, criteria=c("rmse","success","ti_error","tii_error"), includedata=FALSE, seed=NULL, ...){

  if (!requireNamespace("e1071", quietly = TRUE)) {
    stop(crayon::bold(crayon::red("e1071 package needed for this function to work. Please install it.")),
         call. = FALSE)
  }

  response_variable <- as.character(formula[[2]])
  data[,response_variable] <- as.numeric( data[,response_variable])

  #Using a Sample module to part data
  data <- sampler(data, p,seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)

   k <- 0
   models <- predicts <- rmse <- thresholds_tested  <- mc_threshold <- best_threshold <- list()
   thresholdsused <- seq(0,1,0.05)
   Names  <- as.numeric(names(table(as.numeric(training[ , response_variable]))))

    while(k<4){
    k <- k+1
    kernels <- list("linear","polynomial","radial","sigmoid")
    models[[k]] <- e1071::svm(formula, data = training,kernel =kernels[[k]] )
    predicts[[k]] <- predict(models[[k]],testing,type = "response")
    rmse[[k]] <- RMSE(y=testing[, response_variable], yhat =  predicts[[k]])

    results_threshold <- lapply(thresholdsused,threshold,y=testing[ , response_variable],yhat=predicts[[k]],categories=Names)
    ##Para cortar los datos de corte
    thresholds_tested[[k]] <- do.call("rbind",sapply(results_threshold, function(x) utils::head(x, 1)))
    thresholds_tested[[k]] <-  OrderThresholds(thresholds_tested[[k]], criteria)
    best_threshold[[k]] <- thresholds_tested[[k]][1,]
    ##Para sacar las matrices
    mc_threshold[[k]] <- lapply(results_threshold, function(x) utils::tail(x, 1))
  }
   summary_models <-cbind(data.frame(Kernels = unlist(kernels),
                                     rmse = unlist(rmse)),
                          do.call("rbind",best_threshold),
                          List_Position=c(1:length(unlist(rmse))))

   models_output <- OrderModels(summary_models,"rmse")
   ans <- list(Type="SVM",
              Models=models_output[,-7],
              Model=models[models_output$List_Position],
              Predict=predicts[models_output$List_Position],
              Thresholds=thresholds_tested[models_output$List_Position],
              Confussion_Matrix=mc_threshold[models_output$List_Position],
              Data=ifelse(includedata,list(training,testing),list(NULL))
   )
   class(ans) <- "Optim"
   return(ans)

}
