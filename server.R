
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RCurl)
library(dplyr)
shinyServer(function(input, output) {
  output$distPlot <- renderPrint({
    dt.l <- tbl_df(read.table("Links.txt", header = T))
    dt.n <- tbl_df(read.table("Nodes.txt",header = T))
    dt.l1 = dt.l %>%
      left_join(dt.n,by = c("source"="name")) %>%
      left_join(dt.n,by = c("target"="name")) %>%
      as.data.frame
    dt.n = dt.n %>% as.data.frame
    
    d3ForceNetwork(Links =dt.l1,Nodes = dt.n,fontsize = 15,linkDistance = 60,
                 Source = "rname.x", Target = "rname.y",
                 Value = "group.x",NodeID = "name",
                 Group = "group",
                 opacity = 0.9
      )
  })

})
