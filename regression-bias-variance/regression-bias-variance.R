# Week 3 Notes

# Assumptions for Linear Regression Models
# __________________________________
# 1) Independence Assumption: We assume Yi are independant of eachother. Is determined by experimental design
# 2) The true relationship between X and Y is linear: (g(mew) = X*beta) X can sufficiently capture the trend in the data. If there is a pattern, X fails to capture pattern.
#     - Look at residual plot to identify systematic constant band. If there is a trend, must be an issue
# 3) Distribution assumption of Y: 
# 4) Extreme values and outcomes on estimates:
#     - Avoid deleting data as data collection is expensive. Unless there is ALOT of data
#     - Solution: Show model with and without data
#     - There are many other ways to deal with outlier data. More on that later
# LOOK AT ENGSCI NOTES
# Possibly also refer to the regression paper
# Need a recap on t and p values
# Look at CLT lol

# Log vs Interaction for prediction and inference -> Allow for EOV assumption
# Log: Used for inference as we can see the general trend. Hard to back transform to get prediction
# Interaction: Used for prediction. Not inference.

# As a data scientist
# __________________________________
# Think about characteristics of data and find the most sensible model to solve the problem

# How do we make a good prediction?
# __________________________________
# Data
#   Quantity: Usually not a problem nowadays for more data mature sources
#   Quality: Experimental design. Missing values.
#   Type: Time series, continuous, discrete

# Model
#   Purpose: Define problem precisely. i.e Something that was can measure and not vague
#   Fit: How do we fit the model? Hyperparameters i.e for NN, define hidden layers, epochs and the impact on the model
#   Limitations: When can the model go wrong?

# Evaluation Scheme
#   Metrics for Prediction: How do we define how accurate our model is? I.e mean square error

# ____________________________________________________________________________________________________________________

# Black-Box or not
# __________________________________
# Where Yhat = fhat(X)
# For pure predictions, using black-box is acceptable
# For pure inference, you cannot use black-box
# Most applications have a combination of the two objectives, seeking a good balance between prediction vs interpretability

# Types of errors
# __________________________________
# Apparent error: is the RSS of the training data (for the fit)
# Mean-square prediction error: error observed for the future unseen data
# Choose the model which would give th lowest prediction error
# NOTE: Add more notes from lecture slides

# Bias-Variance Tradeoff
# __________________________________
# Good model needs to strike a balance between under and ovewrfitting
# Flexible model (polynomial): low bias, high variance, resulting in overfit
# Rigid model (flat line): high bias, low variance, resulting in underfit
# NOTE: Look at bias and notes on this topic

# ____________________________________________________________________________________________________________________

# Criteria for a good model
# __________________________________
# Low Prediction Error
# Predictors are simple to obtain
# Face Validity: Coefficients and estimates make sense. Shouldn't contradict to what people expect
# Casual stability: Think about underlying casual relations to predict outcomes from factors. Does it make sense?
# Hard to game: Get the right attribute and outcomes measured. Are the predictors easy to manipulate?
# Creepy / Evil: Is my model ethical?

# Correlation is not Causation
# __________________________________
# High p value, results in correlation. Need to really think about it before confirming causation


setwd("/Users/tarineccleston/Documents/Masters/STATS 765/statistical-learning-for-DS/regression-bias-variance")

aq_data = data.frame(airquality)

# we want to model effect of solar radiation on temperature
# we want to take temperature and wind into consideration
# plot ozone as explained by solar radiation, given each combination of temp and wind
coplot(Ozone ~ Solar.R|Temp + Wind, data = aq_data, n = 4)

# Interaction Terms:
# as shown from the coplot, the relationship between the solar radiation and ozone
# depends on the temperature and wind
# the figure is a clear indication that we have an interaction term

# EOV Assumption:
# scatter appears to increase (variance) as ozone increase, use poisson distribution
# to model behavior

# use log scale
# seems to have very little interaction between solar and temp and solar and wind
coplot(log(Ozone) ~ Solar.R|Temp + Wind, data = aq_data, n = 4)

# now, consider interaction between solar radiation and temperature, and solar
# radiation and wind on the original scale
aq_fit = lm(Ozone ~ Solar.R * (Temp + Wind), data = aq_data)
summary(aq_fit)

# p-values for interaction terms seem statistically significant interaction terms
# adjusted R-square is 0.64. This model explains 65% of the variability

# now compare interaction terms when using log scale.
aq_fit = lm(log(Ozone) ~ Solar.R * (Temp + Wind), data = aq_data)
summary(aq_fit)

# high p-values for the interaction term confirm that they are not significant at 
# explaining our data
