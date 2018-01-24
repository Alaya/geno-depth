library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
# ui <- fluidPage(theme = shinytheme("flatly"),
# ui <- fluidPage(theme = "superhero.css",
#        background-color:#003d3d;
# theme background is #2b3e50
ui <- fluidPage(theme = shinytheme("superhero"),
  tags$head(
    tags$style(HTML("
      body {
      }
    "))
   ),
  
  # Application title
  titlePanel("Impact of Varying Minimum Read Depth"),
   
   # Sidebar with a slider input for minimum depth
   # The average depth is 29.59
  sidebarLayout(
    sidebarPanel(
      sliderInput("minDepth",
                  "Minimum genotype depth",
                  min = 0,
                  max = 84,
                  value = 30),
        hr(),
        h5("Heterozygosity"),
        htmlOutput("hetSummary"),
        hr(),
        h5("Missingness")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         tabsetPanel(type = "tabs",
            tabPanel("Min Depth",
                     plotOutput("depthPlot")),
            tabPanel("Sample Het",
                     plotlyOutput("hetPlot")),
            tabPanel("Mean Het",
                     plotOutput("meanHetPlot")),
            tabPanel("Missing Sites",
                     plotOutput("missPlot"))
         )
      )
   )
)