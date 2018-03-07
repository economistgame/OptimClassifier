context("OptimDA")

test_that("Test DA methods with Australian Credit", {
  modelFit <- Optim.DA(Y~., AustralianCredit, p = 0.7, seed=2018)
  expect_equal(class(modelFit), "Optim")
})
