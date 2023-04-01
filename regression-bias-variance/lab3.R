# Lab 3


# Task 1: 

set.seed(991) # replace "765" with your student ID.
n <- 200  
x <- rnorm(n)
residual_std <- exp(x) # error standard deviation is exponential w.r.t. x values, 
y <- 1.5+3*x + residual_std*rnorm(n)

x_y_df = data.frame(cbind(x,y))

# plot y and x
plot(x,y, xlab = "x", ylab = "y")

# Task 2:

# Task 2.1
x_y_fit <- lm(y~x, data = x_y_df)
summary(x_y_fit)

## Task 2.2
# What is the standard error of coefficient of X? What is the 95% confidence interval of the β1^? Interprete the p-value shown.
std_err_x <- round(summary(x_y_fit)$coef['x','Std. Error'])
p_value_x <- round(summary(x_y_fit)$coef['x','Pr(>|t|)'])

# confidence intervals
confint(x_y_fit)['x','97.5 %']
confint(x_y_fit)['x','2.5 %']

# Task 3

# Step 3.1: Calculate se(βi^) use sandwich estimator.

# automatically with 'sandwich' library
library(sandwich)
vcovHC(x_y_fit, type = "HC")

# get the sandwich variance estimator manually
y <- matrix(y, ncol = 1)
x <- cbind(1, matrix(x, ncol = 1))

# Look up sandwich formula #######

# Step 3.2: Inference
# Use the sandwich standard error for the cofficient of X to calculate the 95% confidence interval and p-value for β1
sqrt(diag(vcov(x_y_fit)))








)