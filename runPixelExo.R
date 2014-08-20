
runPixel <- function(x, ...) {
    ts <- bfastts(x, dates=index(x), type='irregular')
    bfm <- bfastmonitor(ts, ...)
    return(bfm)
}


runExo <- function(x, exo, ...) {
    ts <- bfastts(x, dates=index(x), type='irregular')
    exots <- bfastts(exo, dates=index(exo), type='irregular')
    bfmExo(ts=ts, exo=exots, ...)   
}
