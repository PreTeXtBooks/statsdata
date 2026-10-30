## Code to prepare `burkina_headminer_djibasso` and `burkina_headminer_dori`: millet
## head miner larvae counted on millet spikes in a field trial at Djibasso and Dori,
## Burkina Faso, 2021 rainy season. One dataset per site, as in the article.
##
## Source: the supplementary data of Boly, A., Waongo, A., Kabore, A., Drabo, E.,
## Traore, F. and Sanon, A. (2025) Combined effect of millet-cowpea intercropping and
## biopesticide application against Heliocheilus albipunctella De Joannis
## (Lepidoptera: Noctuidae) in Burkina Faso. PeerJ 13, e20221.
## doi:10.7717/peerj.20221. Published under CC BY 4.0. The two CSV files are copied
## unchanged from the article's Supplemental Information 1 (Djibasso) and 2 (Dori).
##
## The trial is a split plot in three blocks: the cropping system is the main plot
## and the pest treatment the sub-plot. Each row is one millet spike from a 1 m^2
## quadrat in a sub-plot. The cowpea-only plots are not in the files, since they have
## no millet. In the Dori file, the insecticide plots of the farmers' practice system
## all carry block B1 (48 spikes, three times the usual number); they are kept as
## recorded.
## The per-site datasets are the files as published, as tibbles with double
## counts, which is what readr::read_csv2() gives. The two disagree on column
## names (Phytosanitary_treatment against Phytosanitary treatment) and on the
## insecticide label (K_optimal against K-optimal), which is what makes appending
## them a lesson. check.names = FALSE keeps the spaces in the Dori names.
read_raw <- function(file) {
  d <- read.csv2(file.path("data-raw", file), check.names = FALSE,
                 stringsAsFactors = FALSE)
  d[[4]] <- as.numeric(d[[4]])
  tibble::as_tibble(d)
}

## The stacked dataset is cleaned: one set of names and labels, and a site column.
clean_site <- function(d, site) {
  names(d) <- c("block", "treatment", "cropping", "larvae")
  data.frame(
    site = site,
    block = as.integer(sub("B", "", d$block)),
    cropping = c(Mil_pur = "millet", `2M_1N` = "two_millet_one_cowpea",
                 P_P = "farmer_practice")[d$cropping],
    treatment = ifelse(grepl("neem", d$treatment), "neem",
                       ifelse(d$treatment == "Control", "control", "insecticide")),
    larvae = as.integer(d[[4]])
  )
}

burkina_headminer_djibasso <- read_raw("burkina_headminer_djibasso.csv")
burkina_headminer_dori <- read_raw("burkina_headminer_dori.csv")

burkina_headminer <- rbind(
  clean_site(burkina_headminer_djibasso, "djibasso"),
  clean_site(burkina_headminer_dori, "dori")
)
rownames(burkina_headminer) <- NULL
stopifnot(!anyNA(burkina_headminer), nrow(burkina_headminer) == 859)

usethis::use_data(burkina_headminer_djibasso, burkina_headminer_dori,
                  burkina_headminer, overwrite = TRUE)
