#' Tune CART for the optimal complexity parameter
#'
#' @name Optim.CART
#' @description The complexity parameter aims to save computing time by pruning off splits that are obviously not worthwhile. This function starting with null value of \code{cp} and ranks the different possibles levels of pruning trees  find best CART for different levels of cost complexity.
#'  The main role of this parameter is to save computing time by pruning off splits that are obviously not worthwhile.
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param criteria This variable selects the criteria to select the best threshold. The default value is \code{success_rate}.
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[rpart]{rpart}}
#'
#'
#' @return An object of class \code{Optim}. See\code{\link{Optim.object}}
#'
#'@details  Classification And Regression Tree (CART) are a decision tree learning technique that produces either classification or regression trees, first introduced by
#'Breiman et al.(1984). Trees used for regression and trees used for classification have some similarities -
#'but also some differences, such as the procedure used to determine where to split.

#' @references Breiman L., Friedman J. H., Olshen R. A., and Stone, C. J. (1984) Classification and Regression Trees. Wadsworth.

#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#' ## Generate a model
#' modelFit <- Optim.CART(Y~., AustralianCredit, p = 0.7, seed=2018)
#' modelFit
#' }
#'
#'@importFrom "stats" "predict"
#' @export
Optim.CART <- function (formula, data,p,criteria=c("success_rate","ti_error","tii_error"),seed=NULL,...)
{
  #Protect if it doesn't install Rpart
  if (!requireNamespace("rpart", quietly = TRUE)) {
    stop(crayon::bold(crayon::red("rpart package needed for this function to work. Please install it.")),
         call. = FALSE)
  }

  response_variable <- as.character(formula[[2]])
  #Using a Sample module to part data
  data <- sampler(data, p,seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)
  # }
  tree <- rpart::rpart(formula = formula, data=training, na.action = rpart::na.rpart,
                       model = FALSE, x = FALSE, y =FALSE, cp= 0,...)
  orig_predict <- predict(tree,testing, type="class")
  K <- nrow(tree$cptable)-1
  k <- 0
  newtree <- newpredict <- rmse <- cp <- mc <- Success_rate <- error_tII <- error_tI <- nodes <- list()
  while(k<K){
    k <- k + 1
    cp[[k]] <- tree$cptable[K-k+1,1]
    newtree[[k]] <- rpart::prune.rpart(tree,cp = cp[[k]])
    newpredict[[k]] <- predict(newtree[[k]],testing,type = "class")
    rmse[[k]] <- RMSE(y=testing[ , response_variable], yhat =  newpredict[[k]])
    mc[[k]] <- MC(y=testing[ , response_variable], yhat =  newpredict[[k]])
    Success_rate[[k]] <- (sum(diag(mc[[k]])))/sum(mc[[k]])
    error_tI[[k]] <- sum(mc[[k]][upper.tri(mc[[k]], diag = FALSE)])/sum(mc[[k]])
    error_tII[[k]] <- sum(mc[[k]][lower.tri(mc[[k]], diag = FALSE)])/sum(mc[[k]])
    nodes[[k]] <- nrow(newtree[[k]]$frame)
  }

 SummaryTrees <- data.frame(CP=unlist(cp),
                            rmse=unlist(rmse),
                            success_rate=unlist(Success_rate),
                            ti_error=unlist(error_tI),
                            tii_error=unlist(error_tII),
                            Nnodes=unlist(nodes),
                           List_Position=c(1:length(unlist(rmse))))

 models_output <- OrderModels(SummaryTrees,"rmse",desc=FALSE)

 ans <- list(Types="CART",
             Models=SummaryTrees[,-7],
             Model=newtree[models_output$List_Position],
             Predict=newpredict[models_output$List_Position],
             Confussion_Matrixs=mc[models_output$List_Position])
 class(ans) <- "Optim"
ans

  }

