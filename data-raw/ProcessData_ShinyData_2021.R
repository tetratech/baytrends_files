# Prepare data for use in the package
#
# Erik.Leppo@tetratech.com
# 2021-12-06
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# "final" data for 2020
# Received data from Rebecca via email, 2021-10-18
# different format from 2019 (all data in CSV)
# 2019 was single RDA file with 6 datasets in it.
# Mike Lane uses gamOption
#
# NLT_FA_F <- GAM 1 and 2
# NLT_FA_T <- GAM 4 and 5
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2021-07-18, EWL
# revision to the Shiny app (with 2020 data)
# Combined files; 
# Long Term = Full Period + Long-term (two smaller data sets)
# Short Term = short-term file (larger data set)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2022-11-21, EWL
# 2021 data from Rebecca (2022-11-09), same format as 2020 data
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Data ----
dn_data <- file.path("data-raw", "data_final_2021")
fn_zip <- "baytrendsmaps_2021_chngCombo.zip"
fn_data <- "baytrendsmaps_2021_chngCombo.csv"
df_data <- read.csv(unz(file.path(dn_data, fn_zip), fn_data))

# QC
table(df_data$gamName)
table(df_data$periodName)
table(df_data$gamName, df_data$periodName)
table(df_data$dep)
table(df_data$layer)
table(df_data$seasonName)
str(df_data)

# Loads 6 data sets (2019)
#ls(globalenv())
# "Non-linear_Trend_1999-2000_to_2018-2019"                     
# "Non-linear_Trend_2010-2011_to_2018-2019"                     
# "Non-linear_Trend_Full_Period"                                
# "Non-linear_Trend_with_Flow_Adjustment_1999-2000_to_2018-2019"
# "Non-linear_Trend_with_Flow_Adjustment_2010-2011_to_2018-2019"
# "Non-linear_Trend_with_Flow_Adjustment_Full_Period"

# Munge Datasets

## Add mapLayer ----
df_data$mapLayer <- paste(toupper(df_data$dep)
                          , df_data$layer
                          , df_data$seasonName
                          , sep = "|")

# gamName ----
# different from 2020
table(df_data$gamOption)

df_data$gamName[df_data$gamOption == 2 | df_data$gamOption == 3] <- "Non-Linear Trend"
df_data$gamName[df_data$gamOption == 4 | df_data$gamOption == 5] <- "Non-Linear Trend with Flow Adjustment"

table(df_data$gamName)

table(df_data$gamName, df_data$periodName, useNA = "ifany")

# trim the file to required columns ----
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

NLT_FA_F_ShortTerm <- dplyr::filter(df_data
                                    , gamName == "Non-Linear Trend"
                                    & periodName == "2012/13-2020/21")
NLT_FA_F_LongTerm <- dplyr::filter(df_data
                                   , gamName == "Non-Linear Trend"
                                   & periodName != "2012/13-2020/21")
NLT_FA_T_ShortTerm <- dplyr::filter(df_data
                                    , gamName == "Non-Linear Trend with Flow Adjustment"
                                    & periodName == "2012/13-2020/21")
NLT_FA_T_LongTerm <- dplyr::filter(df_data
                                   , gamName == "Non-Linear Trend with Flow Adjustment"
                                   & periodName != "2012/13-2020/21")



# Data not documented in package so don't have to updated data.R

# Save  ----
# 
# # Save as CSV to shiny app
path_out <- file.path("data", "new")


# write CSV
file_year <- "20202021"
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
fn_pick <- "pick_files.csv"
df_pick <- read.csv(file.path("data", fn_pick))
df_pick
df_pick$names <- gsub("20192020", file_year, df_pick$names)
write.csv(df_pick, file.path(path_out, fn_pick), row.names = FALSE)


