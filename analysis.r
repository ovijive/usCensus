## load our libraries for this work
library(leaflet)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
install.packages("maps")
install.packages("ggmap", dependencies = T)
library(ggmap)

## Load dataset
cencus <- read.csv(file.choose(), header = T)

## visualise cencus
head(cencus)
### SummaryInfo and Plots ###

## Histogram of age distribution within the dataset, can be considered useful or not useful
##terrible way to visualise this particular data
ggplot(cencus) +
  aes(x = age) +
  geom_bar()

##is.factor(cencus$age)
## convert AgeVariable to a factor 
data <- 
  cencus%>%
  mutate(age = cut(age, breaks = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)))

## get an idea of age distribution in the dataset categorised by race and gender
ggplot(data) +
  aes(x = age, fill = race) +
  geom_bar() + facet_grid(. ~ sex) + labs(x = "Age Category", y = "Frequency Count")  ##geom_bar(position = "dodge")
ggtitle("Race n Age Variation Categorised by gender")

## Group incomeLevel by race
ggplot(data) +
  aes(x = age, fill = race) +
  geom_bar() + facet_grid(. ~ income.level) + labs(x = "Age Category", y = "Frequency Count")  ##geom_bar(position = "dodge")
ggtitle("Income Level Categorised by race")

## extract variable we are interested in analysing to be used in map
census1 <- cencus[c('age', 'race', 'income.level', 'sex', 'education', 'state.of.previous.residence', 'region.of.previous.residence')]

## visusalise the census1 dataseat 1st 15 lines
head(census1, 15)

## get map into R
GetMap <- get_map(location = "united states", source = "google", zoom = 8, color = "color")

## create map
your.map <- leaflet(data = census1) %>% addTiles()
your.map # print the map

## now add points to data to make it interactive and interesting
?addPolygons
?addGeoJSON
?aes
