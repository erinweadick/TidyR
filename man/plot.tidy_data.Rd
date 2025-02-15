% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R-code.R
\name{plot.tidy_data}
\alias{plot.tidy_data}
\title{Plot a 'tidy_data' object}
\usage{
\method{plot}{tidy_data}(x, y = NULL, ...)
}
\arguments{
\item{x}{A 'tidy_data' object to plot.}

\item{y}{Ignored (exists for compatibility with the generic plot method).}

\item{...}{Additional arguments where \code{var_x} and \code{var_y} specify column names.}
}
\value{
A ggplot2 object.
}
\description{
S3 method for plotting objects of class "tidy_data" using ggplot2.
Users must specify the columns for the x and y axes via \code{var_x} and \code{var_y}.
}
\examples{
\dontrun{
plot(tidied_data,var_x = "chlorophyll",var_y = "spad")
}

}
