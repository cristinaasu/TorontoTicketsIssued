#### Preamble ####
# Purpose: Simulates the issuance of tickets in Toronto, from 2019 to 2023.
# Author: Cristina Su Lam
# Date: 21 September 2024
# Contact: cristina.sulam@utoronto.ca 
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(ggplot2)


#### Simulate data ####
set.seed(23)

num_obs <- 500

simulated_data <- 
  tibble(
    year = sample(2018:2023, num_obs, replace = TRUE),
    ticket_type = sample(c("Prov Offence Notice - Part I (Pot)", 
                           "Prov Offence Summons Part III Form 104"), 
                         num_obs, replace = TRUE),
    offence_category = sample(c("Distracted Driving", "Other HTA", "All CAIA", 
                                "Aggressive Driving", "Speeding"), 
                              num_obs, replace = TRUE),
    age_group = sample(c("Adult", "Young", "Unknown"), num_obs, replace = TRUE),
    division = sample(c("NSA", "D42", "D22", "D11", "D41", "D53", "D31", "D43", 
                        "D23", "D52", "D32", "D12", 
                        "D55", "D51", "D33", "D14", "D13"), num_obs, 
                      replace = TRUE),
    delay = sample(0:47, num_obs, replace = TRUE)
  )


# Plot 1: Ticket Categories and their Frequencies
ggplot(simulated_data, aes(y = offence_category)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Ticket Categories and their Frequencies", 
       x = "Count", 
       y = "Offence Category") +
  theme_minimal()

# Plot 2: Bar Graph of Tickets Issued by Year
ggplot(simulated_data, aes(x = as.factor(year))) +
  geom_bar(fill = "lightblue") +
  labs(title = "Number of Tickets Issued by Year", 
       x = "Year", 
       y = "Count of Tickets") +
  theme_minimal()

# Plot 3: Line Graph of Ticket Count by Offence Category (2019-2023)

# Prepare data for plotting by grouping and counting
plot_data <- simulated_data %>%
  group_by(year, offence_category) %>%
  summarise(ticket_count = n()) %>%
  ungroup()

# Line graph: Offence Category vs Ticket Count
ggplot(plot_data, aes(x = offence_category, y = ticket_count, 
                      group = year, color = as.factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Ticket Count by Offence Category (2019-2023)", 
       x = "Offence Category", 
       y = "Count of Tickets", 
       color = "Year") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

