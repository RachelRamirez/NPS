# global.r is evaluated using the source() function and stored as global objects in the parent environment

# This is a good place to call libraries 
# NEVER NEVER NEVER INSTALL.PACKAGES() IN THE GLOBAL.R
# because someone using this on the web will fail

# you can also call custom-functions here 
library(ggplot2)
library(shiny)
library(shinythemes)

library(NPS)
#library(choroplethr)
#library(choroplethrMaps)
#library(readxl)
#dataSource <- read_excel("..\\dataSource.xlsx", sheet = "CONUS Data", range = "c3:iq514")

#devtools::use_data(dataSource, overwrite = TRUE)

myenv <- new.env()

data('dataSource', envir = myenv)
# data('cleandata')
dataSource <- as.data.frame(get('dataSource', envir = myenv))

   dataSource$LCLUCI.labels <-
   factor(
     dataSource$LCLUCI,
     levels = c(11,	12,	21,	22,	23,	31,	41,	42,	52,	71,	81,	82,	90,	95),
     labels = c(
       "Open Water",             #HEX   486da2
       "Perennial Ice/Snow",     #      e7effc     
       "Developed (Low Intensity)", #   dc9881
       "Developed (Medium Intensity)",# f10100
       "Developed (High Intensity)", #  ab0101
       "Barren Land (Rock/Sand/Clay)", # b3afa4
       "Deciduous Forest",             #6ba966
       "Evergreen Forest",             #1d6533
       "Shrub/Scrub",                  #d1bb82
       "Grassland/Herbaceous",          #edeccd
       "Pasture/Hay",                   #ddd83e
       "Cultivated Crops",              #ae7229
       "Woody Wetlands",                #bbd7ed
       "Emergent Herbaceous Wetland"     #71a4c1
     )
   )
   
   

 
 data('cleandata')
 # data('cleandata')
 cleandata <- as.data.frame(cleandata)
 
 