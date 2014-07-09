\name{runSummary}
\alias{runSummary}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
runSummary(workflow = "Basecall_2D_000", configFile = "basecall_2d_field_map.cfg", summaryFile = "results.csv", metrichorFolder = "data")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{workflow}{
%%     ~~Describe \code{workflow} here~~
}
  \item{configFile}{
%%     ~~Describe \code{configFile} here~~
}
  \item{summaryFile}{
%%     ~~Describe \code{summaryFile} here~~
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
function (workflow = "Basecall_2D_000", configFile = "basecall_2d_field_map.cfg", 
    summaryFile = "results.csv", metrichorFolder = "data") 
{
    repmap <- ParseConfig(configFile)
    columnNames <- c("channel", "mux", "read_number", "file_number", 
        "strand_start", "duration")
    for (section in names(repmap)) {
        columnNames <- c(columnNames, unlist(repmap[[section]]))
    }
    files <- list.files(metrichorFolder, pattern = "\\.fast5$", 
        full.names = TRUE)
    summary.df <- data.frame(matrix(NA, 1, length(columnNames), 
        dimnames = list(character(0), columnNames)))
    summaryRow <- 0
    for (fname in files) {
        fileNumber <- getFileNumber(fname)
        if (is.na(fileNumber)) {
            next
        }
        if (!keyExists(fname, "UniqueGlobalKey/read_id")) {
            next
        }
        channel <- getChannelNumber(fname)
        mux <- getMux(fname)
        readNumber <- getReadNumber(fname)
        if (is.na(readNumber)) {
            next
        }
        datasetName <- sprintf("Analyses/EventDetection_000/Reads/Read_\%d/Events", 
            readNumber)
        eventData <- h5read(fname, datasetName, read.attributes = TRUE)
        strandStart <- attr(eventData, "start_time")
        duration <- attr(eventData, "duration")
        vals <- c(channel, mux, readNumber, fileNumber, strandStart, 
            duration)
        names(vals) <- columnNames[1:length(vals)]
        for (section in names(repmap)) {
            field = sprintf("Analyses/\%s/Summary/\%s", workflow, 
                section)
            if (keyExists(fname, field)) {
                data = h5read(fname, field, read.attributes = TRUE)
                newVals <- sapply(names(repmap[[section]]), attr, 
                  x = data)
                names(newVals) <- unlist(repmap[[section]])
                vals <- append(vals, newVals)
            }
        }
        summaryRow <- summaryRow + 1
        summary.df[summaryRow, names(vals)] <- vals
    }
    write.csv(summary.df, summaryFile, row.names = FALSE)
    pdf("summaryPlots.pdf", paper = "a4r", width = 11, height = 8)
    data.frame <- read.csv(summaryFile)
    hist(data.frame$num_events, col = "red", main = "Distribution of Events")
    hist(data.frame$num_template_events, col = "red", main = "Distribution of Template Events")
    hist(data.frame$num_complement_events, col = "red", main = "Distribution of Complement Events")
    layout(mat = c(1, 2))
    lim <- max(data.frame[, c("num_template_events", "num_complement_events")])
    plot(data.frame$num_template_events, data.frame$num_complement_events, 
        xlab = "Template Events", ylab = "Complement Events", 
        main = "Template vs Complement Events", xlim = c(0, lim), 
        ylim = c(0, lim))
    templateSpeed <- data.frame$num_template_events/data.frame$duration_template
    complementSpeed <- data.frame$num_complement_events/data.frame$duration_complement
    lim <- max(templateSpeed, complementSpeed, na.rm = TRUE)
    plot(templateSpeed, complementSpeed, xlab = "Template Speed", 
        ylab = "Complement Speed", main = "Template vs Complement Speed", 
        xlim = c(0, lim), ylim = c(0, lim))
    numComplement <- dim(subset(data.frame, num_complement_events != 
        0))[1]
    numTemplate <- dim(subset(data.frame, num_template_events != 
        0))[1]
    percent <- 0
    if (numComplement > 0) {
        percent <- (numComplement/numTemplate) * 100
    }
    cat(sprintf("Proportion of events with complements: \%.2f\%\%\n", 
        percent))
    graphics.off()
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
