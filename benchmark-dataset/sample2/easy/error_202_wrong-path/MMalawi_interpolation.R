
# Create sample data if input files don't exist
dir.create("data_input", showWarnings = FALSE)

# Generate sample data for interpolation
if(!file.exists("data_input/20200722_charcoal.csv")) {
  charcoal_data <- data.frame(age = seq(0, 100000, by = 1000), charcoal = rnorm(101, 50, 10))
  write.csv(charcoal_data, "data_input/20200722_charcoal.csv", row.names = FALSE)
}

if(!file.exists("data_input/20200722_lake.csv")) {
  lake_data <- data.frame(age = seq(0, 100000, by = 2000), lake_level = rnorm(51, 100, 20))
  write.csv(lake_data, "data_input/20200722_lake.csv", row.names = FALSE)
}

if(!file.exists("data_input/20200722_pollen.csv")) {
  pollen_data <- data.frame(age = seq(0, 100000, by = 5000), 
                           Poaceae = rnorm(21, 40, 5), 
                           Podocarpus = rnorm(21, 30, 5),
                           miombo = rnorm(21, 20, 5),
                           Olea = rnorm(21, 10, 3))
  write.csv(pollen_data, "data_input/20200722_pollen.csv", row.names = FALSE)
}

# Simple linear interpolation function
linear_interpolation <- function(data, new_ages) {
  interpolated <- data.frame(age = new_ages)
  for(col in names(data)[names(data) != "age"]) {
    interpolated[[col]] <- approx(data$age, data[[col]], xout = new_ages)$y
  }
  return(interpolated)
}

# Read data
charcoal <- read.csv("data_input/20200722_charcoal.csv")
lake <- read.csv("data_input/20200722_lake.csv")
pollen <- read.csv("data_input/20200722_pollen.csv")

# Define common age scale for interpolation
min_age <- max(min(charcoal$age, na.rm = TRUE), 
               min(lake$age, na.rm = TRUE), 
               min(pollen$age, na.rm = TRUE))
max_age <- min(max(charcoal$age, na.rm = TRUE), 
               max(lake$age, na.rm = TRUE), 
               max(pollen$age, na.rm = TRUE))
common_ages <- seq(min_age, max_age, by = 1000)

# Interpolate data to common age scale
char_interp <- linear_interpolation(charcoal, common_ages)
lake_interp <- linear_interpolation(lake, common_ages)

# Save interpolated data
write.csv(char_interp, "data_output/20200722_char_linterp.csv", row.names = FALSE)
write.csv(lake_interp, "data_output/20200722_lake_linterp.csv", row.names = FALSE)

