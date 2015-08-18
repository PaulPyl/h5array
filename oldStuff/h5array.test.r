source("h5array.R")

x <- h5arrayCreate(tempfile(), "Data", c(3,2,3), "double")
y <- h5arrayCreate(tempfile(), "StringData", c(10,3,2), "character", size = 10)
dimnames(y) <- list(letters[1:10], letters[1:3], c("First", "Second"))

z <- h5matrixCreate(tempfile(), "Matrix", c(1000, 120), "double")
dimnames(z) <- list(paste0("Row", 1:1000), paste0("Column", 1:120))

require(GenomicRanges)

se <- SummarizedExperiment(list(z))

