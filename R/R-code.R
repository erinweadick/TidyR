library(readr)
library(dplyr)
library(janitor)
data <- read_csv("R/Advanced r programming dataset.csv")

data<- as.data.frame(data)


utils::globalVariables(c("x", "y", "SPAD", "chlorophyll", "stomatal", "leaf thickness","Leaf number","Tree ID", "Pot ID", "Culture", "Temperature"))

## Function 1 : Making column names the same and removing any NA values

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

load_data <- function(data){

  usethis::use_data(data, compress="xz",overwrite = TRUE)

}

load_data(cleaned_Data)

