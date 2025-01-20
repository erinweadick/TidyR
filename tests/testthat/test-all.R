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

test_that("tidy_data() works correctly with a valid data frame (basic case)", {

  sample_df <- data.frame(
    SPAD        = c(10, NA, 15),
    Chlorophyll = c(30, 40, NA),
    `Leaf number` = c(1, 2, 3),
    stringsAsFactors = FALSE
  )

  cleaned_df <- tidy_data(sample_df)  # default case = "snake"

  # Only one row should remain (rows with any NA are dropped)
  expect_equal(nrow(cleaned_df), 1)

  # Column names should be snake_case
  expect_equal(names(cleaned_df), c("spad", "chlorophyll", "leaf_number"))
})

test_that("tidy_data() throws an error when input is not a data frame", {
  expect_error(tidy_data(123), "Input must be a data frame")
})

test_that("tidy_data() handles data frames with no NAs (no rows dropped)", {
  sample_df <- data.frame(
    SPAD        = c(10, 12, 15),
    Chlorophyll = c(30, 40, 45),
    stringsAsFactors = FALSE
  )

  # No NA values => no rows dropped
  cleaned_df <- tidy_data(sample_df)
  expect_equal(nrow(cleaned_df), 3)
  # Check that column names were converted
  expect_equal(names(cleaned_df), c("spad", "chlorophyll"))
})

test_that("tidy_data() respects different case arguments", {
  sample_df <- data.frame(
    SPAD        = c(10, 12),
    Chlorophyll = c(30, 45),
    stringsAsFactors = FALSE
  )

  # Try upper_camel
  cleaned_camel <- tidy_data(sample_df, case = "upper_camel")
  expect_equal(names(cleaned_camel), c("Spad", "Chlorophyll"))

  # Try lower_camel
  cleaned_lower_camel <- tidy_data(sample_df, case = "lower_camel")
  expect_equal(names(cleaned_lower_camel), c("spad", "chlorophyll"))
})

#### Test load_data() ####

test_that("load_data() runs without error", {
  test_df <- data.frame(
    x = 1:3,
    y = c("a", "b", "c"),
    stringsAsFactors = FALSE
  )

  # load_data() calls usethis::use_data() internally,
  # so you need usethis installed or in your DESCRIPTION.
  # We suppress messages because use_data() can print info.
  expect_silent({
    suppressMessages(load_data(test_df))
  })
})

#### Test plot.tidy_data() ####

test_that("plot.tidy_data() returns a ggplot object for valid inputs", {
  sample_df <- data.frame(
    SPAD        = c(10, 12, 15),
    Chlorophyll = c(30, 40, 45),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)

  p <- plot.tidy_data(cleaned_df, "spad", "chlorophyll")

  # The returned plot should be a ggplot object
  expect_true(inherits(p, "ggplot"))
})

test_that("plot.tidy_data() throws error if x or y is missing", {
  sample_df <- data.frame(
    SPAD        = c(10, 12),
    Chlorophyll = c(30, 40),
    stringsAsFactors = FALSE
  )
  cleaned_df <- tidy_data(sample_df)

  # Missing 'x'
  expect_error(plot.tidy_data(cleaned_df, y = "chlorophyll"),
               "You must specify both x and y")

  # Missing 'y'
  expect_error(plot.tidy_data(cleaned_df, x = "spad"),
               "You must specify both x and y")
})

# Finally, run all tests in this package.
test_check("TidyR")

