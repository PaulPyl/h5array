\name{h5arrayOrMatrix-class}
\Rdversion{1.1}
\docType{class}
\alias{h5arrayOrMatrix-class}
\alias{dim,h5arrayOrMatrix-method}
\alias{dimnames,h5arrayOrMatrix-method}
\alias{dimnames<-,h5arrayOrMatrix-method}
\alias{getFileName,h5arrayOrMatrix-method}
\alias{getLocation,h5arrayOrMatrix-method}
\alias{print,h5arrayOrMatrix-method}
\alias{typeof,h5arrayOrMatrix-method}

\title{Class \code{"h5arrayOrMatrix"}}
\description{
A virtual class that is used to define common methods on \code{\linkS4class{h5array}} and \code{\linkS4class{h5matrix}} objects.
}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Methods}{
  \describe{
    \item{apply}{\code{signature(X = "h5arrayOrMatrix", MARGIN = "numeric", FUN = "function")}: Described in \code{\link{apply-methods}} }
    \item{dim}{\code{signature(x = "h5arrayOrMatrix")}: ... }
    \item{dimnames}{\code{signature(x = "h5arrayOrMatrix")}: ... }
    \item{dimnames<-}{\code{signature(x = "h5arrayOrMatrix", value = "ANY")}: ... }
    \item{getFileName}{\code{signature(object = "h5arrayOrMatrix")}: ... }
    \item{getLocation}{\code{signature(object = "h5arrayOrMatrix")}: ... }
    \item{print}{\code{signature(x = "h5arrayOrMatrix")}: ... }
    \item{typeof}{\code{signature(x = "h5arrayOrMatrix")}: ... }
	 }
}
\author{
Paul Theodor Pyl
}
\seealso{
\code{\linkS4class{h5array}}
\code{\linkS4class{h5matrix}}
}
\examples{
showClass("h5arrayOrMatrix")
}
\keyword{classes}
