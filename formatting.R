rm(list=ls())
setwd(".../Spatial Data & GIS/Final Project/Data")


## function to format business pattern data from the census
bpdataformat <- function(filename){
  
  library(reshape)
  library(zipcode)
  
  ## read file
  data <- read.csv(filename)
  
  ## restore leading zeroes to zips
  data$zip <- clean.zipcodes(data$zip)
  
  ## extract aggregate industry data (NAICS ~ "xx----")
  trunc <- substr(data[,"naics"],3,6) == "----"
  agg <- data[trunc,]
  
  ## melt and recast data -> one row per zipcode
  melted<-melt(agg,id=c("zip","naics"))
  return(cast(melted, zip ~ naics + ...))
}

data12 <- bpdataformat("zbp12detail.txt")
