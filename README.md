
# baytrends_files

Repository to store baytrends R package outputs to be used with maps.

<!-- badges: start -->
<!-- badges: end -->

# Installation
No installation as these files are meant to be accessed by the baytrendsmap 
Shiny app.

https://baytrends.chesapeakebay.net/baytrendsmap/

# File Access
Example code to access files.

```r
url_data <- "https://raw.githubusercontent.com/tetratech/baytrends_files/main/data/"
df_data <- read.csv(paste0(url_data, "pick_files.csv")) 
```

# Naming Scheme
Plot files are named in a consistent manner to make them easy to parse and 
identify (Station_Parameter_MapLayer).

Map Layer:

* B = Bottom

* S = Surface

Plots are in folders with the following naming scheme:

* NLT = Non-Linear Trend

* FA = Flow Adjusted

* T or F = TRUE or FALSE (Flow Adjusted)

* FP = Full Period
