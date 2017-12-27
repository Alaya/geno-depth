library(shiny)
depth <- read.table("depth.tsv", sep = "\t", header = TRUE)
MAXDEPTH = 84

server <- function(input, output) {
   
  # Render step plot of genotype depths 
  # Include vertical line at selected minimum
  output$depthPlot <- renderPlot({
      data <- cbind(depth[1], depth[2] / 1000)
     
      plot(data, type = "n", 
           xlim = c(0, MAXDEPTH),
           main = "Genotype Depth Distribution", 
           xlab = "Genotype Read Depth", 
           ylab = "Number of Genotypes (Thousands)")
      lines(data, type = "s")
      abline(v = input$minDepth)
   })
  
  output$missPlot <- renderPlot({
      data <- cbind(depth[1], depth[2] / 1000)
     
      plot(data, type = "n", 
           xlim = c(0, MAXDEPTH),
           main = "Missing Site Distribution", 
           xlab = "Number of Sites Dropped", 
           ylab = "Maximum Allowed Missing Genotypes")
      lines(data, type = "s")
      abline(v = input$minDepth)
   })
}