
setwd("./rprog")


# ** FUNCTIONS ** 
# - Functions can be passed as arguments to other functions
# - Functions can be nested, so that you can define a function inside of another function
# - The return value of a function is the last expression in the function body to be evaluated.

# ** ARGUMENTS **
# - The formal arguments are the arguments included in the function definition
# - The formals function returns a list of all the formal arguments of a function
# - Function arguments can be missing or might have default values

#R functions arguments can be matched positionally or by name. 

# ** ARGUMENT MATCHING **
# When an argument is matched by name, it is “taken out” of the argument list and 
# the remaining unnamed arguments are matched in the order that they are listed in the function definition.

# Named arguments are useful on the command line when you have a long
# argument list and you want to use the defaults for everything except for an argument near the
# end of the list
#
# Named arguments also help if you can remember the name of the argument and not its position
# on the argument list (plotting is a good example)

# Function arguments can also be partially matched, which is useful for interactive work. The order of
# operations when given an argument is
# 1. Check for exact match for a named argument
# 2. Check for a partial match
# 3. Check for a positional match


# ** LAZY EVALUATION **
#Arguments to functions are evaluated lazily, so they are evaluated only as needed.

f <- function(a, b) {
  a^2
}
f(2)

# fails
f <- function(a, b) {
  print(a)
  print(b)
}
f(45)


# The “...” Argument

# A variable number of arguments that are usually passed on to other functions.
# Often used when extending another function and you don’t want to copy the entire argument list 
# of the original function

myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}

# Necessary when the number of arguments passed to the function cannot be known in advance.
args(paste)


# One catch with ... is that any arguments that appear after ... on the argument list must be named
# explicitly and cannot be partially matched.
args(paste)

# wrong
paste(recursive=F, "a","b")





# ** SCOPING RULES **

# Search the global environment for a symbol name matching the one requested.
# Search the namespaces of each of the packages on the search list
# The search list can be found by using the search function.


# Symbol Binding
# Binding a value to a symbol, searches
# - global environment for a symbol name matching the one requested.
# - namespaces of each of the packages on the search list
search()

searchpaths()

# Element of the search list:
# The global environment or the user’s workspace is always the first 
# base package is always the last.
# The order of the packages on the search list matters!
  

# User configurable which packages to load on startup
#
# When a user loads a package with library the namespace of that package gets put in position 2 
# of the search list (by default) and everything else gets shifted down the list.
#
# R has separate namespaces for functions and non-functions

# ** SCOPING RULES **

# - The scoping rules determine how a value is associated with a free variable in a function
# (Free variables are not formal arguments and are not local variables)
# - R uses lexical scoping or static scoping. (Not dynamic scoping.)
# - Related to the scoping rules is how R uses the search list to bind a value to a symbol

# free variable
f <- function(x, y) {
  x^2 + y / z
}

# Lexical scoping in R means that:
# - the values of free variables are searched for in the environment in which the function was defined.

# Environment
# - collection of (symbol, value) pairs
# - has parent environment
# - only environment without a parent is the empty environment

# A function + an environment = a closure or function closure

# ** LEXICAL SCOPING **
# Searching for the value for a free variable:
# 1. defined environment
# 2. parent environment
# 3. sequence of parent environments 
# 4  the top-level environment; (usually the global environment, workspace or the namespace of a package)
# 5. Empty
# 6. Error Thrown


# functions defined inside other functions
# the environment in which a function is defined is the
# body of another function!

#This function returns another function as its value.
make.power <- function(n) {
  pow <- function(x) {
    x^n
  }
  pow
}

square = make.power(2)
cube = make.power(3)


square(10)

cube(10)
          
          

# Exploring a Function Closure 
# What’s in a function’s environment?
ls(environment(cube))

get("n", environment(cube))

ls(environment(square))

get("n", environment(square))


# defined

# defining environment 

# With lexical scoping the value of y in the function g is looked up in the environment in which the
# function was defined,


# calling environment 

# With dynamic scoping, the value of y is looked up in the environment from which the function was
# called (sometimes referred to as the calling environment).

y <- 10

f <- function(x) {
  y <- 2
  y^2 + g(x)
}

g <- function(x) {
  x*y
}


f(3)
