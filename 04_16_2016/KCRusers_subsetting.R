## ---- cache = TRUE, comment=NA, warning=FALSE, message=FALSE-------------
### vectors
x <- c(1.1, 2.3, 4.5, 1.05, 3.9)
# using [
x[1]
x[c(2,3)]
x[order(x)]
order(x)

## ---- cache = FALSE, comment=NA, warning=FALSE, message=FALSE------------
x
### using [ with -
x[-c(1, 4)]
x[-1]



## ---- cache = FALSE, comment=NA, warning=FALSE, message=FALSE------------
## Here is a trick for multiple indices
x[-c(1:3)]


set.seed(1)
dog <- rnorm(20)
dog
dog[-c(11:20)]

dog[-c(seq(2, 20, 2))]  

## ---- cache = FALSE, comment=NA, warning=FALSE, message=FALSE------------
x
# using [ with booleans
x[c(TRUE, TRUE, FALSE, TRUE, FALSE)]
x[x > 2.5]
x > 2.5 

x[x > 2.5 | x < 1.10]

x > 2.5 | x < 1.10

## ---- cache = FALSE, comment=NA, warning=FALSE, message=FALSE------------
# using [  with characters
(y <- setNames(x, letters[1:5]))
y
y['a']
y[c('c', 'a', 'd')]


## ---- cache = TRUE, comment=NA, warning=FALSE, message=FALSE-------------
## Matrices
test <- matrix(1:16, nrow = 4)
test

## Simple integer subsetting 
test[1:2, ]
test[, 3:4]
test[c(1, 3), c(1, 2)]
test[1, ]

## ---- cache = FALSE, comment=NA, warning=FALSE, message=FALSE------------
## Can also use -
test

test[-c(1,3), -c(1,2)]

## ---- cache = TRUE, comment=NA, warning=FALSE, message=FALSE-------------
select <- matrix(c(1, 1, 1, 3, 2, 4), ncol = 2, byrow = TRUE)
select 
test 
test[select]

## ---- cache=FALSE, comment=NA, warning=FALSE, message=FALSE--------------
dimnames(test) <- list(c('r1', 'r2', 'r3', 'r4'), 
                       c('c1', 'c2', 'c3', 'c4'))
test
test[, 'c1']

test[test[, 'c1'] > 2 & test[, 'c2'] < 10, ]

## ---- cache=TRUE, comment=NA, warning=FALSE, message=FALSE---------------
#vectors behind the scenes in column major form
test
test[1,2]
test[5]
as.vector(test)

## ---- cache=TRUE, comment=NA, warning=FALSE, message=FALSE---------------
## Data frames
df <- data.frame(a = 1:6, b = 6:1, c = LETTERS[1:6], stringsAsFactors = FALSE)
df
## Like a list
df[c('a', 'b')]
df[1:2]

## ---- cache=TRUE, comment=NA, warning=FALSE, message=FALSE---------------
df
## Like a matrix
df[, c('a', 'b')]
df[, 1:2]

## ---- cache=TRUE, comment=NA, warning=FALSE, message=FALSE---------------
df
## What is the difference?

## Preserving
df['a']

## Simplifying
df[, 'a']

## ---- comment=NA---------------------------------------------------------
df 
## Subseting a data frame based on column values
df[df['a'] > 2 & df['b'] > 2, ]

## Subsetting a 
df[df['a'] > 2 & df['b'] > 2, c('a', 'c')]

## ---- cache = TRUE, comment=NA-------------------------------------------
train <- list(a = c(1, 2, 3), b = c(3, 2, 1), c = letters[1:3])
train

## ---- comment=NA---------------------------------------------------------
## car 1
train[1]

## first 2 cars
train[1:2]

## ---- comment=NA---------------------------------------------------------
train[[1]]

## ---- comment=NA---------------------------------------------------------
new_list = list(z = list(y = list(x = list(w = 10))))
new_list

## This 
new_list[[c('z', 'y', 'x', 'w')]]

## And This are the same
new_list[['z']][['y']][['x']][['w']]

## ---- comment=NA---------------------------------------------------------
new_list = list(abc = c(1, 2, 3), def = letters[1:3])
new_list[['a', exact = FALSE]]
new_list$a

## ---- comment=NA---------------------------------------------------------
x <- c(a = 1, b = 2, c = 3)
#Preserves names
x[1]

#Drops names
x[[1]]

## ---- comment=NA---------------------------------------------------------
x <- list(a = c(1, 2, 3), b = letters[5:7])
#Preserves the list object
str(x[2])

#Simplifies list to character vector
str(x[[2]])


## ---- comment=NA---------------------------------------------------------
fac <- factor(c("A", "B"))
#Preserves all factor levels
fac[1]

#Drops unused levels
fac[1, drop = TRUE]

## ---- comment=NA---------------------------------------------------------
mat <- matrix(rnorm(36), ncol = 6)
#Preserves the matrix
mat[, 1, drop = FALSE]

#Drops the matrix to a vector 
mat[, 1]

## ---- comment=NA---------------------------------------------------------
df <- data.frame(a = 1:3, b = 3:1, c = letters[6:8], stringsAsFactors = FALSE)
#Preserves the data frame
df['c']

#Drops the data frame to a character vector
df[['c']]

## ---- comment=NA---------------------------------------------------------
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
class(lm.D9)
str(lm.D9[1:5])
lm.D9['coefficients']
lm.D9[['coefficients']]
lm.D9$coefficients

## ---- comment=NA, message = FALSE----------------------------------------
library(Matrix)
mat_ex <- Matrix(1:9, nrow=3,
                dimnames = list(c("a", "b", "c"), c("A", "B", "C")))
str(mat_ex)
## Like $ operator
mat_ex@x
## Like [[ operator
slot(mat_ex, 'x')

## ---- comment=NA---------------------------------------------------------
df <- data.frame(a = 1:6, b = 6:1, c = letters[6:11], 
                 d = LETTERS[6:11], stringsAsFactors = FALSE)
df
subset(x = df, subset = a > 3 & c %in% c('j', 'k'), select = names(df))

subset(x = df, subset = a > 3 & c %in% c('j', 'k'))

## ---- comment = NA-------------------------------------------------------
## Create data
x <- sample(c('j', 's', 'u'), 15, replace = TRUE)
x
## Create a lookup table
lookup <- c(j = 'Jared', s = 'Steve', u = 'Alien')

lookup[x]


## ---- comment = NA-------------------------------------------------------

df <- data.frame(a = rnorm(15), b = letters[1:15], c = rep(c(T, F, T), times = 5 ), 
stringsAsFactors = FALSE)  

## Without replacement
df[sample(nrow(df), 5, replace = FALSE), , drop = FALSE]
  
  
## With replacement (Bootstrapping)
df[sample(nrow(df), 5, replace = TRUE), , drop = FALSE]

## ---- comment = NA-------------------------------------------------------
df <- data.frame(a = rnorm(15), b = letters[1:15], c = rep(c(T, F, T), times = 5 ), 
stringsAsFactors = FALSE)

train <- sample(nrow(df), floor(nrow(df)*.6), replace = FALSE)

train_df <- df[train, ]

test_df <- df[-train, ]

train_df

test_df

## ---- comment=NA---------------------------------------------------------
df <- data.frame(apple = 1:6, bubble = 6:1, cushion = letters[1:6], dog = LETTERS[1:6], ernie = state.abb[1:6])
df

## We want to remove apple and ernie
purge <- grep("apple|ernie", names(df))
purge
df[, -purge]


## ---- comment=NA---------------------------------------------------------
df <- data.frame(apple = 1:6, bubble = 6:1, cushion = letters[1:6], dog = LETTERS[1:6], ernie = state.abb[1:6])
df

keepers <- setdiff(names(df), c('apple', 'ernie'))
keepers
df[, keepers]


## ---- comment = NA-------------------------------------------------------
set.seed(12)
ex <- sample(letters, 20, replace = TRUE)
ex
which(ex == 'a')
ex[which(ex == 'a')]
which(ex %in% c('a', 'b', 'c'))


## ---- comment = NA, cache = TRUE-----------------------------------------

(t1 <- 11:20 %% 2 == 0)

(t2 <- which(t1))

(u1 <- 11:20 %% 3 == 0)

(u2 <- which(u1))

## ---- comment = NA-------------------------------------------------------
# t & u <=> intersect(t, u)
t1 & u1

intersect(t2, u2)
cbind(t1, u1)


## ---- comment = NA-------------------------------------------------------
# t | u <=> union(t, u)
t1 | u1

union(t2, u2)
cbind(t1, u1)

## ------------------------------------------------------------------------

