#'@title Runs an app in my package
#'@description 
#'Runs as shiny app
#'@importFrom shiny shinyAppDir

#'@author Rachel
#'@param app_name character string for a directory in this package
#'@param ...  additional options passed to shinyAppdir
#'
#'@return a printed shiny app
#'@examples #remember to use EXAMPLES not Example
#'\dontrun{
#'run_my_app("myFirstApp")
#'}
#'@export 
run_my_app <- function(app_name, ...) {
  
  app_dir <- system.file("apps", app_name, package = "NPS")
  
  shiny::shinyAppDir(appDir = app_dir, options = list(...))
  
}
