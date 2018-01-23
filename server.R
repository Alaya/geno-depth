library(shiny)
library(ggplot2)

MAXDEPTH = 84
COLOR = "#2b3e50"

# Read data and perform once-per-process manipulation
depth    <- read.delim("data/depth.tsv") 
miss     <- read.delim("data/miss.tsv")

het      <- read.delim("data/het.tsv")
het$Indv <- as.factor(het$Indv)

# hetMeans <- colMeans(het[-1])
# hetMeans <- data.frame("Depth" = seq_along(hetMeans) - 1, 
                       # "Mean_F" = hetMeans)
hetStats <- data.frame("Depth" = seq_along(het[-1]) - 1, 
                         "Mean_F" = colMeans(het[-1]),
                         "SD_F" = sapply(het[-1], sd))

server <- function(input, output) {
  # output$meanHet <- hetStats$Mean_F[30]  
  # output$foo <- "test"
  # Render step plot of genotype depths 
  # Include vertical line at selected minimum
  output$depthPlot <- renderPlot({
      ggplot(depth, aes(x = Depth, y = Freq / 1000)) +
        geom_step(color = COLOR) +
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
        geom_bar(stat = "identity", fill = COLOR) +
        ylim(-0.1, 0.1) +
        ggtitle("Heterozygosity By Sample") +
        xlab("Sample Identifier") +
        ylab("Inbreeding Coefficient")
   })
  
  output$meanHetPlot <- renderPlot({
      ggplot(hetStats, aes(x = Depth, y = Mean_F)) +
        geom_step(color = COLOR) +
        geom_vline(xintercept = input$minDepth) +
        xlim(0, MAXDEPTH) +
        ggtitle("Mean Heterozygosity By Depth Threshold") +
        xlab("Minimum Genotype Depth Threshold") +
        ylab("Inbreeding Coefficient")
   })
  
  output$missPlot <- renderPlot({
      ggplot(miss, 
        aes(x = N_Smp - 0.5, 
            y = miss[, input$minDepth + 3] / 1000000)) + 
        geom_step(color = COLOR) +
        scale_x_continuous(breaks = seq(0, 11)) +
        # geom_vline(xintercept = input$minDepth) +
        ggtitle("Missing Site Distribution") + 
        xlab("Maximum Allowed Missing Samples") +
        ylab("Number of Sites Dropped (Millions)")
   })
}  
