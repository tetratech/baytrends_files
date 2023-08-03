
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

# File Structure

All files to be served up to the Shiny app are in the folder "data".

Each year will have its own folder and the current files will be in the folder 
"current_year".

The CBP version of the app hosts these files on their own servers for faster
response times.