\name{h5array-package}
\alias{h5array-package}
\docType{package}
\title{
\packageTitle{h5array}
}
\description{
\packageDescription{h5array}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{h5array}
\packageIndices{h5array}
~~ An overview of how to use the package, including the most important ~~
~~ functions ~~
}
\author{
\packageAuthor{h5array}

Maintainer: \packageMaintainer{h5array}
}

\keyword{ package }
\examples{
fn <- tempfile()
x <- h5arrayCreate(fn, "/Data", c(12,3), "double")
y <- h5array(fn, "/Data") #pointing to the same location in the HDF5 file
x
y[1,] <- 23 #assignment to y
y #y is changed
x #x is also changed
}
