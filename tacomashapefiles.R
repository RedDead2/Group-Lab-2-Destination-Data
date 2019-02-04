library(tigris)
library(tidycensus)
library(purrr)
library(tidyverse)
library(stringr)
library(dplyr)
library(sf)
library(rgeos)
library(rgdal)
library(sp)

options(class = "sf")
options(tigris_use_cache = TRUE)



tacoma <- st_as_sf(places("Washington", year = 2017) %>% filter_place("Tacoma"))

tacoma_plot <- places("Washington", year = 2017) %>% filter_place("Tacoma")

pierce_tracts <- st_as_sf(tracts(state = "WA", county = "Pierce", year = "2017", cb = TRUE))

pierce_blocks <- st_as_sf(blocks(state = "WA", county = "Pierce", year = "2017"))

tacoma_blocks <- st_intersection(tacoma, pierce_blocks)

tacoma_tracts <- st_intersection(tacoma, pierce_tracts)

st_write(obj = tacoma_blocks, dsn = "tacomablocks.geojson")

st_write(obj = tacoma_tracts, dsn = "tacomatracts.geojson")

st_write(obj = tacoma_tracts, dsn = "tacomatracts.gpkg")

st_write(obj = tacoma_blocks, dsn = "tacomablocks.gpkg")

options(sf_max.plot = 1)

plot(tacoma_blocks)
plot(tacoma_tracts)

plot(tacoma)

