qualityScoreStats <-
function(
    ## the workflow that was run
    workflow='Basecall_2D_000',
    ## The directory containing the fast5 files from Metrichor
    metrichorFolder='data'){
    ## Iterate over all the fast5 files and get the quality scores

    files <- list.files(metrichorFolder, pattern = "\\.fast5$", full.names = TRUE);

    bases <- NULL;
    mean.scores <- NULL;

    ## File Processing
    for(fname in files){
        ## this produces errors complaining about invalid object IDs, etc
        templatePath <-
            sprintf("Analyses/%s/BaseCalled_template", workflow);
        twoDPath <- sprintf("Analyses/%s/BaseCalled_2D", workflow);
        fastq <- NULL;
        if(!(keyExists(fname, templatePath))){
            next;
        }
        if(keyExists(fname, twoDPath)){
            fastq <- h5read(fname, bit64conversion="bit64",
                            sprintf("Analyses/%s/BaseCalled_2D/Fastq",workflow));
        } else {
            fastq <-
                h5read(fname, bit64conversion="bit64",
                       sprintf("Analyses/%s/BaseCalled_template/Fastq", workflow));
        }
        mean.scores[length(mean.scores)+1] <- mean(getQuals(fastq));
        bases[length(bases)+1] <- nchar(getSeq(fastq));
    }

    ## Plots

    pdf("quality_scores.pdf",paper = "a4r", width = 11, height = 8);

    hist(mean.scores, main="Distribution of mean quality scores", col="red");

    plot(x=bases, y=mean.scores, xlab="Number of bases", ylab="Mean quality score",
         main="Mean quality scores vs number of bases");

    graphics.off();
}
