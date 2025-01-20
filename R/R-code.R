# R-code.R

# 1) Read and pre-clean the CSV without using the pipe at top-level
#    (So we avoid the "could not find function `%>%`" error at load time.)

#raw_data <- readr::read_csv(
#  file = system.file("extdata", "Advanced_r_programming_dataset.csv", package = "TidyR"), show_col_types = FALSE
#)


utils::globalVariables(c(
  "x", "y", "SPAD", "chlorophyll", "stomatal", "leaf thickness",
  "Leaf number", "Tree ID", "Pot ID", "Culture", "Temperature"
))
# In an R session:
#raw_data <- readr::read_csv("inst/extdata/Advanced_r_programming_dataset.csv",show_col_types = FALSE)
#raw_data <- stats::na.omit(raw_data)
#raw_data <- janitor::clean_names(raw_data, case="snake")
# Now store it as an .rda in your 'data/' folder:
#usethis::use_data(raw_data, overwrite=TRUE)


# ------------------------------------------------------------------------------
#' Tidy data for use in other functions
#'
#' This function removes rows with NA values and cleans up column names
#' so that they all follow a specified naming case (like snake_case or UpperCamelCase).
#'
#' @param data A data frame to be tidied.
#' @param case The case to which the data column names will be changed.
#'   Defaults to \code{"snake"}.
#' @return A data frame (class "tidy_data") that omits NA rows and has standardized column names.
#' @export
#'
#' @examples
#' df <- data.frame(VarA = c(NA,1,2), VarB = 1:3)
#' tidy_data(df, case = "snake")
tidy_data <- function(data, case = "snake") {

  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }

  # Use the pipe inside a function (which is fine once magrittr is imported).
  tidied_data <- data %>%
    na.omit() %>%
    clean_names(case = case)

  class(tidied_data) <- c("tidy_data", class(tidied_data))
  tidied_data
}


# ------------------------------------------------------------------------------
#' Load and save plant data for use with the package
#'
#' Saves the supplied data frame as an internal `.rda` file, so that it can be
#' used in the package. It uses [usethis::use_data()] to compress and overwrite
#' any existing data with the same name.
#'
#' @param data A data frame to be saved with \code{usethis::use_data}.
#' @return Invisibly returns \code{TRUE} on success (from use_data).
#' @export
#'
#' @details
#' Use this only if you want to bundle or update data as part of the development
#' workflow. Typically not called by end users unless they want to overwrite the
#' existing dataset.
#'
#' @examples
#' \dontrun{
#' my_df <- data.frame(x = 1:10, y = rnorm(10))
#' load_data(my_df)
#' }
load_data <- function(data){
  usethis::use_data(data, compress = "xz", overwrite = TRUE)
}


# ------------------------------------------------------------------------------
#' Plot one variable against another in the tidied dataset
#'
#' This function takes a **tidy_data** object plus the desired x and y columns,
#' and produces a scatter plot with a linear regression line.
#'
#' @param object A data frame of class \code{tidy_data}.
#' @param x A string naming the x-column.
#' @param y A string naming the y-column.
#' @param ... Additional arguments passed to ggplot2 functions (currently not used).
#'
#' @return A \code{ggplot} object showing a scatter plot and a linear regression line.
#' @export
#'
#' @examples
#' \dontrun{
#' # Suppose 'raw_data' has columns "spad" and "chlorophyll":
#' # (If 'raw_data' is recognized by your package.)
#' plot.tidy_data(tidy_data(raw_data), "spad", "chlorophyll")
#' }
plot.tidy_data <- function(object, x, y, ...) {

  if (missing(x) || missing(y)) {
    stop("You must specify both x and y for the plot.")
  }

  ggplot(object, aes_string(x = x, y = y)) +
    geom_point(color = "steelblue", size = 3, alpha = 0.8) +
    geom_smooth(method = "lm", color = "darkred", se = FALSE,
                linetype = "dashed", linewidth = 1) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title       = element_text(hjust = 0.5, face = "bold",
                                      color = "darkblue", size = 16),
      panel.grid.major = element_line(color = "lightgray",
                                      linetype = "dotted"),
      panel.grid.minor = element_blank()
    )
}

# End of R-code.R
