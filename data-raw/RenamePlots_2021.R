# Rename 2021 plots
# Erik.Leppo@tetratech.com
# 2022-11-18
#
# _surf and _bot instead of _S and _B
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Files ----
fn_plots <- list.files(file.path("test")
                       , pattern =".png"
                       , recursive = TRUE
                       , full.names = TRUE)

# # Test
# s <- "plots_NLT_FA_F_LT/LE5.1_wtemp_surf.png" 
# b <- "plots_NLT_FA_F_LT/LE5.1_wtemp_bot.png"
# x <- c(s, b)

# Replace Names
fn_plots_rename1 <- gsub("_surf\\.png$", "_S\\.png", fn_plots)
fn_plots_rename2 <- gsub("_bot\\.png$", "_B\\.png", fn_plots_rename1)

# Rename Files
file.rename(fn_plots, fn_plots_rename2)


