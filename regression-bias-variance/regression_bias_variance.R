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
# adjusted R-square is slightly better at 66%

# exploring more plots show that we don't need the interaction term if we log
# transform the data

# The next question is... whuch one should I use? Log or original?
# think about what I want to do with the data
  # inference -> use the log model, stablises variance, makes inference a bit easier.
  # prediction -> we can't make sense of log transformed data, but we need to consider 
  # other factors.

# under conditions when we don't know our model, we can use the sanwich estimator
# to get the covariance matrix of our beta_hats
library(sandwich)
# sandwich estimator (HC = Heteroskedasticity-consistent estimation)
fit = lm(Ozone ~ Wind, data = aq_data)
sqrt(diag(vcovHC(fit)))
# standard lm estimate
sqrt(diag(vcov(fit)))

# in comparison, the bootstrap and sandwich estimators have similar beta coefficients
# whereas the lm coefs are quite different
