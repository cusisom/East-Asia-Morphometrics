# Project 3 Processing Code
#Primary objectives: Consolidate Data, Check for Errors, and develop Data Dictionary

## ---- loadpackages --------

require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 
require(geomorph)
require(knitr) 




## ---- loaddata ---------
#path to data

data_location1 <- "../../Data/Processed_data/Japan_array.rds"
data_location2 <- "../../Data/Processed_data/Korea_array.rds"
data_path <- "../../Data/Raw_data/"

d1array <- readRDS(data_location1)


## ---- Step1 --------

#Run GPA

d1array.gpa <- gpagen(d1array, print.progress=FALSE)

summary(d1array.gpa)

## ---- Step2 --------


#Generate mean shape data. 

d1Dat <- mshape(d1array)

head(d1Dat)
tail(d1Dat) 

#Read in wireframe data

d1Links <- "../../Data/Processed_data/d1Links.rds"

d1Links <- readRDS(d1Links)

head(d1Links)


## ---- plot1 --------
#Plot mean data with wireframe

plot(d1Dat, d1Links)


## ---- plot2 --------

#Use function to alter aesthetics of plot

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


plot.coords(d1Dat, d1Links, points.col="blue", points.cex=1.5)

## ---- D1Analysis --------

D1.pca <- gm.prcomp(d1array.gpa$coords)

D1.pca

D1.pca.plot <- plot(D1.pca)




