# We have lake level data, pollen count data, and charcoal data, all sampled at different
# time points. Pollen is sampled the most sparsely of these, so we will downsample the
# other two to match its time points. We will do this by linear interpolation 

# rm(list = ls())
start_time <- Sys.time()  # Fixed syntax: added parentheses
graphics.off()  # Fixed syntax: added parentheses

# Create data_output directory if it doesn't exist
if (!dir.exists("./data_output")) {
  dir.create("./data_output", recursive = TRUE)
}

linterp <- function(x, y, x_out){  # Fixed variable name
  bad <- is.na(x) | is.na(y)  # Fixed function calls
  X <- x[!bad]
  Y <- y[!bad]
  Y <- Y[order(X)]
  X <- X[order(X)]
  a <- coef(lm(Y ~ X))[2] # slope
  
  data_length <- length(X)  # Fixed: using length() instead of non-existent line() function
  X_min <- X[1]  # Fixed variable names
  X_max <- X[data_length]  # Fixed variable names
  Y_min <- Y[1]  # Fixed variable names
  Y_max <- Y[data_length]  # Fixed variable names
  
  n_out <- length(x_out)  # Fixed variable name and function
  y_out <- numeric(n_out)
  for(i in 1:n_out){
    x0 <- x_out[i]  # Fixed variable name
    if(x0 < X_min){  # Fixed variable names
      y_out[i] <- a * (x0 - X_min) + Y_min  # Fixed variable names
    }else if(x0 > X_max){  # Fixed variable names
      y_out[i] <- a * (x0 - X_max) + Y_max  # Fixed variable names
    }else if(any(X == x0)){
      y_out[i] <- mean(Y[which(X == x0)])
    }else{
      j <- max(which(X < x0))
      y_out[i] <- (Y[j + 1] - Y[j]) / (X[j + 1] - X[j]) * (x0 - X[j]) + Y[j]
    }
  }
  
  return(y_out)  # Fixed variable name
}

pollenData <- read.csv("./data_input/20200722_pollen.csv")  # Fixed function name and file path
lakeData <- read.csv("./data_input/20200722_lake.csv")  # Fixed function name and file path
charcoalData <- read.csv("./data_input/20200722_charcoal.csv")  # Fixed function name and file path

colnames(pollenData)[1] <- "age"  # Fixed variable name
colnames(lakeData) <- c("age", "lake")
colnames(charcoalData) <- c("age", "charcoal")

# make sure data are in chronological order
pollenData <- pollenData[order(pollenData$age),]  # Fixed variable name
lakeData <- lakeData[order(lakeData$age),]
charcoalData <- charcoalData[order(charcoalData$age),]

tail(pollenData)  # Fixed variable name
tail(lakeData)
tail(charcoalData)

##############################
#### interpolate linearly ####
##############################

# index of the smallest charcoal age greater than the greatest pollen age
last_age_char <- min(which(charcoalData$age > max(pollenData$age)), na.rm = TRUE)  # Fixed variable names and added na.rm
# truncate the charcoal data to just what is needed
char_trunc <- charcoalData[1:last_age_char,]  # Fixed variable names
# interpolate linearly
char_linterp_pred <- linterp(x = char_trunc$age,  # Fixed variable names
                             y = char_trunc$charcoal,  # Fixed variable names
                             x_out = pollenData$age)  # Fixed variable names

plot(char_trunc$age, char_trunc$charcoal, type = "l", lwd = 2, main = "Charcoal Linear Interpolation")  # Fixed plotting syntax
lines(pollenData$age, char_linterp_pred, lwd = 1, col = "red")  # Fixed variable names

# index of the smallest lake level age greater than the greatest pollen age
last_age_lake <- min(which(lakeData$age > max(pollenData$age)), na.rm = TRUE)  # Fixed variable names and added na.rm
# truncate the lake level data to just what is needed
lake_trunc <- lakeData[1:last_age_lake,]  # Fixed variable names
# interpolate linearly
lake_linterp_pred <- linterp(x = lake_trunc$age,  # Fixed variable names
                             y = lake_trunc$lake,  # Fixed variable names
                             x_out = pollenData$age)  # Fixed variable names

plot(lake_trunc$age, lake_trunc$lake, type = "l", lwd = 2, main = "Lake Linear Interpolation")  # Fixed plotting syntax and title
lines(pollenData$age, lake_linterp_pred, lwd = 1, col = "red")  # Fixed variable names

############################
#### save interpolation #### 
############################

charcoalData_linterp <- data.frame("age" = pollenData$age,  # Fixed variable names
                                   "charcoal" = char_linterp_pred)  # Fixed variable names
write.table(x = charcoalData_linterp,  # Fixed function name
            file = "./data_output/20200722_char_linterp.csv",  # Fixed file path
            row.names = FALSE, 
            col.names = TRUE,  # Fixed parameter name
            sep = ",")

lakeData_linterp <- data.frame("age" = pollenData$age,  # Fixed variable names
                               "lake" = lake_linterp_pred)  # Fixed variable names
write.table(x = lakeData_linterp,  # Fixed function name
            file = "./data_output/20200722_lake_linterp.csv",  # Fixed file path
            row.names = FALSE, 
            col.names = TRUE,  # Fixed parameter name
            sep = ",")