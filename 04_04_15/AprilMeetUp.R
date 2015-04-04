## ----basen, comment=NA, size="footnotesize"------------------------------
set.seed(1)
dat_1a <- data.frame(a = sample(3, 10, replace = TRUE), b = sample(2, 10, replace = TRUE))
dat_1a
dat_1a$a[dat_1a$a == 1] <- 50
dat_1a$b[dat_1a$b == 2] <- 100
dat_1a

## ----, comment = NA------------------------------------------------------
set.seed(1)
dat_1b <- data.frame(a = rnorm(10), b = rnorm(10))
dat_1b
dat_1b$a[dat_1b$a < 0.2 & dat_1b$a > -.7] <- 100
dat_1b

## ----basefw, comment = NA------------------------------------------------
dat_2 <- data.frame(a = gl(2, 5, labels = c('hi', 'low')), b = gl(5, 2, labels = letters[1:5]))
dat_2
dat_2$a[dat_2$a == 'hi'] <- 'v-high'
dat_2

## ----, echo = FALSE, cache=TRUE------------------------------------------
dat_2a <- data.frame(a = gl(2, 5, labels = c('hi', 'low')), b = gl(5, 2, labels = letters[1:5]))
dat_2b <- dat_2a

## ----, comment = NA------------------------------------------------------
dat_2a
levels(dat_2a$a) <- c('walrus', 'snake')
dat_2a

## ----basefr, comment = NA------------------------------------------------
dat_2b
levels(dat_2b$b) <- rev(levels(dat_2b$b))
dat_2b

## ----basec, comment = NA-------------------------------------------------
set.seed(1)
dat_3 <- data.frame(a = sample(letters[1:3], 10, replace = TRUE), 
                    b = sample(letters[11:14], 10, replace = TRUE), 
                    stringsAsFactors = FALSE)
dat_3$a[dat_3$a == 'a'] <- 'z'
dat_3

## ----, comment = NA------------------------------------------------------
set.seed(1)
dat_4a <- data.frame(a = rnorm(20), b = rnorm(20))
dat_4b <- dat_4a
dat_4a
dat_4a$a <- cut(dat_4a$a, breaks = c(-Inf, -1, 1, Inf), 
                ordered_result = TRUE)
dat_4a$b <- cut(dat_4a$b, breaks = c(-Inf, 0, Inf),
                ordered_result = TRUE)
dat_4a


## ----, comment = NA------------------------------------------------------
dat_4b$a <- cut(dat_4b$a, breaks = c(-Inf, -1, 1, Inf), 
                labels = c("small", "med", "large"),
                ordered_result = TRUE)
dat_4b$b <- cut(dat_4b$b, breaks = c(-Inf, 0, Inf), 
                labels = c("low", "high"), 
                ordered_result = TRUE)
dat_4b

## ----, comment = NA, echo = FALSE----------------------------------------
if(!require(plyr))
      install.packages('plyr')
set.seed(1)

## ----, comment = NA------------------------------------------------------
dat_5 <- data.frame(a = sample(3, 10, replace = TRUE), b = sample(2, 10, replace = TRUE))
dat_5
dat_5$a <- mapvalues(dat_5$a, from = c(1,2,3), to = c(3,2,1))
dat_5
dat_5$b <- mapvalues(dat_5$b, from = c(1,2), to = c(10, 20))
dat_5

## ----, comment = NA, cache=TRUE------------------------------------------
dat_6 <- data.frame(a = gl(2, 5, labels = c('hi', 'low')), b = gl(5, 2, labels = letters[1:5]))
dat_6
dat_6$a <- mapvalues(dat_6$a, from = c('hi', 'low'), to = c(1, 2))
dat_6

## ----, comment = NA------------------------------------------------------
dat_6$a <- mapvalues(dat_6$a, from = c(1, 2), to = c(1,1))
dat_6$b <- mapvalues(dat_6$b, from = letters[1:5], 
                     to = c('a', 'a', 'c', 'd', 'e'))
dat_6

## ----, cache = TRUE, comment = NA, echo = FALSE--------------------------
makeMiss <- function(Nit, Ncase, missVec){
    set.seed(1234)
    sampVals <- c(1:5, missVec)
    dat <- list()
    for(i in 1:Nit){
        dat[[i]] <- sample(sampVals, Ncase, replace = TRUE)
    }
    dat <- as.data.frame(do.call(cbind, dat))
    dat
}
dat_7a <- makeMiss(5, 100, -999)
dat_7b <- dat_7a
dat_8a <- makeMiss(15, 100, -999)
dat_8b <- makeMiss(15, 100, -999)


## ----, comment = NA------------------------------------------------------
head(dat_7a)
sapply(dat_7a, table)
dat_7a$V1[dat_7a$V1 == -999] <- NA
dat_7a$V2[dat_7a$V2 == -999] <- NA
dat_7a$V3[dat_7a$V3 == -999] <- NA
dat_7a$V4[dat_7a$V4 == -999] <- NA
dat_7a$V5[dat_7a$V5 == -999] <- NA
sapply(dat_7a, table, useNA = "always")


## ----, comment = NA------------------------------------------------------
head(dat_7b)
sapply(dat_7b, table)
dat_7b$V1 <- mapvalues(dat_7b$V1, from = -999, to = NA)
dat_7b$V2 <- mapvalues(dat_7b$V2, from = -999, to = NA)
dat_7b$V3 <- mapvalues(dat_7b$V3, from = -999, to = NA)
dat_7b$V4 <- mapvalues(dat_7b$V4, from = -999, to = NA)
dat_7b$V5 <- mapvalues(dat_7b$V4, from = -999, to = NA)
sapply(dat_7b, table, useNA = "always")


## ----, comment = NA------------------------------------------------------
head(dat_8a)
sapply(dat_8a, table)

## ----, comment = NA------------------------------------------------------
table(dat_8a$V1)
dat_8a$V1[dat_8a$V1 == -999] <- NA
table(dat_8a$V1)

## ----, comment = NA, cache = TRUE----------------------------------------
recodeSingleMiss <- function(x, naVal){
    x[x == naVal] <- NA
    x
}

## ----, comment = NA------------------------------------------------------
head(dat_8b)
sapply(dat_8b, table)
dat_8b[] <- lapply(dat_8b, recodeSingleMiss, -999)
sapply(dat_8b, table, useNA = "always")


