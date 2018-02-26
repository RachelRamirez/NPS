#' @title This is my title
#' @description This is my description
#'@import shiny
#'@import tidyverse
#'@importFrom dplyr mutate
#'@import magrittr
#'@importFrom htmlwidgets JS
#'
#'@param dataSource A data.frame
#'
#' @export
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
  ,width = 1200
  ,height = 800
  ,brushMode = "1d-axes"
  ,color = list(colorScale = htmlwidgets::JS('d3.scale.category10()'),
                  colorBy = "LCLUCI.labels")
  
)
}








# # 
# myparacoords(cleandata[, c("LCLUCI.labels", "HIHerbaceous200m",	 "RecCon5km",	 	"DistHeliports",	 	"DistRoadsMajor",	"FlightFreq25Mile",	"RddMajorPt","PopDensity_2010_50km", "park")])
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