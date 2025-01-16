library(readr)
library(dplyr)
library(janitor)
library(roxygen2)
library(ggplot2)

data <- read_csv("R/Advanced r programming dataset.csv")
data<- as.data.frame(data)

utils::globalVariables(c("x", "y", "SPAD", "chlorophyll", "stomatal", "leaf thickness","Leaf number","Tree ID", "Pot ID", "Culture", "Temperature"))

## Function 1 : Making column names the same and removing any NA values

#' Tidy data for use in other functions
#'
#' @param data
#' @param case The case to which the data column names will be changed to. The case options are \code{"snake"}
#' (the default), \code{"upper_camel"}, \code{"lower_camel"}, or \code{"title"}
#'
#' @return An object of class \code{"tidy_data"} which is tidied by omitting NA values and changing column names to be of the same case.
#' @export
#' @author Erin Weadick - <\email{erin.weadick.2022@@mumail.ie}>
#' @author Kate Mullins - <\email{kate.mullins.2022@@mumail.ie}>
#' @author Daniel McKean - <\email{daniel.mckean.2022@@mumail.ie}>
#' @author Laurynas Jonikas - <\email{laurynas.jonikas.2022@@mumail.ie}>
#'
#' @examples
#' tidy_data <- function(data) {
#' if (!is.data.frame(data)){
#' stop("Input must be a data frame")
#' }
#'
#' tidied_data <- data %>%
#' na.omit(data) %>%
#' clean_names(case = case)
#' }
#'
#' new_data <- tidy_data(data, case = "upper_camel")
tidy_data <- function(data, case = "snake") {

  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }

  tidied_data <- data %>%
    na.omit(data) %>%
    clean_names(case = case)

  return(tidied_data)
}

cleaned_Data <-tidy_data(data, "snake")


## Function 2: Making this dataset available as part of this R package

#' Load in and save plant data for use with the package.
#'
#' A function to save the data from the package as an R object to be used
#' with the other functions inside the package. It is saved using the
#' 'usethis :: use_data' function
#'
#' @param data
#'
#' @return An object of class \code{"data"} which is a list of \code{\link[tibble]{tibble}}s which
#' contains plant stress responses for species in ambient and warm temperature conditions.
#'
#' @details
#' The function saves the data with 'compress = "xz"' to reduce the file size
#' and 'overwrite = TRUE' to allow it to overwrite any existing data in the
#' environment with the same name.
#'
#' @export
#' @author Erin Weadick - <\email{erin.weadick.2022@@mumail.ie}>
#' @author Kate Mullins - <\email{kate.mullins.2022@@mumail.ie}>
#' @author Daniel McKean - <\email{daniel.mckean.2022@@mumail.ie}>
#' @author Laurynas Jonikas - <\email{laurynas.jonikas.2022@@mumail.ie}>
#'
#' @importFrom usethis use_data
#'
#' @examples
#' \dontrun{
#' clean_data <- data.frame(x = 1:10, y = rnorm(10))
#' load_Data(clean_Data)
#' }
#'
load_data <- function(data){
  usethis::use_data(data, compress="xz",overwrite = TRUE)
}

load_data(cleaned_Data)

##Function 3: Plotting inputted x vs. y
#' Plot one variable against another in the tidied dataset
#'
#' This function takes a tidied dataset, plus the desired x and y columns,
#' and produces a scatter plot with a linear regression line.
#'
#' @param object A data frame (preferably tidied via \code{\link{tidy_data}}).
#' @param x A character string indicating the x-column name.
#' @param y A character string indicating the y-column name.
#' @param ... Other arguments passed to the underlying \code{ggplot2} functions.
#'
#' @return A \code{ggplot} object.
#'
#' @export
#' @author Erin Weadick - <\email{erin.weadick.2022@@mumail.ie}>
#' @author Kate Mullins - <\email{kate.mullins.2022@@mumail.ie}>
#' @author Daniel McKean - <\email{daniel.mckean.2022@@mumail.ie}>
#' @author Laurynas Jonikas - <\email{laurynas.jonikas.2022@@mumail.ie}>
#'
#' @importFrom ggplot2 "ggplot"
#'
#' @examples
#'
#' plot.tidy_data(cleaned_Data, "spad", "chlorophyll", )
plot.tidy_data <- function(object, x, y, ...) {
  if (missing(x) || missing(y)) {
    stop("You must specify both x and y for the plot.")
  }

  ggplot(object, aes(x = .data[[x]], y = .data[[y]])) +
    geom_point(color = "steelblue", size = 3, alpha = 0.8) +
    geom_smooth(method = "lm", color = "darkred", se = FALSE, linetype = "dashed", linewidth = 1) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", color = "darkblue", size = 16),
      panel.grid.major = element_line(color = "lightgray", linetype = "dotted"),
      panel.grid.minor = element_blank()
    )
}

plot.tidy_data(cleaned_Data, "spad", "chlorophyll")

devtools::check()

