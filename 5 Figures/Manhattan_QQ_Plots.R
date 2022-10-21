# Manhattan Plots for Lentil Protein Quality GWAS
library("CMplot")

# Create CSV files with the following columns for each trait:
# SNP, Chromosome, Position, GLM, MLM, MLMM, CMLM, SUPER, FarmCPU, Blink
# Note that Digestibility does not have SUPER. It wouldn't run for Digestibility.

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
barplot(c(1:8), col=cbPalette)

GWASCol <- c("#E69F00", "#56B4E9", "#009E73", "#D55E00", "#F0E442", "#0072B2", "#CC79A7")
barplot(c(1:7), col=GWASCol)

DigCol <- c("#E69F00", "#56B4E9", "#009E73", "#D55E00", "#0072B2", "#CC79A7")
barplot(c(1:6), col=DigCol)
# An i loop for Manhattan plots.
setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern=".csv")
filenames <- filenames[c(1:5,7:17)] # Remove Digestibility
filenames
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data, col=GWASCol,
         plot.type="m",multracks=TRUE,threshold=c(0.01/22280,0.05/22280),threshold.lty=c(1,2),
         threshold.lwd=c(1,1), threshold.col=c("black","grey"), amplify=FALSE,
         chr.den.col=c("darkgreen", "yellow", "red"), signal.col=NULL, bin.range=c(1,50), bin.size =1e6,
         signal.cex=1, file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,
         points.alpha=255)
  renameFile("Multracks-Manhattan.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManStack.jpg"))
  renameFile("Multraits-Manhattan.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManOverlay.jpg"))
}

#For Digestibilty, because SUPER would not run with Digestibility data.
setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern=".csv")
filenames <- filenames[6] # Keep Digestibility
filenames
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data, col=DigCol,
         plot.type="m",multracks=TRUE,threshold=c(0.01/22280,0.05/22280),threshold.lty=c(1,2),
         threshold.lwd=c(1,1), threshold.col=c("black","grey"), amplify=FALSE,
         chr.den.col=c("darkgreen", "yellow", "red"), signal.col=NULL, bin.range=c(1,50), bin.size =1e6,
         signal.cex=1, file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,
         points.alpha=255)
  renameFile("Multracks-Manhattan.GLM.MLM.MLMM.CMLM.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManStack.jpg"))
  renameFile("Multraits-Manhattan.GLM.MLM.MLMM.CMLM.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManOverlay.jpg"))
}

# TotalAA

setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern="TotalAA.csv")
filenames <- filenames[6] 
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data, col=GWASCol,
         plot.type="m",multracks=TRUE,threshold=c(0.01/22280,0.05/22280),threshold.lty=c(1,2),
         threshold.lwd=c(1,1), threshold.col=c("black","grey"), amplify=FALSE,
         chr.den.col=c("darkgreen", "yellow", "red"), signal.col=NULL, bin.range=c(1,50), bin.size =1e6,
         signal.cex=1, file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,
         points.alpha=255)
  renameFile("Multracks-Manhattan.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManStack.jpg"))
  renameFile("Multraits-Manhattan.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".ManOverlay.jpg"))
}

# QQ Plots

# Note that the example plots cut the SNPs off to make the CIs clear in the overlayed plots.
#Without Digestibility
setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern=".csv")
filenames
filenames <- filenames[c(1:5,7:17)] # Remove Digestibility
# filenames <- "Alanine.csv"
filenames
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data,plot.type="q",col=GWASCol,threshold=0.05/22280,
         ylab.pos=2,signal.pch=c(4),signal.cex=1.2,signal.col="red",conf.int=TRUE,box=FALSE,multracks=
           TRUE,cex.axis=2,file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,ylim=c(0,8),width=5,height=5)
  renameFile("Multracks-QQplot.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQSideBySide.jpg"))
  renameFile("Multraits-QQplot.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQOverlay.jpg"))
}

#Digestibility
setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern=".csv")
filenames <- filenames[6] # Remove Digestibility
# filenames <- "Alanine.csv"
filenames
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data,plot.type="q",col=DigCol,threshold=0.05/22280,
         ylab.pos=2,signal.pch=c(4),signal.cex=1.2,signal.col="red",conf.int=TRUE,box=FALSE,multracks=
           TRUE,cex.axis=2,file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,ylim=c(0,8),width=5,height=5)
  renameFile("Multracks-QQplot.GLM.MLM.MLMM.CMLM.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQSideBySide.jpg"))
  renameFile("Multraits-QQplot.GLM.MLM.MLMM.CMLM.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQOverlay.jpg"))
}

#TotalAA
setwd("/scratch1/njohns9/AADig_GWASResultsForPlots/")
filenames <- list.files(pattern="TotalAA.csv")
filenames <- filenames[6] 
# filenames <- "Alanine.csv"
filenames
for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  CMplot(data,plot.type="q",col=GWASCol,threshold=0.05/22280,
         ylab.pos=2,signal.pch=c(4),signal.cex=1.2,signal.col="red",conf.int=TRUE,box=FALSE,multracks=
           TRUE,cex.axis=2,file="jpg",memo="",dpi=600,file.output=TRUE,verbose=TRUE,ylim=c(0,8),width=5,height=5)
  renameFile("Multracks-QQplot.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQSideBySide.jpg"))
  renameFile("Multraits-QQplot.GLM.MLM.MLMM.CMLM.SUPER.FarmCPU.Blink.jpg", paste0(substr(filenames[i],1,nchar(filenames[i])-4),".QQOverlay.jpg"))
}
  