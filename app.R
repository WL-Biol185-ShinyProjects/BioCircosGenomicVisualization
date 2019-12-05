install.packages("shiny")
install.packages("shinydashboard")

## app.R ##
library(shiny)
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
                  p("With advances in modern medicine and genomic sequencing, 
                    we now have the opportunity to create specific treatment protocols for 
                    patients who have not been successful in their search for effective medical 
                    management. Genetic therapies hold promise for several pathologies such as 
                    cystic fibrosis, cardiovascular disease, HIV, AIDS, and a variety of cancers. 
                    Gene therapy is still in its infancy in the realm of clinical research, 
                    but is predicted to become standard treatment in future medicine."),
                  p("With this app, you can upload a file of patient genomic data in the form 
                    of SNP’s and generate a BioCircos plot indicating the presence and location 
                    of a variety of mutations with known disease associations. To start 
                    generating your plot, read more on the “BioCircos Plot” tab. To understand 
                    your graph, read “Interpreting Your Data”. To find out more about genetic 
                    counselling or to explore your future treatment options, read “Next Steps.”")
                )
              )
      ),
      
      # "BioCircos Plot" tab content
      tabItem(tabName = "plot",
              
              # Page header text
              h2("Your BioCircos Plot"),
              
              #Input: upload a csv file of your gene snp's
              fileInput("file1",
                        "Choose a CSV file",
                        multiple = FALSE,
                        
                        ## Tells R what types of files can be uploaded
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   "application/vnd.ms-excel",
                                   "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                   )
                        ),
              
              # Aesthetic Horizontal line 
              tags$hr(),
              
              # Creating check box for user to indicate
              # if the csv input file has a header
              checkboxInput("header", 
                            "Header", 
                            TRUE),
              
              # Adding radio buttons for user to select how
              # data in their csv file is separated. 
              radioButtons("separator", 
                           "Separator",
                           choices = c(Comma = ",",
                                       Semicolon = ";",
                                       Tab = "\t"
                                       ),
                           selected = ","),
              
              # Creating a main panel where user data file 
              # can be displayed
              mainPanel(
                
                # Output data file
                tableOutput("userFile")
                
              )
      ),
      
      # "Interpreting Your Data" tab content
      tabItem(tabName = "interpret",
              
              # Page header text
              h2("Interpreting Your Data")
      ),
      
      # "Next Steps" tab content
      tabItem(tabName = "nextSteps",
              
              # Page header text
              h2("What are my next steps?")
      ),
      
      # "Documentation tab content"
      tabItem(tabName = "documentation",
              
              # Page header text
              h2("Documentation"),
              
              box(
                
                # Page body text
                p("Bloss CS, Jeste DV, Schork NJ. Genomics for disease treatment and prevention. 
                  Psychiatr Clin North Am. 2011;34(1):147–166. doi:10.1016/j.psc.2010.11.005"),
                p("Gonçalves GAR, Paiva RMA. Gene therapy: advances, challenges and perspectives.
                  Einstein (Sao Paulo). 2017;15(3):369–375. doi:10.1590/S1679-45082017RB4024"),
                p("McCain J. The future of gene therapy. Biotechnol Healthc. 2005;2(3):52–60.")
              )
      )
    )
  )
)

## server ##
server <- function(input, output) {
  
  output$userFile <- renderTable({
    
    req(input$file1)
    
    inputFile <- read.csv(input$file1$datapath,
                             header = input$header,
                             striped = TRUE
                             )
  })
  
}

## Display the app ##
shiny::shinyApp(ui = ui, server = server)