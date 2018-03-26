\name{Microsoft}
\alias{Microsoft}
\docType{data}
\title{Daily Information Data of Microsoft}
\description{
Daily Information Data of Microsoft, 2007/01/03~2018-03-13
}
\usage{data("Microsoft")}
\format{
  A data frame with 2817 observations on the following 6 variables.
  \describe{
    \item{\code{Date}}{a Date}
    \item{\code{Y}}{a factor with levels \code{0} and \code{1}}
    \item{\code{DayWeek}}{a factor, represent the day of the week}
    \item{\code{Month}}{a factor, month}
    \item{\code{LastDay}}{a numeric vector, difference of open price and close price}
    \item{\code{PayDiv}}{a logical vector, represent when Microsoft was payed dividends}
  }
}
\source{
Yahoo Finance.
}

\examples{
data(Microsoft)

## See a general view of a dataset
summary(Microsoft)

## Plot a response variable
plot(Microsoft$Y)
}
\keyword{datasets}
