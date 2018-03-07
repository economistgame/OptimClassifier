context("OptimCART")

test_that("Test CART with Australian Credit", {
  expect_equal(class(Optim.CART(Y~., AustralianCredit, p = 0.7, seed=2018)), "Optim")
})
