# TidyR: Streamlined Data Preprocessing and Visualization <img src="man/figures/logo.png" align="right" height="139" />

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/yourusername/TidyR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yourusername/TidyR/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/yourusername/TidyR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/yourusername/TidyR?branch=main)

A lightweight R package for efficient data cleaning, standardization, and exploratory visualization of plant physiology datasets.

## Features

- 🧹 **Automated Data Cleaning**: Remove NA values and standardize column names
- 📈 **Smart Visualization**: Generate publication-ready plots with built-in statistics
- 📦 **Data Packaging**: Simplify dataset storage and retrieval
- ✔️ **Comprehensive Testing**: Robust validation of all data transformations

## Installation

```r
# Install development version from GitHub
if (!require("devtools")) install.packages("devtools")
devtools::install_github("erinweadick//TidyR")

# Install dependencies
install.packages(c("ggplot2", "janitor", "usethis", "testthat"))
```

## Usage
Data Cleaning

```r
library(TidyR)

raw_data <- data.frame(
  SPAD = c(32.1, NA, 28.4),
  Chlorophyll = c(NA, 45.2, 38.7),
  `Leaf number` = 1:3
)

cleaned_data <- tidy_data(raw_data, case = "snake")
# Output: tibble with standardized names and NA rows removed
```
