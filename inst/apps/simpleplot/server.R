# Define server function required to create the scatterplot
server <- function(input, output, session) {
  
  # Create the scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = dataSource, aes_string(x = input$x, y = input$y,
                                         color = input$z)) +
      geom_point()
  })
  
  
  output$table <- renderDataTable({
    brushedPoints(dataSource, input$plot_brush) })
  
  
  # Create text output stating the correlation between the two ploted 
  output$correlation <- renderText({
    r <- round(cor(dataSource[input$x], dataSource[input$y], use = "pairwise"), 3)
    paste0("Correlation = ", r, ". Note: If the relationship between the two variables is not linear, the correlation coefficient will not be meaningful.")
  })
}



   

  
