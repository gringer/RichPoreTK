getAlignMat <- function(mafFileStr, ref){
    myConn <- file(mafFileStr,open="r");
    res <- NULL;
    alignStrs <- data.frame();
    line <- 1;
    alignment <- 0;
    alignText <- list();
    alignMat <- matrix(0, 5, 5, dimnames=list(c("A","C","G","T","-"),
                                    c("A","C","G","T","-")));
    align.pat <- "";
    align.sub <- "";
    fileEnd <- FALSE;
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
            ## new alignment
            alignment <- alignment + 1;
            align.pat <- "";
            align.sub <- "";
        }
        if(flag == "s"){
            ## alignment text
            res <- unlist(strsplit(res," +"))[-1];
            names(res) <- c("src","start","size","strand","srcSize","text");
            ## note: strand is not taken into account when determining location
            if(res["src"] == ref){
                align.sub <- res["text"];
            } else {
                align.pat <- res["text"];
            }
            if((nchar(align.pat)>0) && (nchar(align.sub)>0)){
                a <- table(strsplit(align.sub,"")[[1]],
                           strsplit(align.pat,"")[[1]]);
                alignMat[rownames(a),colnames(a)] <-
                    alignMat[rownames(a),colnames(a)] + a;
            }
        }
        line <- line+1;
    }
    close(myConn);
    return(alignMat);
}
