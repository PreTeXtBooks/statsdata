## Code to prepare `sahel_rainfall`: simulated annual rainfall at three Sahel sites
##
## For line graphs and smoothing: a stand-in for ggplot2::economics in the CRFS
## variant of "Reproducible Research Using R". The data is SIMULATED. Its shape
## follows the well-known history of Sahel rainfall -- wet in the 1950s and
## 1960s, a long drought through the 1970s and 1980s, and a partial recovery
## since the 1990s -- so a straight trend line and a LOESS smooth tell visibly
## different stories. The yearly values are not records from any station.
##
## The sites are those of sahel_millet: Maradi (Niger), Segou (Mali) and
## Yatenga (Burkina Faso), with Segou the wettest and Maradi the driest.

set.seed(1950)

years <- 1950:2023
# The shared Sahel signal, as a fraction of each site's long-term mean:
# about +15% in the 1950s-60s, about -25% at the 1980s low, about -8% now.
signal <- 0.15 - 0.40 / (1 + exp(-(years - 1972) / 3)) +
  0.17 / (1 + exp(-(years - 1995) / 4))

sites <- data.frame(
  site = c("Maradi", "Segou", "Yatenga"),
  mean_mm = c(480, 700, 620),
  sd_frac = c(0.17, 0.14, 0.16)
)

rows <- lapply(seq_len(nrow(sites)), function(i) {
  s <- sites[i, ]
  # year-to-year noise with a little persistence (wet years follow wet years)
  noise <- as.numeric(stats::arima.sim(list(ar = 0.3), n = length(years), sd = s$sd_frac))
  rain <- s$mean_mm * (1 + signal + noise)
  data.frame(
    site = s$site,
    year = years,
    rainfall_mm = round(pmax(rain, 0.2 * s$mean_mm)),
    rainy_days = round(pmax(10, rain / 11 + stats::rnorm(length(years), 0, 4)))
  )
})
sahel_rainfall <- do.call(rbind, rows)
sahel_rainfall$site <- factor(sahel_rainfall$site)
sahel_rainfall$year <- as.integer(sahel_rainfall$year)
sahel_rainfall <- tibble::as_tibble(sahel_rainfall)

write.csv(sahel_rainfall, "data-raw/sahel_rainfall.csv", row.names = FALSE)
usethis::use_data(sahel_rainfall, overwrite = TRUE)
