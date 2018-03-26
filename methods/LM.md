---
layout: page
title: Linear Models
---
## Description

**Linear Models** fits with coefficients $$ \beta = (\beta_1, ..., \beta_p)   $$  to minimize the residual sum of squares between the observed responses in the dataset, and the responses predicted by the linear approximation.

**Optim.LM** is used to fit the best classification linear model to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when transformations are applied on the response variable. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, type I error and type II error) according to a given criterion.

## Usage

<div class="row">
	<div class="col">Optim.LM(</div> <div class="col">formula, </div> <div class="col">data, </div><div class="col">p, </div> <div class="col">threshold = NULL, </div> <div class="col">criteria =</div> <div class="col"> "success_rate" <br> "error_ti" <br> "error_tii")</div> <div class="col">,</div> <div class="col">seed = NULL, ...) </div>
</div>	
