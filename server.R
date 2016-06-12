#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
options(scipen=999)

moneyFormat<- function(n){
  paste("$", formatC(n, format = "f", big.mark = ",", digits = 2),sep = "")
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  mrc <- reactive({
    r <- as.numeric(input$annualRate) / 100 / 12
    N <- as.numeric(input$years) * 12
    P <- as.numeric(input$principal)
    pmt <- (r * P) / (1 - ((1 + r) ^ (-N)))
    x <- c(1:N)
    outstanding <- P * ((1 + r) ^ x) - (pmt * ((1 + r) ^ x - 1) / r)
    return(list("pmt" = pmt, "outstanding" = outstanding))

  })

  output$payment <-
    renderText(ifelse ((!is.na(mrc()$pmt) & mrc()$pmt != 0),
      moneyFormat(mrc()$pmt),
      "$0"
      )
    )


  output$outstandingPlot <- renderPlot({
    #Generate a plot of amount owing over time
    pmt<-mrc()$pmt
    outstanding<-mrc()$outstanding
    if (!is.na(pmt) & pmt != 0)  {
      plot(x=c(1:length(outstanding))/12, y= outstanding, type = "l",
            main = "Remaining Principal Over Time", yaxt="n",  xlab = "Years", ylab = "Amount Owing", col=c("red")
            )
      axis(2,axTicks(4),moneyFormat(axTicks(4)))
    }

  }, width = 500, height = 500)

})
