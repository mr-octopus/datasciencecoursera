setwd("./rprog")

rm(list=ls())
x <- c(1,3, 5) 
y <- c(3, 2, 10)
m = cbind(x, y)


rm(list=ls())
x <- list(2, "a", "b", TRUE)
foo = x[[2]]


rm(list=ls())
x <- 1:4 
y <- 2:3
x+y

rm(list=ls())
x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] = 0


rm(list=ls())
df = read.csv("data/hw1_data.csv")

str(df)
summary(df)

df[1:2,]

nrow(df)

df[c(nrow(df)-1,nrow(df)),]

df[47,]$Ozone

ozone.missing = is.na(df$Ozone)
length(df$Ozone[ozone.missing])

mean(df$Ozone[!ozone.missing])


# Extract the subset of rows of the data frame where 
# Ozone values are above 31
# Temp values are above 90. 
# What is the mean of Solar.R in this subset?


solar.sub2 = df[df$Ozone > 31 & df$Temp > 90,]$Solar.R
mean(solar.sub2[!is.na(solar.sub2)])

t = df[df$Month == 6, ]$Temp
mean(t)

#What was the maximum ozone value in the month of May (i.e. Month = 5)?
may.ozone2 = df[df$Month == 5 & !is.na(df$Ozone),]$Ozone
max(may.ozone2)
