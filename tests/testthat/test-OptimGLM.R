context("Optim.GLM")

test_that("Test GLM with Australian Credit", {
  expect_equal(class(Optim.GLM(Y~., AustralianCredit, p = 0.7, seed=2018)), "Optim")
})
