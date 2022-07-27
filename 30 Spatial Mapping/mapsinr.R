# load packages
library(tidyverse)
library(sf)
library(tmap)
library(shiny)
library(gifski)

#read in files you need
durham <- st_read("30 Spatial Mapping/demo_beat_data/demographic_summary_arrests_per_beat.shp", quiet = TRUE)
beat <- read.csv("10 Clean Data/GROUPEDBY_BEAT.csv")
years <- read.csv("30 Spatial Mapping/years.csv")
with_beats <- read_csv("10 Clean Data/with_beats.csv")

# merge geometry file with information files
years_withgeom <- full_join(durham, years, by = c("Beat" = "LAWBEAT"))

#changes mode of tmaps to control interactivity
tmap_mode("view")
tmap_mode("plot")

#creates object for a map of arrests by race faceted by year
years_map <- tm_shape(years_withgeom) +
  tm_polygons("Black.", palette = "Blues", title = "Percent Black Identified Arrests") +
  tm_facets(by = "Year", nrow = 2, free.coords = FALSE) +
  tm_layout(main.title = "Beat Map of Percentage of Arrets that are Black Identified People faceted by year", main.title.size = 1)

# plots map created in object above
years_map

## START OF PROCESS OF MAPPING PRE/POST GEORGE FLOYD AND DAY NIGHT

#creates new data frame with the hour (on 24 clock) the arrest occured at. Creates new variable classifying those times of day
times <- with_beats %>% 
  mutate(georgefloyd = ifelse(dates <= "2020-06-01", "Pre George Floyd", "Post George Floyd")) %>% 
  select(time, LAWBEAT, arrestnumber, race, georgefloyd) %>% 
  mutate(timetime = as.numeric(substr(time, start = 1, stop = 2))) %>% 
  mutate(timeofday = case_when(timetime > 8 & timetime < 17 ~ "Day", (timetime <= 8 & timetime > 6) | (timetime >= 17 & timetime < 20) ~ "Dawn/Dusk",
                               timetime >= 20 | timetime <= 6 ~ "Night")) %>% 
  select(LAWBEAT, arrestnumber, race, timeofday, georgefloyd, timetime)


#creates dataframe with counts of each race identified in arrests grouped by lawbeat and day category
racial_counts <- times %>% 
  mutate(Black = ifelse(race == "B", 1, 0)) %>% 
  mutate(White = ifelse(race == "W", 1, 0)) %>% 
  mutate(Asian = ifelse(race == "A", 1, 0)) %>% 
  mutate(Indigenous = ifelse(race == "I", 1, 0)) %>% 
  mutate(Unknown = ifelse(race == "U", 1, 0)) %>% 
  group_by(LAWBEAT, timeofday) %>% 
  summarise(sum(Black), sum(White), sum(Asian), sum(Indigenous), 
            sum(Unknown), n())

#renames columns from teh above counts so they're usable in mappings
racial_counts <- racial_counts %>% 
  rename("Black" = "sum(Black)", "White" = "sum(White)", "Asian" = "sum(Asian)",
         "Indigenous" = "sum(Indigenous)", "Unknown" = "sum(Unknown)", 
         "total" = "n()") 

#turns the counts into percentages
percentage_of_race <- racial_counts %>% 
  mutate("% Black Arrests" =  Black / total, percentW =  White / total,
         "percentA" = Asian / total, percentI = Indigenous / total,
         percentU = Unknown / total, percentPOC = 1 - percentW)

#creates new data frame so we have time odf day with geometries for each beat
day_time <- full_join(durham, percentage_of_race, by = c("Beat" = "LAWBEAT"))

# filters out times of day we're unsure about
day_time <- day_time %>% 
  filter(timeofday != "Dawn/Dusk")

# creates and prints a map of durham by beats contrasting day and night by arrest of APB people
day_night_map <- tm_shape(day_time) +
  tm_polygons("% Black Arrests", palette = "Blues", breaks = c(0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1)) +
  tm_facets(by = c("timeofday"), nrow = 1, free.coords = FALSE) +
  tm_layout(main.title = "Percentage of Black Arrests Day vs Night")
day_night_map

# creates a map showing the percentage of people that are APB in each police beat
demographic_map_anypartblack <- tm_shape(durham) +
  tm_polygons("percent_ap", palette = "Blues", breaks = c(0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1), title = "Percentage") +
  tm_layout(main.title = "Percentage of Black Population by Police Beat", legend.outside = TRUE)
demographic_map_anypartblack
