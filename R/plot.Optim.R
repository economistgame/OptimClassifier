#' @importFrom "utils" "capture.output"
#' @importFrom "ggplot2" "ggplot" "geom_col" "theme_classic" "xlab"
#' @S3method plot Optim

plot.Optim <- function(x, ...)
{
  if (!inherits(x, "Optim")) stop("Not a legitimate \"Optim\" object")

  Files <- data.frame(Model=factor(x$Models[[1]],levels = x$Models[[1]]),rmse=x$Models$rmse)
  Variable <- colnames(Files)[1]
  Files$color <- c("green",rep("darkgrey",nrow(Files)-2),"red")
  ggplot2::ggplot(Files,aes(x=get(Variable),y=rmse))+geom_col(fill=Files$color)+theme_classic()+ylab="RMSE"+switch(x[[1]],
                                                                                                       "LM" = {xlab("Transformations")},
                                                                                                       "GLM" = {xlab("Transformations")},
                                                                                                       "CART"={xlab("Models")},
                                                                                                       "DA"={xlab("Models")},
                                                                                                       "NN" = {xlab("Hidden Layers")},
                                                                                                       "SVM" = {xlab("Kernels")})


}
