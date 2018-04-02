## Functions to allow the rest of the functions


## Styles
#VersionMajor <- R.Version()$major
#VersionMinor <- R.Version()$minor

warningstyle <- crayon::make_style(WarningStyle = rgb(1,0.2,0), bg = FALSE)
errorstyle <- crayon::make_style(ErrorStyle = "red", bg = FALSE)
successstyle <- crayon::make_style(SucessStyle = rgb(0,1,0), bg = FALSE)



##Order your models
OrderModels <- function(summary_table,column, desc=FALSE){

ifelse(desc==TRUE,
         {order_summary <- dplyr::arrange(summary_table, desc(get(column)))},
                        {order_summary <- dplyr::arrange(summary_table, get(column))})
return(order_summary)
}
OrderThresholds <- function(summary_table,column){
  if(length(column)>1){
    column <- "success_rate"
  }
  switch(column,
    "success_rate"= {order_summary <- dplyr::arrange(summary_table, dplyr::desc(get(column)))},
    "ti_error" ={order_summary <- dplyr::arrange(summary_table, get(column))},
    "tii_error" ={order_summary <- dplyr::arrange(summary_table, get(column))}
  )
  return(order_summary)
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
                         ti_error=error_tI_threshold,
                         tii_error=error_tII_threshold),mc_threshold))
}

