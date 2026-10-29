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
read_site <- function(file) {
  d <- read.csv2(file.path("data-raw", file))
  names(d) <- c("block", "treatment", "cropping", "larvae")
  data.frame(
    block = as.integer(sub("B", "", d$block)),
    cropping = c(Mil_pur = "millet", `2M_1N` = "two_millet_one_cowpea",
                 P_P = "farmer_practice")[d$cropping],
    treatment = ifelse(grepl("neem", d$treatment), "neem",
                       ifelse(d$treatment == "Control", "control", "insecticide")),
    larvae = as.integer(d$larvae)
  )
}

burkina_headminer_djibasso <- read_site("burkina_headminer_djibasso.csv")
burkina_headminer_dori <- read_site("burkina_headminer_dori.csv")
stopifnot(!anyNA(burkina_headminer_djibasso), !anyNA(burkina_headminer_dori))

## The two sites stacked, kept for code that already uses it.
burkina_headminer <- rbind(
  cbind(site = "djibasso", burkina_headminer_djibasso),
  cbind(site = "dori", burkina_headminer_dori)
)

usethis::use_data(burkina_headminer_djibasso, burkina_headminer_dori,
                  burkina_headminer, overwrite = TRUE)
