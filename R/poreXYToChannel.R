poreXYToChannel <- function(px = rep(0:67,32), py = rep(0:31,each=68),
                            hasGap = TRUE){
    ## round to work with both square and hexagonal grids
    rpx <- round(px + (py %% 2) * sqrt(3)/8);
    if(hasGap){
        ## central gap locations don't have any channels
        rpx[(px > 31) & (px <=35)] <- NA;
        ## remove central gap
        rpx[px>35] <- rpx[px>35] - 4;
    }
    side <- floor(rpx / 32); # 0: left, 1: right
    rightSide <- is.na(side) | (side == 1);
    yframe <- floor((py + 4)/4) %% 8;
    framey <- 3 - (py %% 4);
    framex <- floor((rpx %% 32)/4);
    framex[rightSide] <- 7 - framex[rightSide];
    frame <- yframe * 2 + side;
    c0 <- frame*32 + framey * 8 + framex;
    muxRev <- is.na(framex) | xor((framex %% 2) == 1,rightSide);
    m0 <- rpx %% 4;
    m0[muxRev] <- 3 - m0[muxRev];
    mux <- ((m0 + 2) %% 4) + 1;
    channelNum <- c0 + 1;
    return(data.frame(px=px, py=py, channelNum=channelNum, mux=mux,
                      frame=frame, m0=m0));
}
