#'@title Parallel Coordinate Plot
#'@description uses timelyportfolio's github function for a parallel coordinate plots
#'@import shiny
#'@import tidyverse
#'@importFrom dplyr mutate
#'@import magrittr
#'@importFrom htmlwidgets JS
#'
#'@param dataSource A data.frame with a column called "LCLUCI.labels"
#'
#'@export
#' 
#' 
myparacoords <- function(dataSource){
  parcoords::parcoords(
  dataSource
  ,reorderable = T
  ,rownames = FALSE
  ,alpha=0.5
  ,axisDots = 0
  ,mode = "queue"
  ,rate = 1
# ,autoresize = TRUE
  ,width = 1500
  ,height = 700
  ,brushMode = "1d-axes"
  ,color = list(colorScale = htmlwidgets::JS('d3.scale.category10()'),
                  colorBy = "LCLUCI.labels")
  
)
}




# 
# myparacoords(cleandata[, c("LCLUCI.labels","Developed200m",	 "RecCon5km",	 "DistCoast", "WaterOnly200m",	"DistHighAirports", "DistModerateAirports", 	"DistRoadsMajor",	"RddMajorPt", "park", "L90f1", "L90f3", "L90f5", "L90dBA")])
# 
# 
# 

# 
# 
# `%<>%` <- magrittr::`%<>%`
# `%>%`  <- magrittr::`%>%`
# 
# dataSource %<>% dplyr::rowwise() %>% 
#   dplyr::mutate(DistanceToNearestAirport = min(DistAirportsSeaplane,DistHeliports,DistHighAirports, DistModerateAirports, DistLowAirports))  
# 
# 
# #L90f1-33 Acoustic Data:
# myparacoords(dataSource = dataSource[,c("park", "L90f3","L90f3",  "L90dBA",  "LCLUCI.labels")])
# 
# 
# 
# #L90f1-33 Acoustic Data:
# myparacoords(dataSource = dataSource[,c("park", "L90f3", "L90dBA","DistanceToNearestAirport", "DistRoadsAll", "LCLUCI.labels")])
# 
# 
# myparacoords()