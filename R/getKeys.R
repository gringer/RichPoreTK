getKeys <-
function(fileName, keyPath){
    keyPath <- sub("^/","",keyPath); # rhdf5 doesn't like beggining slashes
    fid <- H5Fopen(fileName);
    gid <- NULL;
    if(keyPath != ""){
        gid <- H5Gopen(fid,keyPath);
    }
    retVal <- h5ls(if(is.null(gid)) fid else gid, recursive = FALSE)$name;
    if(!is.null(gid)){
        H5Gclose(gid);
    }
    H5Fclose(fid);
    return(retVal);
}
