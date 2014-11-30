\name{toUnambig}
\title{Generates unambiguous base sequences}

\description{
  Given a string containing ambiguous bases, generate a list of
  all possible unambiguous sequences that could match that string
}

\usage{
toUnambig(ambigBases)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ambigBases}{a character string, or a character vector}
}
\details{
  If ambigBases is a vector, then a list will be output containing the
  unambiguous translations for each element in ambigBases.
}
\value{
  A character vector containing all possible unambiguous translations
  for the given input string, using standard IUPAC base classifications:

  \item{A;C;G;T}{A;C;G;T}
  \item{S;W}{C/G;A/T}
  \item{Y;R}{C/T;A/G}
  \item{M;K}{A/C;G/T}
  \item{B}{C/G/T}
  \item{D}{A/G/T}
  \item{H}{A/C/T}
  \item{V}{A/C/G}
  \item{N}{A/C/G/T}
}
\references{
  %% ~put references to the literature/web site here ~
  
}
\author{ David Eccles (gringer) <bioinformatics@gringene.org>}
\note{
  %%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  %% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## Select 10 random translations of an ambiguous sequence
gringene.backtran <- "GGNMGNATHAAYGGNGARAAYGAR";
sample(toUnambig("GGNMGNATHAAYGGNGARAAYGAR"),10);
## Show all the needles in a haystack
toUnambig(c("HAYSTACK"));
## Display all translations of the sequences "BAH","HUMBUG"
toUnambig(c("BAH","HUMBUG"));
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~manip }% __ONLY ONE__ keyword per line
