# On-farm trials of Oga on pearl millet in Niger, 2014-2016, and the rainfall
# recorded alongside them.
#
# Oga is a fertiliser invented by women farmers in Niger's FUMA Gaskiya
# federation: human urine, stored until it is safe and applied to the millet.
# The federation tested it in on-farm trials with its women members from 2014
# to 2016. In each trial, a woman grew pearl millet on two plots of her own
# field, one given Oga (with organic manure in 2014 and 2015, on its own in
# 2016) and one under her usual practice, and the millet heads (panicles)
# harvested from each plot were weighed.
#
#   Moussa, H.O., Nwankwo, C.I., Aminou, A.M., Stern, D.A., Haussmann, B.I.G.
#   and Herrmann, L. (2021). Sanitized human urine (Oga) as a fertilizer
#   auto-innovation from women farmers in Niger. Agronomy for Sustainable
#   Development, 41, 56. doi:10.1007/s13593-021-00675-2
#
#   Data: Moussa, O.H., Nwankwo, C.I., Aminou, A.M., Stern, A.D. and
#   Haussmann, B.I.G. (2020). Zenodo. doi:10.5281/zenodo.4071826. CC BY 4.0.
#
# The published workbook, Data.xlsx, has one sheet per year and a rainfall
# sheet. This script makes two datasets from it.
#
# niger_oga: the three trial sheets put together, one row per trial, ready for
# analysis. The sheets are laid out differently -- 2014 and 2015 have one row
# per trial with the control and Oga yields side by side, 2016 has one row per
# plot with each Oga plot followed by its control plot -- and only what is
# needed to put them together is changed:
#
# - "." (no yield recorded) becomes NA;
# - spaces around names are trimmed ("Safo " and "Safo");
# - social class is coded "Adult+Aid"/"Adult-Aid" in 2014-2015 and
#   "Eld+Aid"/"Eld-Aid" in 2016; the paper calls these elderly women (aged 40
#   or more) with and without help, so all years use those names;
# - the soil type "Jampali" (2014) is written "Jambali" in 2015-2016, so all
#   years use "Jambali";
# - region is added from the site: Serkin Haussa and Safo are in Maradi, Say
#   in Tillabery;
# - weeding was not recorded in 2016, so it is NA for that year.
#
# Everything else is as published, including the 2015 trials the paper does
# not report (the workbook has 406 trials for 2015, the paper 288). In one
# 2016 pair (Garin Labo), the Oga and control plots have different soil
# types; the soil type of the Oga plot is kept.
#
# niger_oga_rainfall: the rainfall sheet exactly as published, header row and
# all, every cell as text. It is left messy on purpose, for practising
# reshaping: three blocks of month and rainfall side by side, of different
# lengths, each headed by a year (the third block is headed 2015 again, though
# it probably holds 2016).

library(readxl)
library(dplyr)

src <- "data-raw/oga_zenodo_Data.xlsx"
if (!file.exists(src)) {
  download.file("https://zenodo.org/api/records/4071827/files/Data.xlsx/content",
                src, mode = "wb")
}

as_yield <- function(x) suppressWarnings(as.numeric(ifelse(x == ".", NA, x)))

wide_year <- function(year) {
  d <- read_excel(src, sheet = as.character(year), col_types = "text")[, 1:7]
  names(d) <- c("site", "village", "social_class", "soil_type", "weeding",
                "control_yield_kg_ha", "oga_yield_kg_ha")
  d %>%
    filter(!is.na(site)) %>%
    mutate(year = year,
           control_yield_kg_ha = as_yield(control_yield_kg_ha),
           oga_yield_kg_ha = as_yield(oga_yield_kg_ha))
}

y2016 <- read_excel(src, sheet = "2016", col_types = "text")[, 1:6]
names(y2016) <- c("plot", "site", "village", "social_class", "soil_type", "yield")
y2016 <- y2016 %>% filter(!is.na(plot))
oga_rows <- y2016[y2016$plot == "OGA", ]
control_rows <- y2016[y2016$plot == "Control", ]
# each Oga plot is followed by its control plot
stopifnot(nrow(oga_rows) == nrow(control_rows),
          all(which(y2016$plot == "OGA") + 1 == which(y2016$plot == "Control")))
y2016 <- oga_rows %>%
  transmute(site, village, social_class, soil_type, weeding = NA_character_,
            control_yield_kg_ha = as_yield(control_rows$yield),
            oga_yield_kg_ha = as_yield(yield),
            year = 2016)

niger_oga <- bind_rows(wide_year(2014), wide_year(2015), y2016) %>%
  mutate(
    across(c(site, village, social_class, soil_type, weeding), trimws),
    social_class = recode(social_class,
                          "Adult+Aid" = "Elderly with help",
                          "Eld+Aid"   = "Elderly with help",
                          "Adult-Aid" = "Elderly without help",
                          "Eld-Aid"   = "Elderly without help"),
    soil_type = recode(soil_type, "Jampali" = "Jambali"),
    region = if_else(site == "Say", "Tillabery", "Maradi"),
    treatment = if_else(year == 2016, "Oga", "Oga + manure"),
    year = as.integer(year)
  ) %>%
  mutate(trial_id = sprintf("T%03d", row_number())) %>%
  select(trial_id, year, region, site, village, social_class, soil_type,
         weeding, treatment, control_yield_kg_ha, oga_yield_kg_ha)
niger_oga <- as.data.frame(niger_oga)

# read each cell as it is, then store it as the text Excel shows (7.874, not
# 7.8739999999999997)
rain <- read_excel(src, sheet = "Rainfall", col_names = FALSE, col_types = "list",
                   .name_repair = "minimal")
niger_oga_rainfall <- as.data.frame(lapply(rain, function(col) {
  vapply(col, function(x) if (is.null(x) || is.na(x)) NA_character_ else as.character(x),
         character(1))
}))
names(niger_oga_rainfall) <- paste0("col", seq_along(niger_oga_rainfall))

write.csv(niger_oga, "data-raw/niger_oga.csv", row.names = FALSE)
write.csv(niger_oga_rainfall, "data-raw/niger_oga_rainfall.csv", row.names = FALSE)
usethis::use_data(niger_oga, niger_oga_rainfall, overwrite = TRUE)
