## Code to prepare `sahel_striga`: simulated millet fields, manure and Striga
##
## Striga hermonthica (witchweed) is a parasitic weed of millet and sorghum
## across the Sahel. It does worst in poor soil, so fields given more manure
## tend to have less Striga as well as more millet. Manure and Striga therefore
## overlap as explanations of yield, which is what a lesson on partial
## correlation needs.
##
## The data is SIMULATED, for teaching. It copies the correlation structure of
## the exam_data example in "Reproducible Research Using R" (studying hours,
## anxiety and exam score) so that the lesson's conclusions carry over:
##
##   manure ~ yield     positive, about 0.4
##   striga ~ yield     negative, about -0.45
##   manure ~ striga    strongly negative, about -0.7
##   partial striga ~ yield | manure   still negative and significant
##   partial manure ~ yield | striga   not significant
##   frn member ~ yield                no relationship
##
## The column names have spaces and capitals, as farm data typed into a
## spreadsheet often does, for practising janitor::clean_names().

n <- 100
target <- matrix(c( 1.00,  0.40, -0.72,
                    0.40,  1.00, -0.45,
                   -0.72, -0.45,  1.00), 3, byrow = TRUE)

# Search seeds for a draw whose sample correlations keep the lesson intact
ok <- FALSE
for (s in 1:5000) {
  set.seed(s)
  z <- matrix(rnorm(n * 3), n) %*% chol(target)
  manure <- round(pmax(0, 3 + 2.4 * z[, 1] + 0.6 * z[, 1]^2), 1)
  yield <- round(pmax(150, 700 + 230 * z[, 2]), -1)
  striga <- round(pmax(0, 18 + 12 * z[, 3]))
  r <- cor(cbind(manure, yield, striga))
  p_sy <- ppcor::pcor.test(striga, yield, manure)$p.value
  p_my <- ppcor::pcor.test(manure, yield, striga)$p.value
  if (abs(r[1, 2] - 0.40) < 0.03 && abs(r[2, 3] + 0.45) < 0.03 &&
      abs(r[1, 3] + 0.71) < 0.03 && p_sy < 0.02 && p_my > 0.2) {
    ok <- TRUE
    break
  }
}
stopifnot(ok)
frn <- sample(c("Yes", "No"), n, replace = TRUE)

sahel_striga <- data.frame(
  "Farmer ID" = sprintf("F%03d", seq_len(n)),
  "Manure Applied (t/ha)" = manure,
  "Millet Yield (kg/ha)" = yield,
  "Striga Count (plants per m2)" = striga,
  "FRN Member" = frn,
  check.names = FALSE
)

write.csv(sahel_striga, "data-raw/sahel_striga.csv", row.names = FALSE)
usethis::use_data(sahel_striga, overwrite = TRUE)
