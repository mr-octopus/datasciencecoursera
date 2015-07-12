
setwd("./rprog")
#Matrices are vectors with a dimension attribute. The dimension attribute is itself an integer vector of
#length 2 (nrow, ncol)

m1 <- matrix(nrow = 2, ncol = 3)
m1
dim(m1)
attributes(m1)


# Matrices are constructed column-wise, so entries can be thought of starting in the “upper left” corner
# and running down the columns.
m2 <- matrix(1:6, nrow = 2, ncol = 3) 
m2
str(m2)

# Matrices can also be created directly from vectors by adding a dimension attribute.
m3 <- 1:10
m3

dim(m3) <- c(2, 5)
m3

 
# Matrices can be created by column-binding or row-binding with cbind() and rbind().
x <- 1:3
y <- 10:12
cbind(x, y, z=20:22)
rbind(x, y) 

# List
my.list <- list(1, "a", TRUE, 1 + 4i) 
my.list

str(my.list)


rm(list=ls())

# Factors are used to represent categorical data. Factors can be unordered or ordered. One can think
# of a factor as an integer vector where each integer has a label.

f <- factor(c("yes", "yes", "no", "yes", "no"))
f
table(f)
unclass(f)


attributes(f)
str(f)

# The order of the levels can be set using the levels argument to factor(). This can be important
# in linear modelling because the first level is used as the baseline level.
f2 <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))
f2



#Vectorized Matrix Operations
x <- matrix(1:4, 2, 2); 
y <- matrix(rep(10, 4), 2, 2)

## element-wise multiplication
x * y       

x / y

x %*% y     ## true matrix multiplication


rm(list=ls())


# dput-ting R Objects dput-ting R Objects
# Deparsing the R object with dput and reading it back in using dget.
y <- data.frame(a = 1, b = "a")
dput(y)

dput(y, file = "data/y.R")
new.y <- dget("data/y.R")
new.y


# Dumping R Objects Dumping R Objects
# Multiple objects can be deparsed using the dump function and read back in using source.
x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "data/data.R")
rm(x, y)
source("data/data.R")
y
x
