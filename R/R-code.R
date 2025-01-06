library(readr)
library(dplyr)
library(janitor)
library(roxygen2)
library(ggplot2)

data <- read_csv("R/Advanced r programming dataset.csv")

data<- as.data.frame(data)


utils::globalVariables(c("x", "y", "SPAD", "chlorophyll", "stomatal", "leaf thickness","Leaf number","Tree ID", "Pot ID", "Culture", "Temperature"))

## Function 1 : Making column names the same and removing any NA values

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
tidy_data <- function(data) {

  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }

  tidied_data <- data %>%
    na.omit(data) %>%
    clean_names(case = "snake") ## changes all column names to snake_case (lowercase and spaces replaced with)

  return(tidied_data)
}


cleaned_Data <-tidy_data(data)


## Function 2: Making this dataset available as part of this R package

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
load_data <- function(data){

  usethis::use_data(data, compress="xz",overwrite = TRUE)

}

load_data(cleaned_Data)

##Function 3: Plotting inputted x vs. y

plot.tidy_data <- function(object, x, y, ...) {
  if (missing(x) || missing(y)) {
    stop("You must specify both x and y for the plot.")
  }

  ggplot(object, aes(x = .data[[x]], y = .data[[y]])) +
    geom_point(color = "steelblue", size = 3, alpha = 0.8) +
    geom_smooth(method = "lm", color = "darkred", se = FALSE, linetype = "dashed", size = 1) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", color = "darkblue", size = 16),
      axis.title.x = element_text(face = "italic", color = "darkgreen"),
      axis.title.y = element_text(face = "italic", color = "darkgreen"),
      panel.grid.major = element_line(color = "lightgray", linetype = "dotted"),
      panel.grid.minor = element_blank()
    )
}

plot.tidy_data(cleaned_Data, "spad", "chlorophyll")

