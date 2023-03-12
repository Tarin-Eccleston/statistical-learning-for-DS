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



