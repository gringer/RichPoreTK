getAlign <- function(mafFileStr, searchPat=NULL){
    myConn <- file(mafFileStr,open="r");
    res <- NULL;
    alignStrs <- data.frame();
    line <- 1;
    alignment <- 0;
    fileEnd <- FALSE;
    #while((!fileEnd) && (line < 20) && (dim(alignStrs)[1] < 2)){
    while(!fileEnd){
        res <- readLines(myConn, n=1);
        if(length(res) == 0){
            fileEnd <- TRUE;
            next;
        }
        if(nchar(res) == 0){
            next;
        }
        flag <- substring(res,1,1);
        if(flag == "#"){
            next;
        }
        if(flag == "a"){
            alignment <- alignment + 1;
        }
        if(flag == "s"){
            res <- unlist(strsplit(res," +"))[-1];
            names(res) <- c("src","start","size","strand","srcSize","text");
            ## note: strand is not taken into account when determining location
            inserts <- paste(c(gregexpr("-",res["text"])[[1]]),collapse=";");
            alignStrs <- rbind(alignStrs,
                               data.frame(aln=alignment, src=res["src"],
                                          start=as.numeric(res["start"]),
                                          strand=res["strand"], text=res["text"],
                                          inserts=inserts, stringsAsFactors=FALSE));
        }
        line <- line+1;
    }
    close(myConn);
    if(!is.null(searchPat)){
        aln.id <- alignStrs$aln[grep(searchPat,alignStrs$src)];
        return(subset(alignStrs, aln == aln.id));
    }
    else {
        return(alignStrs);
    }
}
