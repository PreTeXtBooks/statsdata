## Code to prepare `millet_heights`.
##
## The height of pearl millet plants by variety, from sahel_millet. It is the
## same measurements with the plants that were not measured (two rows) dropped,
## and the columns reduced to the variety and the height in centimetres, so that
## it can be used to teach summaries, histograms and the normal distribution
## without having to deal with missing values first.

load("data/sahel_millet.rda")

d <- sahel_millet[!is.na(sahel_millet$plant_height_cm), ]
millet_heights <- data.frame(
  variety = droplevels(factor(d$variety, levels = c("HKP", "Souna 3", "ICMV IS 89305"))),
  height  = d$plant_height_cm,
  stringsAsFactors = FALSE
)

stopifnot(nrow(millet_heights) == 342, !anyNA(millet_heights))

save(millet_heights, file = "data/millet_heights.rda", compress = "bzip2")
