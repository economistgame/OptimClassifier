context("OptimNN")

test_that("Test example with Australian Credit Dataset for NN", {
  expect_equal(class(Optim.NN(Y~., AustralianCredit, p = 0.7, seed=2018)), "Optim")
})
