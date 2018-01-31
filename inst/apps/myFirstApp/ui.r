#bootstrap makes dynamic sizing options to move from PC -> phone


ui <- fluidPage(title = "My first app!",
                responsive = NULL,
                theme = shinythemes::shinytheme("cerulean"), #try cyborg/flatly
                sidebarLayout(
                  sidebarPanel(width = 3,#3+9 = 12
                               sliderInput("num_colors",
                                           label = "Number of colors:",
                                           min =1, 
                                           max = 9, 
                                           value = 7),
                               selectInput("select",
                                           label = "Select Demographic:",
                                           choices = colnames(map_data)[2:9],
                                           selected = 1)),
                               
                  mainPanel(width = 9,  #3+9 = 12 -- dont exceed 12
                            tabsetPanel(
                               tabPanel(title = "Output Map",
                                        plotOutput(outputId = "map")),
                               tabPanel(title = "Data Table",
                                        dataTableOutput(outputId = "table")))
                           
                            
                            )
                  
                  
                  ))  
      
