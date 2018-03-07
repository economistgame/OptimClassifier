\name{AustralianCredit}
\alias{AustralianCredit}
\docType{data}
\title{
Australian Credit}
\description{
This dataset concerns credit card applications and represent positive and negative instances of people who were and were not granted credit. It has served as an important test data set for several credit-scoring algorithms. This dataset was introduced by Quinlan (1987).
}
\usage{data("AustralianCredit")}
\format{
  A data frame with 690 observations on the following 15 variables.
  \describe{
    \item{\code{X1}}{a factor with levels \code{0} and \code{1}}
    \item{\code{X2}}{a numeric vector}
    \item{\code{X3}}{a numeric vector}
    \item{\code{X4}}{a factor with 3 levels}
    \item{\code{X5}}{a factor with 14 levels}
    \item{\code{X6}}{a factor with 9 levels}
    \item{\code{X7}}{a numeric vector}
    \item{\code{X8}}{a factor with levels \code{0} and \code{1}}
    \item{\code{X9}}{a factor with levels \code{0} and \code{1}}
    \item{\code{X10}}{a numeric vector}
    \item{\code{X11}}{a factor with levels \code{0} and \code{1}}
    \item{\code{X12}}{a factor with  3 levels }
    \item{\code{X13}}{a numeric vector}
    \item{\code{X14}}{a numeric vector}
    \item{\code{Y}}{a factor with levels \code{0} and \code{1}}
  }
}
\references{
Lichman, M. (2013). UCI machine learning repository.
Quinlan,R. (1987). "Simplifying decision trees", Int J Man-Machine Studies 27, pp. 221-234.

}
\examples{
data(AustralianCredit)
## maybe str(AustralianCredit) ; plot(AustralianCredit) ...
}
\keyword{datasets}
