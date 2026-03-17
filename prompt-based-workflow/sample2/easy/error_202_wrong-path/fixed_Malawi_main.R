# rm(list = ls())
start_time <- Sys.time()

graphics.off()

# required packages
packages <- c("gdtools", "svglite","MASS", "vegan", "lattice", "permute", "openxlsx")

## load and/or install required packages
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)  # Use library instead of require after installation
    } else {
      library(x, character.only = TRUE)  # Load the package if already installed
    }
  }
)

# Create output directories if they don't exist
if (!dir.exists("./data_output")) {
  dir.create("./data_output", recursive = TRUE)
}
if (!dir.exists("./vector_graphics")) {
  dir.create("./vector_graphics", recursive = TRUE)
}

#######################
#### Interpolation ####
#######################

# Take in: ./data_input/20200722_charcoal.csv
#          ./data_input/20200722_lake.csv
#          ./data_input/20200722_pollen.csv

# Output:  ./data_output/20200722_char_linterp.csv
#          ./data_output/20200722_lake_linterp.csv

source("Malawi_interpolation.R")  # Fixed filename - removed M prefix

####################
#### Ordination ####
####################

# Take in: ./data_input/20200722_pollen.csv
#          ./data_output/20200722_lake_linterp.csv
#          ./data_output/20200722_char_linterp.csv

# Output:  ./data_output/pollen_ordination.csv
#          ./vector_graphics/additional_vec_fit.svg
#          ./vector_graphics/additional_vec_fit_noLabels.svg
#          ./vector_graphics/axes.svg
#          ./vector_graphics/data_pts_asAges.svg
#          ./vector_graphics/data_pts_asDots1.svg
#          ./vector_graphics/data_pts_asDots2.svg
#          ./vector_graphics/legend.svg
#          ./vector_graphics/ordination_surface.svg
#          ./vector_graphics/pollen_vec_fit.svg
#          ./vector_graphics/pollen_vec_fit_noLabels.svg

source("Malawi_ordination.R")  # Fixed filename - removed M prefix

################
#### MagSus ####
################

# Take in: ./data_input/magSus.csv
#          ./data_input/magSus_charcoal.csv
#          ./data_input/Core2A_MagSusCharcoal.xlsx
#          

# Output:  ./data_output/MagSusDownsampled.csv
#          ./data_output/Core2A_MagSusDownsampled.csv

source("Malawi_MagSus.R")  # Fixed filename - removed M prefix