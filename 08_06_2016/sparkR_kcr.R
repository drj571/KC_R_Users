## PREREQUISITES:
## install.packages(c("devtools", "magrittr"))
## library(devtools)
## install_github("amplab-extras/SparkR-pkg",subdir = "pkg")
#mySparkRpackagepath <- "/home/jared/spark-1.6.1-bin-hadoop2.6.tgz"
install.packages(mySparkRpackagepath)
library(devtools)
library(magrittr)
library(SparkR)
install.packages("jsonlite")
## Initialize the spark context
sc <- sparkR.init(master = "local")
wordCount <- sc %>%
  textFile("./words.txt") %>%
  map(function(x) {
    tmp <- unlist(strsplit(x, '\n'))
    return(list(tmp, 1))
    }) %>% reduceByKey(`+`, 2L)
sql <- sparkRSQL.init(sc)
sparkR.stop()
## Create an RDD 
myfirstRDD <- sc %>%
  parallelize(sample(1:100, 40, replace = TRUE))

myfirstRDD

## Now let's explore this RDD
myfirstRDD %>% first()

myfirstRDD %>% take(4) 

myfirstRDD %>% count()

## Only do this when data is small
myfirstRDD %>% foreach(print)


## Use collect() with care
myfirstList <- myfirstRDD %>% collect()


## filterRDD function
myfirstRDD_filtered <- myfirstRDD %>%
  filterRDD(function(x) x > 30)

myfirstRDD_filtered %>% count()

myfirstRDD_filtered %>% take(10)

## Can chain operations
myfirstRDD %>%
  filterRDD(function(x) x > 30) %>%
  foreach(print)

## map function
myfirstRDD_map <- myfirstRDD %>%
  map(function(x) x**2 + 10)

myfirstRDD_map %>% take(10)

## Can use map to create key, value pairs (more to come)
new_data <- sc %>% parallelize(list(c(0, "apple", "jared"), c(1, "orange", "sean"),
                                c(2, "melon", "steve"), c(3, "grapes", "kevin")))

myfirstKV_RDD <- new_data %>% 
  map(function(x) list(x[3], c(x[1], x[2]))) %>% foreach(print)

## Reduce 
sc %>%
  parallelize(seq(5, 5000, by = 5)) %>%
  reduce(`+`)

tmp_data<- list(list("a", 1), list("a", 2), list("b", 3), list("b", 2), list("c", 50), list("c", 20), 
     list("d", 1), list("d", 2), list("a", 50), list("e", 3))

rdd1 <- sc %>%
  parallelize(tmp_data)

rdd1

rdd1 %>% take(3)

rdd1 %>% first()

collected1 <- rdd1 %>% collect()

myRDDFilter <- function(x){
  ifelse(x[[2]] > 2, TRUE, FALSE)
}

rdd1 %>%
  filterRDD(myFilter) %>%
  collect()

myReducer <- function(x, y){
  x[[2]] + y[[2]]
}

rdd1 %>% 
  reduceByKeyLocally(`+`)

rdd2 <- sc %>% textFile("/home/jared/sparkR_pres/grades.csv") 
rdd2 %>% take(2)
splitLines <- function(x){
  strsplit(x, ",")
}
example <- rdd2 %>% flatMap(splitLines)
example %>% take(3)
example2 <- rdd2 %>% map(splitLines) 
example2 %>% take(3)

lut <- c(A = 4, B = 3, C = 2, D = 1, F = 0)
mapped_example <- example %>% 
  map(function(x) {
    key <- paste0(x[1], "_", x[2])
    list(key, lut[x[5]])
  }) %>% 
  reduceByKey(`+`, 2L)

## combineByKey example
start_fun <- function(x){
  list(c(x[1], x[2]))
}

mergeVal_fun <- function(x, y){
  c(list(c(y[1], y[2])), x)
} 

mergeComb_fun <- function(x, y){
  c(x, y)
}

combineByKey_example <- example %>%
  map(function(x) {
    key <- paste0(x[1], "_", x[2])
    list(key, c(x[4], x[5]))
  }) %>% 
  combineByKey(start_fun, mergeVal_fun, mergeComb_fun, 3L) %>% collect()

parseJSON <- function(x){
  if ("{" %in% x){
    return(NULL)
  } else {
    return(fromJSON(x))
  }
}
jsonRDD <- sc %>% textFile("./employee1.json") %>% 
  filterRDD(function(x) x[1] != "{") 

jsonRDD <- jsonRDD %>% map(function(x) fromJSON(x))
#unlist(fromJSON(jsonRDD[[2]], simplifyVector = TRUE))
"{" %in% jsonRDD[[2]]
library(jsonlite)

sqlContext <- sparkRSQL.init(sc)
