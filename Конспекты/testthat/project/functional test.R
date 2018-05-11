library(rstudioapi)
library(testthat)

set_wd <- function() {
  current_path <- getActiveDocumentContext()$path 
  setwd(dirname(current_path))
}
set_wd()

source("code.R")

test_that("Distinct roots", {
  
  roots <- real.roots(1, 7, 12)
  
  expect_is(roots, "numeric")
  expect_length(roots, 2)
  expect_true(roots[1] < roots[2])
})


test_that("Repeated root", {
  
  roots <- real.roots(1, 6000, 9000000)
  
  expect_length(roots, 1)
  expect_equal(roots, -3000)
  
  # Test whether ABSOLUTE error is within 0.1 
  expect_equal(roots, -3000.01, tolerance  = 0.1)
  expect_equal(roots, -3001, tolerance  = 0.1, scale=-3001) 
})

test_that("Polynomial must be quadratic", {
  
  # Test for ANY error                     
  expect_warning(real.roots(0, 2, 3))
  # Test specifically for an error string containing "zero"
  expect_warning(real.roots(0, 2, 3), "zero")
  # Test specifically for an error string containing "zero" or "Zero" using regular expression
  expect_warning( real.roots(0, 2, 3), "[zZ]ero")
})

test_that("Bogus tests", {
  
  x <- c(1, 2, 3)
  
  expect_length(x, 2)
  expect_is(x, "data.frame")
})
  