---
layout: page
title:  Tutorials
---
<font color="red"><i class="fa fa-exclamation-triangle"></i>
This section is still under construction. Sorry for the inconvenience</font>

<button class="method-button" onClick="location.href='#lm'">LM</button>
<button class="method-button GLM-button" onClick="location.href='#glm'">GLM</button>
<button class="method-button LMM-button" onClick="location.href='#lmm'">LMM</button>
<button class="method-button DA-button" onClick="location.href='#da'">DA</button>
<button class="method-button CART-button" onClick="location.href='#cart'">CART</button>
<button class="method-button NN-button" onClick="location.href='#nn'">NN</button>
<button class="method-button SVM-button" onClick="location.href='#svm'">SVM</button>

<script> function LMResults() {var element = document.getElementById("LMResults"); element.classList.toggle("hidden")};
function LMResults2() {var element = document.getElementById("LMResults2"); element.classList.toggle("hidden")};
function GLMResults() {var element = document.getElementById("GLMResults"); element.classList.toggle("hidden")};
function LMMResults() {var element = document.getElementById("LMMResults"); element.classList.toggle("hidden")};
function DAResults() {var element = document.getElementById("DAResults"); element.classList.toggle("hidden")};
function NNResults() {var element = document.getElementById("NNResults"); element.classList.toggle("hidden")};
function SVMResults() {var element = document.getElementById("SVMResults"); element.classList.toggle("hidden")};</script>


In general, OptimClassifier functions have an intuitive syntax, although some examples are shown below.

## LM
<style>
.hljs-literal {
color: #990073;
}
.hljs-number {
color: #099;
}
.hljs-comment {
color: #998;
font-style: italic;
}
.hljs-keyword {
color: #900;
font-weight: bold;
}
.hljs-string {
color: #d14;
}
 .codeFragment {
    margin-bottom: 0px;
}
     .buttonFragment {
    margin-top: 0px;
}
</style>

First step charging the dataset and package
<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package </span>
<span class="hljs-keyword">library</span>(OptimClassifier)
 
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)

<span class="hljs-comment"># Let's go with the model </span> 
<span class="hljs-literal">linearcreditscoring</span> &lt;- <span class="hljs-keyword">Optim.LM</span>(<span class="hljs-literal">Y~.</span>, <span class="hljs-literal">AustralianCredit</span>, <span class="hljs-literal">p</span> = <span class="hljs-number">0.7</span>, <span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">linearcreditscoring</span>)
</code></pre>
<p class="buttonFragment"><button id="LM-1" style="width:100%;margin-top: 0px;" class="method-button" onClick="LMResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="LMResults" class="hidden">
<pre><code><span class="hljs-comment"># Appears a warning because we don't choose threshold criteria </span> 
<font color="red"><b>Warning: Thresholds' criteria not selected. The success rate is defined as the default.</b></font> 
 <b>3</b> successful models have been tested 
  <br>
      Model      rmse threshold success_rate   ti_error tii_error 
  1      LM 0.3425880       1.6       0.8413     0.0192 0.1394231 
  2 SQRT.LM 0.4480197       1.2       0.8317     0.0144 0.1538462 
  3  LOG.LM 1.1473270       1.0       0.5961     0.4038 0.0000000  
  </code></pre>
 
 <p> Do you want to see the coefficients of best model? <br> Simply, make a summary <i class="fa fa-smile-o" aria-hidden="true"></i></p>
<pre class="r codeFragment" ><code><span class="hljs-keyword">summary</span>(<span class="hljs-literal">linearcreditscoring</span>)</code></pre>
<p class="buttonFragment"><button id="LM-2" style="width:100%;margin-top: 0px;" class="method-button" onClick="LMResults2()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="LMResults2" class="hidden">
<pre><code>
 Call:
 stats::lm(formula = ModelsTested$train_formula[[i]], data = training, 
     model = FALSE, x = FALSE, y = FALSE)
 
 Residuals:
      Min       1Q   Median       3Q      Max 
 -0.90688 -0.09413  0.01314  0.15060  1.07490 
 
 Coefficients:
               Estimate Std. Error t value Pr(&gt;|t|)    
 (Intercept)  8.731e-01  9.800e-02   8.910  &lt; 2e-16 ***
 X11          1.261e-03  3.402e-02   0.037 0.970452    
 X2          -3.950e-04  1.521e-03  -0.260 0.795202    
 X3          -3.336e-03  3.297e-03  -1.012 0.312103    
 X42          4.622e-02  3.543e-02   1.304 0.192741    
 X43          4.618e-01  3.020e-01   1.529 0.126975    
 X52          3.150e-01  1.909e-01   1.651 0.099538 .  
 X53          3.183e-01  1.879e-01   1.694 0.090933 .  
 X54          2.765e-01  1.777e-01   1.556 0.120495    
 X55          3.118e-01  2.448e-01   1.273 0.203562    
 X56          2.742e-01  1.885e-01   1.455 0.146493    
 X57          3.970e-01  1.893e-01   2.098 0.036496 *  
 X58          3.621e-01  1.813e-01   1.998 0.046345 *  
 X59          3.638e-01  1.861e-01   1.955 0.051261 .  
 X510         4.024e-01  2.142e-01   1.879 0.060928 .  
 X511         3.762e-01  1.845e-01   2.039 0.042061 *  
 X512         3.440e-01  3.925e-01   0.876 0.381265    
 X513         4.934e-01  1.851e-01   2.665 0.007971 ** 
 X514         5.414e-01  1.886e-01   2.870 0.004297 ** 
 X62         -1.205e-01  2.641e-01  -0.456 0.648353    
 X63         -1.974e-01  2.726e-01  -0.724 0.469365    
 X64         -1.660e-01  1.749e-01  -0.949 0.343214    
 X65         -1.329e-01  1.839e-01  -0.723 0.470246    
 X67         -2.636e-02  2.293e-01  -0.115 0.908517    
 X68         -1.810e-01  1.765e-01  -1.026 0.305576    
 X69         -3.445e-01  2.545e-01  -1.353 0.176605    
 X7           1.208e-02  5.127e-03   2.356 0.018921 *  
 X81          6.131e-01  3.637e-02  16.859  &lt; 2e-16 ***
 X91          1.004e-01  3.994e-02   2.513 0.012335 *  
 X10          5.034e-03  3.524e-03   1.429 0.153840    
 X111        -4.244e-02  3.013e-02  -1.408 0.159694    
 X122         4.371e-02  5.719e-02   0.764 0.445102    
 X123         6.488e-01  1.666e-01   3.894 0.000113 ***
 X13         -2.302e-04  9.932e-05  -2.317 0.020936 *  
 X14          4.384e-06  3.361e-06   1.304 0.192811    
 ---
 Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
 
 Residual standard error: 0.3136 on 447 degrees of freedom
 Multiple R-squared:  0.6332, Adjusted R-squared:  0.6053 
 F-statistic:  22.7 on 34 and 447 DF,  p-value: &lt; 2.2e-16
 </code></pre>
 And if I want to see the second best model? We simply add a 2 to the summary
</div>
</div>


## GLM
<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">creditscoring</span> &lt;- <span class="hljs-keyword">Optim.GLM</span>(<span class="hljs-literal">Y~.</span>, <span class="hljs-literal">AustralianCredit</span>, <span class="hljs-literal">p</span> = <span class="hljs-number">0.7</span>, <span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">creditscoring</span>)
</code></pre>
<p class="buttonFragment"><button id="GLM" style="width:100%;margin-top: 0px;" class="method-button" onClick="GLMResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="GLMResults" class="hidden">
<pre class="r codeFragment"><code>
<span class="hljs-comment"># Appears a warning because we don't choose threshold criteria </span> 
<font color="red"><b>Warning: Thresholds' criteria not selected. The success rate is defined as the default.</b></font> 
 
<span class="hljs-comment"># Appear warnings generated by fitting low level function</span> 
<font color="red">Warning messages:
1: glm.fit: fitted probabilities numerically 0 or 1 occurred 
2: glm.fit: fitted probabilities numerically 0 or 1 occurred 
3: glm.fit: fitted probabilities numerically 0 or 1 occurred </font>

<span class="hljs-comment"># A table with all the models evaluated</span>
<b>7</b> successful models have been tested and <b>21</b> thresholds evaluated 
 
               Model      rmse Threshold success_rate   ti_error tii_error 
 1      poisson(log) 0.3389622      0.50    0.8365385 0.01442308 0.1490385 
 2     poisson(sqrt) 0.3409605      0.55    0.8365385 0.01442308 0.1490385 
 3          gaussian 0.3425880      0.60    0.8413462 0.01923077 0.1394231 
 4           poisson 0.3430554      0.55    0.8365385 0.01442308 0.1490385 
 5 binomial(cloglog) 0.3519640      0.35    0.8269231 0.01923077 0.1538462 
 6  binomial(probit) 0.3587217      0.45    0.8221154 0.02403846 0.1538462 
 7   binomial(logit) 0.3595036      0.35    0.8173077 0.01923077 0.1634615 
</code>
</pre>


</div>

## LMM
First step charging the dataset and package
<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">modelChooser</span> &lt;- <span class="hljs-keyword">Optim.LMM</span>(<span class="hljs-string">"Y"</span>, <span class="hljs-literal">AustralianCredit</span>, <span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">modelChooser</span>)
</code></pre>
<p class="buttonFragment"><button id="LMM" style="width:100%;margin-top: 0px;" class="method-button" onClick="LMMResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="LMMResults" class="hidden">
// TODO results for Optim.LMM example
</div>

## DA
<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">fit</span> &lt;- <span class="hljs-keyword">Optim.DA</span>(<span class="hljs-string">"Y~."</span>, <span class="hljs-literal">AustralianCredit</span>,<span class="hljs-literal">p</span>=<span class="hljs-number">0.7</span> ,<span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">fit</span>)
</code></pre>
<p class="buttonFragment"><button id="DA" style="width:100%;margin-top: 0px;" class="method-button" onClick="DAResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="DAResults" class="hidden">
// TODO results for Optim.DA example
</div>

## CART

<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">fit</span> &lt;- <span class="hljs-keyword">Optim.CART</span>(<span class="hljs-string">"Y~."</span>, <span class="hljs-literal">AustralianCredit</span>,<span class="hljs-literal">p</span>=<span class="hljs-number">0.7</span> ,<span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">fit</span>)
</code></pre>
<p class="buttonFragment"><button id="CART" style="width:100%;margin-top: 0px;" class="method-button" onClick="CARTResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="CARTResults" class="hidden">
// TODO results for Optim.CART example
</div>

## NN

<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">fit</span> &lt;- <span class="hljs-keyword">Optim.NN</span>(<span class="hljs-string">"Y~."</span>, <span class="hljs-literal">AustralianCredit</span>,<span class="hljs-literal">p</span>=<span class="hljs-number">0.7</span> ,<span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">fit</span>)
</code></pre>
<p class="buttonFragment"><button id="NN" style="width:100%;margin-top: 0px;" class="method-button" onClick="NNResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="NNResults" class="hidden">
// TODO results for Optim.NN example
</div>

## SVM

<pre class="r codeFragment"><code><span class="hljs-comment"># Load the package, if you still do not have it loaded</span>
<span class="hljs-keyword">library</span>(OptimClassifier)
<span class="hljs-comment"># Load the dataset, <i>AustralianCredit</i> in this example </span> 
data(<span class="hljs-string">"AustralianCredit"</span>)
<span class="hljs-comment"># Let's go with the model, if you had seen the LM example, this is very similar </span> 
<span class="hljs-literal">fit</span> &lt;- <span class="hljs-keyword">Optim.SVM</span>(<span class="hljs-string">"Y~."</span>, <span class="hljs-literal">AustralianCredit</span>,<span class="hljs-literal">p</span>=<span class="hljs-number">0.7</span> ,<span class="hljs-literal">seed</span>=<span class="hljs-number">2018</span>)

<span class="hljs-keyword">print</span>(<span class="hljs-literal">fit</span>)
</code></pre>
<p class="buttonFragment"><button id="SVM" style="width:100%;margin-top: 0px;" class="method-button" onClick="SVMResults()">Run <i class="fa fa-angle-double-right"></i>
</button></p>

<div id="SVMResults" class="hidden">
// TODO results for Optim.SVM example
</div>
