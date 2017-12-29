library(shiny)
library(ggplot2)

MAXDEPTH = 84

depth   <- read.table("depth.tsv", sep = "\t", header = TRUE)
het     <- read.table("het_minDP0.tsv", sep = "\t", header = TRUE)
meanHet <- read.table("het_mean.tsv", sep = "\t", header = TRUE)

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
    Indv <- factor(het[, 1])
    df   <- cbind(Indv, het[5])   
    
    ggplot(data = df, aes(x = Indv, y = F)) +
        geom_bar(stat = "identity") +
        ggtitle("Heterozygosity By Sample") +
        xlab("Sample Identifier") +
        ylab("Inbreeding Coefficient")
   })

  output$meanHetPlot <- renderPlot({
      df <- meanHet
      
      ggplot(df, aes(x = Depth, y = Mean_F)) +
        geom_step() +
        # xlim(0, input$minDepth + 5) +
        geom_vline(xintercept = input$minDepth) +
        ggtitle("Mean Heterozygosity By Depth Threshold") +
        xlab("Minimum Genotype Depth Threshold") +
        ylab("Inbreeding Coefficient")
   })
  
  # Render bar plot of sample F values at given depth 
  # threshold
  output$hetPlot <- renderPlot({
    Indv <- factor(het[, 1])
    df   <- cbind(Indv, het[5])   
    
    ggplot(data = df, aes(x = Indv, y = F)) +
        geom_bar(stat = "identity") +
        ggtitle("Heterozygosity By Sample") +
        xlab("Sample Identifier") +
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