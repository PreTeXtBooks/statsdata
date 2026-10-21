## Code to prepare `ghana_dhims_validation`: checking Ghana's routine neonatal
## health data against the hospital registers, Greater Accra, January-March 2012
##
## Real data: Table 4 of Kayode, G.A. et al. (2014), "Quantifying the validity of
## routine neonatal healthcare data in the Greater Accra Region, Ghana", PLOS ONE
## 9(8): e104053, doi:10.1371/journal.pone.0104053, CC BY 4.0 ("All data are
## included within the manuscript"). The table was read from the article's XML
## on Europe PMC (PMC4140714) into data-raw/ghana_dhims_validation.csv, cell for
## cell; nothing was retyped.
##
## Kept as published: district labels (including "DISTIRCT F"), indicator names
## (which differ between districts: "Total delivery" in some, "Mothers delivered"
## in others), and "***" where the paper gives no value, read here as NA.

raw <- utils::read.csv("data-raw/ghana_dhims_validation.csv", stringsAsFactors = FALSE,
                       na.strings = "***")
ghana_dhims_validation <- tibble::as_tibble(raw)
usethis::use_data(ghana_dhims_validation, overwrite = TRUE)
