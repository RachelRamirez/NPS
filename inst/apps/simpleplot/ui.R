
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
                  choices = intersect(colnames(dataSource),colnames(cleandata)),
                  selected = "L90dBA"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = intersect(colnames(dataSource),colnames(cleandata)),
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
             
             h4("I recently cut down the number of choices  available to plot on axes to those  in both datasets.  I'm working on getting the map working"),
           uiOutput(outputId = "instructions")),
                  
        tabPanel(title = "Plot",                   
                 
        h4("Click and drag to highlight points of interest"),
        plotOutput(outputId = "scatterplot", brush = "plot_brush"),
        textOutput(outputId = "correlation")),
        
        tabPanel(title ="Data",
                 br(),
                 dataTableOutput(outputId = "table")),
    
        tabPanel(title ="Map",
                 h5("May take a minute to load... or not work at all"),
               h4("Overview of all data:"),
             #Select map type >>   input$MapType
             plotOutput(outputId = "map"),
             h4("Overview of first selected Data: "),
             selectInput(inputId = "MapType", 
                         label = "Choose a Map Type:",
                         choices =  c("terrain", "roadmap", "hybrid", "toner", "watercolor"),
                         selected = "toner"),
             plotOutput(outputId = "map2")
             
          ),
    
         

         tabPanel("Parallel Plot", 
              h3("Parallel Coorinate Plots enable one to see highly dimensional data"),
              h5("Change the inputs to the left to see different axes on the parallel coordinate plot below.  Click on lines in the parallel coordinate plot below to get the full benefits of using.  I've limited this  to four inputs but it is easy to add a LOT more.  The only limit is how far you're willing to scroll left and right"),
              parcoords::parcoordsOutput(outputId = "parcoors")),
     
            tabPanel("Codebook",
                     br(),
                     textOutput(outputId = "codebook")
)))))

