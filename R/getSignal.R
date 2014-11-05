getSignal <- function(fname, channel){
    ## fast5File <- "/home/gringer/bioinf/MIMR-2014-Feb-17-OXNP/data/4T1_FC2_Jul-17/bundled/mimr-minion_BN_011_34887GT_James_4T1_mtDNA_3_5506_1.fast5";
    ## channel <- 266;

    fid <- H5Fopen(fname);
    gid <- H5Gopen(fid, sprintf("Raw/Channel_%d",channel));
    did <- H5Dopen(gid, "Signal");
    readSignal <- H5Dread(did);
    H5Dclose(did);
    aid <- H5Aopen(gid, sprintf("Channel_%d",channel));
    
    H5Gclose(gid);
    H5Fclose(fid);

    signalMeta <- h5read(fname, sprintf("Raw/Channel_%d/Meta",channel), readAttributes = TRUE);
    readSignal <- h5read(fname, sprintf("Raw/Channel_%d",channel),
                         readAttributes = TRUE);
}

sigStart <- 4848.0324 * 5000;
sigEnd <- 5103.7546 * 5000;

plot(readSignal[seq(sigStart-50000,sigEnd+10000,by=100)], type = "p", pch = ".");
