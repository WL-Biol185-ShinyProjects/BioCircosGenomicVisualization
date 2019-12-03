library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Genomic Visualization With BioCircos"),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input,output) {
  
  
}

shinyApp(ui,server)