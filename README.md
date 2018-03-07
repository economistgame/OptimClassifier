# OptimClassifier <img src="man/figures/logo.png" align="right" />

OptimClassifier provides a set of tools for creating models, selecting the best parameters combination for a model, and select the best threshold for your binary classification. The package contains tools for:

- Linear Model (LM) 
- Generalized Linear Model (GLM) 
- Linear Mixed Model (LMM) 
- Classification And Regression Tree (CART)
- Discriminant Analysis (DA)
- Neural Networks (NN)
- Support Vector Machines (SVM)

as well as others that will be implemented in the future.

## Example

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
# OptimClassifier
