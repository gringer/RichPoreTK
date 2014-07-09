getChannelNumber <-
function(fname){
    readAttrs <- h5read(fname, "UniqueGlobalKey/read_id", read.attributes = TRUE);
    return(as.numeric(attr(readAttrs, "channel_number")));
}
