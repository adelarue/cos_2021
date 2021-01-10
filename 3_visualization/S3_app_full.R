#' Load libraries and read data.
library(shiny)
library(DT)
library(tidyverse)
library(leaflet)

listings = read_csv('../data/listings_2019.csv') %>% 
    mutate(price = parse_number(price))

#' User Interface. 
ui <- fluidPage(
    theme = shinythemes::shinytheme("flatly"),
    titlePanel("Boston AirBnB"),
    sidebarLayout(
        sidebarPanel(
            selectInput("neighb", 
                        "Neighbourhood", 
                        choices=sort(unique(listings$neighbourhood_cleansed)), 
                        selected="Beacon Hill"),
            sliderInput("price", "Price", min = 0, max = 300, value = c(0, 150))
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Map", leafletOutput("map")),
                tabPanel("Scores", plotOutput("plot")), 
                tabPanel("Details", dataTableOutput("table"))
            )
        )
    )
)

#' Server-side logic
server <- function(input, output, session) {
    
    selected_listings <- reactive({
        listings %>% 
            filter(neighbourhood_cleansed %in% input$neighb, 
                   price >= input$price[1],
                   price <= input$price[2])
    })
    
    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles() %>% 
            addCircleMarkers(
                ~longitude, ~latitude, 
                data=selected_listings(),
                popup=~sprintf("($%.1f) %s", price, name))
    })
    
    output$plot <- renderPlot({
        selected_listings() %>% 
            ggplot(aes(x = review_scores_rating)) + 
            geom_histogram() + 
            labs(x = "Review Score", y = "# Listings") + 
            theme_bw()
            
    })
    
    output$table <- renderDT({
        selected_listings() %>% 
            select(price, accommodates, name)
    })
}

#' Run the app
shinyApp(ui, server)