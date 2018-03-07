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
    #spatialData(brushedPoints(rv$Data, input$plot_brush), input$Location, input$MapType, input$Zoom)
    
    #Current Trials and Tribulations
    spatialData(data = rv$Data, coolrows= brushedPoints(rv$Data, input$plot_brush), input$MapType, input$Zoom)
    #tells the spatialData function what is the relevatn reactuve Data (rv$data)
    # tells the spatialData which data is Brushed (so it should be a different color, like RED)
    # tells the spatialData where to look, kind of, its default to "US"
    # tells the spatial data function what type of map is requested, like "watercolor" or "toner" or "satelite"
    # tells the function how close or far we should be zoomed in
    
    
   # spatialData(rv$Data, Location = input$Location, MapType= input$MapType, Zoom = input$Zoom)
   
    spatialData <- function(data, coolrows,MapType, Zoom) {
    #   
    #   #find out how many unique parks - need to put all of them in the picture
    #   #or maybe just take everything and layover the BRUSHED POINTs in a different color?
    #   
      
     
      data$lon <- data$Longitude
      data$lat <- data$Latitude 
      
      # 
      # cooldata$lon <- cooldata$Longitude
      # cooldata$lat <- cooldata$Latitude 
      # 
      
      Location1 <- c(lon = data$lon[1], lat = data$lat[1])
      
      map_1 <- get_map(location = Location1, maptype = MapType, zoom = Zoom, source = ifelse(MapType == "toner", "stamen", "google"))
      
      
      
      ggmap::ggmap(map_1,
                   base_layer = ggplot(data, aes(lon, lat))) + 
        geom_point(data[cooldata,], aes(lon, lat, color = "red") )
    
    # 
     }
    # # spatialData(brushedPoints(rv$Data, input$plot_brush))})
  
  
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