#' Example Plant Physiology Dataset (Raw)
#'
#' A raw dataset containing plant physiology measurements with original column
#' names and missing values. Contains 27 observations of 9 variables.
#'
#' @format ## `raw_data`
#' A data frame with 27 rows and 9 columns:
#' \describe{
#'   \item{TreeID}{Character - Unique plant identifier}
#'   \item{SPAD}{Numeric - SPAD chlorophyll meter values}
#'   \item{Chlorophyll}{Numeric - Chlorophyll content (μg/cm²)}
#'   \item{StomatalDensity}{Numeric - Stomatal density (stomata/mm²)}
#'   \item{LeafThickness}{Numeric - Leaf thickness (mm)}
#'   \item{Culture}{Factor - Growth culture type}
#'   \item{Temperature}{Numeric - Growing temperature (°C)}
#'   \item{Treatment}{Factor - Experimental treatment group}
#'   \item{MeasurementDate}{Date - Date of measurement}
#' }
#' @source Experimental data collected from plant physiology lab measurements
"raw_data"
