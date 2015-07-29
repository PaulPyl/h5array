\name{h5matrix-class}
\Rdversion{1.1}
\docType{class}
\alias{h5matrix-class}
\alias{[,h5matrix,ANY-method}
\alias{[<-,h5matrix,ANY,ANY,ANY-method}
\alias{head,h5matrix-method}
\alias{show,h5matrix-method}

\title{Class \code{"h5matrix"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("h5matrix", ...)}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{file}:}{Object of class \code{"character"} ~~ }
    \item{\code{location}:}{Object of class \code{"character"} ~~ }
    \item{\code{dimnames}:}{Object of class \code{"listOrNULL"} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "h5matrix", i = "ANY")}: ... }
    \item{[<-}{\code{signature(x = "h5matrix", i = "ANY", j = "ANY", value = "ANY")}: ... }
    \item{head}{\code{signature(x = "h5matrix")}: ... }
    \item{show}{\code{signature(object = "h5matrix")}: ... }
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
showClass("h5matrix")
}
\keyword{classes}
