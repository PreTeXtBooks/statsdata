## Code to prepare data-raw/visites_mais.csv.
##
## Seven field visits of ghana_maize as they might come from a French-speaking
## team: French column names with accents, dates written out with the name of
## the month, a decimal comma, and the file saved in Latin-1 (ISO-8859-1). It
## exists to practise reading a file with another encoding, decimal mark and
## language for dates (the chapter "Locales"). The visits and the leaf area
## index are those of ghana_maize. The time at which each visit was entered
## (saisie) is invented for the exercise, and the growth stage is translated.

load("data/ghana_maize.rda")

fr_months <- c("janvier", "f\u00e9vrier", "mars", "avril", "mai", "juin", "juillet",
               "ao\u00fbt", "septembre", "octobre", "novembre", "d\u00e9cembre")
stage_fr <- c("Vegetative phase" = "Phase v\u00e9g\u00e9tative",
              "Flowering" = "Floraison", "Grain filling" = "Remplissage du grain",
              "Maturity" = "Maturit\u00e9")

d <- ghana_maize[!is.na(ghana_maize$lai) & ghana_maize$growth_stage %in% names(stage_fr), ]
d <- d[order(d$date), ]
d <- d[!duplicated(d$field_id), ]
d <- d[round(seq(1, nrow(d), length.out = 7)), ]
stopifnot(nrow(d) == 7)

dates <- sprintf("%02d %s %d", as.integer(format(d$date, "%d")),
                 fr_months[as.integer(format(d$date, "%m"))], as.integer(format(d$date, "%Y")))
# the visit is typed in the evening of the same day or the day after
entered <- as.POSIXct(format(d$date), tz = "UTC") + c(19, 21, 23, 46, 20, 22, 44) * 3600 + c(2, 5, 28, 43, 59, 7, 31) * 60
x <- data.frame(
  parcelle = d$field_id,
  date_de_visite = dates,
  saisie = format(entered, "%Y-%m-%d %H:%M:%S"),
  "stade_de_d\u00e9veloppement" = ifelse(d$growth_stage %in% names(stage_fr), stage_fr[d$growth_stage], d$growth_stage),
  indice_foliaire = format(d$lai, decimal.mark = ","),
  check.names = FALSE, stringsAsFactors = FALSE
)
write.csv(x, "data-raw/visites_mais.csv", row.names = FALSE, fileEncoding = "latin1", quote = TRUE)
