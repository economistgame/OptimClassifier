#'@importFrom "utils" "capture.output"

#' @S3method predict Optim

predict.Optim <- function(object, newdata, rankmodel=1,...)
{
  if (!inherits(object, "Optim")) stop("Not a legitimate \"Optim\" object")

  switch (object[[1]],
          "LM" = {predictlm(object, newdata,rankmodel)},
          "GLM" = {predictglm(object, newdata,rankmodel)},
          "LMM" = {predictlmm(object, newdata, rankmodel)},
          "CART"={predictcart(object, newdata,rankmodel)},
          "DA"={predictda(object, newdata,rankmodel)},
          "NN" = {predictnn(object, newdata,rankmodel)},
          "SVM" = {predictsvm(object, newdata,rankmodel)}
  )
}

## predict LM Information to show the print
predictlm <- function(x, data,rankmodel=1){
  prob_predict <- stats::predict.lm(x[[3]][[rankmodel]],newdata = data)

}

## Print GLM Information to show the print
predictglm <- function(x, data,rankmodel=1){
  stats::predict.glm(x[[3]][[rankmodel]],newdata = data)

}

predictlmm <- function(x, data,rankmodel=1){
  stop("Sorry, but this type of models are not implemented in predict function. \n
       You can predict calling:
       \n predict(Object[[3]][[1]],NewData) \n
       directly in your Terminal" )
  }
## Print CART Information to show the print
predictcart <- function(x, data,rankmodel=1){
  predict(x[[3]][[rankmodel]])

}

## Predict DA Information to show the print
predictda <- function(x, data,rankmodel=1){
  predict(x[[3]][[rankmodel]],newdata=data)

}

## Predict SVM Information to show the print
predictsvm <- function(x, data,rankmodel=1){
  predict(x[[3]][[rankmodel]], newdata=data)
}

## Predict NN Information to show the print
predictnn <- function(x, data,rankmodel=1){
  predict(x[[3]][[rankmodel]], newdata=data)
}
