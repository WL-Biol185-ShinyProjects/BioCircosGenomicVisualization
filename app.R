## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  
  dashboardHeader(title = "Geonomic Visualization",
                  titleWidth = 300
  ),
  
  dashboardSidebar(
    width = 300,
    
    # SidebarMenu-- Add space for sidebar 
    sidebarMenu(
      
      # MenuItem -- Add tab names to sidebar with corresponding icons 
      # Icons are sourced from: https://fontawesome.com/icons?d=gallery
      menuItem("Home", 
               tabName = "home", 
               icon = icon("home")
      ),
      
      menuItem("BioCircos Plot",
               tabName = "plot",
               icon = icon("first-order-alt")
      ),
      
      menuItem("Interpreting Your Data",
               tabName = "interpret",
               icon = icon("dna")
      ),
      
      menuItem("Next Steps",
               tabName = "nextSteps",
               icon = icon("shoe-prints")
      ),
      
      menuItem("Documentation",
               tabName = "documentation",
               icon = icon("chart-line")
      )
    )
  ),
  
  dashboardBody(
    
    # Container -- making tabItems container to hold each tabItem
    tabItems(
      
      # Content -- "Home" tab 
      tabItem(tabName = "home",
              
              # Body content -- "Home" tab
              fluidRow(
                
                box(
                  title = "Welcome",
                  status = "primary",
                  
                  # Paragraph -- body text
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
      
      # Content -- "BioCircos Plot" tab
      tabItem(tabName = "plot",
              
              # Header -- page header text
              h2("Your BioCircos Plot"),
              
              #Input -- Upload a csv file of your gene snp's
              fileInput("file1",
                        
                        # Text to display in upload button
                        "Choose a CSV file",
                        
                        # Prevents uploading multiple files at a time
                        multiple = FALSE,
                        
                        # Tells R what types of files can be uploaded
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   "application/vnd.ms-excel",
                                   "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                        )
              ),
              
              # Aesthetic Horizontal line 
              tags$hr(),
              
              # Checkbox -- Check box for user to indicate if the csv input file has a header
              checkboxInput("header", 
                            "Header", 
                            TRUE),
              
              # Radio buttons -- User selects how data in their csv file is separated. 
              radioButtons("separator", 
                           
                           "Separator",
                           
                           choices = c(Comma = ",",
                                       Semicolon = ";",
                                       Tab = "\t"
                           ),
                           
                           selected = ","
              ),
              
              # Main panel -- Container where uploaded patient data table is displayed
              mainPanel(
                
                # Output data file as table
                tableOutput("userFile")
                
              )
      ),
      
      # Content -- "Interpreting Your Data" tab
      tabItem(tabName = "interpret",
              
              # Page header text
              h2("Interpreting Your Data")
      ),
      
      # Content -- "Next Steps" tab 
      tabItem(tabName = "nextSteps",
              
              # Page header text
              h2("What are my next steps?"),
              
              fluidRow(
                box(title = "What are my next steps?",
                    status = "primary",
                    
                    # Paragraph -- body text
                    p("It is important to note that our app visualizing and providing a general 
                      interpretation of the Illumia Myeloid Panel sequencing data is not a diagnostic 
                      tool, neither is Illumia Myeloid Panel itself. While the data provided by the 
                      test and interpreted by our app is not to be used for diagnostic purposes, it 
                      does provide valuable risk assessment data. We recommend directing all concerns 
                      regarding the genomic data to a qualified health care professional specializing 
                      in genetic diseases."),
                    
                    p("Genetic counseling gives you information about how genetic conditions might 
                      affect you or your family. The genetic counselor further interprets the results 
                      of your genetic testing and will also collect your personal and family medical 
                      history. They can use this information to determine how likely it is that you or
                      your family member is at greater risk of developing a major myeloid disorder.
                      Based on this information, the genetic counselor can help you decide whether 
                      further genetic testing might be right for you or your relatives."),
                    
                    p("Following your counseling session, you might decide to have further genetic 
                      testing that can help you better understand your treatment options. Talking over
                      your test results with your counselor can help address any concerns. Your 
                      healthcare professional can refer you to other providers and advocacy and 
                      support groups to provide you with the best line of personalizaed treatment."),
                    
                    p("We recommend the following first steps to look for a qualified genetic counselor:"),
                    
                    p("National Society of Genetic Counselors directory:"),
                    
                    p("https://www.nsgc.org/page/find-a-genetic-counselor"),
                    
                    p("American College of Medical Genetics and Genomics Genetics Clinics Database:"),
                    
                    p("https://www.acmg.net/ACMG/Genetic_Services_Directory_Search.aspx")
                )
              )
      ),
      
      # Content -- "Documentation" tab
      tabItem(tabName = "documentation",
              
              # Page header text
              h2("Documentation"),
              
              fluidRow(
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

