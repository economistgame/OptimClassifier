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

\item{Thresholds }{a list whose content data.frames that summarize the different thresholds tested. This component is only available in LM, GLM, NN and SVM}

\item{Confussion_Matrixs }{a data.frame whose content summarize the different models generated}

\item{Data }{a list which training and testing datasets}

\item{Inference Tests }{a data.frame with different diagnostics for models generated. It is only available in LM}

}
\keyword{methods}
