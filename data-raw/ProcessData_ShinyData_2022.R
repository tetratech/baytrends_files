# Prepare raw data for use in the package
#
# Erik.Leppo@tetratech.com
# 2023-08-17
#
# Comments about each dataset below
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2020 data
# "final" data for 2020
# Received data from Rebecca via email, 2021-10-18
# different format from 2019 (all data in CSV)
# 2019 was single RDA file with 6 datasets in it.
# Mike Lane uses gamOption
#
# NLT_FA_F <- GAM 1 and 2
# NLT_FA_T <- GAM 4 and 5
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2020b data
# 2021-07-18, EWL
# revision to the Shiny app (with 2020 data)
# Combined files; 
# Long Term = Full Period + Long-term (two smaller data sets)
# Short Term = short-term file (larger data set)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2021 data
# 2022-11-21, EWL
# 2021 data from Rebecca (2022-11-09), same format as 2020 data
# add "useNA" to table()
# add testthat check
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2023-08-17, EWL
# Add more comments to the code and parameterize a few values and put at start
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2022 data
# 2022-09-26, EWL
# 2022 data from Rebecca (2022-09-21), same format as 2021 data
## parameterize some variables based on date
## Add copy to current and archive old
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Packages----
#library(testthat)

# GLOBAL----
yr_data <- 2022


# Variables dependent on years of the data
pname_yr  <- "2012/13-2021/22"  # used in filter to define datasets
file_year <- as.character(paste0(yr_data - 1, yr_data)) # used in filenames when save data
file_year_prev <- as.character(as.numeric(file_year) - 10001)    
              # used in create pick_files.csv to designate previous year

# Data ----
# Change folder name and files names to match new data
dn_data <- file.path("data-raw", paste0("data_final_", yr_data))
fn_zip  <- paste0("baytrendsmaps_", yr_data, "_chngCombo.zip")
fn_data <- paste0("baytrendsmaps_", yr_data, "_chngCombo.csv")
df_data <- read.csv(unz(file.path(dn_data, fn_zip), fn_data))

# QC
# Visual check of data and distribution
table(df_data$gamName, useNA = "ifany")
table(df_data$periodName, useNA = "ifany")
table(df_data$gamName, df_data$periodName, useNA = "ifany")
table(df_data$dep, useNA = "ifany")
table(df_data$layer, useNA = "ifany")
table(df_data$seasonName, useNA = "ifany")
table(df_data$state, useNA = "ifany")
str(df_data)

# Older dataset names used in 2019
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Loads 6 data sets (2019)
#ls(globalenv())
# "Non-linear_Trend_1999-2000_to_2018-2019"                     
# "Non-linear_Trend_2010-2011_to_2018-2019"                     
# "Non-linear_Trend_Full_Period"                                
# "Non-linear_Trend_with_Flow_Adjustment_1999-2000_to_2018-2019"
# "Non-linear_Trend_with_Flow_Adjustment_2010-2011_to_2018-2019"
# "Non-linear_Trend_with_Flow_Adjustment_Full_Period"

# Munge Datasets ----
# Modify data as needed for consistency for package and Shiny app

## Add mapLayer ----
# Create variable used for mapping in Shiny app
df_data$mapLayer <- paste(toupper(df_data$dep)
                          , df_data$layer
                          , df_data$seasonName
                          , sep = "|")
table(df_data$mapLayer, useNA = "ifany")

## Add gamName ----
# Create word gamName from numeric values

# 2021 different from 2020
table(df_data$gamOption, useNA = "ifany")

df_data$gamName[df_data$gamOption == 2 
            | df_data$gamOption == 3] <- "Non-Linear Trend"
df_data$gamName[df_data$gamOption == 4 
            | df_data$gamOption == 5] <- "Non-Linear Trend with Flow Adjustment"

table(df_data$gamName, useNA = "ifany")

table(df_data$gamName, df_data$periodName, useNA = "ifany")

## Trim Data ----
# Include only the columns needed for the Shiny app (i.e., remove clutter)
col_req <- c("station"
             , "layer"
             , "latitude"
             , "longitude"
             , "cbSeg92"
             , "state"
             , "stationGrpName"
             , "parmName"
             , "gamName"
             , "gamOption"
             , "periodName"
             , "seasonName"
             , "gamDiff.bl.mn.obs"
             , "gamDiff.cr.mn.obs"
             , "gamDiff.abs.chg.obs"
             , "gamDiff.pct.chg"
             , "gamDiff.chg.pval"
             , "dep"
             , "mapLayer")
df_data <- df_data[, col_req]


## Filter ----
# Create datasets to be used for each file
# periodName defined as pname_yr at top of script

NLT_FA_F_ShortTerm <- dplyr::filter(df_data
                                    , gamName == "Non-Linear Trend"
                                    & periodName == pname_yr)
NLT_FA_F_LongTerm <- dplyr::filter(df_data
                                   , gamName == "Non-Linear Trend"
                                   & periodName != pname_yr)
NLT_FA_T_ShortTerm <- dplyr::filter(df_data
                                    , gamName == "Non-Linear Trend with Flow Adjustment"
                                    & periodName == pname_yr)
NLT_FA_T_LongTerm <- dplyr::filter(df_data
                                   , gamName == "Non-Linear Trend with Flow Adjustment"
                                   & periodName != pname_yr)

# QC
# Test to ensure have correct number of records
nrow_orig <- nrow(df_data)
nrow_parts <- nrow(NLT_FA_F_ShortTerm) + 
  nrow(NLT_FA_F_LongTerm) + 
  nrow(NLT_FA_T_ShortTerm) + 
  nrow(NLT_FA_T_LongTerm)
testthat::expect_equal(nrow_orig, nrow_parts )

# Data not documented in package so don't have to updated data.R

# Save  ----

# Save as CSV for use with shiny app in a folder for current year
path_out <- file.path("data", yr_data)
if (!dir.exists(path_out)) {dir.create(path_out)}
path_out <- file.path("data", yr_data, "data")
if (!dir.exists(path_out)) {dir.create(path_out)}

# write CSV
## file_year defined at top of script
write.csv(NLT_FA_F_ShortTerm
          , file = file.path(path_out, paste0("NLT_FA_F_ShortTerm_"
                                              , file_year
                                              , ".csv"))
          , row.names = FALSE)
write.csv(NLT_FA_F_LongTerm
          , file = file.path(path_out, paste0("NLT_FA_F_LongTerm_"
                             , file_year
                             , ".csv"))
          , row.names = FALSE)
write.csv(NLT_FA_T_ShortTerm
          , file = file.path(path_out, paste0("NLT_FA_T_ShortTerm_"
                             , file_year
                             , ".csv"))
          , row.names = FALSE)
write.csv(NLT_FA_T_LongTerm
          , file = file.path(path_out, paste0("NLT_FA_T_LongTerm_"
                             , file_year
                             , ".csv"))
          , row.names = FALSE)

# Pick File ----
# Create file used to drive Shiny App on-screen pick list
fn_pick <- "pick_files.csv"
df_pick <- read.csv(file.path("data", yr_data - 1, "data", fn_pick))
df_pick
df_pick$names <- gsub(file_year_prev, file_year, df_pick$names)
write.csv(df_pick, file.path(path_out, fn_pick), row.names = FALSE)

# Current, Archive OLD ----
path_current <- file.path("data", "current", "data")

file.rename(file.path(path_current, "pick_files.csv")
            , file.path(path_current, paste0("pick_files_", yr_data - 1, ".csv")))

fn_current <- list.files(path_current, pattern = "csv$")
file.rename(file.path(path_current, fn_current)
            , file.path(path_current, "old", fn_current))

# Current, Add NEW
fn_new <- list.files(path_out, pattern = "csv$")

file.copy(file.path(path_out, fn_new)
          , file.path(path_current, fn_new))

