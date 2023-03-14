# Week 2 Notes

# Why are graphs important?
# __________________________________
# they can tell you 1000 words
# summary statistics can be misleading
# Different graphs can show important features and findings

# Components of a Graph
# __________________________________
# Decision process
# Dataset -> Mapping (x, y) -> Scales -> Geometric Objects (line, bar, points) -> Stats (mean, quantile)
# -> Facets -> Coordinate System

# Code for ggplot
## first, lets lok at the aestetic attributes (aes)
library(tidyverse)
# available through R
data("airquality")

# store graph structure as variable to save coding time
p1=airquality %>%
  # just create graph with solar as x, and ozone as y
  ggplot(aes(x = Solar.R, y = Ozone))

# geometric object #
# p2=airquality %>%
#   ggplot(aes(x = Solar.R, y = Ozone)) + 
#   # add point to figure. The points will inherit all the attributes specified in aes
#   geom_point()

# gives the same as the uncommented section above. saves coding time.
# can use transparent parameters to change the look of the plot
p1 + geom_point(alpha=0.5, shape=".")

# use different colour to show different months
airquality %>%
  ggplot(aes(x = Solar.R, y = Ozone, color=factor(Month))) +
  geom_point()

# add geomsmooth 
airquality %>%
  ggplot(aes(x = Solar.R, y = Ozone)) +
  geom_point() +
  # does smoothing for each curve for each month if you divy up the data by month
  # alternatively, it smooths out the whole data
  # need to think about how many points there are per group. determines how valuable the smoothing curve is
  geom_smooth()

# might not be able to distinguish between overlapping points
# use hex function to solve this
airquality %>%
  ggplot(aes(x = Solar.R, y = Ozone)) +
  geom_hex()

# Geometrix Objects
# __________________________________

airquality %>%
  # ozone is a numeric value. month is a factor (doesn't make sense to treat it as a numeric value). can use a boxplot to display information because of this
  ggplot(aes(x = factor(Month), y = Ozone)) +
  geom_boxplot()

# Facets
# __________________________________
# diving data sets into sub groups and plot seperately for each group. useful when the relationship is beyond 2D

airquality %>%
  ggplot(aes(x = Solar.R, y = Ozone)) +
  geom_point() + 
    # very useful for explloring 3+ variables. using a 3d plot is complicated and usually difficult to understand
    # create plots for individual months. transform problems from 3d to 2d
    # can also use facet_grid()
    facet_wrap(~Month, nrow = 2)

# incorporating data processing
# DOESNT WORK FOR SOME REASON
# airquality %>% na.omit() %>%
#   # incorporate data preprocessing step
#   mutate(TempGp = cut(Temp,
#           breaks = quantile(Temp, (0:4)/4,
#           inc = TRUE)) %>%
#   mutate(WindGp = cut(Wind,
#           breaks = quantile(Wind, (0:4)/4,
#           inc = TRUE)) %>%
#   ggplot(aes(x = Solar.R, y = Ozone)) +
#   geom_point() +
#   facet_grid(WindGp ~ TempGp)
  
  # _________________________________________________________________________________________________________________________
  
# Which common plot to use?
# __________________________________
#  Types:
#      Quantitative (e.g a variable of measurement) -> dot plot/strip chart, histogram, density plot, box plot
#      -> pay attention to features such as: shapes, peaks, center, variability, outliers
#      Qualitative (e.g count of a grouping variable) -> bar plot, pie chart, table of counts 
#      -> pay attention to features such as: majority/minority group, gaps in group counts.
#      (need to keep in mind groups with fewer observations. Would it be better to combine groups to get a stable estimate?)


# refer to notes app for more information
# note: plotting for 2+ variables can often be achieved by 'reducing' it to some variations of bi-variate plots
  
# General Plotting Advice
# __________________________________
# use colors, shapes but keep things balanced
# keep the focus - produce a plot with a clear message in mind (make it )
# be aware of scales (in units of $1 vs $1000 for housing prices), labels and hierarchy
# utilize white space
  
# _________________________________________________________________________________________________________________________

# back to code

set.seed(991)
# data is a random mixture of normal distribution (bimodal)
df <- data.frame(x = c(rnorm(100,-2,1), rnorm(100,4,1)))

# boxplot looks relatively symmetric. data looks like it comes from one nice dist
df %>% ggplot(aes(x=x)) +
  geom_boxplot()

# different plot (histogram) shows that the data is bimodal
df %>% ggplot(aes(x=x)) +
  geom_density()

# should not simply rely on one figure as different plots can show new or different information
# as a DS I need to plot the data in different ways to get a full understanding of what is happening
# to present to a client, I need to only show one plot to not overcomplicate things

# another example
setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/w2")
cars_df <- read_csv("data/VehicleYear-2019.csv")

dim(cars_df)
head(names(cars_df), 20)
glimpse(cars_df)

# plots
cars_df %>%
  ggplot(aes(x = GROSS_VEHICLE_MASS)) +
  geom_histogram()

cars_df %>%
  # remove invalid car weights which are = 0
  filter(GROSS_VEHICLE_MASS > 0,
         POWER_RATING > 0) %>%
  ggplot(aes(x = POWER_RATING,
             y = GROSS_VEHICLE_MASS)) +
  geom_point()

# um a little deaf because there was no sound in the Zoom recording
cars_df %>%
  # remove invalid car weights which are = 0. only select Toyota data
  filter(GROSS_VEHICLE_MASS > 0,
         POWER_RATING > 0,
         MAKE == 'TOYOTA') %>%
  ggplot(aes(x = FIRST_NZ_REGISTRATION_YEAR,
             y = GROSS_VEHICLE_MASS)) +
  # geom_point()
  # show overlapping data
  geom_hex()

cars_df %>%
  # remove invalid car weights which are = 0. only select Mitzubishi data
  filter(GROSS_VEHICLE_MASS > 0,
         POWER_RATING > 0,
         MAKE == 'MITSUBISHI') %>%
  ggplot(aes(x = FIRST_NZ_REGISTRATION_YEAR,
             y = GROSS_VEHICLE_MASS)) +
  # geom_hex()
  # adds random variation between different points to show overlapping data
  geom_jitter()
    
p <- cars_df %>%
  filter(GROSS_VEHICLE_MASS > 0,
         POWER_RATING > 0) %>%
  ggplot(alpha = 0.05) +
  labs(title = "Engine power vs. Car weight",
       x = "Power rating (kw)",
       y = "Vehicle mass (kg)",
       caption = "Data from nzta.govt.nz")

# uhhh can't understand, possibly work through lab 2 to get more understanding


