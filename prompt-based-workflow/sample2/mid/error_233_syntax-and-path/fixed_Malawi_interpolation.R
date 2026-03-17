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

pollenData <- read.csv("data_input/20200722_pollen.csv") # Fixed path from input/data_input/ to data_input/
lakeData <- read.csv("data_input/20200722_lake.csv") # Fixed path from input/data_input/ to data_input/
charcoalData <- read.csv("data_input/20200722_charcoal.csv") # Fixed path from input/data_input/ to data_input/

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

# Check if maximum pollen age is within range of charcoal data
if(max(pollenData$age) <= max(charcoalData$age)) {
  # index of the smallest charcoal age greater than the greatest pollen age
  last.age.char <- min(which(charcoalData$age > max(pollenData$age)))
  # truncate the charcoal data to just what is needed
  char.trunc <- charcoalData[1:last.age.char,]
} else {
  # if pollen data extends beyond charcoal data, use all charcoal data
  char.trunc <- charcoalData
  warning("Pollen data extends beyond charcoal data range. Using all charcoal data for interpolation.")
}

# interpolate linearly
char.linterp.pred <- linterp(x = char.trunc$age, 
                             y = char.trunc$charcoal, 
                             x.out = pollenData$age)

plot(char.trunc$age, char.trunc$charcoal, type = "l", lwd = 2, main = "Charcoal Linear Interpolation") # Fixed plotting
lines(pollenData$age, char.linterp.pred, lwd = 1, col = "red") # Fixed plotting

# Check if maximum pollen age is within range of lake data
if(max(pollenData$age) <= max(lakeData$age)) {
  # index of the smallest lake level age greater than the greatest pollen age
  last.age.lake <- min(which(lakeData$age > max(pollenData$age)))
  # truncate the lake level data to just what is needed
  lake.trunc <- lakeData[1:last.age.lake,]
} else {
  # if pollen data extends beyond lake data, use all lake data
  lake.trunc <- lakeData
  warning("Pollen data extends beyond lake data range. Using all lake data for interpolation.")
}

# interpolate linearly
lake.linterp.pred <- linterp(x = lake.trunc$age, 
                             y = lake.trunc$lake, 
                             x.out = pollenData$age)

plot(lake.trunc$age, lake.trunc$lake, type = "l", lwd = 2, main = "Lake Linear Interpolation") # Fixed plotting and title
lines(pollenData$age, lake.linterp.pred, lwd = 1, col = "red") # Fixed plotting

############################
#### save interpolation #### 
############################

charcoalData.linterp <- data.frame("age" = pollenData$age,
                                   "charcoal" = char.linterp.pred)
write.table(x = charcoalData.linterp, 
            file = "data_output/20200722_char_linterp.csv", # Fixed path from ./data_output/ to data_output/
            row.names = F, 
            col.names = T, 
            sep = ",")

lakeData.linterp <- data.frame("age" = pollenData$age,
                               "lake" = lake.linterp.pred)
write.table(x = lakeData.linterp, 
            file = "data_output/20200722_lake_linterp.csv", # Fixed path from ./data_output/ to data_output/
            row.names = F, 
            col.names = T, 
            sep = ",")