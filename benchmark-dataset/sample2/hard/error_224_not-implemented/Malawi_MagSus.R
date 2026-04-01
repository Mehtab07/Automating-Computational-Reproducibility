# rm(list = ls())
start_time <- Sys.time()
graphics.off()

library(openxlsx)

linterp <- function(x, y, x.out){
  stop("not implemented")
    }
  }
  
  return(y.out)
}

magSus <- read.table(file = "./data_input/magSus.csv", header = T, sep = ",")
colnames(magSus) <- c("depth", "age", "gammaDensity", "MS")

char <- read.table(file = "./data_input/magSus_charcoal.csv", header = T, sep = ",")
colnames(char) <- c("age", "char", "lake")

MSdownsampled <- cbind("age" = char$age,
                       "MS_downsampled" = linterp(x = magSus$age,
                                                  y = magSus$MS, 
                                                  x.out = char$age))

write.table(x = MSdownsampled, 
            file = "./data_output/MagSusDownsampled.csv", 
            row.names = F, 
            sep = ",")

core2a_Charcoal <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 1)
core2a_MagSus <- read.xlsx(xlsxFile = "./data_input/Core2A_MagSusCharcoal.xlsx", sheet = 2)
core2a_downsampled <- cbind("Depth" = core2a_Charcoal$Depth,
                            "MS_downsampled" = linterp(x = core2a_MagSus$Depth,
                                                       y = core2a_MagSus$MagSus,
                                                       x.out = core2a_Charcoal$Depth))
write.table(x = core2a_downsampled, 
            file = "./data_output/Core2A_MagSusDownsampled.csv", 
            row.names = F, 
            sep = ",")
