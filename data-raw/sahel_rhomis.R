# Farm households in Burkina Faso, Mali and Niger, from the RHoMIS survey.
#
# RHoMIS (the Rural Household Multi-Indicator Survey) has surveyed over 54,000
# farm households in 35 countries. Its harmonised data is public under CC0:
#
#   Gorman, L., Hammond, J., Frelat, R., Caulfield, M. and van Wijk, M. et al.
#   The Rural Household Multiple Indicator Survey (RHoMIS) data of 54,873 farm
#   households in 35 countries. Harvard Dataverse. doi:10.7910/DVN/WS38SA
#
# This keeps one project from each of the three countries of the CRFS West
# Africa community of practice, and the survey's own answers as recorded --
# crop names, harvest amounts in whatever unit the farmer gave, land area and
# its unit -- not RHoMIS's processed indicators. That is the point: the three
# projects coded some answers differently, farmers gave harvests in sacks,
# carts, bundles and cups, and some answers are missing. Chapters 3 and 4 of
# the CRFS edition of An Introduction to Working with Data explore and then
# clean it.
#
# Left out: GPS coordinates and RHoMIS's household identifiers. Rows get a new
# identifier, household_id.
#
# full_survey_data.csv is about 300 MB; download it once from the Dataverse
# record above (file id 14020762) into data-raw/ before running this.

library(data.table)

src <- "data-raw/full_survey_data.csv"
if (!file.exists(src)) {
  download.file("https://dataverse.harvard.edu/api/access/datafile/14020762", src, mode = "wb")
}

projects <- c("sil", "ta3", "ta8")   # Burkina Faso 2016, Mali 2017, Niger 2019

keep <- c(
  "country", "year", "region", "sublocation", "start_time_user",
  "respondentsex", "household_type", "education_level",
  "landcultivated", "unitland", "crop_count",
  paste0(rep(c("crop_name_", "crop_harvest_", "crop_yield_", "crop_yield_units_",
               "crop_sold_prop_numeric_"), times = 3), rep(1:3, each = 5)),
  "livestock_count", "foodshortagetime", "food_worst_month"
)

raw <- fread(src, select = c("id_proj", "iso_country_code", keep),
             colClasses = "character", na.strings = NULL, encoding = "UTF-8")
raw <- raw[iso_country_code %in% c("BF", "ML", "NE") & id_proj %in% projects]

# Countries in the order of the CRFS community of practice; households in the
# order the survey files list them.
raw[, iso_country_code := factor(iso_country_code, levels = c("BF", "ML", "NE"))]
setorder(raw, iso_country_code)
raw[, c("id_proj", "iso_country_code") := NULL]

sahel_rhomis <- data.frame(
  household_id = sprintf("H%04d", seq_len(nrow(raw))),
  as.data.frame(raw[, ..keep]),
  check.names = FALSE
)

write.csv(sahel_rhomis, "data-raw/sahel_rhomis.csv", row.names = FALSE, fileEncoding = "UTF-8")
usethis::use_data(sahel_rhomis, overwrite = TRUE)
