library(reshape2)
library(dplyr)
library(ggplot2)
library(bfastExoSpatial)
library(bfast)

# load('data/sampledPixelsModisLandsat.rda')
load('data/timeSyncExtractZoo.rda') # LandsatZoo + exo11Zoo
source('R/fortify.bfastmonitor.R')
source('R/runPixelExo.R')
source('R/multiplot.R')

# Check package gridExtra to mimic facetting without merging all in one df

114 148 162 165 170 172 173 179 186 187 195 213 224 226 234 235 246 248 256 257 273 277 278 280 286 298 300

# Best omissions : 257    
# Comissions: 6, 12, 75, 82
# Comission2: 14, start = c(2005,1)

id <- 14
l <- LandsatZoo[,id] / 10000
exoReg <- exo11Zoo[,id] / 10000
pixel <- runPixel(x=l, start=c(2005,1),
         formula = response ~ harmon, order = 1)

exo <- runExo(x=l, start=c(2005,1),
               order = 1, exo=exoReg)



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





####
ggdf <- fortify(exo)

g0 <- ggplot(ggdf)

if(!all(is.na(ggdf$breakpoint))) {
    g0 <- g0 + geom_rect(aes(xmax=Inf, xmin=filter(ggdf, !is.na(breakpoint))$time, ymin=-Inf, ymax=Inf), fill = 'grey90')
}

g1 <- g0 + geom_point(aes(time, response)) +
    geom_line(data=filter(ggdf, stable %in% c(1,2)), aes(time, pred, color=action)) +
    scale_color_manual(values = c("blue", "darkgreen"), guide=FALSE)


if(!all(is.na(ggdf$breakpoint))) {
    g1 <- g1 + geom_vline(xintercept = filter(ggdf, !is.na(breakpoint))$time, color = 'red', linetype= 'dashed') +
        geom_point(data=filter(ggdf, stable == 3), aes(time, response), color='red')
}

g2 <- g1 + geom_vline(xintercept = tail(filter(ggdf, stable == 1), 1)$time) +
    ggtitle("B") +
    theme_bw() +
    theme(axis.title=element_text(face="bold"), legend.key = element_rect(colour = "white"), 
          plot.title = element_text(hjust = 0))


exogg <- g2 + labs(x = "Years",
          y = 'NDVI (-)')


multiplot(pixelgg, exogg)

#export with 1000 * 579
