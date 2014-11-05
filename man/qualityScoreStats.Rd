\name{qualityScoreStats}
\alias{qualityScoreStats}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Produce quality score statistics for fast5 files}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
qualityScoreStats(workflow = "Basecall_2D_000", metrichorFolder = "data")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{workflow}{
%%     ~~Describe \code{workflow} here~~
}
  \item{metrichorFolder}{
%%     ~~Describe \code{metrichorFolder} here~~
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
function (workflow = "Basecall_2D_000", metrichorFolder = "data") 
{
    files <- list.files(metrichorFolder, pattern = "\\.fast5$", 
        full.names = TRUE)
    bases <- NULL
    mean.scores <- NULL
    for (fname in files) {
        templatePath <- sprintf("Analyses/\%s/BaseCalled_template", 
            workflow)
        twoDPath <- sprintf("Analyses/\%s/BaseCalled_2D", workflow)
        fastq <- NULL
        if (!(keyExists(fname, templatePath))) {
            next
        }
        if (keyExists(fname, twoDPath)) {
            fastq <- h5read(fname, bit64conversion = "bit64", 
                sprintf("Analyses/\%s/BaseCalled_2D/Fastq", workflow))
        }
        else {
            fastq <- h5read(fname, bit64conversion = "bit64", 
                sprintf("Analyses/\%s/BaseCalled_template/Fastq", 
                  workflow))
        }
        mean.scores[length(mean.scores) + 1] <- mean(getQuals(fastq))
        bases[length(bases) + 1] <- nchar(getSeq(fastq))
    }
    pdf("quality_scores.pdf", paper = "a4r", width = 11, height = 8)
    hist(mean.scores, main = "Distribution of mean quality scores", 
        col = "red")
    plot(x = bases, y = mean.scores, xlab = "Number of bases", 
        ylab = "Mean quality score", main = "Mean quality scores vs number of bases")
    graphics.off()
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
