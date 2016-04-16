## ---- comment = NA-------------------------------------------------------
set.seed(12)
x <- matrix(rnorm(100), ncol = 10)

output <- vector('numeric', length = ncol(x))
for(col in seq_along(x[1, ])){
  output[col] <- sum(x[,col])
}
output

## ---- comment = NA-------------------------------------------------------
set.seed(12)
x <- matrix(rnorm(100), ncol = 10)

apply(x, MARGIN = 2, FUN = sum)


## ---- comment = NA-------------------------------------------------------
set.seed(12)
mat_list <- list(a = matrix(rnorm(100), ncol = 10), b = matrix(rlnorm(100), ncol = 10))

out_list <- vector('list', length = length(mat_list))
for(i in seq_along(mat_list)){
  tmp <- vector('numeric', length = ncol(mat_list[[i]]))
  for(j in seq_along(mat_list[[i]][1, ])){
    tmp[j] <- sum(mat_list[[i]][, j])
  }
  out_list[[i]] <- tmp
}
out_list

## ---- comment = NA-------------------------------------------------------
set.seed(12)
mat_list <- list(a = matrix(rnorm(100), ncol = 10), b = matrix(rlnorm(100), ncol = 10))

lapply(mat_list, FUN = colSums, na.rm = TRUE)


## ---- comment = NA, cache = TRUE-----------------------------------------

lapply_jh <- function(X, FUN, ...){
  output <- vector('list', length(X))
  for(i in seq_along(X)){
    output[[i]] <- FUN(X[[i]], ...)  
  }
  output
}


## ---- comment = NA-------------------------------------------------------
set.seed(12)
mat_list <- list(a = matrix(rnorm(100), ncol = 10), b = matrix(rlnorm(100), ncol = 10))

lapply(mat_list, colSums, na.rm = TRUE)
lapply_jh(mat_list, colSums, na.rm = TRUE)

## ---- comment = NA-------------------------------------------------------
set.seed(12)
test_list <- list(x = matrix(rnorm(100), ncol = 10), y = matrix(rnorm(100), ncol = 10))

lapply(test_list, colMeans)

sapply(test_list, colMeans)

vapply(test_list, colMeans, vector('numeric', length = 10))



## ---- comment = NA-------------------------------------------------------
set.seed(12)
test_list <- list(x = matrix(rnorm(100), ncol = 10), y = matrix(rnorm(100), ncol = 5))

sapply(test_list, colMeans)

#vapply(test_list, colMeans, vector('numeric', length = 10))


## ---- comment = NA, cache = TRUE-----------------------------------------
ages <- sample(18:65, 45, replace = TRUE)
group <- gl(n = 3, k = 15, labels = c('A', 'B', 'C'))

tapply(X = ages, INDEX = group, FUN = mean, na.rm = TRUE, simplify = TRUE)

## ---- comment = NA-------------------------------------------------------
tapply_jh <- function(X, INDEX, FUN, ..., simplify = TRUE){
  groups <- split(X, INDEX)
  sapply(groups, FUN, ..., simplify = TRUE)
}


## ---- comment = NA-------------------------------------------------------
split(ages, group)

## ---- comment = NA-------------------------------------------------------
groups <- split(ages, group)
sapply(groups, FUN = mean, na.rm = TRUE)

