setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/var-selection-cross-valid")

library(tidyverse)

set.seed(765)

# for each value of X (1:3), I'm going to run this function which...
lapply(1:3, function(x){round(runif(x),2)})
# exactly the same as
for(i in 3){print(runif(i),2)}

# basically the same thing but using the the piping operator and map
# "." is whatever you passed into the function
1:3 %>% map(~round(runif(.),2))

# alternatively, we could create a function and then map our values to that
# basically the same as above
shuffle = function(n){sample(1:n, n)}
map(3:8, shuffle)

# another example using air quality data
data("airquality")
# using dbl as it makes more sense to make it a vector rather than a list
airquality %>% map_dbl(mean)
airquality %>% map_dbl(function(x){mean(x, na.rm = TRUE)})
# not really that readable
airquality %>% map_dbl(~mean(., na.rm = TRUE))

# cars data
cars_df = read_csv("data/VehicleYear-2019.csv")

# ooo filter is actually quite good and powerful
good_car = cars_df %>%
  filter(VEHICLE_TYPE == "PASSENGER CAR/VAN") %>%

  filter(BODY_TYPE %in% c("CONVERTIBLE","HATCHBACK","SALOON","SPORTS CAR","STATION WAGON")) %>%
    
  filter(NUMBER_OF_AXLES == 2 & NUMBER_OF_SEATS > 1 & NUMBER_OF_SEATS < 8) %>%

  filter(MOTIVE_POWER == "PETROL")

# good way to summarise categorical variables
good_car %>% 
    group_by(BASIC_COLOUR) %>%
    summarise(mean(GROSS_VEHICLE_MASS))

# basically does the same thing
good_car %>%
  # split into smaller dataframes based on input var
  split(.$BASIC_COLOUR) %>%
  # map allows up to specify any function
  map_dbl(~mean(.$GROSS_VEHICLE_MASS))

# basically does the same thing
good_car %>%
  # split into smaller dataframes based on input var
  split(.$BASIC_COLOUR) %>%
  # map allows up to specify any function
  map_dbl(function(df) mean(df$GROSS_VEHICLE_MASS))

  
models = good_car %>%
  # split into smaller dataframes based on input var
  split(.$BASIC_COLOUR) %>%
  # return model, not a vector
  map(~lm(GROSS_VEHICLE_MASS ~ POWER_RATING + BODY_TYPE, data = .))


# use map to read multiple files
