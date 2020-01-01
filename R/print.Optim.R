#' Print an Optim Object
#'
#' @name print.Optim
#' @description This function prints an Optim object. It is a method for the generic function print of class "Optim".
#'
#' @param x object of class "Optim"
#' @param plain select if you want enriched output mode (with colors and bold) or a plain output mode.
#' @param digits minimal number of significant digits.
#' @param ... further arguments passed to or from other methods.
#'
#' @importFrom "utils" "capture.output"
#' @S3method print Optim

print.Optim <- function(x, plain=FALSE,
                        digits = getOption("digits"), ...) {

  if (!inherits(x, "Optim")) stop("Not a legitimate \"Optim\" object")

  switch(x[[1]],
    "LM" = {
      info.lm(x, plain, digits)
    },
    "LMM" = {
      info.lmm(x, plain, digits)
    },
    "GLM" = {
      info.glm(x, plain, digits)
    },
    "CART" = {
      info.cart(x, plain, digits)
    },
    "DA" = {
      info.da(x, plain)
    },
    "NN" = {
      info.nn(x, plain, digits)
    },
    "SVM" = {
      info.svm(x, plain, digits)
    }
  )
}

## Print LM Information to show the print
info.lm <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful models have been tested \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]], digits = decimals),
                       format("\n"))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
    print(x[[2]], digits = decimals)
  }
}

## LMM
info.lmm <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("random variables have been tested \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]], digits = decimals))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("random variables have been tested \n"),
      format("\n")
    )
    print(x[[2]], digits = decimals)
  }
}

## Print GLM Information to show the print
info.glm <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful models have been tested and")
      ),
      crayon::bold(nrow(x[[6]][[1]])),
      crayon::black(format("thresholds evaluated \n")),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]], digits = decimals))
      ),
      format("\n")
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
    print(x[[2]], digits = decimals)
  }
}

## Print CART Information to show the print
info.cart <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful models have been tested \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]],digits=decimals))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
    print(x[[2]],digits=decimals)
  }
}

## Print DA Information to show the print
info.da <- function(x, plain=FALSE,decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful models have been tested \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]],digits=decimals))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
    print(x[[2]],digits=decimals)
  }
}

## Print SVM Information to show the print
info.svm <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format("successful kernels have been tested \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]],digits=decimals))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
    print(x[[2]],digits=decimals)
  }
}

## Print NN Information to show the print
info.nn <- function(x, plain=FALSE, decimals=getOption("digits")) {
  if (plain == FALSE) {
    cat(
      crayon::bold(nrow(x[[2]])),
      crayon::black(
        format(" models have been tested with differents levels of hidden layers \n")
      ),
      crayon::black(
        format("\n"),
        capture.output(format(x[[2]],digits=decimals))
      )
    )
  } else {
    cat(
      nrow(x[[2]]),
      format("successful models have been tested \n"),
      format("\n")
    )
   print(x[[2]],digits=decimals)
  }
}
