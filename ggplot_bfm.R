ggplot_bfm <- function(x, order, formula) {
  
  ggdf <- bfastpp(x$data, order = order)
  ggdf[,'breaks'] <- NA
  ggdf[,'monitor'] <- NA
  ggdf$breaks[x$breakpoint == ggdf$time] <- 1
  ggdf$monitor[x$monitor[1] == ggdf$time] <- 1
  
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
  ggdfSub <- subset(ggdfSub0, time >= x$history[1] & time <= x$breakpoint)
  
  gg +
    geom_line(data = ggdfSub, aes(time, pred), color = 'purple')
  
}
