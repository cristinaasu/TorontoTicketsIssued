#### Preamble ####
# Purpose: Downloads and saves the data from OpenData Toronto.
# Author: Cristina Su Lam
# Date: 21 September 2024
# Contact: cristina.sulam@utoronto.ca 
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)


#### Download data ####

# Get all the tickets data
raw_tickets_data <- list_package_resources("police-annual-statistical-report-tickets-issued") |>
  filter(name == "Tickets Issued.csv") |>
  get_resource()


#### Save data ####
write_csv(raw_tickets_data, "data/raw_data/raw_tickets_data.csv") 



         
