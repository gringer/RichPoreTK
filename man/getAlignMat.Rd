\name{getAlignMat}
\alias{getAlignMat}
\title{Produces an allele count alignment matrix}
\description{
  Produces an allele count alignment matrix, aggregating all alignments
  found in the specificed MAF-formatted file.
}
\usage{
  getAlignMat(mafFileStr, ref)
}
\arguments{
  \item{mafFileStr}{
    location of MAF-formatted file to be processed
  }
  \item{ref}{
    character string identifying reference sequence in MAF output
  }
}
\details{
}
\value{
  5x5 matrix indicating number of occurrences of pattern/reference
  allele pairs. Rows headings are the reference allele, column heading
  are the pattern (called) allele. An insertion has an allele of '-' for
  the reference, while a deletion has an allele of '-' for the pattern.
}
\references{
}
\author{
  David Eccles (gringer) <bioinformatics@gringene.org>
}
\note{
}

\seealso{
}
\examples{
}
\keyword{ ~file }
\keyword{ ~array }
\keyword{ ~file }
\keyword{ ~manip }
