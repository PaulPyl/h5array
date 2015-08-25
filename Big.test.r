require(h5array)
x <- h5arrayCreate(tempfile(), "BigData", c(1e4+1,1e4+1,20), "double", chunk = c(1e3, 1e3, 20))
dimnames(x) <- list( NULL, NULL, letters[1:20] )
x[1,,1] <- 23
