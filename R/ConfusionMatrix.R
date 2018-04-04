### Funciones Auxiliares para el calculo
#' Confusion Matrix
#'
#' @name MC
#' @description  Confusion Matrix is a contingency table that gives a visualization of the performance of an algorithm
#'
#' @param yhat A predicted value vector.
#' @param y A real value vector.
#' @param metrics Calculate all metrics. See details for more information.
#'
#' @details
#' Also it known as an error matrix. Normally, you can identify 4 elements, they known as true positive (TP),
#' true negative (TN), false positive (FP) and false negative (FN). To understand it, a simple example is presented:
#'
#' \tabular{rcc}{ \tab Real Values \tab \cr Estimated \tab Class 1 \tab Class 2
#'   \cr Class 1 \tab TP \tab FP
#'   \cr Class 2 \tab FN \tab TN \cr }
#'
#'   The problem arises that there is not always a clear relationship between which is the positive class or
#'   there may be different classes so it is also common to use the terms Type I error (FP),
#'   Type II error (FN) and unify the success or accuracy (TP+TN) in a single value.
#'
#'   Suppose a 3x3 table with notation
#'
#' \tabular{rccc}{ \tab Real Values \tab
#' \cr Estimated \tab Class 1 \tab Class 2 \tab Class 3
#'   \cr Class 1 \tab A \tab B \tab C
#'   \cr Class 2 \tab D \tab E \tab F
#'  \cr Class 3 \tab G  \tab H \tab I \cr
#'}
#' where N = A+B+C+D+E+F+G+H+I
#'The formulas used here are:
#'  \deqn{Success rate = (A+E+I)/N}
#'  \deqn{Type I error = (B+F+C)/N}
#'  \deqn{Type II error = (D+H+G)/N}
#'
#'
#'  Other indicators depends of one class and in the case choose Class 1
#'  \deqn{Sensitivity Class 1 = A/(A+D+G)}
#'  \deqn{Specificity Class 1 = (E+I)/(B+E+H+C+F+I)}
#'  \deqn{Precision Class 1 = A/(A+E+I),}
#'  also it is called Positive Predictive Value (PPV)
#' \deqn{Prevalence Class 1 = (A+D+G)/N}
#'
#'
#'@references
#' Stehman, Stephen V. (1997). "Selecting and interpreting measures of thematic classification accuracy". Remote Sensing of Environment. 62 (1): 77–89. doi:10.1016/S0034-4257(97)00083-7.
#' @examples
#'
#' if(interactive()){
#'  # You can create a confusion Matrix like a table
#'
#'  RealValue <- c(1,0,1,0)
#'  Predicted <- c(1,1,1,0)
#'
#'  MC(y = RealValue, yhat=Predicted ,metrics=TRUE)
#'
#'
#' }
#' @export

MC <- function(yhat, y, metrics=FALSE){

  if(class(yhat)!=class(y)){
  yhat <- as.numeric(yhat)
  y <- as.numeric(y)
  }
  Real <- y
  Estimated <- yhat
   MC <-  table(Estimated,Real)
   Success_rate <- (sum(diag(MC)))/sum(MC)
   tI_error <- sum(MC[upper.tri(MC, diag = FALSE)])/sum(MC)
   tII_error <- sum(MC[lower.tri(MC, diag = FALSE)])/sum(MC)
  General_metrics <- data.frame(Success_rate=Success_rate,
                              tI_error=tI_error,
                              tII_error=tII_error)

if(metrics==TRUE){
  Real_cases <- colSums(MC)
  Sensitivity <- diag(MC)/colSums(MC)
  Prevalence <- Real_cases/sum(MC)
  Specificity_F <- function(N,Matrix){
    sum(diag(Matrix)[-N])/sum(colSums(Matrix)[-N])
  }
  Precision_F <- function(N,Matrix){
    diag(Matrix)[N]/ sum(diag(Matrix))
  }
  Specificity <- unlist(lapply(X=1:nrow(MC),FUN=Specificity_F,Matrix=MC))
  Precision <- unlist(lapply(X=1:nrow(MC),FUN=Precision_F,Matrix=MC))
  Categories <- names(Precision)
  Categorical_Metrics <- data.frame(Categories,Sensitivity,Prevalence, Specificity,Precision)
  output <- list(MC, General_metrics,Categorical_Metrics)

} else{
  output <- MC
}

  return(output)
}
