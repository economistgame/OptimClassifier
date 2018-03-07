context("Optim LM")

test_that("Test LM with Australian Credit", {
  modelFit <- Optim.LM(Y~., AustralianCredit, p = 0.7, seed=2018)
  expect_equal(class(modelFit), "Optim")
})
