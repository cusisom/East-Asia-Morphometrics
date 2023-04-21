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

#I need to read in the rawdata.
#Can I read separate .csv files?

rawdata1 <- read.csv(data_location1, check.names=FALSE)
rawdata1$ID <- as.factor(rawdata1$ID)


## ---- viewdata1 --------

sk1 <- skim(rawdata1)
sk1 <- as.data.frame(sk1)

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

## ---- datadictionary2 --------

d2 <- read.csv(paste(data_path, "Raw_classifiers.csv", sep=""))
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

d2 <- dat1 %>% relocate(where(is.factor), .before = Xalarl)

kable(d2[1:10, ])
