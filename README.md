# OptimClassifier <img src="man/figures/logo.png" align="right" />


[![Linux/Mac Build Status](https://travis-ci.org/economistgame/OptimClassifier.svg?branch=master)](https://travis-ci.org/economistgame/OptimClassifier)
[![Windows Build Status](https://ci.appveyor.com/api/projects/status/f3h44m7jwr8ms9tf?svg=true)](https://ci.appveyor.com/project/economistgame/optimclassifier)
[![Coverage](https://codecov.io/gh/economistgame/OptimClassifier/branch/master/graph/badge.svg)](https://codecov.io/gh/economistgame/OptimClassifier)

OptimClassifier provides a set of tools for creating models, selecting the best parameters combination for a model, and select the best threshold for your binary classification. The package contains tools for:

- Linear Model (LM) 
- Generalized Linear Model (GLM) 
- Linear Mixed Model (LMM) 
- Classification And Regression Tree (CART)
- Discriminant Analysis (DA)
- Neural Networks (NN)
- Support Vector Machines (SVM)

as well as others that will be implemented in the future.

## Installation

### Install this package from CRAN (stable version):

```r
install.packages("OptimClassifier")
```
### Install this package from Github (development version):

For this, you can choose different packages such as:

##### With [devtools](https://github.com/hadley/devtools)

```r
library(devtools)
install_github("economistgame/OptimClassifier")
```
##### With [remotes](https://github.com/r-lib/remotes)

```r
library(remotes)
install_github("economistgame/OptimClassifier")
```
### A simple example

This is a basic example which shows you how to solve a common credit scoring problem with this package:

``` r
## Load a Dataset
data(AustralianCredit)

## Create the model
creditscoring <- Optim.GLM(Y~., AustralianCredit, p = 0.7, seed=2018)

#See a ranking of the models tested
print(creditscoring)

#Access to summary of the best model
summary(creditscoring)

#Do not sure of like the best model??, you can access to the all model, for example the 2nd model
summary(creditscoring,2)
 

```
### Bugs and feature requests

If you find problems with the package, or there's anything that it doesn't do which you think it should, please submit them to <https://github.com/economistgame/OptimClassifier/issues>. In particular, let me know about optimizers and formats which you'd like supported, or if you have a workflow which might make sense for inclusion as a default convenience function.
