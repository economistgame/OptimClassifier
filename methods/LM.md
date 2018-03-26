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
<style>
/* Popup container - can be anything you want */
.popup {
    position: relative;
    display: inline-block;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* The actual popup */
.popup .popuptext {
    visibility: hidden;
    width: 160px;
    background-color: #555;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 8px 0;
    position: absolute;
    z-index: 1;
    bottom: 125%;
    left: 50%;
    margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
    visibility: visible;
    -webkit-animation: fadeIn 1s;
    animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
    from {opacity: 0;} 
    to {opacity: 1;}
}

@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity:1 ;}
}
</style>


<div class="popup" onclick="FunctionName()"><b>Optim.LM</b>(
  <span class="popuptext" id="NamePopUp">The function name</span>
</div>
<div class="popup" onclick="FunctionFormula()">formula
  <span class="popuptext" id="FormulaPopUp">The function name</span>
</div>
<script>
// When the user clicks on div, open the popup
function FunctionName() {
    var popup = document.getElementById("NamePopUp");
    popup.classList.toggle("show");
}
	
function FunctionFormula() {
    var popup = document.getElementById("FormulaPopUp");
    popup.classList.toggle("show");
}
</script>
