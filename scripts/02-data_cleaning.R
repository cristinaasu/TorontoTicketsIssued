#### Preamble ####
# Purpose: Cleans the raw Toronto Tickets Issued data for analysis.
# Author: Cristina Su Lam
# Date: 21 September 2024
# Contact: cristina.sulam@utoronto.ca 
# License: MIT
# Pre-requisites: run 01-download_data.R
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(sf)

#### Clean Tickets Issued Data ####

# Preview of Tickets Issued Data
head(raw_tickets_data)
tail(raw_tickets_data)

# Clean and preprocess the tickets data
cleaned_tickets_data <- raw_tickets_data |>  
  janitor::clean_names() |> 
  select(-x_id, -hood_158, -neighbourhood_158) |>  
  mutate(ticket_type = ifelse(ticket_type == "Prov Offence Summons Part Iii Form 104", 
                              "Prov Offence Summons Part III Form 104", 
                              ticket_type)) |>  
  filter(offence_year %in% 2018:2023, division != "NSA", age_group != "Unknown") |> 
  rename(`Ticket Count` = ticket_count,
         `Offence Year` = offence_year,
         `Division` = division,
         `Ticket Type` = ticket_type,
         `Offence Category` = offence_category,
         `Age Group` = age_group) |>  
  arrange(`Offence Year`)  

# Check for missing values
missing_values <- cleaned_tickets_data |>   
  summarise(across(everything(), ~ sum(is.na(.))))  

# Display missing values and data types
print(missing_values)
str(cleaned_tickets_data)
print(cleaned_tickets_data)

#### Clean Division Data ####

# Preview of Division Data 
head(raw_division_data)
tail(raw_division_data)

# Standardize column names in division data
raw_division_data <- janitor::clean_names(raw_division_data) 

# Check the original row count
original_count <- nrow(raw_division_data)

# Remove duplicate rows and check the new row count
new_division_data <- raw_division_data |> 
  distinct()

new_count <- nrow(new_division_data)

# Print results for duplicate removal
cat("Original count of rows:", original_count, "\n")
cat("New count of rows after removing duplicates:", new_count, "\n")

# Clean and preprocess raw_division_data
cleaned_division_data <- new_division_data |>  
  select(div, area_sqkm, geometry) |>  # Drop unneeded columns
  rename(Division = div, Area = area_sqkm, Geometry = geometry) |>  # Rename for consistency
  arrange(Division)  # Optionally arrange by division name

# Inspect cleaned division data
print(cleaned_division_data)

# Preview of Division Data 
head(raw_division_data)
tail(raw_division_data)

# Standardize columns
raw_division_data <- janitor::clean_names(raw_division_data)
raw_division_data 

# Check the original row count
original_count <- nrow(raw_division_data)

# Check for duplicates
raw_division_data <- raw_division_data |> distinct()

# Check the new row count
new_count <- nrow(raw_division_data)

# Print the results
cat("Original count of rows:", original_count, "\n")
cat("New count of rows after removing duplicates:", new_count, "\n")

# Check if any rows were removed
if (original_count > new_count) {
  cat("Number of rows removed:", original_count - new_count, "\n")
} else {
  cat("No rows were removed.\n")
}


# Clean and preprocess raw_division_data
cleaned_division_data <- raw_division_data |> 
  janitor::clean_names() |>  
  distinct() |>             
  select(div, area_sqkm, geometry) |> 
  rename(Division = div, Area = area_sqkm, Geometry = geometry) |>  
  arrange(Division)  

# Inspect cleaned data
print(cleaned_division_data)

#### Save data ####
write_csv(cleaned_tickets_data, "data/analysis_data/cleaned_tickets_data.csv")
st_write(cleaned_division_data, "data/analysis_data/cleaned_division_data.geojson", driver = "GeoJSON")













