eventPlot <-
function(
    ## The workflow that was run
    workflow='Basecall_2D_000',
    ## The directory containing the fast5 files from Metrichor
    metrichorFolder='data'){

    ## Get the event data from the fast5 files

    strandFile <- list.files(metrichorFolder,
                             pattern = "\\.fast5$", full.names = TRUE)[1];

    readNumber <- getReadNumber(strandFile);
    datasetName <- sprintf("Analyses/EventDetection_000/Reads/Read_%d/Events",readNumber);


    templatePath <- sprintf("Analyses/%s/BaseCalled_template/Events",workflow);
    templateEvents <-
        h5read(strandFile, templatePath, bit64conversion="bit64");

    complementEvents <- NULL;
    complementPath <- sprintf("Analyses/%s/BaseCalled_complement/Events",workflow);
    if(keyExists(strandFile, complementPath)){
        complementEvents <-
            h5read(strandFile, complementPath, bit64conversion="bit64");
    }

    ## Plot Template Trace

    pdf("tracePlot.pdf", paper = "a4r", width = 11, height = 8);

    numEvents <- length(templateEvents$mean);
    seq <- getSeq(strandFile);

    seq <- getSeq(h5read(strandFile, bit64conversion="bit64",
                         sprintf("Analyses/%s/BaseCalled_template/Fastq",workflow)));

    plot(x = 1:numEvents, y = templateEvents$mean, ylab = "Mean Current", type = "l",
         main = "Trace Plot for Template Events");

#### TODO: hmm... tooltips are a bit tricker
    ## [py] tooltip = mpld3.plugins.PointLabelTooltip(trace, list(template_events['model_state']))
    ## [py] mpld3.plugins.connect(fig, tooltip)


    ## Plot Complement Trace

    if(!is.null(complementEvents)){
        numEvents <- length(complementEvents$mean);
#### TODO: not sure what this particular drawstyle means
        ## [py] ax.plot(xrange(num_events), complement_events['mean'], color='red', drawstyle='steps-post')
        plot(x = 1:numEvents, y = complementEvents$mean, col="red",
             ylab = "Mean Current", type = "l",
             main = "Trace Plot for Complementary Events");
#### TODO: tooltips again
        ## [py] tooltip = mpld3.plugins.PointLabelTooltip(trace, list(complement_events['model_state']))
        ## [py] mpld3.plugins.connect(fig, tooltip)
    }

    graphics.off();
}
