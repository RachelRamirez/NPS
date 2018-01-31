library(shiny)
library(ggplot2)
 
dataSource <- read_excel("C:\\Users\\Rachel\\Desktop\\NPS_Folder\\NPS\\inst\\apps\\dataSource_r2.xlsx", sheet = "CONUS Data", range = "c3:iq514")

dataSource <- as.data.frame(dataSource)

#data(dataSource)

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = colnames(dataSource), 
                  selected = "L90f1"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = colnames(dataSource), 
                  selected = "Pop_Density_2010_50km"),  
       
      # Select variable for color
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("LCLUCI", "Season", "Elevation", "Slope", "TPI"),                  selected = "LCLUCI")  
    ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create the scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = dataSource, aes_string(x = input$x, y = input$y,
                                     color = input$z)) +
      geom_point()
  })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)