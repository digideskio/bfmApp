ggplot_bfm <- function(x, order, formula, h = 0.25) {
  
  ggdf <- bfastpp(x$data, order = order)
  ggdf[,'breaks'] <- NA
  ggdf[,'monitor'] <- NA
  ggdf$breaks[x$breakpoint == ggdf$time] <- 1
  ggdf$monitor[x$monitor[1] == ggdf$time] <- 1
  
  # History df (usefull later for the mosum)
  monitordf <- subset(ggdf, time >= x$monitor[1])
  
  xIntercept <- ggdf$time[ggdf$breaks == 1]
  xIntercept2 <- ggdf$time[ggdf$monitor == 1]
  
  gg <- ggplot(ggdf, aes(time, response)) +
    geom_line() +
    geom_point(color = 'green') +
    geom_vline(xintercept = xIntercept, color = 'red', linetype = 'dashed') +
    geom_vline(xintercept = xIntercept2, color = 'blue', linetype = 'dashed') +
    scale_x_continuous(breaks=floor(min(ggdf$time)):ceiling(max(ggdf$time))) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1))
  
  
  # Predict with daily values and filter to the right range
  ggdfSub0 <- bfastpp(x$data, na.action=na.pass, order=order)
  ggdfSub0$pred <- predict(x$model, ggdfSub0)
  ggdfSub0$residuals <- ggdfSub0$response - ggdfSub0$pred
  ggdfSub0$mosum <- rollapply(ggdfSub0$residuals, round(nrow(monitordf) * h) , FUN = sum, fill = NA, align = 'right')
  ggdfSub0$mosumAbs <- abs(ggdfSub0$mosum)
  ggdfSub <- subset(ggdfSub0, time >= x$history[1] & time <= x$breakpoint)
  ggMonitor <- subset(ggdfSub0, time >= x$monitor[1])
  
  gg +
    geom_line(data = ggMonitor, aes(time, mosumAbs), color = 'orange') +
    geom_line(data = ggdfSub, aes(time, pred), color = 'purple')

  
}
