library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Bootstrap tree"),
    tabsetPanel(
      tabPanel("Bootstrap Tree",
        sidebarPanel(selectInput("tree", "Choose a tree algorithm:", choices = c("nj","upgma")),
        
        numericInput("boot", "Number of bootstrap replicates", 100),
      
        helpText("Note: Distances are calculated using Bruvo's distance and a framework of penguins and polar bears!."),
        submitButton("Calculate Tree")
        ),
        plotOutput("distPlotTree")
        ),
    tabPanel("Bootstrap Tree",
             submitButton("Calculate Tree"),
             plotOutput("MinSpanTree")
      )
    ),
    mainPanel()
))
