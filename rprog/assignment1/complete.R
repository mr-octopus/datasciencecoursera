
complete <- function(directory, id = 1:332) {  
  complete.count = vector(mode = "integer", length = length(id))
  for(i in 1:length(id)){
    padded = paste0("00",id[i])
    file.name.num = substr(padded, nchar(padded)-2, nchar(padded))
    file.name = paste0(file.name.num,".csv")
    file.content = read.csv(paste0(directory,"/",file.name))
    complete.rows = subset(file.content, !is.na(file.content$nitrate) & !is.na(file.content$sulfate))    
    complete.count[i] = nrow(complete.rows)
  }  
  result = data.frame(id, nobs=complete.count)  
  
  return(result)  
}


complete("specdata", 1)
