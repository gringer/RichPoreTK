\name{eventPlot}
\alias{eventPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
eventPlot(workflow = "Basecall_2D_000", metrichorFolder = "data")
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
    strandFile <- list.files(metrichorFolder, pattern = "\\.fast5$", 
        full.names = TRUE)[1]
    readNumber <- getReadNumber(strandFile)
    datasetName <- sprintf("Analyses/EventDetection_000/Reads/Read_\%d/Events", 
        readNumber)
    templatePath <- sprintf("Analyses/\%s/BaseCalled_template/Events", 
        workflow)
    templateEvents <- h5read(strandFile, templatePath, bit64conversion = "bit64")
    complementEvents <- NULL
    complementPath <- sprintf("Analyses/\%s/BaseCalled_complement/Events", 
        workflow)
    if (keyExists(strandFile, complementPath)) {
        complementEvents <- h5read(strandFile, complementPath, 
            bit64conversion = "bit64")
    }
    pdf("tracePlot.pdf", paper = "a4r", width = 11, height = 8)
    numEvents <- length(templateEvents$mean)
    seq <- getSeq(strandFile)
    seq <- getSeq(h5read(strandFile, bit64conversion = "bit64", 
        sprintf("Analyses/\%s/BaseCalled_template/Fastq", workflow)))
    plot(x = 1:numEvents, y = templateEvents$mean, ylab = "Mean Current", 
        type = "l", main = "Trace Plot for Template Events")
    if (!is.null(complementEvents)) {
        numEvents <- length(complementEvents$mean)
        plot(x = 1:numEvents, y = complementEvents$mean, col = "red", 
            ylab = "Mean Current", type = "l", main = "Trace Plot for Complementary Events")
    }
    graphics.off()
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
