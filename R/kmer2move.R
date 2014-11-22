kmer2move <- function(kmerSeq){
    ## convert a sequence of kmers into base move offsets
    kmer.1 <- head(kmerSeq, -1);
    kmer.2 <- tail(kmerSeq, -1);
    kl <- nchar(kmer.1[1]);
    move <- rep(kl,length(kmer.1));
    for(i in 1:(kl-1)){
        move[substring(kmer.1,kl-i+1) == substring(kmer.2,1,i)] <- (kl-i);
    }
    move[kmer.1 == kmer.2] <- 0;
    return(c(0,move));
}
