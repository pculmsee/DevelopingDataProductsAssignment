#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Mortgage Repayment Calculator"),

  # Sidebar with a slider input for number of years
  sidebarLayout(
    sidebarPanel(
      h3("How to Use the Application"),
      p("Move the slider to change the number of years
        to repay the mortgage, enter the annual percentage rate
        and the principal of the loan."),
      p("The application will display the monthly repayment amount
        and show a graph of the amount still owing over time."),
      p(),
      p(),
       sliderInput("years",
                   "Number of Years to Repay Loan:",
                   min = 1,
                   max = 50,
                   value = 30),
       numericInput('annualRate', 'Annual Interest Rate:', 5, min = 0, max = 100, step = 0.01),
       numericInput('principal', 'Amount of the Loan:',value = 250000, step = 10000)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Monthly Repayment Amount"),
       textOutput("payment"),
      p(),
       h3("Remaining Principal Over Time"),
       plotOutput("outstandingPlot")
    )
  )
))
