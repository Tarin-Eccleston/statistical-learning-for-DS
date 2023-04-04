library(leaps)

data(agaricus.train, package = "xgboost")
table(agaricus.train$label)
dim(agaricus.train$data)
sample(colnames(agaricus.train$data),20)

# iterating through ps values
allyhat = function(xtrain, ytrain, xtest, ps) {
  yhat = matrix(nrow=nrow(xtest),ncol=length(ps))
  search = regsubsets(xtrain, ytrain, nvmax=max(ps), method="back")
  summ = summary(search)
  for (i in seq_along(ps)) {
    p = ps[i]
    beta_hat = coef(search, p)
    xinmodel = cbind(1,xtext)[,summ$which[p,]] #predictors in the model
    yhat[,i] = xinmodel %*% beta_hat
  }
  yhat
}

# predictors are in a special sparse matrix data structure
X = as.matrix(agaricus.train)
y = agaricus.train$label

possible_ps = 1:40
set.seed(765)

folds = sample(rep(1:10,length=nrow(X)))
fitted = matrix(nrow=nrow(X), ncol=length(possible_ps))

for (k in 1:10) {
  train = (1:nrow(X))[folds!=k]
  test = (1:nrow(X))[folds==k]
  fitted[test,] = allyhat(X[train,], y[train], X[test,], possible_ps)
}

rbind(possible_ps, colMeans((y-fitted)^2))
plot(possible_ps, colMeans((y-fitted)^2))


