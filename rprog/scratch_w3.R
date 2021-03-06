setwd("./rprog")

#
# lapply: Loop over a list and evaluate a function on each element
# list, function, other args
# returns list
#

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)


x <- 1:4
lapply(x, runif)

# extra arguments
lapply(x, runif, min = 0, max = 10)

# anonymous function for extracting the first column of each matrix
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2)) 
lapply(x, function(elt) elt[,1])

#
# sapply: Same as lapply but try to simplify the result
#
# - If the result is a list where every element is length 1, then a vector is returned
# - If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.
# - If it can’t figure things out, a list is returned
#
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

sapply(x, mean)
mean(x)

#
# apply: Apply a function over the margins of an array
# - It is most often used to apply a function to the rows or columns of a matrix
# - It can be used with general arrays, e.g. taking the average of an array of matrices
# - It is not really faster than writing a loop, but it works in one line!
#

str(apply)

  
# X is an array
# MARGIN  a vector giving the subscripts which the function will be applied over. 
#   E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. 
#   Where X has named dimnames, it can be a character vector selecting dimension names.
# FUN is a function to be applied
# ... is for other arguments to be passed to FUN

x <- matrix(rnorm(200), 20, 10)

x <- matrix(1:16, 4, 2)

# each row
apply(x, 1, mean)

# each column
apply(x, 2, mean)

apply(x, 1, sum)
apply(x, 2, sum)


apply(x, 3, sum)
#Error in if (d2 == 0L) { : missing value where TRUE/FALSE needed


# col/row sums and means
# Much faster for a large matrix.
rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)


# Average matrix in an array
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean)


#
# mapply: Multivariate version of lapply
# applies a function in parallel over a set of arguments.
# 
str(mapply)

#FUN is a function to apply
#... contains arguments to apply over
#MoreArgs is a list of other arguments to FUN.
#SIMPLIFY indicates whether the result should be simplified

# simpler list creation
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
mapply(rep, 1:4, 4:1)


# Vectorizing a Function
noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2)


# Instant Vectorization
mapply(noise, 1:5, 1:5, 2)

# Same as
list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2),
     noise(5, 5, 2))

#
# tapply: Apply a function over subsets of a vector
#
str(tapply)
# X is a vector
# INDEX is a factor or a list of factors (or else they are coerced to factors)
# FUN is a function to be applied
# ... contains other arguments to be passed FUN
# simplify, should we simplify the result?

# Take group means
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f

tapply(x, f, mean)

#Take group means without simplification.
tapply(x, f, mean, simplify = FALSE)

#Find group ranges.
tapply(x, f, range)


# 
# An auxiliary function split is also useful, particularly in conjunction with lapply
# takes a vector or other objects and splits it into groups determined by a factor or list of factors.
#
str(split)

# x is a vector (or list) or data frame
# f is a factor (or coerced to one) or a list of factors
# drop indicates whether empty factors levels should be dropped

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)

#A common idiom is split followed by an lapply
lapply(split(x, f), mean)

# Splitting a Data Frame
library(datasets)
head(airquality)
summary(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))


#irquality[airquality$Month == 8 & airquality$Temp > 90, ]

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) 

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))


# Splitting on More than One Level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1

interaction(f1, f2)

#Interactions can create empty levels
str(split(x, list(f1, f2)))

#Empty levels can be dropped.
str(split(x, list(f1, f2), drop = TRUE))



# 
# Debugging
#

# message: A generic notification/diagnostic message produced by the message function;
# execution of the function continues

# warning: An indication that something is wrong but not necessarily fatal; 
# execution of the function continues; generated by the warning function

# error: An indication that a fatal problem has occurred; execution stops; produced by the stop function

# condition: A generic concept for indicating that something unexpected can occur; 
# programmers can create their own conditions
rm(list=ls())


# invisible(x)
# return values not printed when not assigned

f1 <- function(x) x
f2 <- function(x) invisible(x)
f1(1)  # prints
f2(1)  # does not

#
# Debugging Tools in R Debugging Tools in R
#

# traceback: prints out the function call stack after an error occurs; does nothing if there’s no error
mean(x)
traceback()

# debug: flags a function for “debug” mode which allows you to step through execution of a function
# one line at a time
debug(lm)
lm(y ~ x)

# browser: suspends the execution of a function wherever it is called and puts the function in
# debug mode
# trace: allows you to insert debugging code into a function a specific places
# recover: allows you to modify the error behavior so that you can browse the function call stack
options(error = recover)
read.csv("nosuchfile")

options(error = NULL)

#Debugging 
#Summary
# There are three main indications of a problem/condition: message, warning, error
# When analyzing a function with a problem, make sure you can reproduce the problem, clearly
# state your expectations and how the output differs from your expectation
# Interactive debugging tools traceback, debug, browser, trace, and recover can be used to
# find problematic code in functions
# Debugging tools are not a substitute for thinking!

