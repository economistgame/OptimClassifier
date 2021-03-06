#' Discover the best Neural Network for your data
#'
#' @name Optim.NN
#' @description \code{Optim.NN}  function allows to find the best \code{NN}.
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p a percentage of training elements
#' @param criteria this variable selects the criteria to select the best threshold. The default value is \code{success_rate}
#' @param includedata logicals. If TRUE the training and testing datasets are returned.
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param maxhiddenlayers the high number of hidden layers for the neural network considers.
#' @param maxit the maximum allowable number of weights. There is no intrinsic limit in the code, but increasing \code{MaxNWts} will probably allow fits that are very slow and time-consuming.
#' @param MaxNWts maximum number of iterations. Default 500.
#' @param ... arguments passed to \code{\link[nnet]{nnet}}
#'
#' @return An object of class \code{Optim}. See \code{\link{Optim.object}}

#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#' ## Generate a model
#' modelFit <- Optim.NN(Y~., AustralianCredit, p = 0.7, seed=2018)
#' modelFit
#' }
#'
#'@importFrom "utils" "read.table" "write.table"
#'
#' @export
Optim.NN <- function (formula, data, p, criteria=c("success_rate","ti_error","tii_error"),includedata=FALSE,seed=NULL,maxhiddenlayers=10, maxit=500,MaxNWts=2000,...){

   if (!requireNamespace("nnet", quietly = TRUE)) {
    stop(crayon::bold(crayon::red("nnet package needed for this function to work. Please install it.")),
         call. = FALSE)
   }

  if(length(criteria)>1){
    cat(warningstyle(crayon::bold("Warning:"),"Thresholds' criteria not selected. The success rate is defined as the default. \n \n"))
  }

  response_variable <- as.character(formula[[2]])

  ###Comprobar si variable objetivo tiene 2 o más clases
  #Using a Sample module to part data
  data <- sampler(data, p,seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)
  models <- predicts <- rmse <- thresholds <- hiddenlayers <- mc_threshold <- thresholds_tested <-  best_threshold <- list()
  k <- 0

  thresholdsused <- seq(0,1,0.05)
  Names  <- as.numeric(names(table(as.numeric(training[ , response_variable]))))

  while(k<maxhiddenlayers){
    k <- k+1
    hiddenlayers[[k]] <- k
    models[[k]] <- nnet::nnet(formula= formula, data=training,size=k,maxit=maxit,MaxNWts=MaxNWts )
    predicts[[k]]<- predict(models[[k]],testing,type = "raw")
    rmse[[k]] <- RMSE(y=testing[ , response_variable], yhat =  predicts[[k]])
    results_threshold <- lapply(thresholdsused,threshold,y=testing[ , response_variable],yhat=predicts[[k]],categories=Names)

    ##Para cortar los datos de corte
    thresholds_tested[[k]] <- do.call("rbind",sapply(results_threshold, function(x) utils::head(x, 1)))
    thresholds_tested[[k]] <-  OrderThresholds(thresholds_tested[[k]], criteria)
    best_threshold[[k]] <- thresholds_tested[[k]][1,]
    ##Para sacar las matrices
    mc_threshold[[k]] <- lapply(results_threshold, function(x) utils::tail(x, 1))
    if(k > 2 && rmse[[k]]>=rmse[[k-1]] && rmse[[k-1]] >= rmse[[k-2]]){
     k <-  maxhiddenlayers+1

    }
  }


  Rank <-  dplyr::arrange(data.frame(hiddenlayers=unlist(hiddenlayers), rmse=unlist(rmse), do.call("rbind",best_threshold),List_Position=c(1:length(unlist(rmse)))),rmse)
  summary_table <- data.frame(N_hidden_layers=unlist(hiddenlayers), RMSE=unlist(rmse))

  ans <- list(Type="NN",
              Models=Rank[,-7],
              Model=models[Rank$List_Position],
              Predict=predicts[Rank$List_Position],
              Thresholds=thresholds_tested[Rank$List_Position],
              Confussion_Matrix=mc_threshold[Rank$List_Position],
              Data=ifelse(includedata,list(training,testing),list(NULL))
              )
  class(ans) <- "Optim"
  return(ans)

}
