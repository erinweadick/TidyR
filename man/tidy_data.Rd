% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R-code.R
\name{tidy_data}
\alias{tidy_data}
\title{Tidy data for use in other functions}
\usage{
tidy_data(data, case = "snake")
}
\arguments{
\item{data}{A data frame to be tidied.}

\item{case}{The case to which the data column names will be changed.
Defaults to \code{"snake"}.}
}
\value{
A data frame (class "tidy_data") that omits NA rows and has standardized column names.
}
\description{
This function removes rows with NA values and cleans up column names
so that they all follow a specified naming case (like snake_case or UpperCamelCase).
}
\examples{
df <- data.frame(VarA = c(NA,1,2), VarB = 1:3)
tidy_data(df, case = "snake")
}
