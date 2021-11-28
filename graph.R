# Kenny Pham - Assignment 4
# graph.R file (creates graph for application)
# Load Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(plotly)
library(reshape2)
library(scales)

# Load CSV data into 'co2_data_raw'
co2_data_raw <-
  read.csv("https://raw.githubusercontent.com/info-201a-au21/a4-climate-change-kpham62/main/data/annual-co-emissions-by-region.csv?token=AV3RG3GOJ4QZIY3IFQ6ADZTBVQCTS")

# Change the column names for 'co2_data' to more logical labels.               
colnames(co2_data_raw) <- c("Continent", "Code", "Year", "Annual_Co2_Emissions")

# Remove NA values and focus on modern data (1980 and above)
co2_data <- co2_data_raw %>%
  filter(Year >= 1980)

# Filter to continents
continent_year <- function(input, output) {
  # Filters data by continent (with respective years)
  co2_data_cont <- filter(
    co2_data, Continent == "Africa" |
      Continent == "North America" |
      Continent == "South America" |
      Continent == "Asia" |
      Continent == "Europe" |
      Continent == "Australia" |
      Continent == "World"
    )
  
  output$continent_year <- renderPlot({
    # Selects data for a continent and the world based on user's input
    if(input$selected_cont == "North America") {
      selected.data <- co2_data_cont %>% filter(Continent == "North America" | Continent == "World") %>%
      select(Continent, Year, Annual_Co2_Emissions)
    } else if (input$selected_cont == "South America") {
      selected.data <- co2_data_cont %>% filter(Continent == "South America" | Continent == "World") %>%
        select(Continent, Year, Annual_Co2_Emissions)
    }  else if (input$selected_cont == "Europe") {
      selected.data <- co2_data_cont %>% filter(Continent == "Europe" | Continent == "World") %>%
        select(Continent, Year, Annual_Co2_Emissions)
    }  else if (input$selected_cont == "Africa") {
      selected.data <- co2_data_cont %>% filter(Continent == "Africa" | Continent == "World") %>%
        select(Continent, Year, Annual_Co2_Emissions)
    }  else if (input$selected_cont == "Asia") {
      selected.data <- co2_data_cont %>% filter(Continent == "Asia" | Continent == "World") %>%
        select(Continent, Year, Annual_Co2_Emissions)
    }  else if (input$selected_cont == "Australia") {
      selected.data <- co2_data_cont %>% filter(Continent == "Australia" | Continent == "World") %>%
        select(Continent, Year, Annual_Co2_Emissions)
    }  else {
      selected.data <- co2_data_cont %>% select(Continent, Year, Annual_Co2_Emissions)
    }
    
    # Selects data for a specific year based on the user's input selection
    selected.data <- selected.data %>% filter(Year == input$selected_year)
    # Selects data for a specific year based on the user's input selection
    selected.data <- selected.data %>%
      filter(Year == input$selected_year) %>%
      arrange(desc(Continent))
    
    # Creates a bar graph from the selected data
    graph <- ggplot(data = selected.data, aes(x=Continent, y=unlist(selected.data[,3]), fill=Continent)) +
      geom_bar(stat = "identity") +
      theme(legend.position="none") +
      ylab("CO2 Emissions (tonnes)") +
      xlab("Continent vs. World") +
      ggtitle(paste0("Annual CO2 emission total from fossil fuels, by Continent vs. the World cumulatively (",
                                                           input$selected_cont, ", ", input$selected_year, ")")) +
      scale_y_continuous(labels = scales::comma)
    
    return(graph)
    
  })
}
