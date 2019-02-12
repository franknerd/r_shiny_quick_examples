"
In this app we want two things to happen when an action button is clicked:

A message printed to the console stating how many records are shown.
A table output of those records.
While observeEvent() will print a message to the console when the action 
button is clicked on your local machine, it will not currently work on the 
DataCamp platform. It is important, however, to learn how to do this for your 
future Shiny apps!
"
library(shiny)
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/course_4850/datasets/movies.Rdata"))

# UI
ui <- fluidPage(
  sidebarLayout(
    
    # Input
    sidebarPanel(
      
      # Numeric input for number of rows to show
      numericInput(inputId = "n_rows",
                   label = "How many rows do you want to see?",
                   value = 10),
      
      # Action button to show
      actionButton(inputId = "button", 
                   label = "Show")
      
    ),
    
    # Output:
    mainPanel(
      tableOutput(outputId = "datatable")
    )
  )
)

# Define server function required to create the scatterplot-
server <- function(input, output, session) {

  # Print a message to the console every time button is pressed
  observeEvent(input$button, {
    cat("Showing", input$n_rows, "rows\n")
  })
  
  # Take a reactive dependency on input$button, but not on any other inputs
  df <- eventReactive(input$button, {
    head(movies, input$n_rows)
  })
  output$datatable <- renderTable({
    df()
  })
  
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)
