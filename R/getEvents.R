getEvents <- function(fname, readNumber, sampleRate, readType = "all"){
    ## retrieve event data from a FAST5 file
    if(!readType %in% c("template","complement","2D", "all")){
        stop("Read type must be one of 'template','complement', '2D', or 'all'");
    }
    fid <- H5Fopen(fname);
    if(readType == "all"){
        did <- H5Dopen(fid,
                       sprintf("Analyses/EventDetection_000/Reads/Read_%d/Events",
                               readNumber));
        readEvents <- H5Dread(did, bit64conversion='bit64');
        H5Dclose(did);
        H5Fclose(fid);
        rownames(readEvents) <- 0:(dim(readEvents)[1]-1);
        return(readEvents);
    } else if(readType == "2D") {
        didTem <- H5Dopen(fid, "Analyses/Basecall_2D_000/BaseCalled_template/Events");
        didCom <- H5Dopen(fid, "Analyses/Basecall_2D_000/BaseCalled_complement/Events");
        didAln <- H5Dopen(fid,"Analyses/Basecall_2D_000/BaseCalled_2D/Alignment");
        readAln <- H5Dread(didAln, bit64conversion='bit64');
        tmp.events <- list(template=H5Dread(didTem, bit64conversion='bit64'),
                           complement=H5Dread(didCom, bit64conversion='bit64'));
        H5Dclose(didAln);
        H5Dclose(didTem);
        H5Dclose(didCom);
        H5Fclose(fid);
        readAln$template <- as.numeric(readAln$template)+1;
        readAln$complement <- as.numeric(readAln$complement)+1;
        readAln$template[readAln$template == 0] <- NA;
        readAln$complement[readAln$complement == 0] <- NA;
        for(type in c("template","complement")){
            for(stat in c("mean","stdv")){
                readAln[[paste(stat,type,sep=".")]] <-
                    as.numeric((tmp.events[[type]])[[stat]][readAln[[type]]]);
            }
            for(stat in c("start","length")){
                readAln[[paste(stat,type,sep=".")]] <-
                    as.numeric((tmp.events[[type]])[[stat]][readAln[[type]]]) * sampleRate;
            }
        }
        readAln$move <- kmer2move(readAln$kmer);
        readAln$called.pos <- cumsum(readAln$move) + 1;
        rownames(readAln) <- 0:(dim(readAln)[1]-1);
        return(readAln);
    } else {
        did <- H5Dopen(fid,
                sprintf("Analyses/Basecall_2D_000/BaseCalled_%s/Events",
                        readType));
        readEvents <- H5Dread(did, bit64conversion='bit64');
        readEvents$kmer <- readEvents$model_state;
        readEvents$start <- readEvents$start * sampleRate;
        readEvents$length <- readEvents$length * sampleRate;
        readEvents$move <- as.numeric(readEvents$move);
        readEvents$called.pos <- cumsum(readEvents$move) + 1;
        readEvents <- readEvents[,c("mean","stdv","start","length","kmer","move","called.pos")];
        H5Dclose(did);
        H5Fclose(fid);
        rownames(readEvents) <- 0:(dim(readEvents)[1]-1);
        return(readEvents);
    }
}
