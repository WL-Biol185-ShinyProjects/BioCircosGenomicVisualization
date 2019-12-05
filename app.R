install.packages("shiny")
install.packages("shinydashboard")
install.packages("BioCircos")

# The control genomic data
if (!require('devtools')){install.packages('devtools')}

devtools::install_github('lvulliard/BioCircos.R', build_vignettes = TRUE)

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
      
      # Content -- Home tab
      tabItem(tabName = "home",
              
              # Body content -- home tab
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
      
      # Content -- BioCircos tab
      tabItem(tabName = "plot",
              
              # Header -- BioCircos header text
              h2("Your BioCircos Plot"),
              
              #Input -- upload a csv file of your gene snp's
              fileInput("file1",
                        "Choose a CSV file",
                        multiple = FALSE,
                        
                        ## File type -- Tells R what types of files can be uploaded
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
              
              # Adding radio buttons for user to select how
              # data in their csv file is separated. 
              radioButtons("separator", 
                           "Separator",
                           choices = c(Comma = ",",
                                       Semicolon = ";",
                                       Tab = "\t"
                                       ),
                           selected = ","),
              
              # Main Panel -- Creating panel where user data file will display
              mainPanel(
                
                # Output data file -- display table
                tableOutput("userFile"),
                
                # BioCircos -- generate and display plot in main panel
                BioCircos(
                  BioCircosSNPTrack('SNPTrack', 
                                    chromosomes = 1:5,
                                    positions = 1e+7*2:5, 
                                    values = 1:2, 
                                    colors = "RdBu", 
                                    labels = c('A to G', 'T', 'G','C', 'G'))
                  + BioCircosArcTrack('ArcTrack', 
                                      chromosomes = 1:5, 
                                      starts = 2e+7*1:5, 
                                      ends = 2.5e+7*2:5, 
                                      colors = "Accent", 
                                      labels =  c('MYC1', 'ETV6', 'IKZ3', 'P53', 'MTOR3'), 
                                      opacities = 1, 
                                      maxRadius = 0.9,
                                      minRadius = 0.5))
              )
                
              )
      ),
      
      # Content -- "Interpreting Your Data" tab
      tabItem(tabName = "interpret",
              
              # Header -- Adding title text
              h2("Interpreting Your Data"),
              
              # Fluid Row -- Adding place to put body text
              fluidRow(
                box(
                  title = "Welcome",
                  status = "primary",
                  
                  # Body -- Adding new paragraphs of  text
                  p("BioCircos is a popular tool to combine different biological information 
                    onto a single interactive feature. Our test allows for the user to upload 
                    their unique genomic data from an Illumia Myeloid Panel to discover is they 
                    have a mutation on genes that have been previously correlated with leukemia 
                    and lymphoma."),
                  
                  p("When the user uploads their data in the form of a CSV file onto the app, 
                    the file creates a plot in the form of a circle divided into 23 autosome 
                    chromosome tracks and two sex chromosomes (XX or XY) depending on the 
                    biological sex of the user. "),
                  
                  p("Next you will see sub-tracts representing the genes of interest or those
                  tested and their relative location inside the chromosome. If you pass over the 
                  sub track with your curser, you will be provided with the basic information of
                  the gene in question."),
                  
                  p("Our unique code then analyzes cherry-picked single nucleotides inside of 
                    each of the genes of interest to test for polymorphism. A single nucleotide 
                    polymorphism is a mutation or change of a single nucleotide base pair. There 
                    are four nucleotides, Thymine (T), Cytosine (C), Adenine (A), or Guanine (G) 
                    each represented by their first letter in both the Illumia Myeloid Panel data 
                    and in our program. A single nucleotide is represented by a single dot on the 
                    gene of question. Passing a curser over the dot will reveal basic information 
                    including the genomic coordinate (the exact location of the nucleotide in the 
                    chromosome) as well as the identity of the nucleotide and if it is an SNP. 
                    If it is an SNP, it will be represented as the nucleotide that should have 
                    been in that spot and the mutation present in the data provided (A to G).")
                )
              )
      ),
      
      # Content -- "Next Steps" tab
      tabItem(tabName = "nextSteps",
              
              # Page header text
              h2("What are my next steps?")
              
              
      ),
      
      # Content -- "Documentation" tab 
      tabItem(tabName = "documentation",
              
              # Header -- Documentation header text
              h2("Documentation"),
              
              box(
                
                # Body -- adding paragraphs of text
                p("Bloss CS, Jeste DV, Schork NJ. Genomics for disease treatment and prevention. 
                  Psychiatr Clin North Am. 2011;34(1):147–166. doi:10.1016/j.psc.2010.11.005"),
                
                p("Gonçalves GAR, Paiva RMA. Gene therapy: advances, challenges and perspectives.
                  Einstein (Sao Paulo). 2017;15(3):369–375. doi:10.1590/S1679-45082017RB4024"),
                p("McCain J. The future of gene therapy. Biotechnol Healthc. 2005;2(3):52–60.")
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
