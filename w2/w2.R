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
p1 + geom_point()

# use different colour to show different months
airquality %>%
  ggplot(aes(x = Solar.R, y = Ozone, color=factor(Month))) +
  geom_point()

# 
