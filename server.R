# library(maps)
# library(mapproj)
# ts <- readRDS('data//landsatZoo.rds')
# 
# shinyServer(
#   function(input, output) {
#     output$plot <- renderPlot({
#       data <- switch(input$var, 
#                      "Percent White" = counties$white,
#                      "Percent Black" = counties$black,
#                      "Percent Hispanic" = counties$hispanic,
#                      "Percent Asian" = counties$asian)
#       
#       color <- switch(input$var, 
#                       "Percent White" = "darkgreen",
#                       "Percent Black" = "black",
#                       "Percent Hispanic" = "darkorange",
#                       "Percent Asian" = "darkviolet")
#       
#       legend <- switch(input$var, 
#                        "Percent White" = "% White",
#                        "Percent Black" = "% Black",
#                        "Percent Hispanic" = "% Hispanic",
#                        "Percent Asian" = "% Asian")
#       
#       percent_map(var = data, 
#                   color = color, 
#                   legend.title = legend, 
#                   max = input$range[2], 
#                   min = input$range[1])
#     })
#   }
# )

shinyServer(function(input, output) {
})