getQuals <-
function(fastQSeq){
    qualAsc <- strsplit(fastQSeq, "\n")[[1]][4];
    qualInt <- as.integer(charToRaw(qualAsc)) - 33;
    return(qualInt);
}
