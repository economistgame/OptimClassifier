#'@importFrom "utils" "capture.output"
#' @S3method print Optim

print.Optim <- function(x, minlength = 0L, spaces = 2L,
                        digits = getOption("digits"), ...)
{
  if (!inherits(x, "Optim")) stop("Not a legitimate \"Optim\" object")

  switch (x[[1]],
    "LM" = {info.lm(x)},
    "LMM" ={info.lmm(x)},
    "GLM" = {info.glm(x)},
    "CART"={info.cart(x)},
    "DA"={info.da(x)},
    "NN" = {info.nn(x)},
    "SVM" = {info.svm(x)}
  )
}

## Print LM Information to show the print
info.lm <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("sucessful models have been tested \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      )
  )
}

## LMM
info.lmm <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("random variables have been tested \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      )
  )
}
## Print GLM Information to show the print
info.glm <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("sucessful models have been tested and")),
      crayon::bold(nrow(x[[6]][[1]])),
      crayon::black(format("thresholds evaluated \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      ),
      format("\n")

  )
}

## Print CART Information to show the print
info.cart <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful models have been tested \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      )
  )
}

## Print DA Information to show the print
info.da <- function(x){
    cat(crayon::bold(nrow(x[[2]])),
        crayon::black(
          format("successful models have been tested \n")),
        crayon::black(
          format("\n"),
          capture.output(format(x[[2]]))
        )
    )
}

## Print SVM Information to show the print
info.svm <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful kernels have been tested \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      )
  )
}

## Print NN Information to show the print
info.nn <- function(x){
  cat(crayon::bold(nrow(x[[2]])),
      crayon::black(
        format(" models have been tested with differents levels of hidden layers \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]]))
      )
  )
}

