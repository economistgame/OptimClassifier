#'@importFrom "utils" "capture.output"

#' @S3method summary Optim

summary.Optim <- function(object, rankmodel=1, ...)
{
  if (!inherits(object, "Optim")) stop("Not a legitimate \"Optim\" object")

  switch (object[[1]],
          "LM" = {summarylm(object,rankmodel)},
          "GLM" = {summaryglm(object,rankmodel)},
          "CART"={summarycart(object,rankmodel)},
          "DA"={summaryda(object,rankmodel)},
          "NN" = {summarynn(object,rankmodel)},
          "SVM" = {summarysvm(object,rankmodel)}
  )
}

## Summary LM Information to show the print
summarylm <- function(x,rankmodel=1){
stats::summary.lm(x[[3]][[rankmodel]])
}

## Print GLM Information to show the print
summaryglm <- function(x,rankmodel=1){
  stats::summary.glm(x[[3]][[rankmodel]])

}

## Print CART Information to show the print
summarycart <- function(x,rankmodel=1){
  summary(x[[3]][[rankmodel]])

}

## Print DA Information to show the print
summaryda <- function(x,rankmodel=1){
  print(x[[3]][[rankmodel]])

}

## Print SVM Information to show the print
summarysvm <- function(x,rankmodel=1){
  summary(x[[3]][[rankmodel]])
}

## Print NN Information to show the print
summarynn <- function(x,rankmodel=1){
  summary(x[[3]][[rankmodel]])
}
