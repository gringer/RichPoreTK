rescaleRaw <- function(rawSignal, channelMeta, runMedian=FALSE){
    ## Converts from raw signal to pA, using channel metadata
    if(runMedian){
        (runmed(x,7)+channelMeta["offset"]) * 
           channelMeta["range"]/channelMeta["digitisation"];
    } else {
        (x+channelMeta["offset"]) * 
           channelMeta["range"]/channelMeta["digitisation"];
    }
}
