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

regions <- c(
  North = "DZA EGY LBY MAR SDN TUN",
  West = "BEN BFA CPV CIV GMB GHA GIN GNB LBR MLI MRT NER NGA SEN SLE TGO",
  Central = "AGO CMR CAF TCD COG COD GNQ GAB STP",
  East = "BDI COM DJI ETH KEN MDG MWI MUS MOZ RWA SYC SOM TZA UGA ZMB ZWE",
  South = "BWA SWZ LSO NAM ZAF"
)
region_of <- unlist(lapply(names(regions), function(r) {
  setNames(rep(r, length(strsplit(regions[[r]], " ")[[1]])),
           strsplit(regions[[r]], " ")[[1]])
}))

d <- africa_indicators[africa_indicators$year == 2019 &
                         !is.na(africa_indicators$gdp_per_capita), ]
stopifnot(all(d$iso3 %in% names(region_of)))

africa_countries <- tibble::tibble(
  country    = d$country,
  abb        = d$iso3,
  region     = factor(unname(region_of[d$iso3]),
                      levels = c("North", "West", "Central", "East", "South")),
  population = d$population,
  gdp        = round(d$gdp_per_capita * d$population / 1e6)
)
africa_countries <- africa_countries[order(africa_countries$country), ]

stopifnot(nrow(africa_countries) == 52, !anyNA(africa_countries))

save(africa_countries, file = "data/africa_countries.rda", compress = "bzip2")
