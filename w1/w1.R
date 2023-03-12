## Notes

# Getting Help
# __________________________________
# Get more information about function
# Use either ?{function} or solve("{function}")

# Presentation
# __________________________________
# Use rmarkdown file to present work
# Make sure to program in .R file first, then convert to markdown
# Use {r setup, include=???} (in markdown) and either include or exclude the code chunk for the report by stating 
# True / False. Makes things tidier
# Use {r, echo=FALSE} when I only need the output, not the line of code in R (User TRUE to include)
# Use {r, eval=FALSE} when I don't want to evaluate code chunk, but want to show it

# Housekeeping
# __________________________________
# For data management, especially with many variables, utilise rm(???) to rm from workspace
# Use setwd command to course working directory. Make sure that it's on the main .R file head
setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/w1")

# Data Structures and Conditions
# __________________________________
# Basically the same as Python

# NaN
# __________________________________
# Use is.nan({var}) to differentiate if the variable is a missing value or invalid number

# Indexing
# __________________________________
fruit <- c(1,2,3,4)
names(fruit) <- c("orange", "apple", "pear", "banana")
lunch <- fruit[c("apple", "orange")]

# Factoring
# __________________________________
# When R treats vectors as factors, the string elements will be arranged in alphabetical order
state_df <- c("tas", "vic", "nt")
state_df <- factor(state_df)
levels(state_df)

# Functions
# __________________________________
# Can create functions (just like in any other language), then use source({filename}) command to link
# The function will be loaded to the workspace?
# Keep functions in different files, evaluation in the main file
# source("aux_functions.R")

# Can also create one line functions
# NEED HELP WITH THIS
incomes_df <- c(60, 50, 66)
income_means <- tapply(incomes_df, state_df, mean)
get_std_error <- function(x) sqrt(var(x)/length(x))
income_std_error <- tapply(incomes_df, state_df, get_std_error)

# Arrays and matrices
# __________________________________
# So many functions, Google is your best friend!
x = array(1:20, dim=c(4,5))

# List 
# __________________________________
# Similar (ish) to dictionary data structure in Python
husband_list <- list(name="Fred", wife="Mary", no_children=3, child_ages=c(2,3,5), picket_fence=TRUE)

# Dataframe
# __________________________________
# Basically column-binds multiple other vectors
# Must have same number of rows to column-bind
accountants <- data.frame(home=state_df, loot=incomes_df, shot=incomes_df)
# Not sure about detach and attach. GET HELP FOR THAT

# ________________________________________________________________________________________

## Reproducibility
# __________________________________
# Any DA work report is likely to be rerun
  # Dataset gets updated
  # Review or QA want slightly different analysis
  # Revisit some past work
# That's why we use Git. Already sorted!

# Markdown
# __________________________________
# Only work on this once I have the code knuckled down!

# ________________________________________________________________________________________

## Tidyverse package
# __________________________________
# Best package in R for data wrangling. (includes dyplr)

# Gather (pivot_longer) vs Spread
# __________________________________
# Gather (pivot_longer): used to push data from cols to rows
# Spread:Used to push data from rows to cols
# Both functions are inverses of eachother

# Piping
# __________________________________
# Use %>% to create pipe. Basically this makes the var on the left the first input to the function
# On the right of the symbol
# Makes code easier to read

# Separate and combining cols
# __________________________________
# Used to seperate variables by their names. For example

# Separate:
# alarms_count_df <- alarms_count_df %>%
#   separate(date, c('prefix', 'year', 'month', 'day'))

# Unite:
# alarms_count_df <- alarms_count_df %>%
#   unite("yearmonth", year:month, remove = F)

# Subsetting and Adding Columns
# __________________________________
# Remove prefix col
# alarms_count_df %>% select(-prefix))

# Just want prefix col
# alarms_count_df %>% select(prefix))

# Mutate
# Add category
# alarms_count_df %>% mutate(category = if_else(frequency >= 400, 'High', 'Low'))

# Joining
# __________________________________
# Join: Used to join two dataframes based on similar IDs
# REFER to SQL joining diagram

# Group
# __________________________________
# Use group_by({var}, {var}), which will combine elements from different rows
# Determines how we will summaries data
# Can also convert datetime to day. Then can group data by days

# ________________________________________________________________________________________

# Questions: What's the difference between .R and .RProj files and why would I use the latter?
# What is the wrangling workflow for a DS?

# Notes
# Research on Anaconda, AWS, Jupyter, Cloud and Docker