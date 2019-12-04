install.packages("shinydashboard")

## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Geonomic Visualization",
                  titleWidth = 300
                  ),
  dashboardSidebar(
    width = 300,
    
    # Add sidebar menu items (tabs) with corresponding icons 
    # Icons are sourced from: https://fontawesome.com/icons?d=gallery
    sidebarMenu(
      menuItem("Home", 
               tabName = "home", 
               icon = icon("home")),
      menuItem("BioCircos Plot",
               tabName = "plot",
               icon = icon("first-order-alt")),
      menuItem("Interpreting Your Data",
               tabName = "interpret",
               icon = icon("dna")),
      menuItem("Next Steps",
               tabName = "nextSteps",
               icon = icon("shoe-prints")),
      menuItem("Documentation",
               tabName = "documentation",
               icon = icon("chart-line"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Home tab content
      tabItem(tabName = "home",
              
              # Home tab body content
              fluidRow(
                box(
                  title = "Welcome",
                  status = "primary",
                  h2("Homepage content")
                )
              )
      ),
      
      # BioCircos Plot tab content
      tabItem(tabName = "plot",
              h2("Your BioCircos Plot"),
              
              #Input: upload a csv file of your gene snp's
              fileInput("file1",
                        "Choose a CSV file",
                        multiple = FALSE,
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
                        ),
              
              # Aesthetic Horizontal line 
              tags$hr(),
              
              # Creating check box for user to indicate
              # if the csv input file has a header
              checkboxInput("header", "Header", TRUE),
              
      ),
      
      # Interpreting Your Data tab content
      tabItem(tabName = "interpret",
              h2("Interpreting Your Data")
      ),
      
      # Next Steps tab content
      tabItem(tabName = "nextSteps",
              h2("What are my next steps?")
      ),
      
      # Documentation tab content
      tabItem(tabName = "documentation",
              h2("Documentation")
      )
    )
  )
)

## server ##
server <- function(input, output) { }

## Display the app ##
shinyApp(ui, server)