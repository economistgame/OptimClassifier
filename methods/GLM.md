---
layout: page
title: Generalized Linear Models
---
<p class="index-method"><button class="index-button LM-button">This method</button> 
<button class="index-button GLM-button">Our proposal</button>
	<button class="index-button LMM-button">Examples</button></p>
	
## Description

<div class="row">
<div class="col-md-7">

<b>Linear Models</b> fits with coefficients $$ \beta = (\beta_1, ..., \beta_p) $$ to minimize the residual sum of squares between the observed responses in the dataset, and the responses predicted by the linear approximation.

<!--sorting by splitting the responses by a threshold.-->
</div>

<div class="col-md-5">
<img alt="Example of Linear Regression" src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Linear_regression.svg">
	<p class="img-caption">A graphic linear regression example.<br><b>Source:</b> Wikipedia </p>
</div>
</div>

**Optim.LM** is used to fit the best classification linear model to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when transformations are applied on the response variable. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, type I error and type II error) according to a given criterion.-->

## Usage

<style>
.usage-button {
    border: none;
    text-align: center;
    font-weight: bold;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    color: black;
}
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

/* The actual popup */
.popup .popuptext2 {
    visibility: hidden;
    width: 160px;
    background-color: #555;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 8px 0;
    position: absolute;
    z-index: 1;
    top: 125%;
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
.popup .popuptext2::after {
    content: " ";
    position: absolute;
    bottom: 100%;  /* At the top of the tooltip */
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: transparent transparent black transparent;
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


.tooltip-inner {
    background-color: #00cc00;
}
.tooltip.bs-tooltip-right .arrow:before {
    border-right-color: #00cc00 !important;
}
.tooltip.bs-tooltip-left .arrow:before {
    border-right-color: #00cc00 !important;
}
.tooltip.bs-tooltip-bottom .arrow:before {
    border-right-color: #00cc00 !important;
}
.tooltip.bs-tooltip-top .arrow:before {
    border-right-color: #00cc00 !important;
}
</style>


<div class="popup" onclick="FunctionName()"><b>Optim.GLM</b>(
  <span class="popuptext" id="NamePopUp">The function name</span>
</div>
<div class="popup" >
<button class="usage-button LM-button" onclick="FunctionFormula()">formula</button>,
	<div class="popuptext2" id="FormulaPopUp">A formula of the form: <br> Y ~ X1 + X2 + ...</div></div>

<div class="popup" >
<button class="usage-button GLM-button" onclick="FunctionData()">data</button>,
	<span class="popuptext" id="DataPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>

<div class="popup" >
<button class="usage-button LMM-button" onclick="FunctionP()">p</button>,
<div class="popuptext2" id="pPopUp">A percentage of training elements <br> Must be for example <b>0.3</b> or <b>30</b></div></div>

<div class="popup" >
<button class="usage-button DA-button" onclick="ThresholdFormula()">threshold</button>,
<span class="popuptext" id="ThresholdPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>
<div class="popup" >
<button class="usage-button NN-button" onclick="criteriaFormula()">criteria</button>,
<span class="popuptext2" id="criteriaPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>
<div class="popup" >
<button class="usage-button SVM-button" onclick="seedreproducible()">seed</button>,
<span class="popuptext" id="DataPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>
<div class="popup" >
<button class="usage-button CART-button" onclick="moreArguments()">...</button>)
<span class="popuptext2" id="DataPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>
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
function FunctionData() {
    var popup = document.getElementById("DataPopUp");
    popup.classList.toggle("show");
}
function FunctionP() {
    var popup = document.getElementById("pPopUp");
    popup.classList.toggle("show");
}
function ThresholdFormula() {
    var popup = document.getElementById("ThresholdPopUp");
    popup.classList.toggle("show");
}
</script>
