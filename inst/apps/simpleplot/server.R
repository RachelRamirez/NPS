# Define server function required to create the scatterplot
server <- function(input, output, session) {
  
  
  
  #adding a function so that "clean" and "original" change the data:
  rv = reactiveValues()
  observe({
  if(input$Data == "original"){
    rv$Data = dataSource
  }else{
    rv$Data = cleandata
  }})
  
  
  # Create the scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
     ggplot(data = rv$Data, aes_string(x = input$x, y = input$y,
                                         color = input$z)) +
      geom_point()
  })
  
  
  output$table <- renderDataTable({
    brushedPoints(rv$Data, input$plot_brush)[c("siteID","park.labels", "Latitude","Longitude")]})
  
  
  # Create text output stating the correlation between the two ploted 
  output$correlation <- renderText({
    r <- round(cor(rv$Data[input$x], rv$Data[input$y], use = "pairwise"), 3)
    paste0("Correlation = ", r, ". Note: If the relationship between the two variables is not linear, the correlation coefficient will not be meaningful.")
  })
  
#   #attempt to make Data change on colnames() of UI
#   output$DataCol <- renderTable({
#      as.data.frame(rv$Data)
#     })
# }

#adding the rmarkdown vignette to the tab
  
  output$instructions  <- renderUI({
    
    file = 'instructions.Rmd'
    withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
  })
  
  # output$codebook  <- renderDataTable({
  #   
  #   file = 'codebook.Rmd'
  #   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
  # })
  
  output$map  <- renderPlot({
    
    #Last Working Version:
    # spatialData(data = rv$Data, selected= input$plot_brush, input$MapType, input$Zoom)
    spatialData(data = rv$Data, input$MapType, input$Zoom)
    
    #Current Trials and Tribulations
    #tells the spatialData function what is the relevatn reactuve Data (rv$data)
    # tells the spatialData which data is Brushed (so it should be a different color, like RED)
    # tells the spatialData where to look, kind of, its default to "US"
    # tells the spatial data function what type of map is requested, like "watercolor" or "toner" or "satelite"
    # tells the function how close or far we should be zoomed in
 
  })
  
  output$parcoors <- renderPlot({
    myparacoords(data  = rv$Data)
  })
  
}








   
# 
#  #from datacamp woith Charlotte Wickham
# corvallis <- c(lon = -123.2620, lat = 44.5646)
# 
# # Add a maptype argument to get a satellite map
# corvallis_map_sat <- get_map(corvallis, zoom = 13, maptype="satellite")
# 
# # Edit to display satellite map
# ggmap(corvallis_map_sat) +
#   geom_point(aes(lon, lat, color = year_built), data = sales)
# 
# # Add source and maptype to get toner map from Stamen Maps
# corvallis_map_bw <- get_map(corvallis, zoom = 13, source = "stamen", maptype = "toner")
# 
# # Edit to display toner map
# ggmap(corvallis_map_bw) +
#   geom_point(aes(lon, lat, color = year_built), data = sales)