## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations
## NOTE: Do not round the result!

corr <- function(directory, threshold = 0) {
  
  complete.observations = complete(directory)
  above.threshold = subset(complete.observations, complete.observations$nobs > threshold)$id  
  corr.threshold = vector(mode = "numeric", length=length(above.threshold))
  
  if(length(corr.threshold) == 0) return(corr.threshold)
    
  for(i in 1:length(above.threshold)){        
    padded = paste0("00",above.threshold[i])
    file.name.num = substr(padded, nchar(padded)-2, nchar(padded))
    file.name = paste0(file.name.num,".csv")
    file.content = read.csv(paste0(directory,"/",file.name))
    
    complete.rows = subset(file.content, !is.na(file.content$nitrate) & !is.na(file.content$sulfate))    
    corr.threshold[i] = cor(complete.rows$nitrate, complete.rows$sulfate)
  }  
  
  return(corr.threshold)    
}