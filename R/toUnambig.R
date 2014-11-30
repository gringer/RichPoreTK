toUnambig <- function(ambigBases){
    ## given a string containing ambiguous bases, generate a list of
    ## all possible unambiguous sequences that could match that string
    if(length(ambigBases) > 1){
        res <- sapply(ambigBases, toUnambig, simplify=FALSE);
        return(res);
    }
    lookup <- unlist(list(A="A", C="C", G="G", T="T", U="T",
                          Y="CT", R="AG",
                          S="CG", W="AT",
                          M="AC", K="GT",
                          B="CGT", D="AGT", H="ACT", V="ACG",
                          N="ACGT"));
    base.opts <- unlist(lapply(strsplit(toupper(ambigBases),""),function(x){lookup[x]}));
    return(Reduce(x=base.opts, init="", f=function(x,y){
        as.vector(outer(x,unlist(strsplit(y,"")),paste,sep=""))}));
}
