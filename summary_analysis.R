# Kenny Pham - Assignment 4
# analysis.R file (Analyzing data for summary)
# Load packages

# Load CSV data into 'co2_data_raw'
co2_data_raw <-
  read.csv("https://raw.githubusercontent.com/info-201a-au21/a4-climate-change-kpham62/main/data/annual-co-emissions-by-region.csv?token=AV3RG3GOJ4QZIY3IFQ6ADZTBVQCTS")

# Change the column names for 'co2_data' to more logical labels               
colnames(co2_data_raw) <- c("Continent", "Code", "Year", "Annual_Co2_Emissions")

# Remove NA values and focus on modern data (1980 and above)
co2_data <- co2_data_raw%>%
  filter(Year >= 1980)

  # Filters data by continent (with respective years)
co2_data_cont <- filter(
  co2_data, Continent == "Africa" |
    Continent == "North America" |
    Continent == "South America" |
    Continent == "Asia" |
    Continent == "Europe" |
    Continent == "Australia" |
    Continent == "World")

View(co2_data_cont)

# VALUE 1
# Continent with the highest fossil fuel CO2 emissions total from 1980-2020 (with value)
# Asia, 2019, 20608592701
cont_most_co2 <- co2_data_cont %>%
  filter(!grepl('World', Continent)) %>%
  filter(Annual_Co2_Emissions == max(Annual_Co2_Emissions, na.rm = TRUE))
print(cont_most_co2)

# VALUE 2
# Continent with the lowest fossil fuel CO2 emissions total from 1980-2020 (with value)
# Australia, 1980, 220537329
cont_least_co2 <- co2_data_cont %>%
  filter(!grepl('World', Continent)) %>%
  filter(Annual_Co2_Emissions == min(Annual_Co2_Emissions, na.rm = TRUE))
print(cont_least_co2)

# VALUE 3
# Year with the highest fossil fuel CO2 emissions total from 1980-2020
# using 'World' data (with value)
# World, 2019, 36702502903
world_most_co2 <- co2_data_cont %>%
  filter(Annual_Co2_Emissions == max(Annual_Co2_Emissions, na.rm = TRUE))
print(world_most_co2)

# Returns data on how each continent's fossil fuel CO2 emissions has changed
# from the previous entry from 1980-2020 (years). Stores the total amount and
# change as well as the average change.
avg_emissions <- co2_data_cont %>%
  drop_na() %>%
  group_by(Continent) %>%
  mutate(emission_change = Annual_Co2_Emissions - lag(Annual_Co2_Emissions,  default = NA)) %>%
  summarize(total_emission_change = sum(emission_change, na.rm = T),
            avg_emission_change = mean(emission_change, na.rm = T))

# VALUE 4
# Returns data of the continent with the most CO2 emissions increase
# from 1980-2020 with their average annual change
# Asia, Total = +15916153596, Avg = +397903840
most_emissions_increase <- avg_emissions %>%
  filter(total_emission_change == max(total_emission_change, na.rm = TRUE))
print(most_emissions_increase)

# VALUE 5
# Returns data of the continent with the least CO2 emissions increase
# from 1980-2020 with their average annual change
# Europe, Total = -2789666941, Avg = -69741674
# (negative values equates to decrease in emissions)
least_emissions_increase <- avg_emissions %>%
  filter(total_emission_change == min(total_emission_change, na.rm = TRUE))
print(least_emissions_increase)
