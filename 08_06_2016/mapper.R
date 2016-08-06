#! /usr/bin/env Rscript

input <- file('stdin', 'r')

while(length(line <- readLines(input, n = 1, warn = FALSE)) > 0){
  if(nchar(line) == 0) break
  
  fields <- unlist(strsplit(line, '\n'))
  cat(fields[1], '\t', '1', '\n')
}

close(input)