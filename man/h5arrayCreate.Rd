\name{h5arrayCreate}
\alias{h5arrayCreate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create a new h5array object in an HDF5 file.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
h5arrayCreate(fn, location, dim, storage.mode, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fn}{
%%     ~~Describe \code{fn} here~~
}
  \item{location}{
%%     ~~Describe \code{location} here~~
}
  \item{dim}{
%%     ~~Describe \code{dim} here~~
}
  \item{storage.mode}{
%%     ~~Describe \code{storage.mode} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (fn, location, dim, storage.mode, ...) 
{
    if (!file.exists(fn)) {
        h5createFile(fn)
    }
    h5createDataset(fn, location, dims = dim, storage.mode = storage.mode, 
        ...)
    new("h5array", file = fn, location = location)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
