
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RCurl)
library(networkD3)
shinyServer(function(input, output) {
  URL <- "https://raw.githubusercontent.com/christophergandrud/networkD3/master/JSONdata/energy.json"
  Energy <- getURL(URL, ssl.verifypeer = FALSE)
  
  # Convert to data frame
#   EngLinks <- JSONtoDF(jsonStr = Energy,
#                        array = "links")
#   EngNodes <- JSONtoDF(jsonStr = Energy,
#                        array = "nodes")
  EngNodes = data.frame(name = c("Vaishali","Nilga","Arihant","Gokul","Kirthi","Kamal"))
  EngLinks = read.table("Links.txt", header = T)
  output$distPlot <- renderSankeyNetwork({
    sankeyNetwork(Links = EngLinks, Nodes = EngNodes,
                  Source = "source", Target = "target",
                  Value = "value", NodeID = "name",
                  width = 700, fontsize = 12, nodeWidth = 30)
  })

})
