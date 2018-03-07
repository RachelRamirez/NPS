#'@title Description of spatialDataAnalysis
#'
#'@description
#'A function to take a latitude and longitude of selected site and display using ggmap
#'
#'@docType function
#'@name spatialDataAnalysis
#'@format a \code{function} 
#'
#'\describe{
#'\item{latitude}{is a latitude}
#'\item{longitude}{is a longitude}
#'}
#'@importFrom ggmap get_map, ggmap

 

#library(ggmap)

# #the start of my exploring the philippines dataset by rasters
# 
# dataSource <- readRDS(file = './data/cleandata')
# # library(readxl)
# # philippines <- read_excel("~/AFIT Masters OR Program/Thesis/philippines/philippines/phillipine_withData2.xlsx",    range = "B1:AR9", col_types = c("text",  "numeric",  "numeric",  "text", "skip", "skip", "numeric",  "numeric", "skip", "skip", "skip", "skip" , rep("numeric", 31)))
# # philippines <- as.data.frame(philippines)
# # #I dont know if the roads collected from ArcGIS were "Major Roads" or "Any Roads" so to predict I try out both
# # philippines$DistRoadsAll <- philippines$DistNationalRoads/1000
# # philippines$DistRoadsMajor <- philippines$DistNationalRoads/1000
# # philippines$DistanceToNearestAirport <- philippines$DistanceToNearestAirport/1000
# # saveRDS(philippines, file = 'philippinesR')
# 
# philippines$lon = philippines$Longitude
# philippines$lat = philippines$Latitude
# 
# #philippines <- readRDS(file = 'philippinesR')
# location <- c(lon = philippines$Longitude[1], lat =  philippines$Latitude[1])




spatialData <- function(data) {
  
  location <- c(lon = data$Longitude[1], lat = data$Latitude[1])
  map_1 <- get_map(location, zoom = "auto", maptype = "hybrid", scale = "auto")
  
  
  ggmap::ggmap(map_1) +
    geom_point(aes(x = Longitude, y = Latitude), data = data)

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