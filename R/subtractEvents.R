subtractEvents <- function(scaledRawData, eventData, eventRange = NULL){
    if(is.null(eventRange)){
        eventRange <- seq_len(dim(eventData)[1]);
    }
    with(eventData[eventRange,],{
        e.starts <- na.omit(start);
        e.lengths <- na.omit(length);
        e.means <- na.omit(mean);
        e.starts <- e.starts - min(e.starts);
	signalRange <- seq_along(scaledRawData);
        eventposs <- cut(signalRange-1, e.starts, labels=FALSE,
                         include.lowest=TRUE);
        base.loc <- cumsum(rep(1,length(eventposs)) /
                               table(eventposs)[eventposs])+eventRange[1]-1;
        return(cbind(base.loc, scaledRawData - e.means[eventposs]));
    });
}
