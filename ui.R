library(shiny)

shinyUI(fluidPage(
  titlePanel("bfastApp"),
  h3('Run bfastmonitor interactively'),
  h3(em(a('Loïc Dutrieux', href = 'http://www.loicdutrieux.com'))),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("id",
                  label = "Time Series Number", 
                  choices = as.list(as.character(seq(1,11))),
                  selected = '1'),
      
      selectInput('formula',
                  label = 'Formula',
                  choices = list('trend',
                              'trend + harmon',
                              'harmon'),
                  selected = 'trend + harmon'),
      
      dateInput("year", 
                  label = "Begining of monitoring period",
                  min = '2001-01-01', max = '2014-01-01', value = '2008-01-01'), # Make that dynamic (adapted to time-series range)
      
 
      
      numericInput("order", label = 'Harmonic order', value = 1),
      
      selectInput("history", label = "History period",
                  choices = list('ROC', 'BP', 'all'),
                  selected = 'ROC')
      # This should also be able to take a date as input; combine it with year argument by using a dateRangeInput if select 'date'
      
#       selectInput('plotType', label = 'plot type',
#                   choices = list('ggplot', 'base'),
#                   selected = 'base')
      
      
      
    ),
    
    mainPanel(plotOutput("bfmPlot"),
              p('This is a work in progress version;', span('Time series number', style = 'color:green'), 'is a set of 11 NDMI time-series selected from a Landsat stack covering a study area in Peru (Madre de Dios). Thanks to ',  strong('Mathieu Decupier '), 'for providing the samples points'))
  )
))