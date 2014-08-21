library(shiny)

shinyUI(fluidPage(
  titlePanel("bfastApp"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("input_type", label = "Input type",
                  c("upload rds file", "Example time-series")),
      
      uiOutput("ui"),
      uiOutput("ui2"),
      
      selectInput('formula',
                  label = 'Formula',
                  choices = list('trend',
                              'trend + harmon',
                              'harmon'),
                  selected = 'trend + harmon'),
      
      dateInput("year", 
                  label = "Begining of monitoring period",
                  min = '2001-01-01', max = '2014-01-01', value = '2008-01-01'), # Make that dynamic (adapted to time-series range)
      
#       selectInput("id",
#                   label = "Time Series Number", 
#                   choices = as.list(as.character(seq(1,300))),
#                   selected = '1'),
      
      numericInput("order", label = 'Harmonic order', value = 1),
      
      selectInput("history", label = "History period",
                  choices = list('ROC', 'BP', 'all'),
                  selected = 'ROC'),
      # This should also be able to take a date as input; combine it with year argument by using a dateRangeInput if select 'date'
      
      selectInput('plotType', label = 'plot type',
                  choices = list('ggplot', 'base'),
                  selected = 'base')
      
      
      
    ),
    
    mainPanel(plotOutput("bfmPlot"),
              p('This is a work in progress version;', span('Time series number', style = 'color:green'), 'is a set of 300 random NDVI time-series selected from a Landsat stack covering a study area in Bolivia; Future version will include an upload field for users to upload their own time-series objects. Utilities to easily generate and format these objects will be added to the bfastSpatial package. I am also planning to improve the ggploting and add the possibility to select a date range for the selection of the history period.'))
  )
))