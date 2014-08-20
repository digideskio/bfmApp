library(zoo)
library(bfast)
library(ggplot2)
library(lubridate)
library(dplyr)
source('fortify.bfastmonitor.R')
source('runPixelExo.R')
ts <- readRDS('data/landsatZoo.rds')

id <- 14
year <- decimal_date(as.Date('2005-01-01'))
formula <- response ~ trend + harmon
order <- 1
history <- "ROC" # Or numeric slider

l <- ts[,id] / 10000
pixel <- runPixel(x=l, start=year,
                  formula = formula, order = order,
                  history = history)



ggdfP <- fortify(pixel)

g0P <- ggplot(ggdfP)

if(!all(is.na(ggdfP$breakpoint))) {
  g0P <- g0P + geom_rect(aes(xmax=Inf, xmin=filter(ggdfP, !is.na(breakpoint))$time, ymin=-Inf, ymax=Inf), fill = 'grey90')
}

g1P <- g0P + geom_point(aes(time, response)) +
  geom_line(data=filter(ggdfP, stable %in% c(1,2)), aes(time, pred, color=action)) +
  scale_color_manual(values = c("blue", "darkgreen"), guide=FALSE)


if(!all(is.na(ggdfP$breakpoint))) {
  g1P <- g1P + geom_vline(xintercept = filter(ggdfP, !is.na(breakpoint))$time, color = 'red', linetype= 'dashed') +
    geom_point(data=filter(ggdfP, stable == 3), aes(time, response), color='red')
}

g2P <- g1P + geom_vline(xintercept = tail(filter(ggdfP, stable == 1), 1)$time) +
  ggtitle("A") +
  theme_bw() +
  theme(axis.title=element_text(face="bold"), legend.key = element_rect(colour = "white"), 
        plot.title = element_text(hjust = 0))

pixelgg <- g2P + labs(x = "Years",
                      y = 'NDVI (-)')



