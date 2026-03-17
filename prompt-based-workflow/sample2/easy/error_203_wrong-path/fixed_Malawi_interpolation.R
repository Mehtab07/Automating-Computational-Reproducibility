# We have lake level data, pollen count data, and charcoal data, all sampled at different
# time points. Pollen is sampled the most sparsely of these, so we will downsample the
# other two to match its time points. We will do this by linear interpolation 

# rm(list = ls())
start_time <- Sys.time()
graphics.off()

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

# Fix file paths - they should be consistent with other scripts
pollenData <- read.csv("./data_input/20200722_pollen.csv")  # Fixed path
lakeData <- read.csv("./data_input/20200722_lake.csv")      # Fixed path
charcoalData <- read.csv("./data_input/20200722_charcoal.csv")  # Fixed path

colnames(pollenData)[1] <- "age"
colnames(lakeData) <- c("age", "lake")
colnames(charcoalData) <- c("age", "charcoal")

# make sure data are in chronological order
pollenData <- pollenData[order(pollenData$age),]
lakeData <- lakeData[order(lakeData$age),]
charcoalData <- charcoalData[order(charcoalData$age),]

tail(pollenData)
tail(lakeData)
tail(charcoalData)

##############################
#### interpolate linearly ####
##############################

# Fix the logic to handle cases where pollen ages extend beyond charcoal/lake data
# For charcoal interpolation
max_pollen_age <- max(pollenData$age)
max_charcoal_age <- max(charcoalData$age, na.rm = TRUE)

if (max_pollen_age <= max_charcoal_age) {
  # Normal case: pollen data is within charcoal data range
  last.age.char <- min(which(charcoalData$age > max_pollen_age))
  char.trunc <- charcoalData[1:last.age.char,]
} else {
  # Edge case: pollen data extends beyond charcoal data, use all charcoal data
  char.trunc <- charcoalData
  # Extend charcoal data to cover pollen range by extrapolation
  # Add a point at the maximum pollen age with extrapolated value
  extra_age <- max_pollen_age
  # Simple linear extrapolation using last two points
  n <- nrow(charcoalData)
  if (n >= 2) {
    slope <- (charcoalData$charcoal[n] - charcoalData$charcoal[n-1]) / 
             (charcoalData$age[n] - charcoalData$age[n-1])
    extra_charcoal <- charcoalData$charcoal[n] + slope * (extra_age - charcoalData$age[n])
    extra_row <- data.frame(age = extra_age, charcoal = extra_charcoal)
    char.trunc <- rbind(char.trunc, extra_row)
  }
}

# interpolate linearly
char.linterp.pred <- linterp(x = char.trunc$age, 
                             y = char.trunc$charcoal, 
                             x.out = pollenData$age)

plot(char.trunc$age, char.trunc$charcoal, type = "l", lwd = 2, main = "Charcoal Linear Interpolation")
lines(char.linterp.pred ~ pollenData$age, lwd = 1, col = "red")

# For lake interpolation
max_lake_age <- max(lakeData$age, na.rm = TRUE)

if (max_pollen_age <= max_lake_age) {
  # Normal case: pollen data is within lake data range
  last.age.lake <- min(which(lakeData$age > max_pollen_age))
  lake.trunc <- lakeData[1:last.age.lake,]
} else {
  # Edge case: pollen data extends beyond lake data, use all lake data
  lake.trunc <- lakeData
  # Extend lake data to cover pollen range by extrapolation
  # Add a point at the maximum pollen age with extrapolated value
  extra_age <- max_pollen_age
  # Simple linear extrapolation using last two points
  n <- nrow(lakeData)
  if (n >= 2) {
    slope <- (lakeData$lake[n] - lakeData$lake[n-1]) / 
             (lakeData$age[n] - lakeData$age[n-1])
    extra_lake <- lakeData$lake[n] + slope * (extra_age - lakeData$age[n])
    extra_row <- data.frame(age = extra_age, lake = extra_lake)
    lake.trunc <- rbind(lake.trunc, extra_row)
  }
}

# interpolate linearly
lake.linterp.pred <- linterp(x = lake.trunc$age, 
                             y = lake.trunc$lake, 
                             x.out = pollenData$age)

plot(lake.trunc$age, lake.trunc$lake, type = "l", lwd = 2, main = "Lake Linear Interpolation")  # Fixed title
lines(lake.linterp.pred ~ pollenData$age, lwd = 1, col = "red")

############################
#### save interpolation #### 
############################

charcoalData.linterp <- data.frame("age" = pollenData$age,
                                   "charcoal" = char.linterp.pred)
write.table(x = charcoalData.linterp, 
            file = "./data_output/20200722_char_linterp.csv", 
            row.names = F, 
            col.names = T, 
            sep = ",")

lakeData.linterp <- data.frame("age" = pollenData$age,
                               "lake" = lake.linterp.pred)
write.table(x = lakeData.linterp, 
            file = "./data_output/20200722_lake_linterp.csv", 
            row.names = F, 
            col.names = T, 
            sep = ",")