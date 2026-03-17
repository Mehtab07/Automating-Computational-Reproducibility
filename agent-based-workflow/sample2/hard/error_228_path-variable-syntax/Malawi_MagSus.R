# rm(list = ls())
start_time <- Sys.time()
graphics.off()

library(openxlsx)

linterp <- function(x, y, x.out){
  bad <- is.na(x) | is.na(y)
  X <- x[!bad]
  Y <- y[!bad]

  # Check if we have enough data points
  if(length(X) < 2) {
    stop("Not enough data points for interpolation")
  }

  Y <- Y[order(X)]
  X <- X[order(X)]

  # Check if all X values are the same
  if(max(X) == min(X)) {
    stop("All X values are the same, cannot fit a linear model")
  }

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

linearity <- read.table(file = "./data_input/magSus.csv", header = T, sep = ",")
# Use the actual column names from the file: "Depth", "age", "Gamma Density", "MS Loop (negs removed)"
colnames(linearity) <- c("depth", "age", "gammaDensity", "MS")

char <- read.table(file = "./data_input/magSus_charcoal.csv", header = T, sep = ",")
# Use the actual column names from the file: "age (kyr)", "Charcoal (abundance normalized by sedimentation rate)", "Lake Level (PC1 5pt Smooth)"
colnames(char) <- c("age", "char", "lake")

MSdownsampled <- cbind("age" = char$age,
                       "MS_downsampled" = linterp(x = linearity$age,
                                                  y = linearity$MS, 
                                                  x.out = char$age))

write.table(x = MSdownsampled, 
            file = "./data_output/linearityDownsampled.csv", 
            row.names = F, 
            sep = ",")

core2a_Charcoal <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 1)
core2a_linearity <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 2)
core2a_downsampled <- cbind("Depth" = core2a_Charcoal$Depth,
                           "MS_downsampled" = linterp(x = core2a_linearity$Depth,
                                                      y = core2a_linearity$MagSus,
                                                      x.out = core2a_Charcoal$Depth))
write.table(x = core2a_downsampled, 
            file = "./data_output/Core2A_linearityDownsampled.csv", 
            row.names = F, 
            sep = ",")
