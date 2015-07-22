
rm(list=ls())

#Q1
library(datasets)
data(iris)

summary(iris)

s = split(iris, iris$Species)

lapply(s, function(x) mean(x[, "Sepal.Length"]))

mean(s$virginica$Sepal.Length)

#Q2
#vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

apply(iris[, 1:4], 2, mean)
#Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#5.843333     3.057333     3.758000     1.199333 
 
#Q3. How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
rm(list=ls())
library(datasets)
data(mtcars)
?mtcars
summary(mtcars)

s = split(mtcars$mpg, mtcars$cyl)
sapply(s, mean)


# Q4. Continuing with the 'mtcars' dataset from the previous Question, what is the absolute difference 
# between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?

s = split(mtcars$hp, mtcars$cyl)
mean.hp = sapply(s, mean)
abs(unname( mean.hp["4"] - mean.hp["8"]))

