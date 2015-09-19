\name{h5matrixCreate}
\alias{h5matrixCreate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create a new h5matrix object in an HDF5 file.
}
\description{
This function creates a new h5matrix object in an HDF5 file, creating the file if it doesnt exists and the specified dataset within it.
}
\usage{
h5matrixCreate(fn, location, dim, storage.mode, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fn}{
Filename for the HDF5 file.
}
  \item{location}{
Location of the dataset wihtin the HDF5 file, this should be unique.
}
  \item{dim}{
The dimensions of the dataset
}
  \item{storage.mode}{
  Storage mode of the dataset, see \code{\link[rhdf5]{h5createDataset}} for details, typically this will be one of \code{"double"}, \code{"character"}, \code{"integer"}.
}
  \item{\dots}{
  Any additional parameters to \code{\link[rhdf5]{h5createDataset}} go here, e.g. \code{chunk} or \code{fillValue}
}
}

\value{
A \code{h5matrix} object pointing to the specified location in the specified file.
}
\author{
Paul Theodor Pyl
}
\examples{

}