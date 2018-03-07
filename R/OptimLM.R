#' Find out what is the transformation of the response variable that best fits a classification linear model to your data
#'
#' @name Optim.LM
#' @description  \code{Optim.LM} is used to fit the best classification linear model to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when transformations are applied on the response variable. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, error type I and error type II) according to a given criterion.
#'
#' @param formula A formula of the form \code{y ~ x1 + x2 + \dots}
#' @param data Data frame from which variables specified in  \code{formula} are preferentially to be taken.
#' @param p A percentage of training elements
#' @param threshold Linear models doesn't return a class, it returns probability because of he must cut by levels.
#' @param criteria This variable selects the criteria to select the best threshold. The default value is \code{success_rate}
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.
#' @param ... arguments passed to \code{\link[stats]{lm}}
#'
#'
#' @return An object of class \code{Optim}. See\code{\link{Optim.object}}

#' @examples
#' if(interactive()){
#' ## Load a Dataset
#' data(AustralianCredit)
#'
#' ## Create the model
#' linearcreditscoring <- Optim.LM(Y~., AustralianCredit, p = 0.7, seed=2018)
#'
#' #See a ranking of the models tested
#' print(linearcreditscoring)
#'
#' #Access to summary of the best model
#' summary(linearcreditscoring)
#'
#' #not sure of like the best model, you can access to the all model, for example the 2nd model
#' summary(linearcreditscoring,2)
#' }
#'
#' @importFrom "nortest" "lillie.test"
#' @importFrom "car"  "dwt" "ncvTest"
#' @importFrom "clisymbols" "symbol"
#' @importFrom "stats" "rstandard"
#' @importFrom "utils"  "head"  "tail"
#'
#' @export

Optim.LM <- function (formula, data,p,threshold=NULL,criteria=c("success_rate","error_ti","error_tii"),seed=NULL,...)
{
  ###Comprobar si variable objetivo tiene 2 o más clases


  ##Optain the response variable. Ask to Senior
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
  data[,response_variable] <- as.numeric( data[,response_variable])
  data <- sampler(data, p, seed=seed)
  #Rename Training
  training <- data$Data$training
  #Rename Testing
  testing <- data$Data$testing
  #Remove list of content
  remove(data)

  ModelsTested <- list(Model_name=c("LM",
                          "LOG.LM",
                          "SQRT.LM"),
             train_formula= c(formula,
                        as.formula(paste0("log(",formula[[2]],") ~",formula[[3]])),
                        as.formula(paste0("sqrt(",formula[[2]],") ~",formula[[3]]))
              )
             )

models <- mc_threshold <- thresholds_tested <- newpredict <- rmse <- inference_posibilities <- best_threshold <- list()
thresholdsused <- seq(0,1,0.05)
Names  <- as.numeric(names(table(as.numeric(training[ , response_variable]))))

for(i in 1:length(ModelsTested$Model_name)){
  models[[i]] <- stats::lm(formula = ModelsTested$train_formula[[i]], data = training, model = FALSE, x = FALSE, y = FALSE)
  newpredict[[i]] <- predict(models[[i]],testing,type = "response")
  rmse[[i]] <- RMSE(yhat =  newpredict[[i]],y=testing[ , response_variable])
  ##Evaluar un lapply
  results_threshold <- lapply(thresholdsused,threshold,y=testing[ , response_variable],yhat=newpredict[[i]],categories=Names)

  ##Para cortar los datos de corte
  thresholds_tested[[i]] <- do.call("rbind",sapply(results_threshold, function(x) utils::head(x, 1)))
  thresholds_tested[[i]] <-  OrderThresholds(thresholds_tested[[i]], criteria)
  best_threshold[[i]] <- thresholds_tested[[i]][1,]
  ##Para sacar las matrices
  mc_threshold[[i]] <- lapply(results_threshold, function(x) utils::tail(x, 1))
  # normality_error_test <- nortest::lillie.test(rstandard(  models[[i]]))
  #
  # if(normality_error_test$statistic>normality_error_test$p.value){
  #   Normaltest <- clisymbols::symbol$tick
  # } else {
  #   Normaltest <- clisymbols::symbol$warning
  # }
  # breusch_pagan <- lmtest::bgtest(  models[[i]]$terms,data =training)
  # #breusch_pagan <- car::ncvTest(  models[[i]],data=training)
  # if(breusch_pagan$ChiSquare<breusch_pagan$p){
  #   Heterocedasticitytest <- clisymbols::symbol$tick
  # } else {
  #   Heterocedasticitytest <- clisymbols::symbol$warning
  # }
  # #durbin_watson <- lmtest::dwtest(formula = formula, alternative="two.sided", data=training)
  # durbin_watson <- car::dwt(  models[[i]])
  # ##Error cuando p-valor es NaN o NA ¿Como resolverlo? => Considerar nuevo escenario==
  # if(durbin_watson$dw>durbin_watson$p){
  #   Independency <- clisymbols::symbol$tick
  # } else {
  #   Independency <- clisymbols::symbol$warning
  # }
  # inference_posibilities[[i]] <- data.frame(e_normality=Normaltest,
  #            heterocedasticity= Heterocedasticitytest,
  #            independency=Independency)

  }

summary_models <-cbind(data.frame(Model = ModelsTested$Model_name,
                                  rmse = unlist(rmse)),
                       do.call("rbind",best_threshold),
                       List_Position=c(1:length(unlist(rmse))))

models_output <- OrderModels(summary_models,"rmse",desc=FALSE)
ans <- list(Type="LM",
            Models=models_output[,-7],
            Model=models[models_output$List_Position],
            Predict=newpredict[models_output$List_Position],
            Thresholds=thresholds_tested[models_output$List_Position],
            Confussion_Matrixs=mc_threshold[models_output$List_Position]
            )
class(ans) <- "Optim"
ans
return(ans)
}



threshold <- function(quantile,y, yhat,categories){

  current_threshold <- min(as.numeric(y)) + (max(as.numeric(y))-min(as.numeric(y)))*quantile

  CutR <- ifelse(yhat >= current_threshold, categories[2], categories[1] )
  mc_threshold <- MC(y=y, yhat =  CutR)
  Success_rate_threshold <- (sum(diag(mc_threshold)))/sum(mc_threshold)
  error_tI_threshold <- sum(mc_threshold[upper.tri(mc_threshold, diag = FALSE)])/sum(mc_threshold)
  error_tII_threshold <- sum(mc_threshold[lower.tri(mc_threshold, diag = FALSE)])/sum(mc_threshold)
  return(list(data.frame(threshold=current_threshold,
                         success_rate=Success_rate_threshold,
                         error_ti=error_tI_threshold,
                         error_tii=error_tII_threshold),
                        mc_threshold))
}

