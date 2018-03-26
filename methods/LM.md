---
layout: page
title: Linear Model
---
## Description

**Linear Models** fits with coefficients $$ \beta = (\beta_1, ..., \beta_p)   $$  to minimize the residual sum of squares between the observed responses in the dataset, and the responses predicted by the linear approximation.

**Optim.LM** is used to fit the best classification linear model to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when transformations are applied on the response variable. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, type I error and type II error) according to a given criterion.

## Usage

<div class="row">
	<div class="col-md-4">
		<b>Optim.LM</b>(
	</div>
	<div class="col-md-4">
		<b style="color:blue">formula</b>,
	</div>
	<div class="col-md-4">
      		p)
	</div>
</div>	
