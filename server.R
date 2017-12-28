library(shiny)
library(ggplot2)

MAXDEPTH = 84

depth <- read.table("depth.tsv", sep = "\t", header = TRUE)
het   <- read.table("het_minDP0.tsv", sep = "\t", header = TRUE)

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
  
  output$hetPlot <- renderPlot({
    print(het[, 1])
    Indv <- factor(het[, 1])
    print(Indv)
    print(class(Indv))
    
    # df <- cbind(het[1], het[5])   
    df <- cbind(Indv, het[5])   
    print(df)
    
    ggplot(data = df, aes(x = Indv, y = F)) +
        geom_bar(stat = "identity") +
        ggtitle("Heterozygosity By Sample") +
        xlab("Sample Identifier") +
        ylab("Inbreeding Coefficient")
      # barplot(het$F, het$INDV)
           # main = "Heterozygosity Per Sample", 
           # xlab = "Sample Identifier", 
           # ylab = "Inbreeding Coefficient")
   })
}