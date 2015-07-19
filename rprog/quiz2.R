cube <- function(x, n) {
  x^3
}

cube(3)


rm(list=ls())
x <- 1:10
if(x > 5) {
  x <- 0
}


rm(list=ls())
f <- function(x) {
  g <- function(y) {
    y + z
  }
  z <- 4
  x + g(x)
}

z <- 10
f(3)


rm(list=ls())
x <- 5
y <- if(x < 3) {
  NA
} else {
  10
}


rm(list=ls())
h <- function(x, y = NULL, d = 3L) {
  z <- cbind(x, d)
  if(!is.null(y))
    z <- z + y
  else
    z <- z + f
  g <- x + y / z
  if(d == 3L)
    return(g)
  g <- g + 10
  g
}

h(1)