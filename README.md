RichPoreTK
==========

An R package containing tools for processing FAST5 files from Oxford
Nanopore Devices

Goal
----

An R Bioconductor package that can process all FAST5 files from Oxford
Nanopore Devices.

Bioconductor (instead of CRAN) is preferred because the current
scripts use rhdf5, so the package will be synchronised to changes in
rhdf5.

Current Tools
-------------

* valToSci -- conversion from standard to scientific notation (with SI prefixes)
* sequenceHist -- total-length histogram plot
* channelToPoreXY -- convert channel number to physical pore location
* poreXYToChannel -- convert physical pore location to channel number

In-progress Tools
-----------------

* getChannelMeta -- retrieve metadata from a fast5 file
* kmer2move -- convert a sequence of kmers into base move offsets
* getEvents -- retrieve event data from a fast5 file
* getSignal -- read raw signal from a fast5 file

Backburner Tools
----------------
_Note: these tools are not well-developed and need a bit more work_

* getChannelNumber -- get the channel number associated with a file (from read_id metadata)
* getFileNumber -- get the file number associated with a FAST5 file
* getKeys -- get the keys for attributes in a given group of a FAST5 file
* getMux -- get the selected multiplex (mux) associated with a FAST5 file
* getQuals -- extracts quality scores from a single-record fastQ string
* getReadNumber -- get the read number associated with a FAST5 file
* getSeq -- extracts sequence from a single-record fastQ string
* eventPlot -- generate event data statistics from FAST5 files
* keyExists -- determine if a given key (or path) exists in a fast5 file
* ParseConfig -- parse INI-like configuration files
* qualityScoreStats -- produce quality score statistics for fast5 files
* runSummary -- display aggregate statistics fast5 files from Metrichor

