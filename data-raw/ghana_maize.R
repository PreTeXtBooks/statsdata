## Code to prepare `ghana_maize`: weekly visits to maize fields in northern Ghana, 2021
##
## Real data: the ground measurements published by Gomez-Dans et al. (2022),
## "Location, biophysical and agronomic parameters for croplands in Northern
## Ghana", Zenodo, CC BY 4.0, doi:10.5281/zenodo.6632083 (file
## Ghana_ground_data_v5.csv). Field teams visited 56 maize fields in five
## districts of the Northern Region roughly once a week from September to
## November 2021, taking four leaf area index (LAI) readings and five leaf
## chlorophyll (SPAD) readings at each visit, and noting the crop's growth
## stage and anything unusual.
##
## Kept as published: one row per field visit, the growth stage exactly as the
## teams wrote it (several spellings of the same stage), districts as written,
## missing readings left missing, and the teams' comments, which often say why
## a reading is missing. The only changes:
##   - the four LAI readings are averaged into `lai`, over those taken;
##   - the five chlorophyll readings are averaged into `chlorophyll`; a visit
##     with one implausible reading keeps it, so the mean shows it;
##   - dates are parsed (day/month/year), and `month` is added for grouping;
##   - columns are renamed (field_code -> field_id, phenology -> growth_stage).

url <- "https://zenodo.org/records/6632083/files/Ghana_ground_data_v5.csv?download=1"
raw <- utils::read.csv(url, stringsAsFactors = FALSE, na.strings = c("", "NA"))

lai_cols <- c("lai1", "lai2", "lai3", "lai4")
chl_cols <- c("chloro1", "chloro2", "chlorlo3", "chloro4", "chloro5")

lai <- rowMeans(raw[lai_cols], na.rm = TRUE)
lai[is.nan(lai)] <- NA
chlorophyll <- rowMeans(raw[chl_cols])

date <- as.Date(raw$date, format = "%d/%m/%Y")

ghana_maize <- data.frame(
  field_id = raw$field_code,
  district = raw$district,
  date = date,
  month = factor(month.name[as.integer(format(date, "%m"))],levels = c("September", "October", "November")),
  growth_stage = raw$phenology,
  lai = round(lai, 2),
  chlorophyll = round(chlorophyll, 1),
  comments = trimws(gsub("\\s+", " ", raw$comments))
)
ghana_maize <- ghana_maize[order(ghana_maize$date, ghana_maize$field_id), ]
rownames(ghana_maize) <- NULL
ghana_maize <- tibble::as_tibble(ghana_maize)

write.csv(ghana_maize, "data-raw/ghana_maize.csv", row.names = FALSE)
usethis::use_data(ghana_maize, overwrite = TRUE)
