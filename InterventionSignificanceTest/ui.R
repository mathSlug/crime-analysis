library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Significance Tests of GVI Intervention"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #User parameters
      selectInput("cityChoiceExp", "Choose Observation City:",
                  unique(crimeData$City), selected = crimeData$City[1]),
      selectInput("cityChoiceCont", "Choose Control City:",
                  unique(crimeData$City), selected = crimeData$City[-1]),
      selectInput("homsOrGMI", "Examine Total Shootings and Homicides or Only GMI?:",
                  c("TotalShootingsAndHom", "GMI", "PossibleGMI"), selected = "TotalShootingsAndHom"),
      selectInput("yearIntervention", "Choose Implementation Year of Intervention:",
                unique(crimeData$Year), selected = crimeData$Year[crimeData$intervOn == 1][1]),
      selectInput("monthIntervention", "Choose Implementation Month of Intervention:",
                unique(crimeData$Month), selected = crimeData$Month[crimeData$intervOn == 1][1])
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #Models and descriptions
      textOutput("model1text"),
      tableOutput("model1info"),
      textOutput("model2text"),
      tableOutput("model2info"),
      textOutput("model3text"),
      tableOutput("model3info"),
      textOutput("model5text"),
      tableOutput("model5info")
    )
  )
))
