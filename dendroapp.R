
library(shiny)
library(tidyverse)

datos<- read.csv("dendro_parcial1.csv", encoding = "UTF-8")

ui<- fluidPage(
  selectInput(inputId = "familia", 
              label = strong("Seleccione una familia:"), 
              choices = unique(datos$familia),
              selected = "fabaceae"),
  dataTableOutput(outputId = "info"))

server<- function(input, output) {
  
  sel<- reactive(datos %>% filter(familia == input$familia))
  output$info<- renderDataTable({
    sel()
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))
  
}

shinyApp(ui = ui, server= server)
