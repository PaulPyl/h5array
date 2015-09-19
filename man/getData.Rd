\name{getData}
\alias{getData}
\title{
Get data from an \code{h5array} object
}
\description{
This is the basic accessor function, can be used interchangeably with the \code{"["}-operator. 
}
\usage{
getData(x, ...)
}
\arguments{
  \item{x}{
An \code{h5array} object
  }
  \item{...}{
    Subsetting indices for the dimensions of the array, there should be exactly \code{length(dim(x))} parameters given here.
  }
}
\value{
The \code{array} containign the specified data loaded from the HDF5 file.
}
\author{
Paul Theodor Pyl
}
\seealso{
\code{link{getFileName}}
\code{link{getLocation}}
}
\examples{
x <- h5arrayCreate(
      tempfile(),
      "SomeData", c(10,10), "double",
      fillValue = 42)
x
getData(x, 1:3, 4:6)
}

