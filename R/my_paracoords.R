#' @title This is my title
#' 
#' @description This is my description
#'
#'@import shiny
#'@import tidyverse
#'@importFrom dplyr mutate
#'@import magrittr
#'@importFrom htmlwidgets JS
#'
#'@param dataSource A data.frame
#'
#' @export
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
  ,width = 2000
  ,height = 800
  ,brushMode = "1d-axes"
  ,color = list(colorScale = htmlwidgets::JS('d3.scale.category10()'),
                  colorBy = "L90dBA")
  
)
}


# #Exhaustive Regression Variables of Importance:
# myparacoords(dataSource[,c("park", "Slope", "LCLUCI.labels", "TPI.labels", "Barren5km", "DistCoast", "Wind_CRU","Barren200m", "Forest200m", "Shrubland200m", "WaterNat200m", "WaterOnly200m", "Wetlands200m", "Transportation5km", "RecCon5km", "WaterOnly5km", "DistCoast", "DistHeliports", "FlightFreq25Mile",    "DistRailroads", "RddMajorPt" )])
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