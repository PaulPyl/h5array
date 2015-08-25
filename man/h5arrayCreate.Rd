\name{h5arrayCreate}
\alias{h5arrayCreate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create a new h5array object in an HDF5 file.
}
\description{
This function will create a HDF5 file (if it doesn't exist yet) and add a new dataset with the specified properties to it.
}
\usage{
h5arrayCreate(fn, location, dim, storage.mode, ...)
}
\arguments{
  \item{fn}{
Filename pecifying the location of the HDF5 file
}
  \item{location}{
Location within the HDF5 file (see HDF5 secifications at HDFgroup.org). Note that the combination of \code{fn} and \code{location} uniquely identify a \code{h5array} object. If you create two \code{h5array} objects that have the same filename and location they will point to the same data on disk and can modify it both, this can lead to unexpected behaviour if not used cautiously.

With great power comes great responsibility.
}
  \item{dim}{
the dimensions of the array
}
  \item{storage.mode}{
the storage mode, can be e.g. \code{"double"} or \code{"character"}, see the \code{rhdf5} documentation for more information
}
  \item{\dots}{
any additional arguments will be passed on to the \code{\link[rhdf5]{h5createDataset}} function
}
}
\value{
An h5array object pointing to the newly created dataset.
}
\author{
Paul Theodor Pyl
}
\seealso{
\code{\link{h5matrixCreate}}
}
\examples{
x <- h5arrayCreate(tempfile(), "Data", c(4,10), "double")
colnames(x) <- letters[1:10]
x
y <- h5arrayCreate(tempfile(), "CharData", c(2,4,3), "character", size = 10)
y
}
