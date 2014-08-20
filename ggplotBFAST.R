ggplotBFAST <- function(x) {
  
  g0P <- ggplot(x)
  
  if(!all(is.na(x$breakpoint))) {
    g0P <- g0P + geom_rect(aes(xmax=Inf, xmin=filter(x, !is.na(breakpoint))$time, ymin=-Inf, ymax=Inf), fill = 'grey90')
  }
  
  g1P <- g0P + geom_point(aes(time, response)) +
    geom_line(data=filter(x, stable %in% c(1,2)), aes(time, pred, color=action)) +
    scale_color_manual(values = c("blue", "darkgreen"), guide=FALSE)
  
  
  if(!all(is.na(x$breakpoint))) {
    g1P <- g1P + geom_vline(xintercept = filter(x, !is.na(breakpoint))$time, color = 'red', linetype= 'dashed') +
      geom_point(data=filter(x, stable == 3), aes(time, response), color='red')
  }
  
  g2P <- g1P + geom_vline(xintercept = tail(filter(x, stable == 1), 1)$time) +
    ggtitle("A") +
    theme_bw() +
    theme(axis.title=element_text(face="bold"), legend.key = element_rect(colour = "white"), 
          plot.title = element_text(hjust = 0))
  
  pixelgg <- g2P + labs(x = "Years",
                        y = 'NDVI (-)')
  
  pixelgg
}
