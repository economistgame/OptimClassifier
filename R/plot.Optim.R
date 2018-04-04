#' @importFrom "utils" "capture.output"
#' @importFrom "ggplot2" "ggplot" "geom_col" "theme_classic" "xlab" "aes" "ylab"
#' @S3method plot Optim

plot.Optim <- function(x, ...)
{
  if (!inherits(x, "Optim")) stop("Not a legitimate \"Optim\" object")

  Files <- data.frame(Model=factor(x$Models[[1]],levels = x$Models[[1]]),rmse=x$Models$rmse)
  Variable <- colnames(Files)[1]
  Files$color <- c("green",rep("darkgrey",nrow(Files)-2),"red")

  out <- ggplot2::ggplot(Files,aes(x=get(Variable),y=get("rmse")))
   out <- out + geom_col(fill=Files$color)
     out <- out + theme_classic()
     out <- out + ylab("RMSE")
     out <- out + switch(x[[1]],
                  "LM" = {xlab("Transformations")},
                  "LMM" = {xlab("Random Variables")},
                  "GLM" = {xlab("Transformations")},
                  "CART"={xlab("Models")},
                  "DA"={xlab("Models")},
                  "NN" = {xlab("Hidden Layers")},
                  "SVM" = {xlab("Kernels")}
           )
     return(out)


}
