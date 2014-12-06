## Kansas City R Users Group ##
## Jared Harpole 20141206 ##
## This code goes along with .pdf file ##

## clear the workspace
rm(list = ls())

## SECTION 1 Overview ##
## Code Chunk 1
x <- c(TRUE, TRUE)
typeof(x)
str(x)
class(x)
length(x)

## SECTION 2 Vectors ##
## Code Chunk 1
vec1 <- rep(NA, times = 10)
vec1
typeof(vec1)
vec1[1] <- 1.0
vec1
typeof(vec1)

## Code Chunk 2
vec1 <- c(1.0, 2.0, 3.0)
vec1
typeof(vec1)
vec2 <- c(vec1, "3.7")
vec2
typeof(vec2)

## SECTION 2 Additional Material ##
# newV <- seq(from = 1.0, to = 5.0, by = 0.1)
# typeof(newV)
# newV[1:3] <- "1"
# typeof(newV)

## SECTION 3 Matricies and Arrays ##
## Code Chunk 1
X <- matrix(data = 1:4, ncol = 2)
str(X)
class(X)
dim(X)
length(X)

## Code Chunk 2
X <- matrix(data = 1:4, ncol = 2, byrow = TRUE)
X
X <- cbind(X, c("100", "200"))
X

## Code Chunk 3
X <- matrix(data = 1:4, ncol = 2, byrow = TRUE)
X
X[1,2] <- 100
X[1,]

## Code Chunk 4
Z <- array(data = 1:27, dim = c(3, 3, 3))
str(Z)
dim(Z)
class(Z)

## Code Chunk 5
Z <- array(data = 1:27, dim = c(3, 3, 3))
Z

## SECTION3 Additional Material Matricies ##
# Y <- matrix(data = sample(1:100, 100, replace = TRUE), ncol = 10)
# dim(Y)
# str(Y)
# newCol <- seq(from = 1, to = 5, length = 10)
# Y[,1] <- newCol


## SECTION 4 Lists ##
## Code Chunk 1
test_list <- list(a = 1:3, b = letters[1:5], c = FALSE)
str(test_list)
sapply(test_list, class)

## Code Chunk 2
new_list <- list(a = list(b = list(c = 'hi')))
str(new_list)
new_list

## Code Chunk 3
#You may need to install the car package to do this
#install.packages('car', dependencies = TRUE)
library(car)
regmod <- lm(mpg ~ disp + hp, data = mtcars)
str(regmod)
## BONUS STUFF
# Let's grab the fitted values from the regmod object
# Two ways with $ or [[]]
#regmod$fitted.values
#regmod[["fitted.values"]] 

## SECTION 5 Data Frames ##
## Code Chunk 1
dat <- data.frame(V1 = 1:4, V2 = letters[3:6], V3 = gl(n = 2, k = 2, labels = c("M", "F")), stringsAsFactors = FALSE)
str(dat)
dim(dat)

## Code Chunk 2
dat <- data.frame(V1 = 1:4, V2 = letters[3:6], V3 = gl(n = 2, k = 2, labels = c("M", "F")), stringsAsFactors = FALSE)
dat
sapply(dat, class)

## Code Chunk 3
dat <- data.frame(V1 = 1:4, V2 = letters[3:6], V3 = gl(n = 2, k = 2, labels = c("M", "F")), stringsAsFactors = FALSE)
dat
sapply(dat, mean)
