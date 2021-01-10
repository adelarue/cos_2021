#' Load libraries and read data.
library(shiny)
library(DT)
library(tidyverse)
library(leaflet)

listings = read_csv('../data/listings_2019.csv') %>% 
    mutate(price = parse_number(price))

#' User Interface. 
ui <- fluidPage(
    titlePanel("Boston AirBnB"),
    sidebarLayout(
        sidebarPanel(
            selectInput("neighb", 
                        "Neighbourhood", 
                        choices=sort(unique(listings$neighbourhood_cleansed)), 
                        selected="Beacon Hill")
        ),
        mainPanel(
            leafletOutput("map")
        )
    )
)

#' Server-side logic
server <- function(input, output, session) {
    
    selected_listings <- reactive({
        listings %>% 
            filter(neighbourhood_cleansed %in% input$neighb)
    })
    
    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles() %>% 
            addCircleMarkers(
                ~longitude, ~latitude, 
                data=selected_listings(),
                popup=~sprintf("($%.1f) %s", price, name))
    })
}

#' Run the app
shinyApp(ui, server)