runSummary <-
function(
    ## the workflow that was run
    workflow='Basecall_2D_000',
    ## The config file mapping attributes to column names
    configFile='basecall_2d_field_map.cfg',
    ## The summary filename written by this cookbook
    summaryFile='results.csv',
    ## The directory containing the fast5 files from Metrichor
    metrichorFolder='data'){

    ## Shows the aggregation of selected metrics from fast5 files from Metrichor

    repmap <- ParseConfig(configFile);

    ## Iterate over all the fast5 files and write a summary file

    columnNames <- c('channel', 'mux', 'read_number', 'file_number',
                     'strand_start', 'duration');
    for(section in names(repmap)){
        columnNames <- c(columnNames, unlist(repmap[[section]]));
    }

    files <- list.files(metrichorFolder, pattern = "\\.fast5$", full.names = TRUE);

    summary.df <- data.frame(matrix(NA,1,length(columnNames),
                                    dimnames=list(character(0), columnNames)));
    summaryRow <- 0;
    for(fname in files){
        fileNumber <- getFileNumber(fname);
        if(is.na(fileNumber)){
            next;
        }
        if(!keyExists(fname, "UniqueGlobalKey/read_id")){
            next;
        }
        ## get attributes for read
        channel <- getChannelNumber(fname);
        mux <- getMux(fname);
        readNumber <- getReadNumber(fname);
        if(is.na(readNumber)){
            next;
        }
        datasetName <- sprintf("Analyses/EventDetection_000/Reads/Read_%d/Events",readNumber);
        ## TODO: a bit inefficient... h5read forces you to load the data
        ## even if you just want the attributes, see ?h5read
        eventData <- h5read(fname, datasetName, read.attributes = TRUE);
        strandStart <- attr(eventData, "start_time");
        duration <- attr(eventData, "duration");
        vals <- c(channel, mux, readNumber, fileNumber, strandStart, duration);
        names(vals) <- columnNames[1:length(vals)];
        ## Iterate through sections in config file to get summary data
        for(section in names(repmap)){
            field = sprintf("Analyses/%s/Summary/%s", workflow, section);
            if(keyExists(fname, field)){
                ## TODO: again inefficient... a custom method for loading
                ## attributes only would be useful here
                data = h5read(fname, field, read.attributes = TRUE);
                newVals <- sapply(names(repmap[[section]]),attr,x=data);
                names(newVals) <- unlist(repmap[[section]]);
                vals <- append(vals,newVals);
            }
        }
        summaryRow <- summaryRow + 1;
        summary.df[summaryRow,names(vals)] <- vals;
    }

    write.csv(summary.df, summaryFile, row.names=FALSE);

#### Plots

    pdf("summaryPlots.pdf",paper = "a4r", width = 11, height = 8);

    data.frame <- read.csv(summaryFile);

    hist(data.frame$num_events, col = "red", main = "Distribution of Events");

    hist(data.frame$num_template_events, col = "red",
         main = "Distribution of Template Events");

    hist(data.frame$num_complement_events, col = "red",
         main = "Distribution of Complement Events");

    layout(mat=c(1,2));

    lim <- max(data.frame[,c("num_template_events","num_complement_events")]);
    plot(data.frame$num_template_events, data.frame$num_complement_events,
         xlab = "Template Events", ylab = "Complement Events",
         main = "Template vs Complement Events",
         xlim = c(0,lim), ylim = c(0,lim));

    ## assuming these should be events / speed for the respective category,
    ## rather than for the opposing category as in the cookbook code
    ## [py] template_speed = df['num_template_events'] / df['duration_complement']
    templateSpeed <-
        data.frame$num_template_events / data.frame$duration_template;
    ## [py] complement_speed = df['num_complement_events'] / df['duration_template']
    complementSpeed <-
        data.frame$num_complement_events / data.frame$duration_complement;
    lim <- max(templateSpeed, complementSpeed, na.rm = TRUE);

    plot(templateSpeed, complementSpeed,
         xlab = "Template Speed", ylab = "Complement Speed",
         main = "Template vs Complement Speed",
         xlim = c(0,lim), ylim = c(0,lim));

    numComplement <- dim(subset(data.frame, num_complement_events != 0))[1];
    numTemplate <- dim(subset(data.frame, num_template_events != 0))[1];

    percent <- 0;
    if(numComplement > 0){
        percent <- (numComplement / numTemplate) * 100;
    }
    cat(sprintf("Proportion of events with complements: %.2f%%\n",percent));

    graphics.off();
}
