library(tidyverse)
library(lubridate)
library(sf)

setwd('upenn/22s/capstone/repo')

dockless_bikes <- read_csv('raw_data/dockless_bike_data_2022-01-31.csv')

dc <- 
  st_read("https://opendata.arcgis.com/datasets/7241f6d500b44288ad983f0942b39663_10.geojson") %>%
  dplyr::select(CITY_NAME, geometry)

bike_ids <- 
  dockless_bikes %>%
  group_by(bike_id) %>%
  summarize(
    n = n(),
    min_time = seconds_to_period(min(timestamp)),
    max_time = seconds_to_period(max(timestamp))
  )

test_bike <- 
  filter(dockless_bikes, bike_id == '00721af7b7f60f93b41dc49c0674f9ab') %>%
  dplyr::select(bike_id, lon, lat, timestamp) %>%
  st_as_sf(coords = c('lon', 'lat'), crs = 'epsg:4326')

ggplot() +
  # geom_sf(data = dc) +
  geom_sf(data = test_bike)

dist_plot <- function(x) {
  hist(x)                                   # Draw histogram
  abline(v = mean(x),                       # Add line for mean
         col = "red",
         lwd = 3)
  text(x = mean(x) * 1.7,                   # Add text for mean
       y = mean(x) * 1.7,
       paste("Mean =", mean(x)),
       col = "red",
       cex = 2)
}

