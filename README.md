# TidyR: Data Tidying and Visualization Toolkit

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

A lightweight R package for efficient data cleaning, standardization, and exploratory visualization of plant physiology datasets.

## Features

- 🧹 **Automated Data Cleaning**: Remove NA values and standardize column names
- 📈 **Smart Visualization**: Generate publication-ready plots with built-in statistics
- 📦 **Data Packaging**: Simplify dataset storage and retrieval
- ✔️ **Comprehensive Testing**: Robust validation of all data transformations

## Install from Github 

```r
# Install development version from GitHub
if (!require("devtools")) install.packages("devtools")
devtools::install_github("erinweadick/TidyR")
```
## Install from source package
Download the package: TidyR_0.1.0.tar.gz
```r
install.packages(path_to_file, repos = NULL, type="source")
```
Where `path_to_file` would represent the full path and file name:
  On Windows: 
  ```r
install.packages(
"C:\\path\\to\\TidyR_0.1.0.tar.gz",repos = NULL, type = "source")
 ```
  On Linux/MacOS:
 ```r
install.packages("/path/to/TidyR_0.1.0.tar.gz",repos = NULL,type = "source")
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
Data Visualization

```r
plot(cleaned_data,var_x = "chlorophyll",var_y = "spad")
#Output:scatter plot with regression line
```
Example visualization

![Rplot](https://github.com/user-attachments/assets/8e95b1de-15b8-4581-9aca-e67416481777)


Data loading into package
```r
load_data(cleaned_data)
#load data into the package
#Note: only works for package development(not regular projects)
```
## Documentation
Full documentation available via:
```r
?tidy_data
?plot.tidy_data
?load_data
```
For extended tutorials, see the package vignette:
```r
vignette("TidyR")
```
## Contributing

We welcome contributions! Please follow our contribution guidelines:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes with tests
4. Push to the branch
5. Open a Pull Request

## License

Distributed under the GNU General Public License v3.0.

## Contact

Maintainer: Kate Mullins - mullinsk38@gmail.com

Project Link: https://github.com/erinweadick/TidyR
