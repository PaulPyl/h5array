\name{getLocation}
\alias{getLocation}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get the location of the dataset in the underlying HDF5 file.
}
\description{
This function returns the HDF5-internal path to the dataset that the \code{h5array} / \code{h5matrix} points to, this is *not* the path to the file containign the data, but rather a path *within* that file.
}
\usage{
getLocation(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
  An object of class \code{h5array} or \code{h5matrix}
}
}
\details{
}
\value{
A \code{character} containing the location of the dataset.
}
\author{
Paul Theodor Pyl
}
\seealso{
\code{link{getFileName}}
}
\examples{
x <- h5matrixCreate(tempfile(), "This/Is/The/Location", c(10,10), "double", fillValue = 42)
x
getLocation(x) #Note the leading "/"", indicating that this
               #location is a child of the root location wihtin the HDF5 file
}
