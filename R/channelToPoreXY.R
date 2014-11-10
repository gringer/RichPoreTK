channelToPoreXY <- function(channelNum=rep(1:512, each=4),
                           mux=NULL){
    if(is.null(mux)){
        mux <- rep(1:4,length(channelNum))[1:length(channelNum)];
    }
    ## convert pore number to base 0 (makes arithmetic easier)
    c0 <- channelNum-1;
    frame <- floor(c0 / 32); # 0..15
    side <- (frame %% 2); # 0: left, 1: right
    rightSide <- side == 1;
    yframe <- (floor(frame / 2) + 7) %% 8; # 0..7 [bottom..top]
    fPos <- c0 %% 32;
    framex <- fPos %% 8;
    framex[rightSide] <- 7 - (fPos[rightSide] %% 8);
    framey <- (3 - floor(fPos / 8));
    ## convert MUX to 0..3 for easier arithmetic
    m0 <- (mux+1) %% 4;
    muxRev <- (framex %% 2) == 1;
    m0[muxRev] <- 3-m0[muxRev];
    ## generate X,Y locations (with origin bottom left)
    px <- (side*8 + framex) * 4 + m0;
    py <- yframe * 4 + framey;
    ## adjust for central gap
    px[px>31] <- px[px>31]+4;
    ## adjust for hexagonal grid
    px <- px + (py %% 2) * sqrt(3)/4;
    return(data.frame(px=px, py=py, channelNum=channelNum, mux=mux,
                      frame=frame, m0=m0));
}

