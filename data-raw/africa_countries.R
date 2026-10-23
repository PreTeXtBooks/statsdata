## Code to prepare `africa_countries`.
##
## One row per African country for 2019, taken from africa_indicators (World
## Bank, CC BY 4.0). It has the shape of a small teaching table: a name, a
## three-letter abbreviation, a region, a population, and one total.
## The total is gross domestic product in millions of current US dollars, which is the
## World Bank's GDP per person (NY.GDP.PCAP.CD) times the population. Like any
## count, it grows with the size of the country, so comparing totals says more
## about population than about wealth; dividing by the population gives back
## GDP per person.
##
## Eritrea and South Sudan are left out because the World Bank publishes no GDP
## for them in 2019. Regions are the United Nations geoscheme sub-regions.

load("data/africa_indicators.rda")

d <- africa_indicators[africa_indicators$year == 2019 &
                         !is.na(africa_indicators$gdp_per_capita), ]

africa_countries <- data.frame(
  country    = d$country,
  abb        = d$iso3,
  region     = d$subregion,
  population = as.numeric(d$population),
  gdp        = round(d$gdp_per_capita * d$population / 1e6),
  stringsAsFactors = FALSE
)
# The World Bank's long official names are shortened to the names in common use.
short <- c("Congo, Dem. Rep." = "DR Congo", "Congo, Rep." = "Congo",
           "Egypt, Arab Rep." = "Egypt", "Gambia, The" = "Gambia",
           "Somalia, Fed. Rep." = "Somalia")
hit <- africa_countries$country %in% names(short)
africa_countries$country[hit] <- unname(short[africa_countries$country[hit]])
africa_countries <- africa_countries[order(africa_countries$country), ]

stopifnot(nrow(africa_countries) == 52, !anyNA(africa_countries))

save(africa_countries, file = "data/africa_countries.rda", compress = "bzip2")

## The same table as a spreadsheet, for practising importing files.
write.csv(africa_countries, "data-raw/africa_countries.csv", row.names = FALSE)
