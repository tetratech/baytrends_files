# baytrends-files
# QC datasets
# Erik.Leppo@tetratech.com
# 2025-09-26
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Packages ----
library(testthat)

# Global ----
dn_year <- file.path("data", "current")
dn_data <- "data"
dn_plots <- "plots_NLT_FA_F_LT" # only have plots for one dataset

# Plots ----
names_plots_png <- list.files(file.path(dn_year, dn_plots)) 
names_plots_png <- gsub("\\.png$", "", names_plots_png)
names_plots_png <- names_plots_png[!names_plots_png %in% "_no_plot"]

# Data ----
fn_pick <- "pick_files.csv"
df_pick <- read.csv(file.path(dn_year, dn_data, fn_pick))
fn_data <- df_pick[df_pick$dir_plot == dn_plots, "names"]
df_data <- read.csv(file.path(dn_year, dn_data, fn_data))
df_data$name_plot <- paste(df_data$station, 
                           df_data$dep,
                           substr(df_data$layer, 1, 1),
                           sep = "_")
names_plots_data <- df_data$name_plot

# Test ----
## Same Number
expect_equal(length(names_plots_png), length(names_plots_data))
## PNG missing from Data
### extra
names_plots_png[!names_plots_png %in% names_plots_data]
## Data missing from PNG
### Possible error, click on point and don't get a map
missing_png <- names_plots_data[!names_plots_data %in% names_plots_png]
missing_png
missing_png_param_layer <- sub("^[^_]*_", "", missing_png)
table(missing_png_param_layer)
