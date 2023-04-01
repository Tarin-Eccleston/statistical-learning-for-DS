# Lab 2

# Task 1: Examine the Data

# Firstly the group column isn't ordered in rows in the excel file. Instead it's a heading for each of the descriptions.
# To solve this, I would create a for-loop and loop through the description elements and then once I reach a different group title, I
# change the group value and continue.

# There are borders between each weather section in the excel file. These will come up as NaN in the data frame once I load it in
# The solution is to loop through the entire dataframe and remote the NaNs.

# Similar situation to the group and description relationship in the excel file for the office size, type and value columns.

# Also the nnumeric data columns are not arranged nicely for analysis. I should created a new grid header which 
# takes a combination of wall type and office size

# Task 2: Clean the Data

setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/w2")
library(tidyverse)

air_cond_df <- readxl::read_xlsx("data/simulation_outpu1_raw.xlsx", skip = 7, col_names = FALSE)
clean_air_cond_df = air_cond_df

# Step 1: Give sensible column names
# create column names for 6 measured cols
# use grid command when there is a combination of different header titles
# it's better to create new names entirely rather than extracting it from the data
office_header_names = expand.grid(x = c("concrete", "curtain-wall"),
                           y = "offices",
                           z = c("small", "medium", "large")) %>%
  # create new names using a combination of the grid values
  mutate(nn = paste(x, y, z, sep = "_")) %>% 
  pull(nn) # similar to $, get the values

# append other column names to clean_air_cond_df
# create group column
names(clean_air_cond_df) = c("weather", "description", office_header_names)
# clean_air_cond_df = add_column(clean_air_cond_df, "group" = NA, .before = "concrete_offices_small")

# Step 2: fill in NAs due to merged cells

# # defaults in the loop
# group = "overall"
# weather_value = "Very Hot Humid (Honolulu, HI)"
# 
# for(i in 1:nrow(clean_air_cond_df)) {
#   # replace NAs with the previous weather value
#   if(clean_air_cond_df[i,1] == "NA") {
#     clean_air_cond_df[i,1] = weather_value
#   } else {
#     weather_value = i
#   }
# }

# for loops are slow. try something else!
# crewate 'group' attribute with 'overall', 'cooling' and 'heating' values

# add row of NA to follow the rule described below
x1 = as.data.frame(matrix(rep(NA, length(clean_air_cond_df)), nrow = 1))
names(x1) = names(clean_air_cond_df)

clean_air_cond_df = bind_rows(x1, clean_air_cond_df) %>%
  mutate(group = ifelse(is.na(description), "overall",
                 ifelse(description == "Sensible Cooling", "sensible_cooling",
                 ifelse(description == "Sensible Heating", "sensible_heating", NA))))

# use zoo package for extra support
library(zoo)
group_vt = zoo(clean_air_cond_df$group)
clean_air_cond_df$group = na.locf(group_vt) # last observations carry forward (locf)
# change everything in 'group' to character
clean_air_cond_df$group = as.character(clean_air_cond_df$group[1:length(clean_air_cond_df$group)])

# remove non-informative rows, i.e rows with 6 value columns
num_na_per_row_vt = apply(clean_air_cond_df, 1, function(x) sum(is.na(x)))
clean_air_cond_df = clean_air_cond_df[which(num_na_per_row_vt<7),]

# fill "weather" NA values with previous non-na values
weather_vt = zoo(clean_air_cond_df$weather)
clean_air_cond_df$weather = na.locf(weather_vt) # last observations carry forward (locf)

# Step 3: Wrangle and Tidy the data
# gather operation
clean_air_cond_df = clean_air_cond_df %>% 
  gather(key = 'structure', value = 'value', -group, -weather, -description) %>%
  separate(structure, c("office_type", "office", "office_size"),
           sep = "_") %>%
  select(-office) # remove constant 'office' column as it's useless
  

## Task 3: Exploring the Data using ggplot2

# Now use data and suitable plot(s) to answer the following questions. 
# Show your script and your brief answers.

# For small office with sensible cooling in place, how does the outdoor temperature 
# at peak load differ by weather? Does the pattern vary by office type?
  
# Do any of these factors affect the total energy consumption: office_type; 
# office_size and weather? If so, which one has the most significant impact?

clean_air_cond_df %>% filter(office_size == 'small') %>%
  filter(description == "Outdoor Temperature at Peak Load [C]"
  & group == "sensible_cooling") %>% # view
  ggplot(aes(x = weather, y = value, color = weather, shape = office_type)) +
  geom_point(size = 3) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1),
        legend.position = "right",
        legend.text = element_text(size = 6),
        legend.title = element_text(size = 8)) 



