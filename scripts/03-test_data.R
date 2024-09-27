#### Preamble ####
# Purpose: Tests for Cleaned Dataset.
# Author: Cristina Su Lam
# Date: 21 September 2024
# Contact: cristina.sulam@utoronto.ca
# License: MIT
# Pre-requisites: run 02-data_cleaning.R
# Any other information needed? None

#### Workspace Setup ####
library(tidyverse)
library(dplyr)

#### Test Tickets Issued Data ####

# Test for the correct number of rows
num_rows <- nrow(cleaned_tickets_data)
expected_rows <- 15672
if (num_rows != expected_rows) {
  print(paste("Number of entries is incorrect. Expected:", expected_rows, "but got:", num_rows))
}

# Test for valid offence_year values
valid_years <- 2018:2023 
if (any(!(cleaned_tickets_data$`Offence Year` %in% valid_years))) {
  print("There are invalid offence_year values outside the expected range (2018-2023).")
}

# Test for valid divisions
valid_divisions <- c("D42", "D22", "D11", "D41", "D53", "D31", "D43", 
                     "D23", "D52", "D32", "D12", "D55", "D51", "D33", "D14", 
                     "D13")
if (any(!(cleaned_tickets_data$Division %in% valid_divisions))) {
  print("There are invalid division values.")
}

# Test for ticket_type categories
valid_ticket_types <- c("Prov Offence Notice - Part I (Pot)", 
                        "Prov Offence Summons Part III Form 104")
if (any(!(cleaned_tickets_data$`Ticket Type` %in% valid_ticket_types))) {
  print("There are invalid ticket_type values.")
}

# Test for age_group values
valid_age_groups <- c("Adult", "Youth")
if (any(!(cleaned_tickets_data$`Age Group` %in% valid_age_groups))) {
  print("There are invalid age_group values.")
}

# Test that ticket_count is non-negative
if (any(cleaned_tickets_data$`Ticket Count` < 0)) {
  print("There are negative values in the ticket_count column.")
}

# Test that no missing values exist
missing_values <- sum(is.na(cleaned_tickets_data))
if (missing_values > 0) {
  print(paste("There are", missing_values, "missing values in the dataset."))
}

# Test that the ticket_count column is numeric
if (!is.numeric(cleaned_tickets_data$`Ticket Count`)) {
  print("The ticket_count column is not numeric.")
}

#### Test Division Data ####

# Test for the correct number of rows
num_division_rows <- nrow(cleaned_division_data)
expected_division_rows <- 16 
if (num_division_rows != expected_division_rows) {
  print(paste("Number of entries in division data is incorrect. Expected:", 
              expected_division_rows, "but got:", num_division_rows))
}

# Test for missing values
missing_division_values <- sum(is.na(cleaned_division_data))
if (missing_division_values > 0) {
  print(paste("There are", missing_division_values, "missing values in the division dataset."))
}

# Test for valid division names
if (any(!(cleaned_division_data$Division %in% valid_divisions))) {
  print("There are invalid division values in the division dataset.")
}

# Check that Area is non-negative and numeric
if (any(cleaned_division_data$Area < 0)) {
  print("There are negative values in the Area column of the division dataset.")
}

# Test that the Area column is numeric
if (!is.numeric(cleaned_division_data$Area)) {
  print("The Area column is not numeric.")
}

# Optionally, check the validity of geometries
if (any(!st_is_valid(cleaned_division_data$Geometry))) {
  print("There are invalid geometries in the division dataset.")
}

