library(shiny)

shinyUI(fluidPage(
  
  
    fluidRow(
      column(width = 2,

             fileInput(inputId = 'zooTs', label = 'rds file', multiple = FALSE, accept = '.rds'),

             uiOutput("ui"),
             
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
             ),
      column(width = 9, offset = 1,
             titlePanel("bfastApp"),
             h3('Run bfastmonitor interactively'),
             h3(em('by ', a('Loïc Dutrieux', href = 'http://www.loicdutrieux.com'))),
             mainPanel(
                plotOutput("bfmPlot")
             ))
    )))
    
  
  
  
  

      
