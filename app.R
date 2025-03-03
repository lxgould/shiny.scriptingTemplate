#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

date_file <- "/srv/shiny-server/shiny-data/scriptingTemplate/test_app_1.txt"

# Define UI for application that draws a histogram
ui <- fluidPage(
  fluidRow( 
    column(10, offset = 1,
           h2("shiny.scriptingTemplate"),
           p("This app is used to test the following file:"),
           tags$code(date_file),
           p("The file is supposed to be generated with the make_data_file.R script.
             And it contains a single line: the date that the file was generated
             or updated")
    )
  ),
  fluidRow( 
    column(10, offset = 1,
           uiOutput("table_header"),
           tableOutput("file_table")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$table_header <- renderUI({
    if ( !file.exists(date_file) ) {
      response <- h3(paste0("I can't find your file: ", date_file),
                     style = "color:red"
      )
      return(response)
    }
    
    dt <- readLines(date_file)[1]
    tagList(
    h3(paste0("Current Date Time: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))),
    h3(paste0("File Date Time: ", dt)),
    h3(paste0("Files in ", getwd()))
    )
  })
  
  output$file_table <- renderTable({
    data.frame(file_name = list.files())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
