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

#' Farm households in Burkina Faso, Mali and Niger (RHoMIS)
#'
#' Survey answers from 1,026 farm households in the three countries of the
#' CRFS (formerly CCRP) West Africa community of practice, from the Rural
#' Household Multi-Indicator Survey (RHoMIS): one project in Burkina Faso
#' (2016), one in Mali (2017) and one in Niger (2019). The answers are as
#' recorded, not cleaned: the three projects coded some answers differently
#' (\code{"no school"} and \code{"no_school"}, \code{"ha"} and
#' \code{"hectare"}), harvests are in whatever unit the farmer gave, some
#' answers are missing, and some accented place names are garbled in the
#' source file itself. Each row is one household; up to three crops per
#' household are in numbered columns.
#'
#' @format A data frame with 1026 rows and 30 columns, all stored as text:
#' \describe{
#'   \item{household_id}{Household identifier, assigned for this dataset}
#'   \item{country}{burkina_faso, mali or niger}
#'   \item{year}{Year of the survey}
#'   \item{region, sublocation}{Where the household is}
#'   \item{start_time_user}{Time the interview started, as recorded}
#'   \item{respondentsex}{Sex of the person answering: m or f}
#'   \item{household_type}{couple, man_single or woman_single}
#'   \item{education_level}{Highest education of the household head}
#'   \item{landcultivated, unitland}{Land cultivated, and its unit}
#'   \item{crop_count}{Number of crops the household grows}
#'   \item{crop_name_1, crop_name_2, crop_name_3}{Crops grown}
#'   \item{crop_harvest_1, crop_harvest_2, crop_harvest_3}{Whether the
#'     harvest was bad, normal or good}
#'   \item{crop_yield_1, crop_yield_2, crop_yield_3}{Amount harvested, in the
#'     unit in the matching \code{crop_yield_units_} column}
#'   \item{crop_yield_units_1, crop_yield_units_2, crop_yield_units_3}{Unit of
#'     the harvest: kg, sacks, carts, bundles, cups...}
#'   \item{crop_sold_prop_numeric_1, crop_sold_prop_numeric_2,
#'     crop_sold_prop_numeric_3}{Proportion of the crop sold}
#'   \item{livestock_count}{Number of kinds of livestock kept}
#'   \item{foodshortagetime}{Whether the household had a time of food
#'     shortage in the last year: y or n}
#'   \item{food_worst_month}{Month of worst food shortage}
#' }
#' @source Gorman, L., Hammond, J., Frelat, R., Caulfield, M., van Wijk, M.
#'   et al. The Rural Household Multiple Indicator Survey (RHoMIS) data of
#'   54,873 farm households in 35 countries. Harvard Dataverse, CC0.
#'   \doi{10.7910/DVN/WS38SA}. See \code{data-raw/sahel_rhomis.R}.
"sahel_rhomis"

#' On-farm trials of Oga on pearl millet in Niger, 2014-2016
#'
#' On-farm trials of Oga, a fertiliser invented by women farmers in Niger's
#' FUMA Gaskiya federation from human urine. In each trial, a woman farmer grew
#' pearl millet on two plots of her own field: one given Oga (with organic
#' manure in 2014 and 2015, on its own in 2016) and one under her usual
#' practice. The weight of the millet heads (panicles) harvested from each plot
#' was recorded. The published data has one sheet per year in different
#' layouts; this dataset puts them together, one row per trial. See
#' \code{data-raw/niger_oga.R} for exactly what was changed.
#'
#' @format A data frame with 810 rows and 11 columns, one row per trial:
#' \describe{
#'   \item{trial_id}{Trial identifier, assigned for this dataset}
#'   \item{year}{Year of the trial: 2014, 2015 or 2016}
#'   \item{region}{Maradi or Tillabery}
#'   \item{site}{Serkin Haussa, Safo (both Maradi) or Say (Tillabery)}
#'   \item{village}{Village of the trial}
#'   \item{social_class}{The woman's social class, as farmers define it:
#'     Young, Elderly with help, or Elderly without help. Elderly means aged
#'     40 or more; help means access to labour or money to hire it}
#'   \item{soil_type}{Local name of the field's soil type: Jigawa, Gueza,
#'     GuezamiGuezami, Jambali, Damba, or Undifferentiated}
#'   \item{weeding}{Weeding: Complete or Partial (not recorded in 2016)}
#'   \item{treatment}{Oga + manure (2014, 2015) or Oga (2016)}
#'   \item{control_yield_kg_ha}{Panicle yield of the control plot, kg per hectare}
#'   \item{oga_yield_kg_ha}{Panicle yield of the Oga plot, kg per hectare}
#' }
#' @source Moussa, O.H., Nwankwo, C.I., Aminou, A.M., Stern, A.D. and
#'   Haussmann, B.I.G. (2020). Zenodo, CC BY 4.0.
#'   \doi{10.5281/zenodo.4071826}. Described in Moussa, H.O. et al. (2021),
#'   Agronomy for Sustainable Development, 41, 56.
#'   \doi{10.1007/s13593-021-00675-2}.
"niger_oga"


#' Rainfall during the Oga trials in Niger, as published
#'
#' The rainfall sheet published with the Oga on-farm trial data
#' (\code{\link{niger_oga}}), exactly as it is, every cell stored as text.
#' It is deliberately left untidy, for practising reshaping: three blocks of
#' month and rainfall (mm) side by side, of different lengths, each headed in
#' the first row by a year and "Rainfall (mm)". The third block is headed 2015,
#' like the second, though it probably holds 2016.
#'
#' @format A data frame with 51 rows and 6 columns, \code{col1} to
#'   \code{col6}, all text.
#' @source Moussa, O.H., Nwankwo, C.I., Aminou, A.M., Stern, A.D. and
#'   Haussmann, B.I.G. (2020). Zenodo, CC BY 4.0.
#'   \doi{10.5281/zenodo.4071826}.
"niger_oga_rainfall"

