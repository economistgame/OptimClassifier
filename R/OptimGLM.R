#' Find out what is the error distribution and link function that best fits a classification generalized linear model to your data
#'
#' @name Optim.GLM
#' @description \code{Optim.GLM} is used to fit the best classification \code{GLM} to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when different error distribution and link function was used in the model. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, error type I and error type II) according to a given criterion.
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param criteria This variable selects the criteria to select the best threshold. The default value is \code{success_rate}
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[stats]{glm}}
#'
#'
#' @return An object of class \code{Optim}. See\code{\link{Optim.object}}

#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#'
#' ## Create the model
#' creditscoring <- Optim.GLM(Y~., AustralianCredit, p = 0.7, seed=2018)
#'
#' #See a ranking of the models tested
#' print(creditscoring)
#'
#' #Access to summary of the best model
#' summary(creditscoring)
#'
#' #not sure of like the best model, you can access to the all model, for example the 2nd model
#' summary(creditscoring,2)
#' }
#'
#'
#' @export

Optim.GLM <- function (formula, data,p,criteria=c("success_rate","error_ti","error_tii"),seed=NULL,...)
{

  #Detect Response Variable
  response_variable <- as.character(formula[[2]])

  #Detect if Response Variable have more than 2 classes
  if(length(table(data[ ,response_variable]))>2){
    stop(errorstyle(" This function has been designed for classification into two categories."))
  }

  #Detect if Response Variable have more than one class
  if(length(table(data[ ,response_variable]))==1){
    stop(errorstyle(" This function has been designed for classification into two categories, the dataset have only one category."))
  }
  if(length(criteria)>1){
    cat(warningstyle(crayon::bold("Warning:"),"Thresholds' criteria not selected. The success rate is defined as the default. \n \n"))
  }

  #Using a Sample module to part data
  data <- sampler(data, p, seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)

  #All possible options
  familyResourse <- c("binomial(logit)",
                      "binomial(probit)",
                      "binomial(cloglog)",
                      "poisson(log)",
                      "poisson",
                      "poisson(sqrt)",
                      "gaussian")
  models <- predicts <- rmse <- thresholds <-best_threshold <- cm <- description <- list()
  k <- 0
  while(k<7){
    k <- k+1
  description[[k]] <- familyResourse[k]
  res <- GLMmodel(training = training,testing = testing, formula = formula,familyR = familyResourse[k])
  models[[k]] <- res[[1]]
  predicts[[k]] <- res[[2]]
  rmse[[k]] <- res[[3]]
  thresholds[[k]] <-  OrderThresholds(res[[4]],criteria)
  best_threshold[[k]] <- thresholds[[k]][1,]
  cm[[k]] <- res[[5]]
  }
  summary_models <-cbind(data.frame(Model = unlist(description),
                              rmse = unlist(rmse)),do.call("rbind",best_threshold),List_Position=c(1:length(unlist(rmse))))
  models_output <- OrderModels(summary_models,"rmse",desc=FALSE)

  ans <- list(Type="GLM",
              Models=models_output[,-7],
              Model=models[models_output$List_Position],
              Predict=predicts[models_output$List_Position],
              RMSE=rmse[models_output$List_Position],
              Thresholds=thresholds[models_output$List_Position],
              Confussion_Matrixs=cm[models_output$List_Position])
  class(ans) <- "Optim"
  ans
return(ans)
}

#Auxiliar Function to calc GLM without information
GLMmodel <- function(training,testing, formula, familyR, ...){

  response_variable <- as.character(formula[[2]])


  switch(EXPR = familyR,
         "binomial(logit)" = {rowfamily <- stats::binomial("logit"); FamilyRow <- 0},
         "binomial(probit)" = { rowfamily <- stats::binomial("probit"); FamilyRow <- 0},
         "binomial(cloglog)" = { rowfamily <- stats::binomial("cloglog"); FamilyRow <- 0},
         "poisson(log)" = { rowfamily <- stats::poisson("log"); FamilyRow <- 1},
         "poisson" = { rowfamily <- stats::poisson("identity"); FamilyRow <- 1},
         "poisson(sqrt)" = { rowfamily <- stats::poisson("sqrt"); FamilyRow <- 1},
         "gaussian" = { rowfamily <- stats::gaussian("identity"); FamilyRow <- 1}
  )

  if(FamilyRow==1){
    training[,  response_variable] <- as.numeric(training[,  response_variable])
    testing[,  response_variable]<- as.numeric(testing[,  response_variable])
    Names  <- as.numeric(names(table(as.numeric(training[,  response_variable]))))

  } else {
    #If case have binomial mantain a factor vector
    Names <- levels(testing[,  response_variable])
  }
  Model <- (stats::glm(formula = formula, family=rowfamily,data = training, model = FALSE, x = FALSE, y = FALSE,...))

  newpredict <- predict(Model,testing,type = "response")

  rmse <- RMSE(y=testing[,  response_variable], yhat =  newpredict)

  mc_threshold <- Success_rate_threshold <- error_tI_threshold <- error_tII_threshold <- current_threshold <- list()

  thresholdsused <- seq(0,1,0.05)


  for(j in 1:length( thresholdsused ) ){
    if(FamilyRow==1){
      current_threshold[[j]] <- min(as.numeric(testing[,  response_variable])) + (max(as.numeric(testing[,  response_variable]))-min(as.numeric(testing[,  response_variable])))*thresholdsused[j]
      CutR <- ifelse(newpredict >= current_threshold[[j]], Names[2], Names[1] )

      } else {
      current_threshold[[j]] <- thresholdsused[[j]]
      CutR <- factor(ifelse(newpredict >= current_threshold[[j]], 1,0),levels=c(0,1))

}


    mc_threshold[[j]] <- MC(y=testing[,  response_variable], yhat =  CutR)
    Success_rate_threshold[[j]] <- (sum(diag(mc_threshold[[j]])))/sum(mc_threshold[[j]])
    error_tI_threshold[[j]] <- sum(mc_threshold[[j]][upper.tri(mc_threshold[[j]], diag = FALSE)])/sum(mc_threshold[[j]])
    error_tII_threshold[[j]] <- sum(mc_threshold[[j]][lower.tri(mc_threshold[[j]], diag = FALSE)])/sum(mc_threshold[[j]])
  }

  thresholds <- data.frame(Threshold=seq(0,1,0.05),
                           success_rate=unlist(Success_rate_threshold),
                           error_ti=unlist(error_tI_threshold),
                           error_tii=unlist(error_tII_threshold)
                           )

return(list(Models=Model,Predicts=newpredict,RMSEs=rmse,Thresholds=thresholds,Confussion_Matrixs=mc_threshold))
}


