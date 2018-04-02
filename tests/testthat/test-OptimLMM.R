context("Optim LMM")

test_that("Test LMM with Australian Credit", {
  #Train a simply model
  modelFit <- Optim.LMM("Y", AustralianCredit)
  expect_equal(class(modelFit), "Optim")
  #Print
  print(modelFit, plain=TRUE)
  print(modelFit, plain=FALSE)
  })
