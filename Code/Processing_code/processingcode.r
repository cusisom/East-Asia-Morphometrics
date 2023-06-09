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

data_location1 <- "../../Data/Raw_data/Raw_Japan.csv"
data_location2 <- "../../Data/Raw_data/Raw_korea.csv"
data_path <- "../../Data/Raw_data/"
d2 <- read.csv(paste(data_path, "Raw_classifiers.csv", sep=""))

#I need to read in the rawdata.

rawdata1 <- read.csv(data_location1, check.names=FALSE)
rawdata1$ID <- as.factor(rawdata1$ID)


## ---- viewdata1 --------

sk1 <- skim(rawdata1)
sk1 <- as.data.frame(sk1)

## ---- viewdata1.1 --------

head(sk1)
kable(rawdata1[1:10, ])

## ---- viewdata2 --------

rawdata2 <- read.csv(data_location2, check.names=FALSE)
rawdata2$ID <- as.factor(rawdata2$ID)
sk2 <- skim(rawdata2)
sk2 <- as.data.frame(sk2)

head(sk2)
kable(rawdata2[1:6, ])


## ---- datadictionary1 --------
colnames(rawdata1)

dictionary1 <- read.csv(paste(data_path, "Cranial_landmarks.csv", sep=""))
knitr::kable(dictionary1)

save_data_location_csv <- "../../Data/Processed_data/datadictionary.csv"
write.csv(dictionary1, file = save_data_location_csv, row.names=FALSE)

## ---- demdata --------

# Editing for Visualization

skim(d2)
kable(d2[1:10, ])

d2 <- subset(d2, select = -c(Period))
kable(d2[1:10, ])

ii <- grep("JM", d2$Sex)
d2$Sex[ii] <- "Male"

ii <- grep("KM", d2$Sex)
d2$Sex[ii] <- "Male"

ii <- grep("KF", d2$Sex)
d2$Sex[ii] <- "Female"

ii <- grep("JF", d2$Sex)
d2$Sex[ii] <- "Female"

#There are a few individuals in the Korean collection that are classified as indeterminate (KI). I change this to NA values. 

ii <- grep("KI", d2$Sex)
d2$Sex[ii] <- "NA"

unique(d2$Sex)

d2$Sex <- as.factor(d2$Sex)
d2$Population <- as.factor(d2$Population)

unique(d2$Population)

d2$Population <- sub("K", "Korean", d2$Population)
d2$Population <- sub("J", "Japanese", d2$Population)
unique(d2$Population)

d2$Population <- as.factor(d2$Population)

kable(d2[1:10, ])


## ---- mergedata --------



dat <- merge(rawdata1, d2, by= "ID")
kable(dat[1:10, ])

dat1 <- merge(rawdata2, d2, by="ID")
kable(dat1[1:10, ])

## ---- arrangedata --------

d1 <- dat %>% relocate(where(is.factor), .before = Xalarl)


kable(d1[1:10, ])

save_data_location_csv <- "../../Data/Processed_data/Japan_dem.csv"
write.csv(d1, file = save_data_location_csv, row.names=FALSE)

save_data_location <- "../../Data/Processed_data/Japan_dem.rds"
saveRDS(d1, file = save_data_location)

d2 <- dat1 %>% relocate(where(is.factor), .before = Xalarl)

kable(d2[1:10, ])

save_data_location_csv <- "../../Data/Processed_data/Korea_dem.csv"
write.csv(d2, file = save_data_location_csv, row.names=FALSE)

save_data_location <- "../../Data/Processed_data/Korea_dem.rds"
saveRDS(d2, file = save_data_location)

## ---- d1Array --------

#subset the data without the demographic information

land1 <- d1[,-c(1:3)]

#Make sure that my data is classified as numeric.

class(land1)
rownames(land1)



my_mat <- apply(as.matrix.noquote(land1), 2, as.numeric)
my_mat[1:4,1:3]

#Next step is to transform my data into an array
#I need to determine how many landmarks I have so I can set the parameters

dim(land1)
#From this I can develop an array for my land2 data (92 specimens) 
#that has 38 landmarks with 3 measures per landmark

#Transform the data with arrayspecs()

d1array <- arrayspecs(my_mat, 38, 3)

#Check and save array

str(d1array)

save_data_location_csv <- "../../Data/Processed_data/Japan_array.csv"
write.csv(d1array, file = save_data_location_csv, row.names=FALSE)

save_data_location <- "../../Data/Processed_data/Japan_array.rds"
saveRDS(d1array, file = save_data_location)

## ---- d2Array --------

#Repeat the process above for the d2 dataset.

land2 <- d2[,-c(1:3)]
my_mat2 <- apply(as.matrix.noquote(land2), 2, as.numeric)
my_mat2[1:4,1:3]

#Double check the d2 dimensions.

dim(land2)

#Set array.

d2array <- arrayspecs(my_mat2, 38, 3)

#I want to check my data but I don't want it to take up too much space
#I can index the first couple of sheets to see the layout

d2array[1:4, , 1:2]

#Check structure.

str(d2array)

save_data_location_csv <- "../../Data/Processed_data/Korea_array.csv"
write.csv(d2array, file = save_data_location_csv, row.names=FALSE)

save_data_location <- "../../Data/Processed_data/Korea_array.rds"
saveRDS(d2array, file = save_data_location)

