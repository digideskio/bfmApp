library(zoo)
library(bfast)
library(lubridate)
library(dplyr)
source('fortify.bfastmonitor.R')
source('ggplot_bfm.R')
source('runPixelExo.R')
ts <- readRDS('data//landsatZoo.rds')
obs <- readRDS('data/observations.rds')

shinyServer(
  function(input, output) {

    output$ui <- renderUI({
    zooTs <- input$zooTs
    if (is.null(zooTs))
      return(NULL)
    
    zooTs <- readRDS(zooTs$datapath)
        
    n <- ncol(zooTs)        
    selectInput("id",
                label = "Time Series Number", 
                choices = as.list(as.character(seq(1,n))),
                selected = '1')

  })

    output$bfmPlot <- renderPlot({
      
      zooTs <- input$zooTs
      if (is.null(zooTs))
        return(NULL)
      
      zooTs <- readRDS(zooTs$datapath)
      
      
      id <- as.numeric(input$id)

      # Reformat variable selected in UI
      formula <- switch(input$formula,
                        'trend' = response ~ trend,
                        'trend + harmon' = response ~ trend + harmon,
                        'harmon' = response ~ harmon)
      
      year <- decimal_date(input$year)
      
      order <- input$order
      
      history <- input$history
      
#       plotType <- switch(input$plotType,
#                          'ggplot' = TRUE,
#                          'base' = FALSE)
      
      
      
      ### Plotting function
      l <- zooTs[,id] / 10000
      pixel <- runPixel(x=l, start=year,
                        formula = formula, order = order,
                        history = history)
      
      
      plot(pixel)

    })
    
    output$table1 <- renderTable({obs})
  }
)
