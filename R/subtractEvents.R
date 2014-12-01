subtractEvents <- function(scaledRawData, eventData, eventRange = NULL){
    if(eventRange == NULL){
        eventRange <- seq_len(dim(eventData)[1]);
    }
    with(eventData[eventRange,],{
        e.starts <- na.omit(start);
        e.means <- na.omit(mean);
        e.starts <- e.starts - min(e.starts);
        eventposs <- cut(eventRange, e.starts, labels=FALSE,
                         include.lowest=TRUE);
        base.loc <- cumsum(rep(1,length(eventposs)) /
                               table(eventposs)[eventposs])-1;
        return(cbind(base.loc, data.inp - e.means[eventposs]));
    });
}
