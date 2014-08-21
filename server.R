library(zoo)
library(bfast)
library(ggplot2)
library(lubridate)
library(dplyr)
source('fortify.bfastmonitor.R')
source('ggplotBFAST.R')
source('runPixelExo.R')

# ts <- readRDS('data//landsatZoo.rds')

shinyServer(
  function(input, output) {
    output$ui <- renderUI({

      
      switch(input$input_type,
             "upload rds file" = fileInput('ts', label = 'zoo rds file',
                                           accept = '.rds'),
             "Example time-series" = NULL)
    })
      
    output$ui2 <- renderUI({
      if(input$input_type == "upload rds file") {
        ts <- readRDS(input$ts$datapath)
      } else {
        ts <- readRDS('data/landsatZoo.rds')
      }
             
      n <- ncol(ts)
      
      selectInput("id",
                  label = "Time Series Number", 
                  choices = as.list(as.character(seq(1,n))),
                  selected = '1')
    })
      
    output$ui3 <- renderUI({
      if(input$input_type == "upload rds file") {
        ts <- readRDS(input$ts$datapath)
      } else {
        ts <- readRDS('data/landsatZoo.rds')
      }
      selectInput("id",
                  label = "Time Series Number", 
                  choices = as.list(as.character(seq(1,n))),
                  selected = '1')
    })
      
   
    
      
    output$bfmPlot <- renderPlot({
      
      # Reformat variable selected in UI
      if(input$input_type == "upload rds file") {
        ts <- readRDS(input$ts$datapath)
      } else {
        ts <- readRDS('data/landsatZoo.rds')
      }
      
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
        pixelFort <- fortify(pixel)
        ggplotBFAST(pixelFort)
      }
      
      

      
    })
  }
)
