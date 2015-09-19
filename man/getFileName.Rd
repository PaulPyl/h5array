\name{getFileName}
\alias{getFileName}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get the filename of the underlying HDF5 files.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
getFileName(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
%%     ~~Describe \code{object} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{link{getLocation}}
}
\examples{
x <- h5matrixCreate(
      file.path(tempdir(), "this.is.the.file.name.txt"),
      "This/Is/The/Location", c(10,10), "double",
      fillValue = 42)
x
getFileName(x)
}

