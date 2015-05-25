\name{getAlignMat}
\alias{getAlignMat}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Produces an allele count alignment matrix}
\description{
  %%  ~~ A concise (1-5 lines) description of what the function does. ~~
  Produces an allele count alignment matrix, aggregating all alignments
  found in the specificed MAF-formatted file.
}
\usage{
getAlignMat(mafFileStr, ref)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mafFileStr}{
    %%     ~~Describe \code{fastQSeq} here~~
    location of MAF-formatted file to be processed
  }
  \item{ref}{
    character string identifying reference sequence in MAF output
  }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  5x5 matrix indicating number of occurrences of pattern/reference
  allele pairs. Rows headings are the reference allele, column heading
  are the pattern (called) allele. An insertion has an allele of '-' for
  the reference, while a deletion has an allele of '-' for the pattern.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
  %%  ~~who you are~~
  David Eccles (gringer)
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~file }% __ONLY ONE__ keyword per line
\keyword{ ~array }
\keyword{ ~file }
\keyword{ ~manip }
