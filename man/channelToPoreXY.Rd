\name{channelToPoreXY}
\alias{poreXYToChannel}
\title{Convert channel number to/from physical pore location}

\description{
  These functions are for converting the channel number (and
  mux) reported in the FAST5 file to the physical pore that the channel
  represents. Both forward and reverse conversions are available.
}

\usage{
poreXYToChannel(px = rep(0:67,32), py = rep(0:31,each=68),
                hasGap = TRUE)
channelToPoreXY(channelNum=rep(1:512, each=4), mux=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{px}{X location of physical pore}
  \item{py}{Y location of physical pore}
  \item{hasGap}{if TRUE, include calculation for central gap}
  \item{channelNum}{Channel number from FAST5 file}
  \item{mux}{Multiplex selection from FAST5 file}
}
\details{
  If mux is NULL, then it will be set to 1:4 and re-used as necessary to
  create a mux value for all elements of channelNum.
}
\value{
  A data frame containing information on the mapping between channel and
  physical location. The output format is identical for both the forward
  and reverse conversions:

  \item{px}{X location of physical pore}
  \item{py}{Y location of physical pore}
  \item{channelNum}{Channel number from FAST5 file}
  \item{mux}{Multiplex selection from FAST5 file}
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
## Generate hexagon plot of pores, with labelled channels
data.df <- channelToPoreXY();
plot(data.df$x, data.df$y,
     pch = 16, col = c("#D6BA76","#A29BEA","#D68B8B","#8ABF8A")[data.df$mux],
     cex = 2, axes = FALSE, xlab = "", ylab = "");
text(data.df, labels=data.df$poreNum,
     cex = 0.8 / sqrt(nchar(as.character(data.df$poreNum))));

## Create rotated symbolic plot of pores, with labelled channels
plot(NA,xlim = c(0,32), ylim = c(0,17), axes = FALSE,
     ylab = "", xlab = "", xaxs = "i", yaxs = "i",
     panel.first = abline(v=0:32,h=0:17));
data.df <- poreXYToChannel();
data.df$x[is.na(data.df$poreNum)] <- NA;
data.df$tx <- data.df$y;
data.df$ty <- 17 - data.df$x / 4;
data.df$mx <- data.df$x %% 4;
data.df$ry <- ceiling(16 - data.df$x / 4);
points(x = data.df$tx+0.15 + (((3-data.df$mx) + floor(data.df$mx/2))%%2)*0.7,
       y = data.df$ry+0.15 + (1-floor((data.df$mx)/2))*0.7);
points(x = data.df$tx+0.15 + (((3-data.df$mx) + floor(data.df$mx/2))%%2)*0.7,
       y = data.df$ry+0.15 + (1-floor((data.df$mx)/2))*0.7,
       pch = 16, cex = 0.8,
       col = c("#D6BA76","#A29BEA","#D68B8B","#8ABF8A")[data.df$mux]);
yadj <- strheight("0", cex = 1)/3;
text(x = tapply(data.df$tx, data.df$poreNum, mean) + 0.5,
     y = tapply(data.df$ty, data.df$poreNum, mean) - yadj,
     adj = c(0.5,0.5), offset = 0,
     labels = names(tapply(data.df$x, data.df$poreNum, mean)),
     cex = 1);
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~manip }% __ONLY ONE__ keyword per line
