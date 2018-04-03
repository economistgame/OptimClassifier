#' Discover the best Discriminant Analysis for your data
#'
#' @name Optim.DA
#' @description This function search the best Discriminant Analysis (DA) between \code{LDA} and \code{QDA}.
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param criteria Select criterion to use.
#' @param includedata logicals. If TRUE the training and testing datasets are returned.
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[MASS]{lda}} and \code{\link[MASS]{qda}}
#'
#'@details LDA and QDA are distribution-based classifiers with the assumption that data follows
#' a multivariate normal distribution.
#' LDA differs from QDA in the assumption about the class variability. LDA assumes that all classes share the same within-class covariance matrix whereas QDA allows for distinct within-class covariance matrices.
#'
#' @return An object of class \code{Optim}. See \code{\link{Optim.object}}


#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#' ## Generate a Model
#' modelFit <- Optim.DA(Y~., AustralianCredit, p = 0.7, seed=2018)
#' modelFit
#' }
#'
#' @export
Optim.DA <- function (formula, data,p, criteria=c("rmse","success_rate","ti_error","tii_error"), includedata=FALSE, seed=NULL, ...)
{
  if (!requireNamespace("MASS", quietly = TRUE)) {
    stop(crayon::bold(crayon::red("MASS package needed for this function to work. Please install it.")),
         call. = FALSE)
  }

###Comprobar si variable objetivo tiene 2 o más clases

  response_variable <- as.character(formula[[2]])
#Using a Sample module to part data
data <- sampler(data, p, seed=seed)
#Rename Training
training <- data$Data$training
#Rename Testing
testing <- data$Data$testing
#Remove list of content
remove(data)

models <- predicts <- rmse  <- cm <- errorti <- errortii <- Success_rate <- list()
models$lda <-  try(MASS::lda(formula = formula, data = training), TRUE)
#models[[1]] <-  MASS::lda(formula = formula, data = training)

models$qda <-  try(MASS::qda(formula = formula, data = training),TRUE)
#models[[2]] <-  MASS::qda(formula = formula, data = training)
#Detect_errors <- rapply(models,class)
#do.call(class,models)
Detect_errors <- lapply(models,class)

k <- 0
while(k<2){
  k <- k+1
  if(Detect_errors[[k]]=="try-error"){
    models  <- models[[-k]]
    k <- k+1
  } else {
  predicts[[k]] <- predict(models[[k]],testing)
  rmse[[k]] <- RMSE(y=testing[ , response_variable], yhat =  unlist(predicts[[k]]$class))
  cm[[k]] <- MC(y=testing[, response_variable], yhat =  predicts[[k]]$class)
  errorti[[k]] <- sum(cm[[k]][upper.tri(cm[[k]], diag = FALSE)])/sum(cm[[k]])
  errortii[[k]] <- sum(cm[[k]][lower.tri(cm[[k]], diag = FALSE)])/sum(cm[[k]])
  Success_rate[[k]] <- sum(diag(cm[[k]]))/sum(cm[[k]])
}
}
summary_models <- data.frame(Model = names(Detect_errors)[Detect_errors!="try-error"],
                             rmse = unlist(rmse),
                             success_rate = unlist(Success_rate),
                             ti_error = unlist(errorti),
                             tii_error = unlist(errortii))

order_models <- OrderModels(summary_models,criteria)

ans <- list(Type="DA",
            Models=order_models,
            Model=models,
            Predict=predicts,
            Confussion_Matrixs=cm,
            Data=ifelse(includedata,list(training,testing),list(NULL))
            )
class(ans) <- "Optim"
ans
#return(list(models,predicts,rmse,cm))


}
