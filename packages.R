
# from CRAN
library(geojsonio) # install.packages('geojsonio')

# from GRAN
#options(repos=c(USGS='https://owi.usgs.gov/R', options()$repos))
library(dataRetrieval) # install.packages('dataRetrieval')
library(sbtools) # install.packages('sbtools')

# from github
library(vizlab) # install.packages('vizlab'); devtools::install_github('richfitz/remake'); devtools::install_github('USGS-VIZLAB/vizlab@v0.3.8')

# from rocker/geospatial (shouldn't need to install)
library(dplyr)
library(jsonlite)
library(maptools)
library(rgdal)
library(tibble)
library(tidyr)
library(sp)
