# Define server function required to create the scatterplot
server <- function(input, output, session) {
  
  rv = reactiveValues()
  observe({
  if(input$Data == "original"){
    rv$Data = dataSource
  }else{
    rv$Data = cleandata
  }})
  
  
  # Create the scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    
  #adding a function so that "clean" and "original" change the data:

    
    
    
    ggplot(data = rv$Data, aes_string(x = input$x, y = input$y,
                                         color = input$z)) +
      geom_point()
  })
  
  
  output$table <- renderDataTable({
    brushedPoints(rv$Data, input$plot_brush) })
  
  
  # Create text output stating the correlation between the two ploted 
  output$correlation <- renderText({
    r <- round(cor(rv$Data[input$x], rv$Data[input$y], use = "pairwise"), 3)
    paste0("Correlation = ", r, ". Note: If the relationship between the two variables is not linear, the correlation coefficient will not be meaningful.")
  })
}



   

  
