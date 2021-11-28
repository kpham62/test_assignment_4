# Kenny Pham - Assignment 4
# server.R file
# Load packages
library(shiny) 
library(HSAUR)
library(dplyr)
library(ggplot2)
library(ggsci)

# Define source file
source("graph.R")

# Define data based on input and turn into output plot using server function
shinyServer(function(input, output) {
  
  # Information to be outputted based on location user clicks on the ggplot bar graph
  output$click_info <- renderText({
      paste0("Click on the colored bars to view detailed CO2 Emission information!\n",
             "\nCO2 Emission Value at Click Location (tonnes) = ", input$plot_click$y,
             "\nWorld Peak CO2 Emissions (tonnes) = ", input$plot_click$domain$top, "\n",
             "\nThis bar graph shows each continent's annual CO2 emissions from fossil
fuels compared to the world cumulative total that year. This provides a visualization
to better understand how continents are performing relative to the total. For example,
paired alongside the initial analysis, we can see that Asia, again, makes up a large
portion of the world data in most years. Additionally, Australia has some of the lowest
figures. By comparing each continent's bar side by side (alongside being able to click
to receive specific values), it provides a more objective way to analyze relativity in
emissions. However, this should be used as a base understanding to conduct additional
research, like finding out what specific events may have led to each emission total.")
    })
  
  # Define image to be outputted on first page
  output$image <- renderImage({
    list(src = "images/fossil.jpg",
         filetype = "image/jpg",
         alt = "fossil")
  }, deleteFile = FALSE)
  
  continent_year(input, output)
  
})
