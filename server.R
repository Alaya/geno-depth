library(shiny)
library(ggplot2)

MAXDEPTH = 84

# Read data and 
depth    <- read.table("data/depth.tsv", 
                      sep = "\t", header = TRUE)

het      <- read.table("data/het.tsv", 
                        sep = "\t", header = TRUE)
het$Indv <- as.factor(het$Indv)

hetMeans <- colMeans(het[-1])
hetMeans <- data.frame("Depth" = seq_along(hetMeans) - 1, 
                       "Mean_F" = hetMeans)

server <- function(input, output) {
   
  # Render step plot of genotype depths 
  # Include vertical line at selected minimum
  output$depthPlot <- renderPlot({
      df <- cbind(depth[1], depth[2] / 1000)
     
      plot(df, type = "n", 
           xlim = c(0, MAXDEPTH),
           main = "Genotype Depth Distribution", 
           xlab = "Genotype Read Depth", 
           ylab = "Number of Genotypes (Thousands)")
      lines(df, type = "s")
      abline(v = input$minDepth)
      
      ggplot(df, aes(x = Bin, y = Freq)) +
        geom_step() +
        xlim(0, MAXDEPTH) +
        geom_vline(xintercept = input$minDepth) +
        ggtitle("Genotype Depth Distribution") +
        xlab("Genotype Read Depth") + 
        ylab("Number of Genotypes (Thousands)")
   })

  # Render bar plot of sample F values at given depth 
  # threshold
  output$hetPlot <- renderPlot({
    ggplot(data = het, 
           aes(x = Indv, y = het[, input$minDepth + 2])) + 
        geom_bar(stat = "identity") +
        ylim(-0.1, 0.1) +
        ggtitle("Heterozygosity By Sample") +
        xlab("Sample Identifier") +
        ylab("Inbreeding Coefficient")
   })
  
  output$meanHetPlot <- renderPlot({
      ggplot(hetMeans, aes(x = Depth, y = Mean_F)) +
        geom_step() +
        geom_vline(xintercept = input$minDepth) +
        ggtitle("Mean Heterozygosity By Depth Threshold") +
        xlab("Minimum Genotype Depth Threshold") +
        ylab("Inbreeding Coefficient")
   })
  
  output$missPlot <- renderPlot({
      df <- cbind(depth[1], depth[2] / 1000)
     
      plot(df, type = "n", 
           xlim = c(0, MAXDEPTH),
           main = "Missing Site Distribution", 
           xlab = "Number of Sites Dropped", 
           ylab = "Maximum Allowed Missing Genotypes")
      lines(df, type = "s")
      abline(v = input$minDepth)
   })
}  