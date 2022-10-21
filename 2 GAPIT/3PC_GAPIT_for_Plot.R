source('http://zzlab.net/GAPIT/GAPIT.library.R')
source('http://zzlab.net/GAPIT/gapit_functions.txt')
setwd("/scratch1/njohns9/AA_GAPIT3/GAPIT3PCs")
myY <- read.csv("/scratch1/njohns9/AA_GAPIT3/Lentil.AA.bayesian.blups.nohead.csv", head = FALSE)
myG <- read.delim("/zfs/dilthavar/njohns9/LentilRefandVariantFiles/Lentil.AAsamples.final2.hmp.txt", head = FALSE) 

myGAPIT <- GAPIT(
  Y=myY[,c(1,2)],
  G=myG,
  PCA.total=3,
  model=c('GLM'),
  )

