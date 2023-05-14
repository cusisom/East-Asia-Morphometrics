###New Attempt###


setwd("C:/Users/danny/Documents/git/East-Asia-Morphometrics/Code/Processing_code")

require(plyr)
require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 
require(geomorph)
require(knitr) 
require(gapminder)
require(readr)

data_location1 <- "../../Data/Raw_data/attempt2/Raw_Japan.csv"
data_location2 <- "../../Data/Raw_data/attempt2/Raw_korea.csv"
data_location3 <- "../../Data/Raw_data/Raw_classifiers.csv"


####Merging Raw Data######

rawdata <- list.files(path = "../../Data/Raw_data/attempt2",
	pattern = "*.csv", full.names = TRUE) %>%
	lapply(read_csv) %>%
	bind_rows

rawdata

as.data.frame(rawdata)
rawdata[191, ]

rawdata1 <- rawdata[-(191), ]
rawdata1$ID <- as.factor(rawdata1$ID)
names(rawdata1)

####Raw Classifiers Edits#######

dem <- read.csv(data_location3, check.names=FALSE)

kable(dem[1:10, ])

dem <- subset(dem, select = -c(Period))
kable(dem[1:10, ])

ii <- grep("JM", dem$Sex)
dem$Sex[ii] <- "Male"

ii <- grep("KM", dem$Sex)
dem$Sex[ii] <- "Male"

ii <- grep("KF", dem$Sex)
dem$Sex[ii] <- "Female"

ii <- grep("JF", dem$Sex)
dem$Sex[ii] <- "Female"

#There are a few individuals in the Korean collection that are classified as indeterminate (KI). I change this to NA values. 

ii <- grep("KI", dem$Sex)
dem$Sex[ii] <- "NA"

unique(dem$Sex)

dem$Sex <- as.factor(dem$Sex)
dem$Population <- as.factor(dem$Population)

unique(dem$Population)

dem$Population <- sub("K", "Korean", dem$Population)
dem$Population <- sub("J", "Japanese", dem$Population)
unique(dem$Population)

dem$Population <- as.factor(dem$Population)
dem$ID <-as.factor(dem$ID)

kable(dem[1:10, ])


####Merging Classifiers with Data######

## I know that the classifer documents accounts for more specimens than are listed in the data. I need to find out which IDs do not have corresponding metrics and remove them.

rawdata1 <- merge(rawdata1, dem, by= "ID")

rawdata1 <- rawdata1 %>% relocate(where(is.factor), .before = Xalarl)

write.csv(rawdata1, file = "../../Data/Processed_data/attempt2/all_data.csv")

#After merging the files I generate a new classifiers file with the data that matched both sets. This way I will have two files with the same number of specimens. 

dem2 <- rawdata1[, 1:3]
write.csv(dem2, file = "../../Data/Processed_data/attempt2/New_classifiers.csv")

dem <- dem2

dem$ID <- as.factor(dem$ID)
dem$Sex <- as.factor(dem$Sex)
dem$Population <- as.factor(dem$Population)

ID <- dem$ID
sex <- dem$Sex
population <- dem$Population



rawdata1[1,(1:5)]

names(rawdata1)
raw1 <- rawdata1[, -(1:3)]
names(raw1)
raw2 <- apply(as.matrix.noquote(raw1), 2, as.numeric)
land <- arrayspecs(raw2, 38, 3)
land[1:4, , 1:2]





land.gpa <-gpagen(land, PrinAxes=FALSE)
summary(land.gpa)

landMeans <- mshape(land)
head(landMeans)

plot(land.gpa)

links <- "../../Data/Processed_data/attempt2/links.csv"

links <- read.csv(links)
class(links)


EAmorph <- list(land, dem, ID, sex, population, links)
names(EAmorph) <- c("land", "dem", "ID", "sex", "population", "links")
str(EAmorph)


EAmorph.pca <- gm.prcomp(land.gpa$coords)
EAmorph.pca 

plot(EAmorph.pca)

plot(EAmorph.pca, main = "PCA",
col=EAmorph$population)

par(mfrow=c(1,2))
plot(EAmorph.pca, main ="PCA",
axis1 = 1, axis2 = 2,
col =EAmorph$sex
)
plot(EAmorph.pca, main = "PCA",
axis1 = 1, axis2 = 2,
col=EAmorph$population
)

plot.coords <- function(A, W, points.col="black", points.cex=1, lines.col="black", lines.wd=2, bg.col=NULL, 
                        main=NULL, main.line=2, main.cex=2, legend=NULL, legend.pos="topright", legend.title="", 
                        legend.col=NULL, legend.cex=1.2, legend.lwd=2, legend.bty="n", params=NULL, add=FALSE) {
  if (!is.null(params)) {par3d(params)}
  points.col <- rep(points.col, length.out=nrow(A))
  points.cex <- rep(points.cex, length.out=nrow(A))
  lines.col <- rep(lines.col, length.out=nrow(W))
  lines.wd <- rep(lines.wd, length.out=nrow(W))
  if (!is.null(bg.col)) rgl.bg(sphere=TRUE, color=bg.col, lit=FALSE, back="fill")
  plot3d(A, type="s", col=points.col, xlab="", ylab="", zlab="", size=points.cex, aspect=FALSE, box=FALSE, axes=FALSE, add=add)
    if (!is.null(main) | !is.null(legend)) {
      if (!is.null(legend) & is.null(legend.col)) stop("must supply legend colors")
      bgplot3d({plot.new()
    if (!is.null(main)) title(main=main, line=main.line, cex.main=main.cex)
    if (!is.null(legend)) legend(legend.pos, title=legend.title, legend=legend, col=legend.col, lwd=legend.lwd, cex=legend.cex, bty=legend.bty)})}
  for (i in 1:nrow(W)) {
    segments3d(rbind(A[W[i,1],], A[W[i,2],]), lwd=lines.wd[i], col=lines.col[i])
  }
}

plot.coords(landMeans, links[ ,2:3], points.col="blue", points.cex=1.5)
plot.coords(land.gpa$consensus, links[,2:3], points.col="blue", points.cex=2, lines.col="red", lines.wd=3)

lines.col <- mapvalues(links[,1], unique(links[,1]), c("goldenrod","blue"))

# make wireframe
plot.coords(land.gpa$consensus, links[,2:3], lines.col=lines.col) 

			
par(mfrow= c(2,2))
plot(EAmorph.pca, main = "PCA",
col=EAmorph$population,
pch=16
)
plot(EAmorph.pca, main = "PCA",
	axis1=1, axis2=3,
	col=EAmorph$population,
	pch=16
)
plot(EAmorph.pca, main = "PCA",
	axis1=2, axis2=3,
	col=EAmorph$population,
	pch=16
)
plot(EAmorph.pca, main = "PCA",
	axis1=3, axis2=4,
	col=EAmorph$population,
	pch=16
)


gdf <- geomorph.data.frame(land.gpa,
population = EAmorph$population)
attributes(gdf)

gdf <- geomorph.data.frame(land.gpa,
population = EAmorph$population,
sex = EAmorph$sex)
attributes(gdf)

lm.fit <- procD.lm(coords~population*sex, data=gdf)
summary(lm.fit)

anova(procD.lm(coords~Csize + population*sex, data=gdf))

ref <- mshape(gdf$coords)
gp1.mn <- mshape(gdf$coords[,,gdf$population=="Japanese"])
plotRefToTarget(ref,gp1.mn,mag=8, links=links[,2:3])
plotAllSpecimens(gdf$coords, links=links[,2:3])

