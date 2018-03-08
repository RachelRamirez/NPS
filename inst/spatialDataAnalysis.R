#'@title spatialData function
#'
#'@description
#'A function to take a latitude and longitude of selected sites and display using ggmap
#'
#'@docType function
#'@name spatialDataAnalysis
#'@format a \code{function} 
#'
#'\describe{
#'\item{latitude}{is a latitude}
#'\item{longitude}{is a longitude}
#'}
#'@import ggmap 
 

#spatialData(brushedPoints(rv$Data, input$plot_brush), input$Location, input$MapType, input$Zoom)

spatialData <- function(data,  MapType, Zoom) {
  
  #find out how many unique parks - need to put all of them in the picture
  #or maybe just take everything and layover the BRUSHED POINTs in a different color?
  # n <- row(data)
  # cat("There are ", n, " selected points. The first will be mapped.")
  location = c(lon = data$Longitude[1], lat = data$Latitude[1])
  
  map_1 <- get_map(messaging = TRUE, location, maptype = MapType, zoom = Zoom, source = ifelse(MapType == c("toner"), "stamen", "google"))
  
  
  
  ggmap::ggmap(map_1, 
               base_layer = ggplot(data, aes(lon, lat))) + 
    geom_point()
  
 
 
  }

#  
# map_13 <- get_map(location, zoom = 13, scale = 1)
# 
# #corvallis <- c(lon = -123.2620, lat = 44.5646)
# 
# library(ggmap)
# # Map color to year_built
# ggmap(map_13) +
#   geom_point(aes(lon, lat), data = philippines)
# 
# # Map size to bedrooms
# ggmap(corvallis_map) +
#   geom_point(aes(lon, lat), data = sales)
# 
# # Map color to price / finished_squarefeet
# ggmap(corvallis_map) +
#   geom_point(aes(lon, lat), data = sales)

# 
# # Use base_layer argument to ggmap() and add facet_wrap()
# ggmap(corvallis_map_bw, 
#       base_layer= ggplot(sales, aes(lon,lat))) + 
#   geom_point(aes(color = class)) +
#   facet_wrap(facets = ~class)