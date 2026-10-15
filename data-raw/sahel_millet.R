## Code to prepare `sahel_millet`: simulated pearl millet plants in the Sahel
##
## A stand-in for palmerpenguins, set where the CRFS (formerly CCRP) West
## Africa community of practice works, as kenya_flamingos is for Kenya. The
## data is SIMULATED. Its shape copies the penguins so that lessons written for
## them still work:
##
##   penguins            sahel_millet
##   species (3)         variety (3): one grown at every site, two at one each
##   island (3)          site (3): Maradi (Niger), Segou (Mali), Yatenga (Burkina Faso)
##   bill_length_mm      panicle_length_cm
##   bill_depth_mm       panicle_girth_mm  -- negatively related to length
##                                            overall, positively within a
##                                            variety (Simpson's paradox)
##   flipper_length_mm   plant_height_cm
##   body_mass_g         grain_weight_g    -- grain from the plant's main head
##   sex (with NAs)      fertiliser: microdose or none (with NAs)
##   year                year: 2021-2023
##
## plus head_miner_damage_pct, the share of the head's grain lost to the
## millet head miner, which lowers grain weight: for correlation lessons.
##
## Two plants have no measurements at all, as two penguins do.
##
## The varieties are real names, used for flavour: HKP is a local early millet
## from Niger, ICMV IS 89305 an improved ICRISAT variety, Souna 3 an improved
## Senegalese variety. The numbers are not measurements of them.

set.seed(20261014)

layout <- data.frame(
  variety = c(rep("HKP", 3), "ICMV IS 89305", "Souna 3"),
  site    = c("Maradi", "Segou", "Yatenga", "Maradi", "Segou"),
  n       = c(52, 56, 44, 124, 68)
)

# Per-variety means and spreads
pars <- list(
  "HKP"           = list(len = 28.0, len_sd = 2.7, girth = 27.0, girth_sd = 1.3,
                         height = 190, height_sd = 7,  grain = 36.5, grain_sd = 4.0),
  "ICMV IS 89305" = list(len = 38.5, len_sd = 3.0, girth = 22.0, girth_sd = 1.0,
                         height = 217, height_sd = 7,  grain = 50.0, grain_sd = 4.8),
  "Souna 3"       = list(len = 40.0, len_sd = 3.3, girth = 27.2, girth_sd = 1.2,
                         height = 196, height_sd = 7,  grain = 37.0, grain_sd = 3.6)
)

rows <- lapply(seq_len(nrow(layout)), function(i) {
  v <- layout$variety[i]; p <- pars[[v]]; n <- layout$n[i]
  fertiliser <- sample(c("microdose", "none"), n, replace = TRUE)
  fert_effect <- ifelse(fertiliser == "microdose", 1, -1)
  # length and girth share a within-variety size factor: r about 0.4
  size <- rnorm(n)
  len <- p$len + p$len_sd * (0.65 * size + 0.76 * rnorm(n)) + 0.8 * fert_effect
  girth <- p$girth + p$girth_sd * (0.65 * size + 0.76 * rnorm(n)) + 0.4 * fert_effect
  height <- p$height + p$height_sd * (0.5 * size + 0.87 * rnorm(n)) + 3 * fert_effect
  damage <- pmin(round(rexp(n, rate = 1 / 12)), 70)
  grain <- p$grain + p$grain_sd * (0.5 * size + 0.87 * rnorm(n)) + 3 * fert_effect -
    0.35 * (damage - 12)
  data.frame(
    variety = v,
    site = layout$site[i],
    panicle_length_cm = round(len, 1),
    panicle_girth_mm = round(girth, 1),
    plant_height_cm = round(height),
    grain_weight_g = round(grain, 1),
    head_miner_damage_pct = damage,
    fertiliser = fertiliser,
    year = sample(2021:2023, n, replace = TRUE)
  )
})
sahel_millet <- do.call(rbind, rows)
sahel_millet <- sahel_millet[order(match(sahel_millet$variety, c("HKP", "ICMV IS 89305", "Souna 3")),
                                   sahel_millet$year), ]

# Fertiliser not recorded for 11 plants, as sex is missing for 11 penguins
sahel_millet$fertiliser[sample(nrow(sahel_millet), 11)] <- NA
# Two plants lost before they were measured
measured <- c("panicle_length_cm", "panicle_girth_mm", "plant_height_cm",
              "grain_weight_g", "head_miner_damage_pct", "fertiliser")
sahel_millet[c(4, 272), measured] <- NA

sahel_millet$variety <- factor(sahel_millet$variety)
sahel_millet$site <- factor(sahel_millet$site)
sahel_millet$fertiliser <- factor(sahel_millet$fertiliser)
sahel_millet$year <- as.integer(sahel_millet$year)
rownames(sahel_millet) <- NULL
sahel_millet <- tibble::as_tibble(sahel_millet)

write.csv(sahel_millet, "data-raw/sahel_millet.csv", row.names = FALSE)
usethis::use_data(sahel_millet, overwrite = TRUE)
