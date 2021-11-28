# Kenny Pham
# ui.R file
# Load packages
library("shiny")
library("plotly")
library("HSAUR")
library("ggsci")
library("rsconnect")

rsconnect::setAccountInfo(name='kpham62',
                          token='48BF7D985510FE7AC802E53CCB4E8C82',
                          secret='a68zQF+KxCOi9ZCi65OuWIEgcV7QPiYv7STNaB4L')

# Store into ui
ui <- navbarPage(
  
  # Define title of application and description
  "Continent Significant CO2 Emissions Analysis",
  tabPanel(
    "Introduction Summary",
    sidebarLayout(
      sidebarPanel(
        imageOutput("image")
      ),
      
      mainPanel(
        p(strong("Kenny Pham - Assignment 4: Data Applications (climate change)")),
        p(strong("Climate Change Introduction")),
        br("Climate change has been a consistently pertinent topic in the 21st century.
        Policies, laws, acts, and movements have all come under light due to the
        impending consequences of climate change. Likewise, the same efforts can be
        seen by those who don't believe in climate change."),
        br(),
        p(strong("Domain - Annual CO2 Emissions From Fossil Fuels (By Continent)")),
        br("Data is an essential piece to make sense of the noise surrounding climate
        change. It can make objective points about our current situation, but on the
        other hand it can emphasize biases. This application is my try at analyzing
        a small snippet of factors affecting climate change. Specifically, analyzing
        annual CO2 emissions from fossil fuels by continent to give us an understanding
        of how climate change has developed for us as a whole. Additionally,
        comparing this data to cumulative world data. After all, it is an
        issue for the world, not just each country individually. Fossil fuels were 
        chosen in specific to bring attention to how much or how little just one 
        pollution source can produce. An important note, Antarctica is excluded due to
        its insignificant emissions figures compared to more populated continents."),
        br(),
        p(strong("\nSummary Analysis")),
        br("My 5 calculated values:"),
        br("1. Continent with the highest fossil fuel CO2 emissions total from 1980-2020 (with value):
        Asia, 2019, 20608592701"),
        br("2. Continent with the lowest fossil fuel CO2 emissions total from 1980-2020 (with value):
        Australia, 1980, 220537329"),
        br("3. Year with the highest fossil fuel CO2 emissions total from 1980-2020 using 'World' data (with value):
        World, 2019, 36702502903"),
        br("4. Continent with the most CO2 emissions increase from 1980-2020 with their average annual change:
        Asia, Total = +15916153596, Avg = +397903840"),
        br("5. Continent with the least CO2 emissions increase from 1980-2020 with their average annual change:
        Europe, Total = -2789666941, Avg = -69741674"),
        br("Conclusions that can be made from my initial analysis is that from 1980-2020, Asia is consistently
        the highest fossil fuel polluter. They hold the highest fossil fuel CO2 emissions total in 2019 as 
        well as the highest total and average change from 1980-2020. In contrast, both Australia and Europe have promising figures.
        Australia holds the lowest fossil fuel CO2 emissions total in 1980 and Europe has actually reduced
        their emissions in both total and average from 1980-2020. Additionally, looking at
        the highest World total in 2019, Asia makes up a significant portion of those emissions.
        This gives us a general idea of how the different continents are performing relative to each other.")
      )
    )
  ),
  
  tabPanel(
    "Annual CO2 emissions from fossil fuels, by Continent vs. the World cumulatively",
    sidebarLayout(
      sidebarPanel(
        selectInput("selected_year", label = h3("Select a year"), 
                    choices = 1980:2020, 
                    selected = 2016),
        
        radioButtons("selected_cont", label = h3("Select a continent"), 
                    choices = c("North America", "South America", "Europe",
                                "Africa", "Asia", "Australia"),
                    selected = "North America")
      ),
      
      # Output graph and necessary click-to-output functions
      mainPanel(
        plotOutput("continent_year", height = 400,
                   click = "plot_click",
                   dblclick = dblclickOpts(
                     id = "plot_dblclick"
                   ),
                     
        )
      )
    ),
    
    # Defines width of output box of clicks
    fluidRow(
      column(width = 12,
             verbatimTextOutput("click_info"))
      )
    )
  )
  
shinyUI(ui)
