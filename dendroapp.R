
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


data<- read.csv("MarkerData.csv")

data<- data %>% select(Notes, Latitude, Longitude) %>% 
  filter(Notes != "null")


library(leaflet)
library(sf)


ui<- fluidPage(
  selectInput(inputId = "Notes", 
              label = strong("Seleccione una familia:"), 
              choices = unique(data$Notes),
              selected = "zamia"),
  leafletOutput(outputId = "coor"))

server<- function(input, output) {
  
  sel<- reactive(data %>% filter(Notes == input$Notes))
  output$coor<- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      addMarkers(data = sel())
  })}

shinyApp(ui = ui, server= server)


m <- leaflet() %>%
  addTiles() %>% 
  addMarkers(lng= data$Longitude[1], 
             lat= data$Latitude[1], popup= "Podocarpaceae")
m
