getChannelMeta <- function(fname, channel){
    ## retrieve channel metadata from a fast5 file
    fid <- H5Fopen(fname);
    oid <- H5Oopen(fid, "UniqueGlobalKey/channel_id");
    data.attrs <- list();
    num.attrs <- H5Oget_num_attrs(oid);
    for (i in seq_len(num.attrs)) {
        aid <- H5Aopen_by_idx(oid, n=i-1);
        attrname <- H5Aget_name(aid);
        attrib <- H5Aread(aid);
        if(typeof(attrib) == "character"){
            attrib <- paste(attrib, collapse = "");
        }
        data.attrs[[attrname]] <- as.numeric(attrib);
        H5Aclose(aid);
    }
    H5Oclose(oid);
    H5Fclose(fid);
    return(unlist(data.attrs));
}
