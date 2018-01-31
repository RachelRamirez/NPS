# Define server function required to create the scatterplot
server <- function(input, output, session) {
  
  # Create the scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = dataSource, aes_string(x = input$x, y = input$y,
                                         color = input$z)) +
      geom_point()
  })
}
