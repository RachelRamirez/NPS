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
data('dataSource')

# dataSource <- as.data.frame(dataSource)

