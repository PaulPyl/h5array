\name{h5array-class}
\Rdversion{1.1}
\docType{class}
\alias{h5array-class}
\alias{[,h5array-method}
\alias{[<-,h5array-method}
\alias{getData,h5array-method}
\alias{head,h5array-method}
\alias{show,h5array-method}

\title{Class \code{"h5array"}}
\description{
An object that behaves like an \code{array} but accesses data stored on disk in an HDF5 file.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("h5array", ...)} and by using the \code{h5array} function or the \code{\link{h5arrayCreate}} function.
}
\section{Slots}{
  \describe{
    \item{\code{file}:}{Filename of the underlying HDF5 file}
    \item{\code{location}:}{Location of the data within the HDF5 file}
    \item{\code{dimnames}:}{Names for the dimensions of the array, this should be a list}
  }
}
\section{Extends}{
Class \code{"\linkS4class{h5arrayOrMatrix}"}, directly.
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "h5array", i = "ANY")}: Basic accessor that should behave as expected. }
    \item{[<-}{\code{signature(x = "h5array", i = "ANY", j = "ANY", value = "ANY")}: Basic setter to assign values to the array, should work as expected. }
    \item{getData}{\code{signature(x = "h5array")}: Explicit function implementation of the accessor, requires complete indexing, i.e. no empty dimension as in e.g. \code{x[1,]} }
    \item{head}{\code{signature(x = "h5array")}: Show the first 6 rows and columns from the dataset }
    \item{show}{\code{signature(object = "h5array")}: Show an informative summary of the object. }
	 }
}
\author{
Paul Theodor Pyl
}
\examples{
showClass("h5array")
x <- h5arrayCreate(tempfile(), "Data", c(10,10), "double")
x
}
\keyword{classes}
