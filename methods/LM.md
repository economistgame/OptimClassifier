---
layout: page
title: Linear Models
---
## Description

**Linear Models** fits with coefficients $$ \beta = (\beta_1, ..., \beta_p) $$  to minimize the residual sum of squares between the observed responses in the dataset, and the responses predicted by the linear approximation, sorting by splitting the responses by a threshold.
<img alt="Regression Image" src="data:image/png;base64,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" \>

**Optim.LM** is used to fit the best classification linear model to a dataset. For this purpose, we examine the variation of the precision using the root mean square error (RMSE) when transformations are applied on the response variable. In addition, several thresholds are applied to check which is the most optimal cut for the indicators derived from the confusion matrix (success rate, type I error and type II error) according to a given criterion.

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


<div class="popup" onclick="FunctionName()"><b>Optim.LM</b>(
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
<button class="usage-button SVM-button" onclick="FunctionFormula()">seed</button>,
<span class="popuptext" id="DataPopUp">Data frame from which variables specified in formula are preferentially to be taken.</span></div>
<div class="popup" >
<button class="usage-button CART-button" onclick="FunctionFormula()">...</button>)
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
