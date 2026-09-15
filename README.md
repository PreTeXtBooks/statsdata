
<!-- README.md is generated from README.Rmd. Please edit that file -->

# statsdata

<!-- badges: start -->

[![R-CMD-check](https://github.com/PreTeXtBooks/statsdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PreTeXtBooks/statsdata/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

`statsdata` provides the datasets used in the PreTeXtBooks open
statistics textbook series. It is intended for students working through
the books, and for instructors who want to reproduce or adapt the
examples and exercises.

## Installation

Install the package from GitHub with:

``` r
# install.packages("pak")
pak::pak("IDEMSInternational/statsdata")
```

## Datasets

| Dataset | Description | Source |
|----|----|----|
| `kenya_flamingos` | Simulated morphological measurements for Greater and Lesser Flamingos at three Rift Valley lakes | Simulated for teaching purposes |
| `kenya_accidents_2016` | Fatal road accident records from Kenya, April–June 2016 | [Humanitarian Data Exchange](https://data.humdata.org/dataset/kenya-road-accidents-database) |
| `kenya_accidents_2017` | Fatal road accident records from Kenya, 2017 | [Humanitarian Data Exchange](https://data.humdata.org/dataset/kenya-road-accidents-database) |

Raw CSV files for use with other software are available in the
[`data-raw/`](https://github.com/PreTeXtBooks/statsdata/tree/main/data-raw)
folder.

## Usage

``` r
library(statsdata)

head(kenya_flamingos)
#>          lake          species bill_length_mm bill_depth_mm leg_length_mm
#> 1     Bogoria  Lesser Flamingo          101.2          25.9         265.1
#> 2      Nakuru Greater Flamingo          135.8          22.5         371.8
#> 3      Nakuru  Lesser Flamingo           96.1          26.9         278.0
#> 4 Elementaita Greater Flamingo          131.1          25.7         360.4
#> 5      Nakuru  Lesser Flamingo           94.1          24.3         264.1
#> 6      Nakuru  Lesser Flamingo           98.4          25.9         272.3
#>   body_mass_g    sex year
#> 1        1330 female 2022
#> 2        2841 female 2023
#> 3        1646   male 2022
#> 4        3476   male 2022
#> 5        1620 female 2021
#> 6        1963   male 2022
```

``` r
library(dplyr)
#> Warning: package 'dplyr' was built under R version 4.4.3
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

kenya_flamingos %>%
  group_by(species) %>%
  summarise(
    n             = n(),
    mean_mass_g   = round(mean(body_mass_g, na.rm = TRUE)),
    mean_bill_mm  = round(mean(bill_length_mm, na.rm = TRUE), 1)
  )
#> # A tibble: 2 × 4
#>   species              n mean_mass_g mean_bill_mm
#>   <chr>            <int>       <dbl>        <dbl>
#> 1 Greater Flamingo    66        3120        127. 
#> 2 Lesser Flamingo    278        1689         97.9
```

## Notes on simulated data

The `kenya_flamingos` dataset was simulated for teaching purposes. The
measurements are realistic for the two species at these lakes. It has
been simulated to be like the `iris` or `penguins` data set, but more
contextually relevant for Kenya. It should not be used as a source
ofempirical claims about flamingo populations in Kenya.

## Licence

Individual datasets carry their own licences as documented in the help
pages (`?kenya_flamingos`, `?kenya_accidents_2016`). The Kenya road
accidents data is released under the Humanitarian Data Exchange [HDX
Open Data Licence](https://data.humdata.org/faqs/licenses).
