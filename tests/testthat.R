# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(TidyR)
#### Test tidy_data() ####
test_that("tidy_data() works correctly with a valid data frame", {


  sample_df <- data.frame(
    "SPAD"        = c(10, NA, 15),
    "Chlorophyll" = c(30, 40, NA),
    "Leaf number" = c(1, 2, 3),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)
  expect_equal(nrow(cleaned_df), 1)  # only 1 row should remain
  expect_equal(names(cleaned_df), c("spad", "chlorophyll", "leaf_number"))
})

test_that("tidy_data() throws an error when input is not a data frame", {
  expect_error(tidy_data(123), "Input must be a data frame")
})

#### Test load_data() ####
test_that("load_data() function runs without error", {
  test_df <- data.frame(
    x = 1:3,
    y = c("a", "b", "c"),
    stringsAsFactors = FALSE
  )

  # Suppress any messages printed by load_data()
  expect_silent(suppressMessages(load_data(test_df)))
})

#### Test plot.tidy_data() ####
test_that("plot.tidy_data() returns a ggplot object", {

  sample_df <- data.frame(
    "SPAD"        = c(10, 12, 15),
    "Chlorophyll" = c(30, 40, 45),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)
  p <- plot.tidy_data(cleaned_df, "spad", "chlorophyll")
  expect_true(inherits(p, "ggplot"))
})

test_check("TidyR")
