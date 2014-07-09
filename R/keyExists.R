keyExists <-
function(fileName, keyName){
    fid <- H5Fopen(fileName);
    retVal <- H5Lexists(fid, keyName);
    H5Fclose(fid);
    return(retVal);
}
