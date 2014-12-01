rescaleRaw <- function(rawSignal, channelMeta, runMedian=FALSE){
    ## Converts from raw signal to pA, using channel metadata
    with(channelMeta, {
        if(runMedian){
            (runmed(x,7)+offset) * range/digitisation;
        } else {
            (x+offset) * range/digitisation;
        }
    });
}
