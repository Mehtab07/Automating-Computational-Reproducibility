
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

# It provides the R code that is shown in the file ComF_Supplement.pdf



# ................................................... ----
#
# Section 1.2: Computational Examples ----
#
# ................................................... ----

sink("ComF_SOM_output.txt")
## define function that computes standardized coefficients from arbitrary correlations ----
betas <- function(rSR, rSH, rRH, 
                  sdS=1, sdR=1, sdH=1){
  
  c1 <- ( ( rSH - rSR*rRH ) / (1 - rSR^2 ) ) * ( sdH/sdS )
  c2 <- ( ( rRH - rSR*rSH ) / (1 - rSR^2 ) ) * ( sdH/sdR )
  
  return(list(c1=c1, c2=c2))
}


## create table that shows all conditions from Fiedler's Table 1 ----

# chose values of rSR and rSH 
rSR.list <- c(.2, .4, .6, .8)
rSH.list <- c(.2, .4, .6, .8)

# generate empty object to store the results
res_betas <- NULL

# compute the coefficients
for(irSR in rSR.list) {

  for(irSH in rSH.list) {

    # compute betas
    b <- betas(rSR=irSR, rSH=irSH, rRH=0)
    
    # save results
    res_betas <- rbind(res_betas, data.frame(rSR=irSR, rSH=irSH, c1=b$c1, c2=b$c2) )
  }
}

# remove results for rSR = rSH = .8
res_betas <- res_betas[!(res_betas$rSR==.8 & res_betas$rSH==.8),]

# inspect
round(res_betas, 3)


# ................................................... ----
#
# Section 1.3: Simulated Examples ----
#
# ................................................... ----

if(!require(mvtnorm)){install.packages("mvtnorm")}; library(mvtnorm)


## define function drawdat() to draw the data ----

drawdat <- function(rSR, rSH, rRH, 
                    n = 100,
                    mS = 0, mR = 0, mH = 0, # means
                    sdS = 1, sdR = 1, sdH = 1, # SDs
                    seed = 1909
                    ){
  
  # compute variances
  vS <- sdS^2
  vR <- sdR^2
  vH <- sdH^2
  
  # compute covariances
 "missing code"
  
  # set a seed so that results will be reproducible
  set.seed(seed)

  # draw data from multivariate normal distribution
  dat <- rmvnorm(n, mean=c(mS, mR, mH), 
                 sigma=matrix(c(vS, covSR, covSH,
                                covSR, vR, covRH, 
                                covSH, covRH, vH), 
                              ncol=3))

  # prettify the data
  dat <- as.data.frame(dat)
  names(dat) <- c("S", "R", "H")

  # return the data
  return(dat)
}


## For example: ----

# draw data
mydata <- drawdat(rSR = .4, rSH = .4, rRH = 0, n = 5)

# inspect the data
mydata

# plot the data
if(!require(RSA)){install.packages("RSA")}; library(RSA)

plotRSA(points=list( data=mydata[,c("S","R","H")], show=TRUE, cex=3), 
        suppress.surface=TRUE, param=FALSE, legend=FALSE)



## Reproduce Fiedler's simulation study ----

# specify correlations
rSR.list <- c(.2, .3, .4, .5, .6, .7, .8, .9)
rSH.list <- c(0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1)
rRH.list <- c(0)

result <- NULL

# run the simulation
for(irSR in rSR.list) {
  
  for(irSH in rSH.list) {
    
    for(irRH in rRH.list) {

    # draw data
    data <- drawdat(rSR = irSR, rSH = irSH, rRH = irRH, n = 100)
    
    # standardize the variables (to obtain standardized coefficients)
    data <- data.frame(apply(data, 2, scale))
    
    # estimate the linear model
    fit <- lm(H ~ S + R, data=data)
    
    # extract coefficients
    coefs <- summary(fit)$coefficients

    # store the results
    result <- rbind(result, 
                    
                    data.frame(
                      rSR = irSR, 
                      rSH = irSH, 
                      rRH = irRH,
                      
                      c1 = coefs["S", "Estimate"], 
                      c2 = coefs["R", "Estimate"]) )
    }
  }
}

# show results
result

# show only excerpt of results as in Fiedler's Table 1
result_sel <- result[result$rSR %in% c(.2, .4, .6, .8) & result$rSH %in% c(.2, .4, .6, .8), ]
result_sel <- result_sel[!(result_sel$rSR==.8 & result_sel$rSH==.8),]
round(result_sel, 3)



## Create figure with simulation results ----

### load required packages for plotting ----

if(!require(ggplot2)){install.packages("ggplot2")}; library(ggplot2)
if(!require(lemon)){install.packages("lemon")}; library(lemon) # enables shared legends


### reduce data to be shown ----

# compute lagged differences
result$diff_c1 <- result$c1 - c(0, result$c1[1:(nrow(result)-1)])
result$diff_c2 <- result$c2 - c(0, result$c2[1:(nrow(result)-1)])

# filter dataset
result_c1 <- result[result$diff_c1 > 0 | result$rSH < .3,] 
result_c2 <- result[result$diff_c2 < 0 | result$rSH < .3,]


### prepare styles ----

# theme
theme <- theme(panel.background = element_blank(),                      
               panel.grid.major.y = element_line(colour = "grey90"),
               axis.ticks.x=element_blank(),
               axis.ticks.y=element_blank(),
               axis.title.y = element_text(hjust = 1, angle = 0),
               axis.text = element_text(size = 15),               # x axis text
               axis.title = element_text(size = 15),              # axis labels
               legend.text = element_text(size = 15),             # legend text
               legend.title = element_text(size=15),              # legend label
               legend.position='none')

# scales
scale_y <- scale_y_continuous(breaks = seq(-2, 2, 0.5), limits = c(-2, 2.3)) 
scale_x <- scale_x_continuous(breaks = seq(0, 1, 0.1))

# colors for points
result$rSR <- factor(result$rSR)
result_c1$rSR <- factor(result_c1$rSR)
result_c2$rSR <- factor(result_c2$rSR)

my_colors_points <- c("grey", "grey", "grey", "grey", "darkgreen", "darkblue", "blue", "darkred")
names(my_colors_points) <- levels(result$rSR) # name the colors
scale_color_points <-  scale_fill_manual(values = my_colors_points)

# colors for lines
my_colors_lines <- c("grey", "grey", "grey", "grey", "black", "black", "black", "black")
names(my_colors_lines) <- levels(result$rSR) # name the colors
scale_color_lines <- scale_color_manual(name = "rSR", values = my_colors_lines)

# linetypes  for lines
my_lines <- c( "solid", "solid", "solid", "solid", "dotted", "dashed", "longdash", "solid")
names(my_lines) <- levels(result$rSR) #name the lines
scale_linetype <- scale_linetype_manual(name = "rSR", values = my_lines)  


### plot ----

# plot for c1
p1 <- ggplot(result_c1, aes(group = rSR)) +
  geom_point(aes(rSH, c1, fill = rSR), size=3, shape =21, stroke=0) +
  scale_color_points +
  geom_line(aes(rSH, c1, linetype = rSR, color = rSR)) +
  scale_color_lines +
  scale_linetype +
  theme + 
  scale_y +
  scale_x 

# plot for c2
p2 <- ggplot(result_c2, aes(group = rSR)) +
  geom_point(aes(rSH, c2, fill = rSR), size=3, shape=21, stroke=0) +
  scale_color_points +
  geom_line(aes(rSH, c2, linetype = rSR, color = rSR)) +
  scale_color_lines +
  scale_linetype +
  theme +
  scale_y +
  scale_x 

# show both in one grid
grid_arrange_shared_legend(p1,p2)




# ................................................... ----
#
# Section 2: Inspect Example Data With Arbitrary PPZ-Correlation-Structures ----
#
# ................................................... ----


if(!require(RSA)){install.packages("RSA")}

# draw data for arbitrary choices of the correlations 
# Note: set the sample size n to quite a large number to achieve that the
# correlations in the random sample will be close to those chosen for the
# population model.
mydata <- drawdat(rSR = .4, rSH = .8, rRH = 0, n = 100000)

# show the correlations in the random sample (as a check)
cor(mydata)

# estimate the linear model
fit <- lm(H ~ S + R, data=mydata)

# inspect CRA results: inspect the coefficients
coefs <- summary(fit)$coefficients
coefs

# save coefficients to use them for the plot
c0 <- coefs["(Intercept)", "Estimate"]
c1 <- coefs["S", "Estimate"]
c2 <- coefs["R", "Estimate"]

# plot the estimated model (show only 100 data points); 
# for rather flat surfaces, adapt the z axis limits: e.g., zlim=c(-2,2)
RSA::plotRSA(b0=c0, x=c1, y=c2,
             xlim=c(-3,3), ylim=c(-3,3), zlim=c(-4,4), 
             points=list( data=mydata[1:100,c("S","R","H")], values="predicted" ), 
             axes=c(), hull=F, param=F, legend=F)




# ................................................... ----
#
# Section 3: Suppressor Effects are Unconnected to S-R Effect Patterns: Empirical Illustration ----
#
# ................................................... ----

## This code reproduces the plots that demonstrate the irrelevance of
## suppressor effects for the occurrence of S-R effect patterns.


## load required packages ----

if(!require(mvtnorm)){install.packages("mvtnorm")}; library(mvtnorm)
if(!require(colorspace)){install.packages("colorspace")}; library(colorspace)

# install the developer version of RSA package used to plot the data, as it currently contains more options for coloring the points etc. than the version on CRAN
# if(!require(devtools)){install.packages("devtools")}; library(devtools)
# devtools::install_github("nicebread/RSA", ref="master")
# library(RSA)

# load function to draw data and function to compute colors and point sizes that yield 3d effect
source("ComF_helpers.R")



# ................................................... ----
#
# SOM Panels (a) and (d): ----
# S-R Effect Pattern in Data With Suppressor Effect



## draw data and estimate model ----

# draw data
dfAD <- drawdat(rSR = .4, rSH = .4, rRH = 0, n = 100000, seed = 18950)

# standardize the variables (to obtain standardized coefficients)
dfAD[,c("S","R","H")] <- data.frame(apply(dfAD[,c("S","R","H")], 2, scale))

# estimate the linear model
fitAD <- lm(H ~ S + R, data=dfAD)


## prepare plots: reduce the data ----

# chose axis limits for the plots
xlim = c(-2,2)
ylim = c(-2,2) 
zlim = c(-3,3) 

# reduce to a sample of 50 persons to be shown in the raw data plot (select only from those who are within the axis limits)
dfAD_raw <- dfAD[ dfAD$S >= xlim[1] & dfAD$S <= xlim[2] & dfAD$R >= ylim[1] & dfAD$R <= ylim[2] & dfAD$H >= zlim[1] & dfAD$H <= zlim[2], ]
dfAD_raw <- dfAD_raw[1:50,]
row.names(dfAD_raw) <- 1:nrow(dfAD_raw)


## show results that are reported in the main text ----

# correlations
round(cor(dfAD_raw)["S","R"], 1)
round(cor(dfAD_raw)["S","H"], 1)
round(cor(dfAD_raw)["R","H"], 1)

# regression coefficients
round(coef(fitAD), 1)


## prepare plots: specify graphical attributes of the points ----

# compute colors and sizes of the points
colcex <- points3d(data=dfAD_raw, xname="S", yname="R", zname="H")

# chose 3 special points
left <- 11
right <- 24 
front <- 22

# specify stilts (only for the 3 special points)
stilt <- rep(FALSE, nrow(dfAD_raw))
stilt[c(left, right, front)] <- TRUE

# specify point sizes and colors for the raw data plot
cex_raw <- colcex$cex
cex_raw[c(left, right, front)] <- colcex$cex[c(left, right, front)] + 1

color_raw <- colcex$color
color_raw[left]  <- sequential_hcl("Blues 3",  n=1, l=100*rep(colcex$luminance[left],2))
color_raw[right] <- sequential_hcl("Greens 2", n=1, l=100*rep(colcex$luminance[right],2))
color_raw[front] <- sequential_hcl("Reds 2",   n=1, l=100*rep(colcex$luminance[front],2))

# specify point sizes and colors for the estimated model plot
cex_surf <- rep(.3, nrow(dfAD_raw))
cex_surf[c(left, right, front)] <- 2

color_surf <- rep("#000000", nrow(dfAD_raw))
color_surf[c(left, right, front)] <- color_raw[c(left, right, front)]


## plot Panel (a) ----

plotRSA(x=coef(fitAD)["S"],
        y=coef(fitAD)["R"],
        
        points=list(
          data=dfAD_raw[,c("S", "R", "H")], 
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


## plot Panel (d) ----

plotRSA(x=coef(fitAD)["S"],
        y=coef(fitAD)["R"],
        
        points=list(
          data=dfAD_raw[,c("S", "R", "H")], 
          value="predicted", 
          color="black",
          fill=color_surf,
          cex=cex_surf,
          stilt=stilt,
          show=TRUE
        ), 
        
        
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
# SOM Panels (b) + (e): ----
# S-R Effect Pattern in Data Without Suppressor Effect


## draw data and estimate model ----

# draw data
dfBE <- drawdat(rSR = 0, rSH = 0.4797, rRH = -0.1959, n = 100000, seed = 2256)

# standardize the variables (to obtain standardized coefficients)
dfBE[,c("S","R","H")] <- data.frame(apply(dfBE[,c("S","R","H")], 2, scale))

# estimate the linear model
fitBE <- lm(H ~ S + R, data=dfBE)


## prepare plots: reduce the data ----

# chose axis limits for the plots
xlim = c(-2,2)
ylim = c(-2,2) 
zlim = c(-3,3) 

# reduce to a sample of 50 persons to be shown in the raw data plot (select only from those who are within the axis limits)
dfBE_raw <- dfBE[ dfBE$S >= xlim[1] & dfBE$S <= xlim[2] & dfBE$R >= ylim[1] & dfBE$R <= ylim[2] & dfBE$H >= zlim[1] & dfBE$H <= zlim[2], ]
dfBE_raw <- dfBE_raw[1:50,]
row.names(dfBE_raw) <- 1:nrow(dfBE_raw)


## show results that are reported in the main text ----

# correlations
round(cor(dfBE_raw)["S","R"], 1)
round(cor(dfBE_raw)["S","H"], 1)
round(cor(dfBE_raw)["R","H"], 1)

# regression coefficients
round(coef(fitBE), 1)


## prepare plots: specify graphical attributes of the points ----

# compute colors and sizes of the points
colcex <- points3d(data=dfBE_raw, xname="S", yname="R", zname="H")

# chose 3 special points
left <- 10
right <- 3
front <- 28

# specify stilts (only for the 3 special points)
stilt <- rep(FALSE, nrow(dfBE_raw))
stilt[c(left, right, front)] <- TRUE

# specify point sizes and colors for the raw data plot
cex_raw <- colcex$cex
cex_raw[c(left, right, front)] <- colcex$cex[c(left, right, front)] + 1

color_raw <- colcex$color
color_raw[left]  <- sequential_hcl("Blues 3",  n=1, l=100*rep(colcex$luminance[left],2))
color_raw[right] <- sequential_hcl("Greens 2", n=1, l=100*rep(colcex$luminance[right],2))
color_raw[front] <- sequential_hcl("Reds 2",   n=1, l=100*rep(colcex$luminance[front],2))

# specify point sizes and colors for the estimated model plot
cex_surf <- rep(.3, nrow(dfBE_raw))
cex_surf[c(left, right, front)] <- 2

color_surf <- rep("#000000", nrow(dfBE_raw))
color_surf[c(left, right, front)] <- color_raw[c(left, right, front)]


## plot Panel (b) ----

plotRSA(x=coef(fitBE)["S"],
        y=coef(fitBE)["R"],
        
        points=list(
          data=dfBE_raw[,c("S", "R", "H")], 
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


## plot Panel (e) ----

plotRSA(x=coef(fitBE)["S"],
        y=coef(fitBE)["R"],
        
        points=list(
          data=dfBE_raw[,c("S", "R", "H")], 
          value="predicted", 
          color="black",
          fill=color_surf,
          cex=cex_surf,
          stilt=stilt,
          show=TRUE
        ), 
        
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
# SOM Panels (c) and (f): ----
# PSV Effect Only Pattern


## draw data and estimate model ----

# draw data
dfCF <- drawdat(rSR = 0, rSH = .6, rRH = 0, n = 100000, seed = 2567)

# standardize the variables (to obtain standardized coefficients)
dfCF[,c("S","R","H")] <- data.frame(apply(dfCF[,c("S","R","H")], 2, scale))

# estimate the linear model
fitCF <- lm(H ~ S + R, data=dfCF)


## prepare plots: reduce the data ----

# chose axis limits for the plots
xlim = c(-2,2)
ylim = c(-2,2) 
zlim = c(-3,3) 

# reduce to a sample of 50 persons to be shown in the raw data plot (select only from those who are within the axis limits)
dfCF_raw <- dfCF[ dfCF$S >= xlim[1] & dfCF$S <= xlim[2] & dfCF$R >= ylim[1] & dfCF$R <= ylim[2] & dfCF$H >= zlim[1] & dfCF$H <= zlim[2], ]
dfCF_raw <- dfCF_raw[1:50,]
row.names(dfCF_raw) <- 1:nrow(dfCF_raw)

# remove one point that would cover the stilt of the blue point
dfCF_raw <- dfCF_raw[-6,]
row.names(dfCF_raw) <- 1:nrow(dfCF_raw)


## show results that are reported in the main text ----

# correlations
round(cor(dfCF_raw)["S","R"], 1)
round(cor(dfCF_raw)["S","H"], 1)
round(cor(dfCF_raw)["R","H"], 1)

# regression coefficients
round(coef(fitCF), 1)


## prepare plots: specify graphical attributes of the points ----

# compute colors and sizes of the points
colcex <- points3d(data=dfCF_raw, xname="S", yname="R", zname="H")

# chose 3 special points
left <- 3
right <- 46
front <- 24

# specify stilts (only for the 3 special points)
stilt <- rep(FALSE, nrow(dfCF_raw))
stilt[c(left, right, front)] <- TRUE

# specify point sizes and colors for the raw data plot
cex_raw <- colcex$cex
cex_raw[c(left, right, front)] <- colcex$cex[c(left, right, front)] + 1

color_raw <- colcex$color
color_raw[left]  <- sequential_hcl("Blues 3",  n=1, l=100*rep(colcex$luminance[left],2))
color_raw[right] <- sequential_hcl("Greens 2", n=1, l=100*rep(colcex$luminance[right],2))
color_raw[front] <- sequential_hcl("Reds 2",   n=1, l=100*rep(colcex$luminance[front],2))

# specify point sizes and colors for the estimated model plot
cex_surf <- rep(.3, nrow(dfCF_raw))
cex_surf[c(left, right, front)] <- 2

color_surf <- rep("#000000", nrow(dfCF_raw))
color_surf[c(left, right, front)] <- color_raw[c(left, right, front)]


## plot Panel (c) ----

plotRSA(x=coef(fitCF)["S"],
        y=coef(fitCF)["R"],
        
        points=list(
          data=dfCF_raw[,c("S", "R", "H")], 
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


## plot Panel (f) ----

plotRSA(x=coef(fitCF)["S"],
        y=coef(fitCF)["R"],
        
        points=list(
          data=dfCF_raw[,c("S", "R", "H")], 
          value="predicted", 
          color="black",
          fill=color_surf,
          cex=cex_surf,
          stilt=stilt,
          show=TRUE
        ), 
        
        
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
