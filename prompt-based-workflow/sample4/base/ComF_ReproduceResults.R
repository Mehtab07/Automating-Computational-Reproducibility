
## This code is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 2 of the License, or
## (at your option) any later version.
## 
## For a copy of the GNU General Public License, 
## see <http://www.gnu.org/licenses/>.

## (c) 2021 Sarah Humberg



# ................................................... ----
#
# Description ----
#
# ................................................... ----

# This R code accompanies the article "The True Role that Suppressor Effects Play in Condition-Based Regression Analysis: None. A reply to Fiedler (2021)"

# It contains code to reproduce all plots and results from the paper. 



# ................................................... ----
#
# Preparations ----
#
# ................................................... ----
sink("ComF_ReproduceResults_output.txt")

## load required packages ----

if(!require(mvtnorm)){install.packages("mvtnorm")}; library(mvtnorm)
if(!require(colorspace)){install.packages("colorspace")}; library(colorspace)

# install the developer version of RSA package used to plot the data, as it currently contains more options for coloring the points etc. than the version on CRAN
if(!require(devtools)){install.packages("devtools")}; library(devtools)
devtools::install_github("nicebread/RSA", ref="master")
library(RSA)

# load function to draw data and function to compute colors and point sizes that yield 3d effect
source("ComF_helpers.R")




# ................................................... ----
#
# Panels A and C: S-R Effect Pattern in Data With Suppressor Effect ----
#
# ................................................... ----


## draw data and estimate model ----

# draw data
dfAC <- drawdat(rSR = .4, rSH = .4, rRH = 0, n = 100000, seed = 18950)

# standardize the variables (to obtain standardized coefficients)
dfAC[,c("S","R","H")] <- data.frame(apply(dfAC[,c("S","R","H")], 2, scale))

# estimate the linear model
fitAC <- lm(H ~ S + R, data=dfAC)


## prepare plots: reduce the data ----

# chose axis limits for the plots
xlim = c(-2,2)
ylim = c(-2,2) 
zlim = c(-3,3) 

# reduce to a sample of 50 persons to be shown in the raw data plot (select only from those who are within the axis limits)
dfAC_raw <- dfAC[ dfAC$S >= xlim[1] & dfAC$S <= xlim[2] & dfAC$R >= ylim[1] & dfAC$R <= ylim[2] & dfAC$H >= zlim[1] & dfAC$H <= zlim[2], ]
dfAC_raw <- dfAC_raw[1:50,]
row.names(dfAC_raw) <- 1:nrow(dfAC_raw)


## show results that are reported in the article ----

# correlations
round(cor(dfAC_raw)["S","R"], 1)
round(cor(dfAC_raw)["S","H"], 1)
round(cor(dfAC_raw)["R","H"], 1)

# regression coefficients
round(coef(fitAC), 1)


## prepare plots: specify graphical attributes of the points ----

# compute colors and sizes of the points
colcex <- points3d(data=dfAC_raw, xname="S", yname="R", zname="H")

# chose 3 special points
left <- 11
right <- 24 
front <- 22

# specify stilts (only for the 3 special points)
stilt <- rep(FALSE, nrow(dfAC_raw))
stilt[c(left, right, front)] <- TRUE

# specify point sizes and colors for the raw data plot
cex_raw <- colcex$cex
cex_raw[c(left, right, front)] <- colcex$cex[c(left, right, front)] + 1

color_raw <- colcex$color
color_raw[left]  <- sequential_hcl("Blues 3",  n=1, l=100*rep(colcex$luminance[left],2))
color_raw[right] <- sequential_hcl("Greens 2", n=1, l=100*rep(colcex$luminance[right],2))
color_raw[front] <- sequential_hcl("Reds 2",   n=1, l=100*rep(colcex$luminance[front],2))

# specify point sizes and colors for the estimated model plot
cex_surf <- rep(.3, nrow(dfAC_raw))
cex_surf[c(left, right, front)] <- 2

color_surf <- rep("#000000", nrow(dfAC_raw))
color_surf[c(left, right, front)] <- color_raw[c(left, right, front)]


## plot Panel A ----

plotRSA(x=coef(fitAC)["S"],
        y=coef(fitAC)["R"],
        
        points=list(
          data=dfAC_raw[,c("S", "R", "H")], 
          color="black",
          fill=color_raw,
          cex=cex_raw,
          stilt=stilt,
          show=TRUE
        ), 
        
        xlim=xlim,
        ylim=ylim,
        zlim=zlim, 
        
        axes=c(), 
        project=c(),
        legend=F,
        param=F,
        
        suppress.surface = TRUE,
        
        xlab="Self-view S",
        ylab="Reality criterion R",
        zlab="Happiness H"
)


## plot Panel C ----

plotRSA(x=coef(fitAC)["S"],
        y=coef(fitAC)["R"],
        
        points=list(
          data=dfAC_raw[,c("S", "R", "H")], 
          value="predicted", 
          color="black",
          fill=color_surf,
          cex=cex_surf,
          stilt=stilt,
          show=TRUE
        ), 
        
        pal=divergingx_hcl("RdBu", n=20),
        
        xlim=xlim,
        ylim=ylim,
        zlim=zlim, 
        
        axes=c(), 
        project=c("contour"),
        legend=F,
        param=F,
        hull=F,
        
        xlab="Self-view S",
        ylab="Reality criterion R",
        zlab="Happiness H"
)




# ................................................... ----
#
# Panels B and D: PSV Effect Only Pattern ----
#
# ................................................... ----


## draw data and estimate model ----

# draw data
dfBD <- drawdat(rSR = .4, rSH = .6, rRH = .24, n = 100000, seed = 8932)

# standardize the variables (to obtain standardized coefficients)
dfBD[,c("S","R","H")] <- data.frame(apply(dfBD[,c("S","R","H")], 2, scale))

# estimate the linear model
fitBD <- lm(H ~ S + R, data=dfBD)


## prepare plots: reduce the data ----

# chose axis limits for the plots
xlim = c(-2,2)
ylim = c(-2,2) 
zlim = c(-3,3) 

# reduce to a sample of 50 persons to be shown in the raw data plot (select only from those who are within the axis limits)
dfBD_raw <- dfBD[ dfBD$S >= xlim[1] & dfBD$S <= xlim[2] & dfBD$R >= ylim[1] & dfBD$R <= ylim[2] & dfBD$H >= zlim[1] & dfBD$H <= zlim[2], ]
dfBD_raw <- dfBD_raw[1:50,]
row.names(dfBD_raw) <- 1:nrow(dfBD_raw)


## show results that are reported in the article ----

# correlations
round(cor(dfBD_raw)["S","R"], 1)
round(cor(dfBD_raw)["S","H"], 1)
round(cor(dfBD_raw)["R","H"], 1)

# regression coefficients
round(coef(fitBD), 1)


## prepare plots: specify graphical attributes of the points ----

# compute colors and sizes of the points
colcex <- points3d(data=dfBD_raw, xname="S", yname="R", zname="H")

# chose 3 special points
left <- 37
right <- 4
front <- 17

# specify stilts (only for the 3 special points)
stilt <- rep(FALSE, nrow(dfBD_raw))
stilt[c(left, right, front)] <- TRUE

# specify point sizes and colors for the raw data plot
cex_raw <- colcex$cex
cex_raw[c(left, right, front)] <- colcex$cex[c(left, right, front)] + 1

color_raw <- colcex$color
color_raw[left]  <- sequential_hcl("Blues 3",  n=1, l=100*rep(colcex$luminance[left],2))
color_raw[right] <- sequential_hcl("Greens 2", n=1, l=100*rep(colcex$luminance[right],2))
color_raw[front] <- sequential_hcl("Reds 2",   n=1, l=100*rep(colcex$luminance[front],2))

# specify point sizes and colors for the estimated model plot
cex_surf <- rep(.3, nrow(dfBD_raw))
cex_surf[c(left, right, front)] <- 2

color_surf <- rep("#000000", nrow(dfBD_raw))
color_surf[c(left, right, front)] <- color_raw[c(left, right, front)]

# extend xlim and ylim by a bit (for esthetic reasons)
xlim = c(-2.2,2.2)
ylim = c(-2.2,2.2) 

## plot Panel B ----

plotRSA(x=coef(fitBD)["S"],
        y=coef(fitBD)["R"],
        
        points=list(
          data=dfBD_raw[,c("S", "R", "H")], 
          color="black",
          fill=color_raw,
          cex=cex_raw,
          stilt=stilt,
          show=TRUE
        ), 
        
        xlim=xlim,
        ylim=ylim,
        zlim=zlim, 
        
        axes=c(), 
        project=c(),
        legend=F,
        param=F,
        
        suppress.surface = TRUE,
        
        xlab="Self-view S",
        ylab="Reality criterion R",
        zlab="Happiness H"
)


## plot Panel D ----

plotRSA(x=coef(fitBD)["S"],
        y=coef(fitBD)["R"],
        
        points=list(
          data=dfBD_raw[,c("S", "R", "H")], 
          value="predicted", 
          color="black",
          fill=color_surf,
          cex=cex_surf,
          stilt=stilt,
          show=TRUE
        ), 
        
        pal=divergingx_hcl("RdBu", n=20),
        
        xlim=xlim,
        ylim=ylim,
        zlim=zlim, 
        
        axes=c(), 
        project=c("contour"),
        legend=F,
        param=F,
        hull=F,
        
        xlab="Self-view S",
        ylab="Reality criterion R",
        zlab="Happiness H"
)

sink()
