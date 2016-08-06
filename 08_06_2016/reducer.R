#! /usr/bin/env Rscript

con <- file('stdin', 'r')
is_first_line <- TRUE
while(length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  pieces <- unlist(strsplit(line, '\t'))
  if(!is_first_line && prev_word == pieces[1]){
    sum <- sum + as.integer(pieces[2])
  } else {
    
    if(!is_first_line){
      cat(prev_word, "\t", sum, "\n")
    }
    prev_word <- pieces[1]
    sum <- as.integer(pieces[2])
    is_first_line <- FALSE
  }
}
cat(prev_word, "\t", sum, "\n")
close(con)
