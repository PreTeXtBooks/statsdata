## Code to prepare `sahel_harveststat` from HarvestStat Africa v1.0
##
## HarvestStat Africa (Lee et al. 2025) is a harmonised compilation of
## subnational crop statistics for Sub-Saharan Africa. This keeps the rows for
## Burkina Faso, Mali and Niger from its tabular file,
## hvstat_africa_data_v1.0.csv (22 MB, CC0), downloaded from Dryad
## (https://doi.org/10.5061/dryad.vq83bk42w). Nothing else is changed: the
## columns, their names and their values are as published, and the gaps are
## the gaps in the published file. The file is not kept here because the
## original is on Dryad.
##
## Usage: Rscript data-raw/sahel_harveststat.R path/to/hvstat_africa_data_v1.0.csv

args <- commandArgs(trailingOnly = TRUE)
path <- if (length(args) >= 1) args[1] else "hvstat_africa_data_v1.0.csv"

hvstat <- read.csv(path, stringsAsFactors = FALSE)

sahel_harveststat <- hvstat[hvstat$country %in% c("Burkina Faso", "Mali", "Niger"), ]
rownames(sahel_harveststat) <- NULL
sahel_harveststat <- tibble::as_tibble(sahel_harveststat)

stopifnot(nrow(sahel_harveststat) == 35674, ncol(sahel_harveststat) == 16)

save(sahel_harveststat, file = "data/sahel_harveststat.rda", compress = "bzip2")
