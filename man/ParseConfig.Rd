\name{ParseConfig}
\alias{ParseConfig}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
ParseConfig(fileName)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fileName}{
%%     ~~Describe \code{fileName} here~~
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
function (fileName) 
{
    Lines <- readLines(fileName)
    Lines <- chartr("[]", "==", Lines)
    d <- read.table(textConnection(Lines), as.is = TRUE, sep = "=", 
        fill = TRUE)
    L <- d$V1 == ""
    d <- subset(transform(d, V3 = V2[which(L)[cumsum(L)]])[1:3], 
        V1 != "")
    ToParse <- sprintf("res$\%s$\%s <- '\%s'", d$V3, d$V1, substring(d$V2, 
        2))
    res <- list()
    eval(parse(text = ToParse))
    return(res)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
