getFileNumber <-
function(fname){
    fSearch <- regexpr("_file(?<fnum>(\\d+))[_\\.]",fname, perl=TRUE);
    if(attr(fSearch,"capture.start")[1,"fnum"] != -1){
        start <- attr(fSearch,"capture.start")[1,"fnum"];
        end <- start + attr(fSearch,"capture.length")[1,"fnum"] - 1;
        return(as.numeric(substr(fname,start,end)));
    } else {
        return(NA);
    }
}
