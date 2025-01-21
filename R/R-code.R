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


## ------------------------------------------------------------------------------
#' Plot a 'tidy_data' object
#'
#' S3 method for plotting objects of class "tidy_data" using ggplot2.
#' Users must specify the columns for the x and y axes via `var_x` and `var_y`.
#'
#' @param x A 'tidy_data' object to plot.
#' @param y Ignored (exists for compatibility with the generic plot method).
#' @param ... Additional arguments where `var_x` and `var_y` specify column names.
#' @return A ggplot2 object.
#' @export
#' @importFrom rlang .data
plot.tidy_data <- function(x, y = NULL, ...) {
  dots <- list(...)
  var_x <- dots$var_x
  var_y <- dots$var_y

  if (is.null(var_x) || is.null(var_y)) {
    stop("Both 'var_x' and 'var_y' must be specified via ...")
  }

  ggplot2::ggplot(x, ggplot2::aes(x = .data[[var_x]], y = .data[[var_y]])) +
    ggplot2::geom_point(color = "steelblue", size = 3, alpha = 0.8) +
    ggplot2::geom_smooth(
      method = "lm", color = "darkred", se = FALSE,
      linetype = "dashed", linewidth = 1
    ) +
    ggplot2::theme_minimal(base_size = 14) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        hjust = 0.5, face = "bold",
        color = "darkblue", size = 16
      ),
      panel.grid.major = ggplot2::element_line(
        color = "lightgray",
        linetype = "dotted"
      ),
      panel.grid.minor = ggplot2::element_blank()
    )
}
