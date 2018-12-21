library(shiny)
library(dplyr)
library(TSA)
library(VIM)


#Read data, sheet created by running mmunging.R
crimeData = read.csv("data/crimeData.csv", header = T) %>%
  #Use only data used in Longevity paper
  filter(., Year < 2014 | Month < 5)

#Impute Hartfort probable GMI as Hartford actual GMI, since values are missing.
#Has the effect of regressing on control actual GMI for 
#calculating Main City Probable GMI. Will affect nothing else.
crimeData[crimeData$City == "Hartford",names(crimeData) == "PossibleGMI"] =
  crimeData[crimeData$City == "Hartford",names(crimeData) == "GMI"]

#Impute missing Co-Offend data
crimeData = kNN(crimeData)
