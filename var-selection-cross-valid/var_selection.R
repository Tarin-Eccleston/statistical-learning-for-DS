setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/var-selection-cross-valid")

# load data from package
library(leaps)
library(tidyverse)
library(Matrix)
data(agaricus.train, package="xgboost")
table(agaricus.train$label)

# get info about data frame
dim(agaricus.train$data)
sample(colnames(agaricus.train$data),20)

# seperate into x and y
X = as.matrix(agaricus.train$data)
y = agaricus.train$label

# explore different variable selection methods and how long they take
system.time(
  backwards_selection_search = regsubsets(X, y, nvmax = 30, method="back")
)

system.time(
  forwards_selection_search = regsubsets(X, y, nvmax = 30, method="forward")
)

