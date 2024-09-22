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


#### Clean data ####

# Preview of Data
head(raw_tickets_data)
tail(raw_tickets_data)

# This process involves standardizing and dropping unnecessary column names,
# renaming specific ticket types for consistency, and filtering the dataset 
# to include only offence years from 2019 to 2023.
cleaned_tickets_data <- raw_tickets_data |>
  janitor::clean_names() |>
  # Drop unnecessary columns
  select(-`x_id`, -`hood_158`, -`neighbourhood_158`) |>
  # Rename ticket type
  mutate(ticket_type = ifelse(ticket_type == "Prov Offence Summons Part Iii Form 104", 
                              "Prov Offence Summons Part III Form 104", 
                              ticket_type)) |>
  # Filter for offence years 2019 to 2023
  filter(offence_year %in% 2019:2023)

# Check for missing values
missing_values <- cleaned_tickets_data |> 
  summarise(across(everything(), ~ sum(is.na(.))))

# Display missing values
print(missing_values)

# Convert character variables to factors for analysis
cleaned_tickets_data <- cleaned_tickets_data |> 
  mutate(
    division = factor(division),
    ticket_type = factor(ticket_type),
    offence_category = factor(offence_category),
    age_group = factor(age_group)
  )

# Check data types
str(cleaned_tickets_data)

# Inspect the cleaned data
print(cleaned_tickets_data)

#### Save data ####
write_csv(cleaned_tickets_data, "data/analysis_data/cleaned_tickets_data.csv")











