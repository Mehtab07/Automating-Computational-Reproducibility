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

# It defines functions that are used in the other R scripts.



## define function to draw data ----

drawdat <- function(rSR, rSH, rRH,  # Fixed: Added missing <- and (
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
  covSR <- rSR*sdS*sdR
  covSH <- rSH*sdS*sdH
  covRH <- rRH*sdR*sdH
  
  # set a seed so that results will be reproducible
  set.seed(seed)
  
  # draw data from multivariate normal distribution
  dat <- rmvnorm(n, mean=c(mS, mR, mH),  # Fixed: meanc -> mean
                 sigma=matrix(c(vS, covSR, covSH,
                                covSR, vR, covRH, 
                                covSH, covRH, vH), 
                              ncol=3))
  
  # prettify the data
  dat <- as.data.frame(dat)  # Fixed: asdataframe -> as.data.frame
  names(dat) <- c("S", "R", "H")
  
  # return the data
  return(dat)
}


## define function to compute colors and point sizes that yield 3d effect ----

points3d <- function(data, 
                     xname, yname, zname,
                     cex.limit.close = 1.7, cex.limit.far = 1,
                     col.limit.close = 0.1, col.limit.far = 0.8, 
                     adapted_eye = list(x=-12, y=-16, z=2)
){
  
  ## determine position in the middle of the coordinate system
  # Define xlim, ylim, zlim based on data range since they're not defined
  xlim <- range(data[,xname])  # Added: Define xlim from data
  ylim <- range(data[,yname])  # Added: Define ylim from data
  zlim <- range(data[,zname])  # Added: Define zlim from data
  
  middle <- list( x = min(xlim) + .5*abs(max(xlim) - min(xlim)),
                  y = min(ylim) + .5*abs(max(ylim) - min(ylim)),
                  z = min(zlim) + .5*abs(max(zlim) - min(zlim))
  )
  
  
  ## compute distance between plane through the point adapted_eye and the data
  
  # normal vector of the plane = directional vector of the sight axis
  n <- mapply('-', adapted_eye, middle, SIMPLIFY = FALSE)
  
  # make a plane parallel to the z axis
  n$z <- 0
  
  # position vector of the plane
  a <- adapted_eye
  
  # for each row of the data, compute euclidean distance between the person's 3-dim point and the plane
  distance <- abs( (data[,xname] - a$x) * n$x + (data[,yname] - a$y) * n$y + (data[,zname] - a$z) * n$z ) / sqrt(n$x^2 + n$y^2 + n$z^2)
  
  
  ## define point colors depending on their distance to the eye
  
  # the linear function to transform distance into gray level has the following slope and intercept:
  col.slope <- ( col.limit.far - col.limit.close ) / ( max(distance) - min(distance) )
  col.intercept <- col.limit.close - col.slope * min(distance)
  
  # compute luminance per point
  luminance <- unname(sapply(distance, 
                             FUN = function(x){
                               col.intercept + col.slope * x
                             }))
  
  # compute color per point
  color <- sapply(luminance, 
                  FUN = function(x){
                    rgb(x,x,x)
                  })
  
  
  ## define point sizes depending on their distance to the eye
  
  # the linear function to transform distance into cex has the following slope and intercept:
  cex.slope <- ( cex.limit.far - cex.limit.close ) / ( max(distance) - min(distance) )
  cex.intercept <- cex.limit.close - cex.slope * min(distance)
  
  # compute cex per point
  cex <- cex.intercept + cex.slope * distance
  
  
  ## build output
  
  return(list(distance=distance, color=color, luminance=luminance, cex=cex))
  
}