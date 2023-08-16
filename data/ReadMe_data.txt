# baytrends data files
Erik.Leppo@tetratech.com
2023-08-16

# Location

## GitHub
https://github.com/tetratech/baytrends_files
https://github.com/tetratech/baytrendsmap

## Shiny

* CBP (official) - https://baytrends.chesapeakebay.net/baytrendsmap/

* Tetra Tech (testing) - https://tetratech-wtr-wne.shinyapps.io/baytrendsmap/



# Data Structure

All data (files and plots) are on GitHub in a "data" folder with subfolders for
each "year".

Within the year folders the data files are in the "data" folder and the plots 
are in folders by type that corresponds to the data file.

A copy of the most recent data is in the "current" folder for use by the Shiny
app.

# Names

## Folders

The "year"" is when the data was compiled.  The data collected is from the 
previous calendar year.  That is, the 2020 folder will contain data that was 
collected in 2019.

## Files

The data files and the plots folders

NLT = Non Linear Trends

FA = Flow Adjusted

T or F = TRUE or FALSE (for flow adjusted)

Long Term (LT) or Short Term (ST) = period of record 

20192020 = Sampling year of data

## Plots

Plots are only included for the non-flow adjusted long-term data (NLT_FA_F_LT).

A non data plot is included for display in the Shiny app when no plot exists for
a given site and data.

Plot names follow a standard that includes the parts below separated by an 
underscore (_).

SiteID

parameter

Layer (Bottom or Surface) [B or S]

A script is included in the "data-raw" folder to rename files from the 
convention used for data analysis to the one used to serve files for the Shiny
app.  The data analysis routine changed after 2020 but wanted to keep using the 
existing naming convention Shiny app files.

# Updating

Each year receive a new dataset and files from the analysis workgroup.

1. Save the zip file to the "data-raw" folder.

2. Create a new folder with the current calendar year.  See previous years for 
folder naming conventions.

3. There is a "process" data script for each year in the "data-raw" folder.
Modify as needed to create the data files and save the files to the correct
folder.  Save the modified script with the data year.

4. Add the new file names to "data/pick_files.csv".

    a. This file controls the radio select buttons in the Shiny app.
    
5. Update the plot names using the R script included in the "data-raw".  Save
the previous year's file with the current data year.  Modify the script as 
needed, run, and save it.

6. When the new year folder is created then remove all files from "current" 
folder and replace with folders from the newly create "year" folder.

7. Test new files on the Tetra Tech Shiny version of the app.

8. Inform CBP IT staff (John M, as of 2023) about availability of new files.

# Other

* 2019. Original dataset with 6 data files.  No graphs.

* 2020a. Data files condensed from 6 to 4 files.  No graphs.

* 2020b. Data files renamed to consistent (and shorter) convention.

* 2021. New plot naming convention.  Created script to rename to Shiny naming 
convention.