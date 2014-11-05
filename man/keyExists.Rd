\name{keyExists}
\alias{keyExists}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{determine if a given key (or path) exists in a fast5 file}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
keyExists(fileName, keyName)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fileName}{
%%     ~~Describe \code{fileName} here~~
}
  \item{keyName}{
%%     ~~Describe \code{keyName} here~~
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
function (fileName, keyName) 
{
    fid <- H5Fopen(fileName)
    retVal <- H5Lexists(fid, keyName)
    H5Fclose(fid)
    return(retVal)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
