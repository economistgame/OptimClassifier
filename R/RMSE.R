### Funciones Auxiliares para el calculo
#' Root Mean Square Error
#'
#' @name RMSE
#' @description RMSE is a commonly used error metric to measure the performance of regression models, but it is also possible to use it in a classification system.
#' The RMSE measures the standard deviation of the predictions from the ground-truth. This is the relationship between RMSE and classification.
#'
#'
#' @param yhat A predicted value vector
#' @param y A real value vector
#' @param type.of Type of response variable, either: \code{numeric} for the numerical response variables, \code{text} for the class response variables without growing relationship or \code{scalable} for the class response variables without growing relationship.
#'
#'@export


RMSE <- function(yhat, y, type.of=c("numeric","text","scalable")){
  ###Agregar funciones de cierre de edición
  ##Opción gráfica
  ## Conversiones, etc.
  if(is.factor(y)==TRUE && is.factor(yhat)==FALSE){
  y <- as.numeric(y)-1
  }
  if(is.factor(y)==FALSE && is.factor(yhat)==TRUE){
    yhat <- as.numeric(yhat)-1
  }
  Real <- y
  Estimated <- yhat
  rmse <- sqrt(sum((as.numeric(Estimated)-as.numeric(Real))^2)/length(Real))

  return(rmse)
}
