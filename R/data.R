#' Flamingo measurements from Kenya's Rift Valley
#'
#' Morphological measurements recorded from Greater and Lesser
#' Flamingos at three lakes in Kenya's Rift Valley between 2021
#' and 2023.
#'
#' @format A data frame with 344 rows and 8 columns:
#' \describe{
#'   \item{lake}{Lake at which the bird was recorded: Bogoria,
#'     Elementaita, or Nakuru}
#'   \item{species}{Greater Flamingo or Lesser Flamingo}
#'   \item{bill_length_mm}{Bill length, in millimetres}
#'   \item{bill_depth_mm}{Bill depth, in millimetres}
#'   \item{leg_length_mm}{Leg length, in millimetres}
#'   \item{body_mass_g}{Body mass, in grams}
#'   \item{sex}{Recorded sex of the bird}
#'   \item{year}{Year of measurement}
#' }
#' @source Collected as part of the IDEMS statistics textbook project.
"kenya_flamingos"


#' Kenya road accident database, April-June 2016
#'
#' Fatal road accident records from Kenya, covering April, May
#' (incomplete), and June 2016. Each row is one incident.
#'
#' @format A data frame with 378 rows and 12 columns:
#' \describe{
#'   \item{TIME 24 HOURS}{Time of incident on a 24-hour clock}
#'   \item{BASE/SUB BASE}{Police base or sub-base responsible}
#'   \item{COUNTY}{County in which the incident occurred}
#'   \item{ROAD}{Road on which the incident occurred}
#'   \item{PLACE}{Specific location of the incident}
#'   \item{BRIEF ACCIDENT DETAILS}{Free-text description of the incident}
#'   \item{GENDER}{Gender of victim(s)}
#'   \item{AGE}{Age of victim(s)}
#'   \item{CAUSE CODE}{Numeric cause code}
#'   \item{VICTIM}{Victim category}
#'   \item{NO.}{Number of victims}
#'   \item{Date DD/MM/YYYY}{Date of incident}
#'   \item{...13}{Extra Column for illustration purposes}
#' }
#' @source Humanitarian Data Exchange.
#'   \url{https://data.humdata.org/dataset/kenya-road-accidents-database}
"kenya_accidents_2016"


#' Kenya road accident database, 2017
#'
#' Fatal road accident records from Kenya, covering 2017.
#' Each row is one incident.
#'
#' @format A data frame with 740 rows and 15 columns:
#' \describe{
#'   \item{TIME 24 HOURS}{Time of incident on a 24-hour clock}
#'   \item{BASE/SUB BASE}{Police base or sub-base responsible}
#'   \item{COUNTY}{County in which the incident occurred}
#'   \item{ROAD}{Road on which the incident occurred}
#'   \item{PLACE}{Specific location of the incident}
#'   \item{MV INVOLVED}{Information on the motor vehicle involved in the incident}
#'   \item{BRIEF ACCIDENT DETAILS}{Free-text description of the incident}
#'   \item{NAME OF VICTIM}{Free-text description of victim name}
#'   \item{GENDER}{Gender of victim(s)}
#'   \item{AGE}{Age of victim(s)}
#'   \item{CAUSE CODE}{Numeric cause code}
#'   \item{VICTIM}{Victim category}
#'   \item{NO.}{Number of victims}
#'   \item{Date DD/MM/YYYY}{Date of incident}
#'   \item{...15}{Extra Column for illustration purposes}
#' }
#' @source Humanitarian Data Exchange.
#'   \url{https://data.humdata.org/dataset/kenya-road-accidents-database}
"kenya_accidents_2017"
