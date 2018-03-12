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
   
  output$instructions  <- renderUI({
    
    file = 'instructions.Rmd'
    withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
  })
  
  output$codebook <- renderText({h3("Pending")})
  # output$codebook  <- renderDataTable({
  #   
  #   file = 'codebook.Rmd'
  #   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
  # })
  
 
  
  output$map  <- renderPlot({   
    spatialData(data = as.data.frame(rv$Data),  MapType = as.character(input$MapType) )
  })
  
  output$map2  <- renderPlot({
    #Last Working Version:
     spatialData(data = as.data.frame(brushedPoints(rv$Data, input$plot_brush)[c("siteID","park.labels", "Latitude","Longitude", "LCLUCI.labels", "park")]), selected = 2, MapType = as.character(input$MapType)) })
  
    output$parcoors <- parcoords::renderParcoords({
#myparacoords(dataSource = rv$Data[, c("LCLUCI.labels", "WaterOnly200m", "DistHeliports", "L90dBA")])
    parcoords::parcoords(
      rv$Data[,c( "park.labels",  input$y, input$x, input$z)]
    
      ,reorderable = T
      ,rownames = FALSE
      ,alpha=0.5
      ,axisDots = 0
      ,mode = "queue"
      ,rate = 1
      ,autoresize = TRUE
      ,width = 900
      ,height = 700
      ,brushMode = "1d-axes"
      ,color = list(colorScale = htmlwidgets::JS('d3.scale.category10()'),
                    colorBy = input$z )
      
    )  
    })
  
}















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