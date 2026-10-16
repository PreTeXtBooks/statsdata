## Code to prepare `sahel_rainfall_grid`: annual rainfall over Burkina Faso, Mali
## and Niger, 1991-2020, from CHIRPS v2.0.
##
## CHIRPS (Climate Hazards Group InfraRed Precipitation with Station data) blends
## satellite estimates with station records at 0.05 degrees. It is in the public
## domain. Funk, C. et al. (2015) The climate hazards infrared precipitation with
## stations - a new environmental record for monitoring extremes. Scientific Data
## 2, 150066. doi:10.1038/sdata.2015.66
##
## Each year's global annual total is read remotely (only the West African window
## is downloaded), averaged to 0.1 degrees to keep the dataset small, and masked
## to the three countries' borders from Natural Earth. 1991-2020 is the standard
## 30-year climate normal period.
library(terra)
library(rnaturalearth)

years <- 1991:2020
url <- "/vsicurl/https://data.chc.ucsb.edu/products/CHIRPS-2.0/global_annual/tifs/chirps-v2.0.%d.tif"
window <- ext(-12.5, 16.5, 9, 25.5)
annual <- rast(lapply(years, function(y) {
  message(y)
  crop(rast(sprintf(url, y)), window)
}))
names(annual) <- paste0("y", years)
annual <- aggregate(annual, fact = 2, fun = "mean", na.rm = TRUE)

countries <- ne_countries(scale = 50, country = c("Burkina Faso", "Mali", "Niger"),
                          returnclass = "sf")
countries <- vect(countries)
zone <- rasterize(countries, annual, field = "name")
annual <- mask(annual, zone)

df <- as.data.frame(c(zone, annual), xy = TRUE, na.rm = TRUE)
yr <- as.matrix(df[, paste0("y", years)])
sahel_rainfall_grid <- data.frame(
  lon = round(df$x, 2),
  lat = round(df$y, 2),
  country = tolower(gsub(" ", "_", df$name)),
  rain_mean_mm = round(rowMeans(yr), 1),
  rain_sd_mm = round(apply(yr, 1, sd), 1),
  rain_2011_mm = round(df$y2011, 1),
  rain_2012_mm = round(df$y2012, 1)
)
sahel_rainfall_grid$rain_cv_pct <- round(100 * sahel_rainfall_grid$rain_sd_mm /
                                           sahel_rainfall_grid$rain_mean_mm, 1)
usethis::use_data(sahel_rainfall_grid, overwrite = TRUE)
