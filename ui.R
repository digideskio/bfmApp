library(shiny)

shinyUI(fluidPage(
  
  
    fluidRow(
      column(width = 2,
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
             ),
      column(width = 9, offset = 1,
             titlePanel("bfastApp"),
             h3('Run bfastmonitor interactively'),
             h3(em('by ', a('Loïc Dutrieux', href = 'http://www.loicdutrieux.com'))),
             tabsetPanel(
               tabPanel('Time Series-viewer', plotOutput("bfmPlot"),
                        p('This is a work in progress version;', span('Time series number', style = 'color:green'), 'is a set of 11 NDMI time-series selected from a Landsat stack covering a study area in Peru (Madre de Dios). Thanks to ',  strong('Mathieu Decuyper '), 'for providing the samples points')),
               tabPanel('Detail', tableOutput('table1'))
             ))
    )))
    
  
  
  
  

      
