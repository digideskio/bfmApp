library(shiny)

shinyUI(fluidPage(
  titlePanel("bfastApp"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('formula',
                  label = 'Formula',
                  choices = list('trend',
                              'trend + harmon',
                              'harmon'),
                  selected = 'trend + harmon'),
      
      dateInput("year", 
                  label = "Begining of monitoring period",
                  min = '2001-01-01', max = '2014-01-01', value = '2008-01-01'), # Make that dynamic (adapted to time-series range)
      
      selectInput("id",
                  label = "Time Series Number", 
                  choices = as.list(as.character(seq(1,300))),
                  selected = '1'),
      
      numericInput("order", label = 'Harmonic order', value = 1),
      
      selectInput("history", label = "History period",
                  choices = list('ROC', 'BP', 'all'),
                  selected = 'ROC'),
      # This should also be able to take a date as input; combine it with year argument by using a dateRangeInput if select 'date'
      
      selectInput('plotType', label = 'plot type',
                  choices = list('ggplot', 'base'),
                  selected = 'base')
      
      
      
    ),
    
    mainPanel(plotOutput("bfmPlot"))
  )
))