library(dplyr)


#Change path as needed
crimeData <- read.csv("C:/Users/jbentley/Documents/GVI/shootingsandhom_jan2011_apr2014.csv", header=TRUE, sep=",")

#Begin with data provided in Longevity Recreation folder

#Processing to consolidate columns by introducing City Variable. More scalable for more cities
NHCrimeData = crimeData %>% select(., TrendID = Trend, Year, Month, TotalShootingsAndHom = NHshootingsandhom, GMI = NH_GMI, shootings = shootings, homs = hom,
                                   CoOffends = NH_CoOffense, Solos = NH_Solo, PossibleGMI = NHshootingandhomPossibleGMI, intervOn = Stable) %>%
  mutate(., City = "New Haven")

HFCrimeData = crimeData %>% select(., TrendID = Trend, Year, Month, TotalShootingsAndHom = HFshootingHom, GMI = HF_GMI,
                                   CoOffends = Hart_CoOffense, Solos = Hart_Solo, intervOn = Stable) %>%
  mutate(., City = "Hartford", shootings = NA, homs = NA, PossibleGMI = NA)


crimeData2 = rbind(NHCrimeData, HFCrimeData)


#Change path as needed
write.csv(crimeData2, file = "C:/Users/jbentley/Desktop/John/InterventionSignificanceTest/data/crimeData.csv")
