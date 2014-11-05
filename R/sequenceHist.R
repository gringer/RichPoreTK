sequence.hist <- function(lengths, invert = TRUE, ...){
    lhist <- hist(lengths, plot = FALSE, breaks = 10);
    seqd.bases <- tapply(lengths,cut(lengths,breaks = lhist$breaks),sum);
    barPos <- barplot(if(invert){rev(seqd.bases)} else {seqd.bases},
                      log = "x", las = 1, axes = FALSE, col = "steelblue",
                      horiz = TRUE, names.arg = rep("",length(seqd.bases)),
                      ylab = "Fragment size (bp)",
                      xlab = "Sequenced bases (number of sequences)", ...);
    barGap <- diff(barPos)[1];
    barOffset <- barPos[1] - barGap/2;
    axis(2, at = if(invert){rev(seq(barOffset,by=barGap,length.out = length(lhist$breaks)))}
         else {seq(barOffset,by=barGap,length.out = length(lhist$breaks))},
         labels = lhist$breaks, las = 2);
    axis(1, at = axTicks(1), labels = valToSci(axTicks(1), "bp"));
    text.poss <- ((log10(seqd.bases) < mean(par("usr")[1:2]))+1)*2;
    text.poss[is.na(text.poss)] <- 4;
    text.col <- c("white","black")[((log10(seqd.bases) < mean(par("usr")[1:2]))+1)];
    text(seqd.bases,if(invert){rev(barPos)} else {barPos},
         paste(seqd.bases, " (", lhist$counts, ")", sep = ""),
         pos=text.poss, col=text.col, cex = 1);
}
