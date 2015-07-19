
#file header
#"Date","sulfate","nitrate","ID"
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  content = data.frame()
  for(i in id){
    padded = paste0("00",i)
    file.name = paste0(substr(padded, nchar(padded)-2, nchar(padded)),".csv")
    file.content = read.csv(paste0(directory,"/",file.name))
    content = rbind(content,file.content)        
  }  
  pollutant.missing = is.na(content[,pollutant])
  clean = content[!pollutant.missing,]
  result = mean(clean[,pollutant])
  
  return(result)
}



