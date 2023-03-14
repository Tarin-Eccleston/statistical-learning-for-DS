# Lab 2

# Task 1: Examine the Data

# Firstly the group column isn't ordered in rows in the excel file. Instead it's a heading for each of the descriptions.
# To solve this, I would create a for-loop and loop through the description elements and then once I reach a different group title, I
# change the group value and continue.

# There are borders between each weather section in the excel file. These will come up as NaN in the data frame once I load it in
# The solution is to loop through the entire dataframe and remote the NaNs.

# Similar situation to the group and description relationship in the excel file for the office size, type and value columns.

# Task 2: Clean the Data

setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/w2")
library(tidyverse)
library(readxl)
air_cond_df <- read_xlsx("data/simulation_outpu1_raw.xlsx")


