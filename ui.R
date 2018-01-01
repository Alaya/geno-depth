library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
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
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("depthPlot"),
         plotOutput("missPlot"),
         tabsetPanel(type = "tabs",
            tabPanel("Sample Heterozygosity", 
                     plotOutput("hetPlot")),
            tabPanel("Mean Heterozygosity", 
                     plotOutput("meanHetPlot"))
         )
      )
   )
)