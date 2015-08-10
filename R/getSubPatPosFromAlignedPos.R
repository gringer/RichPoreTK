getSubPatPosFromAlignedPos <- function(insPoss, delPoss, alnPos){
    if(!is.numeric(insPoss)){
        stop("insert/delete positions must be a numeric vector");
    }
    subPos <- alnPos - sum(insPoss < alnPos);
    patPos <- alnPos - sum(delPoss < alnPos);
    return(c(sub=subPos,pat=patPos));
}

