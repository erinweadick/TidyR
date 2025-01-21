# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(TidyR)
library(ggplot2)

#### Test tidy_data() ####

test_that("tidy_data() works correctly with a valid data frame (basic case)", {
  sample_df <- data.frame(
    SPAD        = c(10, NA, 15),
    Chlorophyll = c(30, 40, NA),
    `Leaf number` = c(1, 2, 3),
    stringsAsFactors = FALSE
  )

  cleaned_df <- tidy_data(sample_df)

  expect_equal(nrow(cleaned_df), 1)
  expect_equal(names(cleaned_df), c("spad", "chlorophyll", "leaf_number"))
})

test_that("tidy_data() throws error for non-dataframe input", {
  expect_error(tidy_data(123), "Input must be a data frame")
})

test_that("tidy_data() handles data with no NAs", {
  sample_df <- data.frame(
    SPAD = c(10, 12, 15),
    Chlorophyll = c(30, 40, 45),
    stringsAsFactors = FALSE
  )

  cleaned_df <- tidy_data(sample_df)
  expect_equal(nrow(cleaned_df), 3)
  expect_equal(names(cleaned_df), c("spad", "chlorophyll"))
})

test_that("tidy_data() respects case arguments", {
  sample_df <- data.frame(
    SPAD = c(10, 12),
    Chlorophyll = c(30, 45),
    stringsAsFactors = FALSE
  )

  # Test different naming cases
  expect_equal(names(tidy_data(sample_df, "upper_camel")), c("Spad", "Chlorophyll"))
  expect_equal(names(tidy_data(sample_df, "lower_camel")), c("spad", "chlorophyll"))
})

#### Test load_data() ####
test_that("load_data() runs without errors", {
  test_df <- data.frame(x = 1:3, y = letters[1:3])
  mock_use_data <- function(...) return(invisible(TRUE))

  with_mocked_bindings(
    load_data(test_df),
    "use_data" = mock_use_data,
    .package = "usethis"
  )
  expect_true(TRUE)
})


#### Test plot.tidy_data() ####

test_that("plot.tidy_data() returns ggplot object", {
  sample_df <- data.frame(
    SPAD = c(10, 12, 15),
    Chlorophyll = c(30, 40, 45),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)

  # Use generic plot() with named arguments
  p <- plot(cleaned_df, var_x = "spad", var_y = "chlorophyll")
  expect_s3_class(p, "ggplot")
})

test_that("plot.tidy_data() validates required arguments", {
  sample_df <- data.frame(
    SPAD = c(10, 12),
    Chlorophyll = c(30, 40),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)

  # Test missing arguments
  expect_error(plot(cleaned_df), "Both 'var_x' and 'var_y' must be specified")
  expect_error(plot(cleaned_df, var_x = "spad"), "Both 'var_x' and 'var_y' must be specified")
  expect_error(plot(cleaned_df, var_y = "chlorophyll"), "Both 'var_x' and 'var_y' must be specified")
})

