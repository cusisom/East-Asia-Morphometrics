# Project 3 Processing Code
#Primary objectives: Consolidate Data, Check for Errors, and develop Data Dictionary

## ---- loadpackages --------

require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 
require(geomorph)
require(knitr) 
require(gapminder)



## ---- loaddata ---------
#path to data

data_location1 <- "../../Data/Processed_data/Japan_array.rds"
data_location2 <- "../../Data/Processed_data/Korea_array.rds"
data_path <- "../../Data/Raw_data/"

d1array <- readRDS(data_location1)


## ---- Step1 --------
#From here it looks like d2 is ready for analysis
#d1 is the complete dataset for Japan
#d1array is the needed landmark data without the population and sex information in an array structure

d1array.gpa <- gpagen(d1array, print.progress=FALSE)

summary(d1array.gpa)
plot(d1array)