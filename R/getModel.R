getModel <- function(fname, modelDir = "template"){
    ## retrieve model data from a FAST5 file
    if(!modelDir %in% c("template","complement")){
        stop("Model direction must be one of 'template','complement'");
    }
    fid <- H5Fopen(fname);
    did <- H5Dopen(fid,
                   sprintf("Analyses/Basecall_2D_000/BaseCalled_%s",
                           modelDir));
    readModel <- H5Dread(did, bit64conversion='bit64');
    H5Dclose(did);
    H5Fclose(fid);
    return(readModel);
}
