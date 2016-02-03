require(h5array)
x <- h5arrayCreate(tempfile(), "BigData", c(1e4+1,1e4+1,20), "double", chunk = c(1e3, 1e3, 20))
dimnames(x) <- list( NULL, NULL, letters[1:20] )
x[1,,1] <- 23
h5ls(getFileName(x))
writeDimnamesToFile(x)
h5ls(getFileName(x))
y <- h5array(getFileName(x), location = getLocation(x))
dimnames(y)
dimnames(x)
y <- loadDimnamesFromFile(y)
dimnames(y)


require(h5array)
y <- h5matrixCreate(tempfile(), "Data", c(1e2,20), "double", chunk = c(1e2, 10))
dimnames(y) <- list( paste0("row", 1:1e2), letters[1:20] )
y[,] <- 23
h5ls(getFileName(y))
writeDimnamesToFile(y)
h5ls(getFileName(y))
y[,"a"]
y[c("row23", "row42"),c("a", "l", "k")]

require(h5array)
z <- h5arrayCreate(tempfile(), "SmallData", c(20,100,5), "double")
zc <- h5arrayCreate(tempfile(), "SmallData", c(20,100,5), "double", chunk = c(1,1,5))

foo <- array(1:(20*100*5), dim = dim(z))
z[,,] <- foo
zc[,,] <- foo

require(microbenchmark)
microbenchmark(apply(z, c(1,2), sum), times = 10)
microbenchmark(apply(zc, c(1,2), sum), times = 10)

apply(z, 2, function(x) as.character(median(x)))


knitr::knit(input="vignettes//h5array.Introduction.Rmd", output = "readme.md")
