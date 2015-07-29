\name{h5array-class}
\Rdversion{1.1}
\docType{class}
\alias{h5array-class}
\alias{[,h5array,ANY-method}
\alias{[<-,h5array,ANY,ANY,ANY-method}
\alias{getData,h5array-method}
\alias{head,h5array-method}
\alias{show,h5array-method}

\title{Class \code{"h5array"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("h5array", ...)}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{file}:}{Object of class \code{"character"} ~~ }
    \item{\code{location}:}{Object of class \code{"character"} ~~ }
    \item{\code{dimnames}:}{Object of class \code{"listOrNULL"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{h5arrayOrMatrix}"}, directly.
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "h5array", i = "ANY")}: ... }
    \item{[<-}{\code{signature(x = "h5array", i = "ANY", j = "ANY", value = "ANY")}: ... }
    \item{getData}{\code{signature(x = "h5array")}: ... }
    \item{head}{\code{signature(x = "h5array")}: ... }
    \item{show}{\code{signature(object = "h5array")}: ... }
	 }
}
\references{
%%  ~~put references to the literature/web site here~~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
}
\examples{
showClass("h5array")
}
\keyword{classes}
