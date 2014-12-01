rescaleRaw <- function(rawSignal, channelMeta, runMedian=FALSE){
    ## Converts from raw signal to pA, using channel metadata
    if(runMedian){
        (runmed(rawSignal,7)+channelMeta["offset"]) * 
           channelMeta["range"]/channelMeta["digitisation"];
    } else {
        (rawSignal+channelMeta["offset"]) * 
           channelMeta["range"]/channelMeta["digitisation"];
    }
}
