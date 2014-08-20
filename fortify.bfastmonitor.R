
fortify.bfastmonitor <- function(x, na.action=na.pass, melt=FALSE){
    order<- floor((length(x$model$coefficients) - 1)/2)
    pp <- bfastpp(x$data, na.action=na.action, order=order)
    pp$pred <- predict(x$model, pp)
    pp$breakpoint <- NA
    if(!is.na(x$breakpoint)) {
        pp$breakpoint[pp$time == x$breakpoint] <- pp$response[pp$time == x$breakpoint]
    }
    pp$action <- NA
    pp$action[pp$time >= x$history[1] & pp$time <= x$monitor[1]] <- 'fit'
    pp$action[pp$time >= x$monitor[1] & pp$time <= x$monitor[2]] <- 'monitor'
    pp$stable <- 0
    pp$stable[pp$time >= x$history[1] & pp$time <= x$monitor[1]] <- 1
    if(!is.na(x$breakpoint)) {
        pp$stable[pp$time > x$monitor[1] & pp$time <= x$breakpoint] <- 2
        pp$stable[pp$time > x$breakpoint & pp$time <= x$monitor[2]] <- 3
    } else {
        pp$stable[pp$time > x$monitor[1]] <- 2
    }              
    return(pp)
}