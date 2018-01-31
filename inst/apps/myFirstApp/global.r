# global.r is evaluated using the source() function and stored as global objects in the parent environment

# This is a good place to call libraries 
# NEVER NEVER NEVER INSTALL.PACKAGES() IN THE GLOBAL.R
# because someone using this on the web will fail

# you can also call custom-functions here 

library(shiny)
library(shinythemes)
library(choroplethr)
library(choroplethrMaps)

data('df_state_demographics')
map_data <- df_state_demographics


