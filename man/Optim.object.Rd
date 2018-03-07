\name{Optim.object}
\alias{Optim.object}

\title{
Optimized Classifier Object}
\description{
  These are objects representing different fitted models.
}
\section{Structure}{
  The following components must be included in a legitimate \code{Optim}
  object.
}
\value{

\item{Type}{character string: the method used to fit the model. At the moment the following models are implemented: \code{"LM"} (\code{\link[stats]{lm}}),
\code{"GLM"} (\code{\link[stats]{glm}}),
\code{"LMM"} (\code{\link[lme4]{lmer}}),
\code{"CART"} (\code{\link[rpart]{rpart}}),
\code{"DA"} (\code{\link[MASS]{lda}} and \code{\link[MASS]{qda}}),
\code{"NN"} (\code{\link[nnet]{nnet}})  and
\code{"SVM"} (\code{\link[e1071]{svm}}).
}
\item{Models }{a data.frame whose content summarize the different models generated, ordered for selected criterion}

\item{Model }{a list of the models generated}

\item{Predict }{a list of the predicts generated}

\item{Confussion_Matrixs }{A data.frame whose content summarize the different models generated}

}
\keyword{methods}
