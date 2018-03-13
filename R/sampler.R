#' Splitting your dataset in training and testing
#'
#' @name sampler
#' @description A training/test partition are created by \code{sampler} function.
#'
#' @param data Data frame from which all variables
#' @param p The percentage of data that goes to training, It can be expressed in either decimal fraction (such as 0.7) or percent (such as 72.12).
#' @param seed a single value, interpreted as an integer, or \code{NULL}. The default value is \code{NULL}, but for future checks of the model or models generated it is advisable to set a random seed to be able to reproduce it.

# @param output A character string. Possible values are \code{list}, \code{environment} and \code{invisible}. See details for more information.
# @param trainingname The name of training object (only with select \code{output = environment} or {invisible} )
# @param testingname The name of testing object (only with select \code{output = environment} or {invisible} )
#
#@details This function was created as an auxiliary function of the optimizing functions contained in this package.
#But the use of auxiliary functions are allowed. For this reason, there are different output options, you can use the next options:
# \code{list}: witch this option, this function returns a list,
 # \code{environment}: witch this option, this function returns a list, and write two objects (training/testing datasets) in Global Environment
 #and \code{invisible}: witch this option, this function returns a NULL, and write two objects (training/testing datasets) in Global Environment.

#' @examples
#' if(interactive()){
#' # The best way to demostrate the functionality is test the function
#'
#'
#' Sampling <- sampler(AustralianCredit,p=0.7)
# ## Now you consider to fix the random seed and write directly
# ## the training/testing objects to the Global Environment.
# sampler(SpanishCredit,p=0.55,seed=1,output="environment")
# ### or simply and the function does not return a training row used.
# sampler(SpanishCredit,p=0.55,seed=1,output="invisible")
#'
#' }
#'
#'
#' @importFrom "stats" "as.formula"  "model.matrix"
#' @export
#sampler <- function(data, p,seed=NULL, output=c("list","environment","invisible"), trainingname="training",testingname="testing"){
sampler <- function(data, p,seed=NULL){

  if(!is.null(seed)){
    set.seed(seed)
  }
  if(p>0.99){
    if(p<99.99){
      p <- p/100
    } else{
      stop(crayon::bold("p"), " must be a value between 0 and 1 or 0 and 100")
    }
  }

  sample <- sample.int(n = nrow(data), size = floor(p*nrow(data)), replace = F)
  training <- data[sample, ]
  testing  <- data[-sample, ]
# if(output=="environment" || output=="invisible"){
#   assign(x=trainingname,value = training,envir =  globalenv())
#   assign(x=testingname,value = testing,envir = globalenv())
#
# }
  # output2 <- switch(output,
  #                   list = list(Data=list(training=training,testing=testing), RowsTraining=sample),
  #                   environment =list(training=paste0("You are see the training dataset in a object called ",trainingname,"Global Environment"),testing =paste0("You are see the training dataset in a object called ",trainingname,"Global Environment"), RowsTraining=sample),
  #                   invisible="Your training and testing datasets are in the Global Environment",
  #                   default = list(Data=list(training=training,testing=testing), RowsTraining=sample)
  # )
  output2 <- list(Data=list(training=training,testing=testing), RowsTraining=sample)
  return(output2)

}
