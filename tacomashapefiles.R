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
library(ggplot2)

options(class = "sf")
options(tigris_use_cache = TRUE)


#Gather place data for Tacoma and make it sf.
tacoma <- st_as_sf(places("Washington", year = 2017) %>% filter_place("Tacoma"))

#Gather tract data for Pierce County and make it sf.
pierce_tracts <- st_as_sf(tracts(state = "WA", county = "Pierce", year = "2017", cb = TRUE))

#Gather block data for Pierce County and make it sf.
pierce_blocks <- st_as_sf(blocks(state = "WA", county = "Pierce", year = "2017"))

#Gather water shapefiles at block level.
pierce_water_blocks <- pierce_blocks %>% 
                       filter(ALAND10 == "0")

#Intersected the block data in both the Tacoma and water sf objects.
tacoma_water_blocks <- st_intersection(tacoma, pierce_water_blocks)

#Gather water shapefiles at tract level.
pierce_water_tracts <- pierce_tracts %>% 
                       filter(ALAND == "0")

#Intersected the tract data in both the Tacoma and water sf objects.
tacoma_water_tracts <- st_intersection(tacoma, pierce_water_tracts)

tacoma_blocks <- st_intersection(tacoma, pierce_blocks)

tacoma_tracts <- st_intersection(tacoma, pierce_tracts)

#testing plot
#plot(tacoma_tracts)
#plot(tacoma_blocks)

write_csv(tacoma_blocks,"tacoma_blocks2.csv")
write_csv(tacoma_tracts, "tacoma_tracts2.csv")

st_write(obj = tacoma_blocks, dsn = "tacomablocks.kml")

save(tacoma_blocks, file = "tacomablocks.RData")
save(tacoma_tracts, file = "tacomatracts.RData")

st_write(obj = tacoma_tracts, dsn = "tacomatracts.sf", driver = "ESRI Shapefile")

st_write(obj = tacoma_tracts, dsn = "tacomatracts.gpkg")

st_write(obj = tacoma_blocks, dsn = "tacomablocks.gpkg")

test <-  read_sf("tacomablocks.sf", stringsAsFactors = FALSE)

options(sf_max.plot = 1)

plot(tacoma_blocks)
plot(tacoma_tracts)

plot(tacoma)

