context("OptimSVM")

test_that("Test SVM with Australian Credit", {
  modelFit <- Optim.SVM(Y~., AustralianCredit, p = 0.7, seed=2018)
  expect_equal(class(modelFit), "Optim")
  })
