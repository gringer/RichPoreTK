getMux <-
function(fname){
    readAttrs <- h5read(fname, "UniqueGlobalKey/read_id", read.attributes = TRUE);
    if(!("mux" %in% names(attributes(readAttrs)))){
        return(0);
    }
    return(as.numeric(attr(readAttrs, "mux")));
}
