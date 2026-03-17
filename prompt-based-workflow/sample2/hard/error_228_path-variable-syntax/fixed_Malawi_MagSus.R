Looking at the error log and the script, I can see the issue is that the `data_output` directory doesn't exist when trying to write files. The script attempts to create this directory but there's still an issue with file paths. Let me fix the script:

```r
# rm(list = ls())
start_time <- Sys.time()
graphics.off()

# Create data_output directory if it doesn't exist
if (!dir.exists("./data_output")) {
  dir.create("./data_output", recursive = TRUE)
}

# Install and load required packages
if (!require(openxlsx)) {
  install.packages("openxlsx")
  library(openxlsx)
} else {
  library(openxlsx)
}

linterp <- function(x, y, x.out){
  bad <- is.na(x) | is.na(y)
  X <- x[!bad]
  Y <- y[!bad]
  Y <- Y[order(X)]
  X <- X[order(X)]
  a <- coef(lm(Y ~ X))[2] # slope
  
  data.length <- length(X)
  X.min <- X[1]
  X.max <- X[data.length]
  Y.min <- Y[1]
  Y.max <- Y[data.length]
  
  n.out <- length(x.out)
  y.out <- numeric(n.out)
  for(i in 1:n.out){
    x0 <- x.out[i]
    if(x0 < X.min){
      y.out[i] <- a * (x0 - X.min) + Y.min
    }else if(x0 > X.max){
      y.out[i] <- a * (x0 - X.max) + Y.max
    }else if(any(X == x0)){
      y.out[i] <- mean(Y[which(X == x0)])
    }else{
      j <- max(which(X < x0))
      y.out[i] <- (Y[j + 1] - Y[j]) / (X[j + 1] - X[j]) * (x0 - X[j]) + Y[j]
    }
  }
  
  return(y.out)
}

# Check if files exist before reading
if(file.exists("./data_input/magSus.csv")) {
  linearity <- read.table(file = "./data_input/magSus.csv", header = T, sep = ",")
  colnames(linearity) <- c("depth", "age", "gammaDensity", "MS")
} else {
  stop("File ./data_input/magSus.csv not found")
}

if(file.exists("./data_input/magSus_charcoal.csv")) {
  char <- read.table(file = "./data_input/magSus_charcoal.csv", header = T, sep = ",")
  colnames(char) <- c("age", "char", "lake")
} else {
  stop("File ./data_input/magSus_charcoal.csv not found")
}

MSdownsampled <- cbind("age" = char$age,
                       "MS_downsampled" = linterp(x = linearity$age,
                                                  y = linearity$MS, 
                                                  x.out = char$age))

# Ensure data_output directory exists before writing
if (!dir.exists("./data_output")) {
  dir.create("./data_output", recursive = TRUE)
}

write.table(x = MSdownsampled, 
            file = "./data_output/MagSusDownsampled.csv", 
            row.names = F, 
            sep = ",")

# Check if file exists before reading
if(file.exists("./data_input/Core2A_MagSusCharcoal.xlsx")) {
  core2a_Charcoal <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 1)
  core2a_linearity <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 2)
  core2a_downsampled <- cbind("Depth" = core2a_Charcoal$Depth,
                              "MS_downsampled" = linterp(x = core2a_linearity$Depth, # Changed back to Depth as that's what's in the data
                                                         y = core2a_linearity$linearity, # Changed to linearity to match actual column name
                                                         x.out = core2a_Charcoal$Depth))
  # Ensure data_output directory exists before writing
  if (!dir.exists("./data_output")) {
    dir.create("./data_output", recursive = TRUE)
  }
  
  write.table(x = core2a_downsampled, 
              file = "./data_output/Core2A_MagSusDownsampled.csv", 
              row.names = F, 
              sep = ",")
} else {
  warning("File ./data_input/Core2A_MagSusCharcoal.xlsx not found. Skipping this section.")
}
```