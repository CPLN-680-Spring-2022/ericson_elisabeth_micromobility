library(tidyverse)
library(sf)

setwd('upenn/22s/capstone/repo')

sf_trips <- read_csv('raw_data/202201-baywheels-tripdata.csv')

dockless_end <-
  sf_trips %>%
  filter(is.na(end_station_id) & !is.na(end_lat) & rideable_type == 'electric_bike') %>%
  group_by(end_lng, end_lat) %>%
  summarize(n = n()) %>%
  st_as_sf(coords = c('end_lng', 'end_lat'), crs = 'epsg:4326')

ggplot() +
  geom_sf(data = dockless_end)