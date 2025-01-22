#' Example Plant Physiology Dataset (Processed)
#'
#' Cleaned version of raw_data after processing with tidy_data(). Contains
#' standardized snake_case names and NA rows removed.
#'
#' @format ## `data`
#' A tibble with reduced rows (NA removed) and 9 columns:
#' \describe{
#'   \item{tree_id}{Character - Unique plant identifier}
#'   \item{spad}{Numeric - SPAD chlorophyll meter values}
#'   \item{chlorophyll}{Numeric - Chlorophyll content (μg/cm²)}
#'   \item{stomatal_density}{Numeric - Stomatal density (stomata/mm²)}
#'   \item{leaf_thickness}{Numeric - Leaf thickness (mm)}
#'   \item{culture}{Factor - Growth culture type}
#'   \item{temperature}{Numeric - Growing temperature (°C)}
#'   \item{treatment}{Factor - Experimental treatment group}
#'   \item{measurement_date}{Date - Date of measurement}
#' }
#' @source Processed version of raw_data using TidyR::tidy_data()
"data"
