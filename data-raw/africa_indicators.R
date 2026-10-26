## Code to prepare `africa_indicators`.
##
## Development indicators for the 54 African countries, 2010-2023, from the
## World Bank's World Development Indicators (licensed CC BY 4.0). One row per
## country per year.
##
## The data comes from the World Bank API, so running this again later may give
## slightly different values as the World Bank revises its estimates. The
## download is kept in africa_indicators.csv so the dataset can be rebuilt
## without a connection: set refresh <- TRUE to download it again.
##
## The missing values are left exactly as the World Bank publishes them. That
## is the point of the dataset: the gaps are not random. Survey-based
## indicators (poverty, births attended by skilled staff) only exist in survey
## years, recent years have not been reported yet, and the countries with the
## most gaps tend to be the poorest or those in conflict.

refresh <- FALSE
csv_path <- "data-raw/africa_indicators.csv"

countries <- c(
  "DZA", "AGO", "BEN", "BWA", "BFA", "BDI", "CPV", "CMR", "CAF", "TCD",
  "COM", "COD", "COG", "CIV", "DJI", "EGY", "GNQ", "ERI", "SWZ", "ETH",
  "GAB", "GMB", "GHA", "GIN", "GNB", "KEN", "LSO", "LBR", "LBY", "MDG",
  "MWI", "MLI", "MRT", "MUS", "MAR", "MOZ", "NAM", "NER", "NGA", "RWA",
  "STP", "SEN", "SYC", "SLE", "SOM", "ZAF", "SSD", "SDN", "TZA", "TGO",
  "TUN", "UGA", "ZMB", "ZWE"
)

indicators <- c(
  population        = "SP.POP.TOTL",
  gdp_per_capita    = "NY.GDP.PCAP.CD",
  life_expectancy   = "SP.DYN.LE00.IN",
  under5_mortality  = "SH.DYN.MORT",
  hiv_prevalence    = "SH.DYN.AIDS.ZS",
  births_skilled    = "SH.STA.BRTC.ZS",
  primary_enrolment = "SE.PRM.ENRR",
  poverty_rate      = "SI.POV.DDAY"
)

get_wb <- function(path) {
  url <- paste0("https://api.worldbank.org/v2/", path,
                "&format=json&per_page=20000")
  jsonlite::fromJSON(url)[[2]]
}

if (refresh || !file.exists(csv_path)) {
  codes <- paste(countries, collapse = ";")

  meta <- get_wb(paste0("country/", codes, "?"))
  meta <- data.frame(
    iso3         = meta$id,
    country      = meta$name,
    region       = ifelse(meta$region$id == "SSF", "Sub-Saharan Africa",
                          "North Africa"),
    income_group = meta$incomeLevel$value
  )

  values <- lapply(names(indicators), function(name) {
    x <- get_wb(paste0("country/", codes, "/indicator/", indicators[[name]],
                       "?date=2010:2023"))
    data.frame(iso3 = x$countryiso3code, year = as.integer(x$date),
               indicator = name, value = x$value)
  })
  values <- do.call(rbind, values)
  values <- tidyr::pivot_wider(values, names_from = indicator,
                               values_from = value)

  raw <- merge(meta, values, by = "iso3")
  raw <- raw[order(raw$country, raw$year), ]
  write.csv(raw, csv_path, row.names = FALSE)
}

africa_indicators <- read.csv(csv_path, stringsAsFactors = FALSE)
africa_indicators <- tibble::as_tibble(africa_indicators)
africa_indicators$income_group <- factor(
  africa_indicators$income_group,
  levels = c("Low income", "Lower middle income", "Upper middle income",
             "High income")
)

# The United Nations geoscheme sub-region, which splits Sub-Saharan Africa into
# West, Central, East and South. Added after the World Bank data were
# downloaded, so it is the one column that is not theirs.
subregions <- c(
  North = "DZA EGY LBY MAR SDN TUN",
  West = "BEN BFA CPV CIV GMB GHA GIN GNB LBR MLI MRT NER NGA SEN SLE TGO",
  Central = "AGO CMR CAF TCD COG COD GNQ GAB STP",
  East = "BDI COM DJI ERI ETH KEN MDG MWI MUS MOZ RWA SYC SOM SSD TZA UGA ZMB ZWE",
  South = "BWA SWZ LSO NAM ZAF"
)
subregion_of <- unlist(lapply(names(subregions), function(r) {
  codes <- strsplit(subregions[[r]], " ")[[1]]
  setNames(rep(r, length(codes)), codes)
}))
stopifnot(all(africa_indicators$iso3 %in% names(subregion_of)))
africa_indicators$subregion <- factor(
  unname(subregion_of[africa_indicators$iso3]),
  levels = c("North", "West", "Central", "East", "South")
)

stopifnot(nrow(africa_indicators) == 54 * 14, ncol(africa_indicators) == 14)

save(africa_indicators, file = "data/africa_indicators.rda",
     compress = "bzip2")
