getSignal <- function(fname, channel, startSample, endSample){
    ## read raw signal from a fast5 file
    cat(sprintf("Getting signal from channel %g[%g..%g]\n",
                channel, startSample, endSample));
    fid <- H5Fopen(fname);
    did <- H5Dopen(fid, sprintf("Raw/Channel_%d/Signal",channel));
    ## warning... might be an off-by-1 error here
    readSignal <- H5Dread(did)[(startSample+1):endSample];
    H5Dclose(did);
    H5Fclose(fid);
    return(readSignal);
}
