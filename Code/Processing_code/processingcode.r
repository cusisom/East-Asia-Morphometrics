# Project 3 Processing Code
#Primary objectives: Consolidate Data, Check for Errors, and develop Data Dictionary

## ---- loadpackages --------

require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 
require(geomorph)


## ---- loaddata ---------
#path to data

data_location <- "../../Data/Raw_data/Raw_Japan.csv"
data_path <- "../../Data/Raw_data/"

#I need to read in the rawdata.
#Can I read separate .csv files?

rawdata <- read.csv(data_location, check.names=FALSE)
rawdata$ID <- as.factor(rawdata$ID)


## ---- viewdata1 --------

skim(rawdata)

## ---- datadictionary1 --------

dictionary1 <- read.csv(paste(data_path, "Cranial_landmarks.csv", sep=""))
print(dictionary1)