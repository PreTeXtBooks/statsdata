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
#' @format A data frame with 1026 rows and 30 columns:
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
#'   \doi{10.7910/DVN/WS38SA}.
#' @seealso \code{\link{sahel_households}} and \code{\link{sahel_crops}},
#'   the same data split into one table per level.
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
#' @format A tibble with 810 rows and 11 columns, one row per trial:
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


#' Farm households in Burkina Faso, Mali and Niger: the household level
#'
#' The household-level columns of \code{\link{sahel_rhomis}}, one row per
#' household: everything except the numbered crop columns. Together with
#' \code{\link{sahel_crops}}, it splits \code{sahel_rhomis} into one table per
#' level, linked by \code{household_id}. The values are as in
#' \code{sahel_rhomis}, not cleaned.
#'
#' @format A tibble with 1026 rows and 15 columns:
#' \describe{
#'   \item{household_id}{Household identifier; links to \code{sahel_crops}}
#'   \item{country}{burkina_faso, mali or niger}
#'   \item{year}{Year of the survey}
#'   \item{region, sublocation}{Where the household is}
#'   \item{start_time_user}{Time the interview started, as recorded}
#'   \item{respondentsex}{Sex of the person answering: m or f}
#'   \item{household_type}{couple, man_single or woman_single}
#'   \item{education_level}{Highest education of the household head}
#'   \item{landcultivated, unitland}{Land cultivated, and its unit}
#'   \item{crop_count}{Number of crops the household grows}
#'   \item{livestock_count}{Number of kinds of livestock kept}
#'   \item{foodshortagetime}{Whether the household had a time of food
#'     shortage in the last year: y or n}
#'   \item{food_worst_month}{Month of worst food shortage}
#' }
#' @source As \code{\link{sahel_rhomis}}. See
#'   \code{data-raw/sahel_levels.R}.
"sahel_households"

#' Farm households in Burkina Faso, Mali and Niger: the crop level
#'
#' The crop columns of \code{\link{sahel_rhomis}}, one row per crop that a
#' household named. \code{sahel_rhomis} keeps up to three crops per household
#' in numbered columns; here they are stacked, so a household has one row for
#' each crop it named, and none if it named none. Linked to
#' \code{\link{sahel_households}} by \code{household_id}. The values are as
#' in \code{sahel_rhomis}, not cleaned.
#'
#' @format A tibble with 2390 rows and 7 columns:
#' \describe{
#'   \item{household_id}{Household identifier; links to
#'     \code{sahel_households}}
#'   \item{crop_number}{1, 2 or 3: the order in which the household named the
#'     crop}
#'   \item{crop_name}{The crop}
#'   \item{crop_harvest}{Whether the harvest was bad, normal or good}
#'   \item{crop_yield}{Amount harvested, in the unit in
#'     \code{crop_yield_units}}
#'   \item{crop_yield_units}{Unit of the harvest: kg, sacks, carts, bundles,
#'     cups...}
#'   \item{crop_sold_prop_numeric}{Proportion of the crop sold}
#' }
#' @source As \code{\link{sahel_rhomis}}. See
#'   \code{data-raw/sahel_levels.R}.
"sahel_crops"

#' Pearl millet plants in the Sahel (simulated)
#'
#' Simulated measurements of 344 pearl millet plants of three varieties,
#' grown at three sites in the CRFS (formerly CCRP) West Africa community of
#' practice between 2021 and 2023: Maradi (Niger), Segou (Mali) and Yatenga
#' (Burkina Faso). Simulated to work like \code{palmerpenguins::penguins}, as
#' \code{kenya_flamingos} does for Kenya: the varieties are grown unevenly
#' across sites, panicle length and girth are negatively related overall but
#' positively within each variety, fertiliser is missing for some plants, and
#' two plants have no measurements. Head-miner damage lowers grain weight.
#' The variety names are real; the numbers are not measurements of them.
#'
#' @format A tibble with 344 rows and 9 columns:
#' \describe{
#'   \item{variety}{HKP (local early millet, Niger), ICMV IS 89305 (improved,
#'     ICRISAT) or Souna 3 (improved, Senegal)}
#'   \item{site}{Maradi, Segou or Yatenga}
#'   \item{panicle_length_cm}{Length of the plant's main head (panicle), in cm}
#'   \item{panicle_girth_mm}{Diameter of the main head at its widest, in mm}
#'   \item{plant_height_cm}{Plant height at harvest, in cm}
#'   \item{grain_weight_g}{Weight of grain threshed from the main head, in g}
#'   \item{head_miner_damage_pct}{Share of the head's grain lost to the millet
#'     head miner, in percent}
#'   \item{fertiliser}{microdose (a small dose of fertiliser placed in the
#'     planting hole) or none}
#'   \item{year}{Year the plant was grown}
#' }
#' @source Simulated for teaching purposes; see \code{data-raw/sahel_millet.R}.
"sahel_millet"

#' Millet fields, manure and Striga in the Sahel (simulated)
#'
#' Simulated records of 100 farmers' millet fields: how much manure each field
#' was given, its millet yield, how much Striga (witchweed, a parasitic weed)
#' grew in it, and whether the farmer belongs to a farmer research network
#' (FRN), as in the CRFS (formerly CCRP) West Africa community of practice.
#' Manure raises yield and also suppresses Striga, so the two overlap as
#' explanations of yield: a partial correlation shows Striga's link to yield
#' survives controlling for manure while manure's does not. The column names
#' have spaces and capitals, for practising \code{janitor::clean_names()}.
#'
#' @format A data frame with 100 rows and 5 columns:
#' \describe{
#'   \item{Farmer ID}{Farmer identifier}
#'   \item{Manure Applied (t/ha)}{Manure applied to the field, in tonnes per hectare}
#'   \item{Millet Yield (kg/ha)}{Millet grain yield, in kilograms per hectare}
#'   \item{Striga Count (plants per m2)}{Striga plants per square metre at flowering}
#'   \item{FRN Member}{Whether the farmer belongs to a farmer research network: Yes or No}
#' }
#' @source Simulated for teaching purposes; see \code{data-raw/sahel_striga.R}.
"sahel_striga"

#' Annual rainfall at three Sahel sites (simulated)
#'
#' Simulated annual rainfall at Maradi (Niger), Segou (Mali) and Yatenga
#' (Burkina Faso), 1950-2023, for line graphs and smoothing. Its shape follows
#' the known history of Sahel rainfall -- wet 1950s-60s, drought through the
#' 1970s-80s, partial recovery since -- but the yearly values are not station
#' records.
#'
#' @format A tibble with 222 rows and 4 columns:
#' \describe{
#'   \item{site}{Maradi, Segou or Yatenga}
#'   \item{year}{Year}
#'   \item{rainfall_mm}{Total rainfall in the year, in mm}
#'   \item{rainy_days}{Number of days with rain}
#' }
#' @source Simulated for teaching purposes; see \code{data-raw/sahel_rainfall.R}.
"sahel_rainfall"

#' Annual rainfall over Burkina Faso, Mali and Niger, 1991-2020
#'
#' Annual rainfall on a 0.1-degree grid (about 11 km) over Burkina Faso, Mali
#' and Niger, from CHIRPS v2.0, which blends satellite estimates with station
#' records. Each row is one grid cell inside one of the three countries. The
#' 1991-2020 summaries are the standard 30-year climate normal; 2011 and 2012
#' are a dry year (before the 2012 Sahel food crisis) and a wet one. Made from
#' the 0.05-degree annual totals by averaging four cells into one; see
#' \code{data-raw/sahel_rainfall_grid.R}.
#'
#' @format A data frame with 22,997 rows and 8 columns:
#' \describe{
#'   \item{lon, lat}{Centre of the grid cell, in degrees}
#'   \item{country}{burkina_faso, mali or niger}
#'   \item{rain_mean_mm}{Mean annual rainfall, 1991-2020, in mm}
#'   \item{rain_sd_mm}{Standard deviation of annual rainfall, 1991-2020, in mm}
#'   \item{rain_2011_mm}{Rainfall in 2011, in mm}
#'   \item{rain_2012_mm}{Rainfall in 2012, in mm}
#'   \item{rain_cv_pct}{Coefficient of variation of annual rainfall,
#'     1991-2020: the standard deviation as a percentage of the mean}
#' }
#' @source Climate Hazards Center, UC Santa Barbara: CHIRPS v2.0, public
#'   domain. \url{https://www.chc.ucsb.edu/data/chirps}. Funk, C. et al.
#'   (2015). The climate hazards infrared precipitation with stations - a new
#'   environmental record for monitoring extremes. Scientific Data, 2, 150066.
#'   \doi{10.1038/sdata.2015.66}. Country borders from Natural Earth (public
#'   domain).
"sahel_rainfall_grid"


#' Weekly visits to maize fields in northern Ghana, 2021
#'
#' Ground measurements from 56 farmers' maize fields in five districts of
#' Ghana's Northern Region, each visited roughly once a week from September to
#' November 2021, collected alongside satellite images of the same fields. One
#' row per field visit. At each visit the field team took four leaf area index
#' readings and five leaf chlorophyll readings, here averaged into \code{lai}
#' and \code{chlorophyll}. Everything else is as the teams recorded it: the
#' growth stage is written in several ways, districts are as written, missing
#' readings are left missing, and the comments often say why.
#'
#' @format A data frame with 500 rows and 8 columns:
#' \describe{
#'   \item{field_id}{Code for the field visited}
#'   \item{district}{District the field is in, as written}
#'   \item{date}{Date of the visit}
#'   \item{month}{Month of the visit: September, October or November}
#'   \item{growth_stage}{Growth stage of the crop, as written}
#'   \item{lai}{Leaf area index, mean of the readings taken}
#'   \item{chlorophyll}{Leaf chlorophyll reading, mean of five readings}
#'   \item{comments}{Anything the field team noted}
#' }
#' @source Gomez-Dans, J.L., Lewis, P., Yin, F., Asare, K., Lamptey, P.,
#'   Aidoo, K., MacCarthy, D., Ma, H., Wu, Q., Addi, M., Aboagye-Ntow, S.,
#'   Doe, C.E., Alhassan, R., Kankam-Boadu, I., Huang, J. and Li, X. (2022).
#'   Location, biophysical and agronomic parameters for croplands in Northern
#'   Ghana. Zenodo, CC BY 4.0. \doi{10.5281/zenodo.6632083}.
"ghana_maize"


#' News and social media in Ghana: Afrobarometer 2022 and 2024
#'
#' A few columns of interest from the Afrobarometer surveys of Ghana in 2022
#' (Round 9, 2,369 adults) and 2024 (Round 10, 2,400 adults), one row per
#' person interviewed. The two rounds number their questions differently, so
#' the columns are matched up by hand, and the few answers the rounds word
#' differently are given one wording. Answers such as "Refused" and
#' "Don't know" are kept as answers.
#'
#' @format A data frame with 4,769 rows and 17 columns:
#' \describe{
#'   \item{id}{Year and respondent number}
#'   \item{year}{2022 or 2024}
#'   \item{region, urban_rural}{Where the person was interviewed}
#'   \item{age, gender, education}{The person interviewed}
#'   \item{news_radio, news_tv, news_newspaper, news_social_media, news_internet_other}{How often they get news from each source}
#'   \item{trust_social_media}{How much they trust news from social media}
#'   \item{internet_use}{How often they use the internet}
#'   \item{interviewer_age, interviewer_gender}{The interviewer}
#'   \item{weight}{Survey weight (withinwt_hh), for national estimates}
#' }
#' @source Afrobarometer Data, Ghana, Rounds 9 and 10, 2022 and 2024,
#'   available at \url{http://www.afrobarometer.org}. Redistributed with
#'   Afrobarometer's permission.
"ghana_news"


#' Afrobarometer Ghana 2024: the people interviewed
#'
#' One row per person interviewed in the 2024 Afrobarometer survey of Ghana
#' (Round 10). Links to \code{\link{ghana_afro_areas}} by \code{area_id} and to
#' \code{\link{ghana_afro_interviewers}} by \code{interviewer_id}. Together the
#' three tables split the survey into its levels.
#'
#' @format A data frame with 2,400 rows and 15 columns: \code{respondent_id},
#'   \code{area_id}, \code{interviewer_id}, \code{date} of interview, \code{age},
#'   \code{gender}, \code{education}, how often they get news from radio, TV,
#'   newspapers, social media and other internet sources (\code{news_*}),
#'   \code{trust_social_media}, \code{internet_use}, and the survey
#'   \code{weight} (withinwt_hh).
#' @source Afrobarometer Data, Ghana, Round 10, 2024, available at
#'   \url{http://www.afrobarometer.org}. Redistributed with Afrobarometer's
#'   permission.
"ghana_afro_people"


#' Afrobarometer Ghana 2024: the areas visited
#'
#' One row per area (enumeration area) visited in the 2024 Afrobarometer
#' survey of Ghana, with what the field team observed there. The released data
#' has no area identifier: \code{area_id} is reconstructed by grouping people
#' who share a district, urban/rural status, area weight and every area-level
#' observation. That gives 300 areas: 298 with eight people interviewed, one
#' with nine and one with seven.
#'
#' @format A data frame with 300 rows and 19 columns: \code{area_id},
#'   \code{region}, \code{district}, \code{urban_rural}; services in the area
#'   (\code{electricity_grid}, \code{piped_water}, \code{sewage},
#'   \code{mobile_service}, \code{borehole}); facilities (\code{post_office},
#'   \code{school}, \code{police_station}, \code{health_clinic},
#'   \code{market_stalls}, \code{bank}, \code{paid_transport}); the
#'   \code{road_surface} at the starting point and \code{road_condition} over
#'   the last 5 km; and the area weight \code{weight_area} (withinwt_ea).
#' @source Afrobarometer Data, Ghana, Round 10, 2024, available at
#'   \url{http://www.afrobarometer.org}. Redistributed with Afrobarometer's
#'   permission.
"ghana_afro_areas"


#' Afrobarometer Ghana 2024: the interviewers
#'
#' One row per interviewer in the 2024 Afrobarometer survey of Ghana: 71
#' interviewers, who carried out between 2 and 54 interviews each.
#'
#' @format A data frame with 71 rows and 5 columns: \code{interviewer_id},
#'   \code{age}, \code{gender}, \code{education}, \code{home_language}.
#' @source Afrobarometer Data, Ghana, Round 10, 2024, available at
#'   \url{http://www.afrobarometer.org}. Redistributed with Afrobarometer's
#'   permission.
"ghana_afro_interviewers"
#' Millet head miner larvae in a field trial in Burkina Faso
#'
#' Counts of millet head miner (\emph{Heliocheilus albipunctella}) larvae on
#' millet spikes in a field trial at Djibasso and Dori, Burkina Faso, in the
#' 2021 rainy season. The trial crossed three cropping systems (main plots)
#' with three pest treatments (sub-plots) in three blocks at each site. Each row
#' is one spike from a 1 m^2 quadrat in a sub-plot. In the Dori data, the
#' insecticide plots of the farmers' practice system are all recorded in block 1.
#'
#' @format A data frame with 859 rows and 5 columns:
#' \describe{
#'   \item{site}{djibasso or dori}
#'   \item{block}{Block, 1 to 3}
#'   \item{cropping}{Cropping system: millet (millet alone),
#'     two_millet_one_cowpea (two rows of millet to one of cowpea) or
#'     farmer_practice (one cowpea hill between four millet hills)}
#'   \item{treatment}{Pest treatment: control (none), neem (an aqueous neem
#'     seed extract, sprayed three times) or insecticide (lambda-cyhalothrin
#'     and acetamiprid, sprayed twice)}
#'   \item{larvae}{Number of head miner larvae found on the spike}
#' }
#' @source Supplementary data of Boly, A., Waongo, A., Kabore, A., Drabo, E.,
#'   Traore, F. and Sanon, A. (2025). Combined effect of millet-cowpea
#'   intercropping and biopesticide application against \emph{Heliocheilus
#'   albipunctella} De Joannis (Lepidoptera: Noctuidae) in Burkina Faso.
#'   PeerJ, 13, e20221. \doi{10.7717/peerj.20221}. CC BY 4.0.
"burkina_headminer"
