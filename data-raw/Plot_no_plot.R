# No Plot Plot
# code missing recreate
# Erik.Leppo@tetratech.com
# 2024-10-11
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Packages ----
library(ggplot2)

# Plot ----
p_no_plot <- ggplot() +
  theme_void() +
  labs(title = "No trends plot available for selected dataset.",
       subtitle = paste0("Trends plots only available for 'Long Term' dataset.", 
                         "\n Parameters DIN and PO4 are only available for surface layer."))

# Save ----
ggsave(file.path("data-raw", "_no_plot.png"),
       plot = p_no_plot,
       width = 1800,
       height = 1050,
       units = "px",
       dpi = 300,
       bg = "white")

