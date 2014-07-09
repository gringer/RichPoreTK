getSeq <-
function(fastQSeq){
    qualAsc <- strsplit(fastQSeq, "\n")[[1]][2];
    return(qualAsc);
}
