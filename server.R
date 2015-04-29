library(zoo)
library(bfast)
library(ggplot2)
library(lubridate)
library(dplyr)
source('fortify.bfastmonitor.R')
source('ggplot_bfm.R')
source('runPixelExo.R')
ts <- readRDS('data//landsatZoo.rds')

shinyServer(
  function(input, output) {
    output$bfmPlot <- renderPlot({
      
      # Reformat variable selected in UI
      formula <- switch(input$formula,
                        'trend' = response ~ trend,
                        'trend + harmon' = response ~ trend + harmon,
                        'harmon' = response ~ harmon)
      
      year <- decimal_date(input$year)
      
      id <- as.numeric(input$id)
      
      order <- input$order
      
      history <- input$history
      
      plotType <- switch(input$plotType,
                         'ggplot' = TRUE,
                         'base' = FALSE)
      
      
      
      ### Plotting function
      l <- ts[,id] / 10000
      pixel <- runPixel(x=l, start=year,
                        formula = formula, order = order,
                        history = history)
      
      if(!plotType) {
        plot(pixel)
      } else {
        ggplot_bfm(pixel, order, formula)
      }
      
      

      
    })
  }
)
