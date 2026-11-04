## Code to prepare `gapminder_modern`.
##
## A modern counterpart to the gapminder data: life expectancy, GDP per capita
## and population for every country and region the World Bank reports, from
## the World Development Indicators (licensed CC BY 4.0). One row per country
## per year, 1960-2026.
##
## The data comes from the World Bank API, so running this again later may give
## slightly different values as the World Bank revises its estimates. The
## download is kept in gapminder_modern.csv so the dataset can be rebuilt
## without a connection: set refresh <- TRUE to download it again.
##
## Missing values are left exactly as the World Bank publishes them: the most
## recent years are not reported yet, and some countries have no data for the
## earliest years. The World Bank also returns aggregates (World, Sub-Saharan
## Africa, High income, ...) alongside countries. They are kept, and have
## region "Aggregates", so filter them out before comparing countries.

refresh <- FALSE
csv_path <- "data-raw/gapminder_modern.csv"

if (refresh || !file.exists(csv_path)) {
  raw <- WDI::WDI(
    indicator = c(
      lifeExp   = "SP.DYN.LE00.IN",
      gdpPercap = "NY.GDP.PCAP.KD",
      pop       = "SP.POP.TOTL"
    ),
    start = 1960,
    end = 2026,
    extra = TRUE
  )
  raw <- raw[order(raw$country, raw$year), ]
  write.csv(raw, csv_path, row.names = FALSE)
}

gapminder_modern <- read.csv(csv_path, stringsAsFactors = FALSE)
gapminder_modern <- tibble::as_tibble(gapminder_modern)

# `status` is empty in every row, so it is dropped.
stopifnot(all(is.na(gapminder_modern$status)))
gapminder_modern$status <- NULL

stopifnot(nrow(gapminder_modern) == 17556, ncol(gapminder_modern) == 14)

save(gapminder_modern, file = "data/gapminder_modern.rda",
     compress = "bzip2")
