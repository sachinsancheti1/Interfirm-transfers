
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(d3Network)
shinyUI(fluidPage(
  tags$head(
    #tags$script(src = 'http://d3js.org/d3.v3.min.js'),
    tags$script(src = 'something.js'),
    tags$script(src = 'newscript.js')
  ),
  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("distPlot")
    )
  )
))
