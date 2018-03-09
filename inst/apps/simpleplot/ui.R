
# Define UI for application that plots features of movies
ui <- fluidPage(
  theme=shinytheme("flatly"),  
  
  
  # App title
  titlePanel("National Park Service Acoustic Summary Data & Shiny App", windowTitle = "NPS"),
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(width = 3,
      
      
      # Select data
      selectInput(inputId = "Data", 
                  label = "Data:",
                  choices = c("original", "cleaned"), 
                  selected = "cleaned"),
      
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = colnames(dataSource),
                  selected = "L90dBA"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = colnames(dataSource),
                  selected = "Barren5km"),  
      
      # Select variable for x-axis
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("LCLUCI.labels","Season","Elevation","L90dBA"),
                  selected = "LCLUCI.labels"),
      
      # Built with Shiny by RStudio
      br(),br(),    # Two line breaks for visual separation
      h5("Built with",
         img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
         "by",
         img(src= "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png", height = "30px"),
         ".")
    ),
    
    # Outputs
    mainPanel(width = 9,
     
     tabsetPanel(id = "tabspanel", type = "tabs",
                  
    tabPanel(title = "Instructions",                   
             uiOutput(outputId = "instructions")),
                  
        tabPanel(title = "Plot",                   
                 
        h4("Click and drag to highlight points of interest"),
        plotOutput(outputId = "scatterplot", brush = "plot_brush"),
        textOutput(outputId = "correlation")),
        
        tabPanel(title ="Data",
                 br(),
                 dataTableOutput(outputId = "table")),
    
        tabPanel(title ="Map",
             br(),
             h4("Based on the points you've chosen in the plot:"),
             #Select map type >>                                 input$MapType
             selectInput(inputId = "MapType", 
                         label = "Map Type:",
                         choices =  c("terrain", "terrain-background", "satellite",
                                      "roadmap", "hybrid", "toner", "watercolor", "terrain-labels", "terrain-lines",
                                      "toner-2010", "toner-2011", "toner-background", "toner-hybrid",
                                      "toner-labels", "toner-lines", "toner-lite"),
                         selected = "hybrid"),
             
             # Select Map Zoom >>                                  input$Zoom
              h4("3 = Continent, 10 = City, 21 = Building" ),
             sliderInput(inputId = "Zoom", 
                         label = "Zoom Level:  3 = Continent, 21 = Building",
                         min = 3,
                         max = 21,
                         value = 11,
                         step = 1),
             
          #    #Select map type >>                                 input$MapType
          #    h5("osm = open street map, statem = just for toner maps"),
          #    selectInput(inputId = "Source", 
          #                label = "Map Source:",
          #                choices = c("google", "osm", "statem"),
          #    selected = "google"),

             plotOutput(outputId = "map")
          ),
    
        # 
        # tabPanel("Codebook",
        #          br()
        # #          uiOutput(outputId = "codebook")
        # ),

         tabPanel("Parallel Plot", 
              h3("Parallel Coorinate Plots enable one to see high dimensional data at once"),
              parcoords::parcoordsOutput(outputId = "parcoors", width = "100%", height = "80%"))))))
