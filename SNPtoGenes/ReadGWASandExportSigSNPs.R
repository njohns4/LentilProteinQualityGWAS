# A script to combine significant GWAS results from GAPIT CSV files into a single CSV file.
library(tidyverse)
library(DataCombine)
setwd("/scratch1/njohns9/AA_GAPIT3/GWAS_CSVs/")

# Working directory should only have GWAS result csv files in it.
filenames <- list.files(pattern="GAPIT.")

allsigsnpsVnum <- data.frame(matrix(ncol = 11, nrow = 0))
colnames(allsigsnpsVnum) <- c(colnames(read.csv("GAPIT.Blink.V10.GWAS.Results.csv")), "filename") # sample csv for headers
head(allsigsnpsVnum)

for(i in 1:length(filenames)){
  data <- read.csv(filenames[i])
  data$filename <- filenames[i]
  sigsnps <- data %>% filter(P.value < 0.05/nrow(data)) #set p-value threshold
  allsigsnpsVnum <- rbind(allsigsnpsVnum,sigsnps)
}

head(allsigsnpsVnum)
nrow(allsigsnpsVnum)
# Rename filenames of allsigsnps with amino acids

LentilAA <- read.csv("/scratch1/njohns9/AA_GAPIT3/Lentil.AA.bayesian.blups.csv")
key <- as.data.frame(matrix(nrow = 35, ncol = 3))
colnames(key) <- c("V", "num", "trait")
key$V <- "V"
key$num <- 2:36
key$dot <- "."
key$GWAS <- ".GWAS"
key$trait <- colnames(LentilAA[2:36])
key$Vnum <- paste(key$dot, key$V, key$num, key$GWAS, sep = "")
key$traits <- paste(key$dot, key$trait, key$GWAS, sep = "")
key <- key[,6:7]
key
allsigsnps <- FindReplace(data = allsigsnpsVnum, Var = "filename", replaceData = key,
                       from = "Vnum", to = "traits", exact = FALSE)
nrow(allsigsnps)
nrow(allsigsnpsVnum)

unique_sigsnps <- unique(allsigsnps$SNP)
class(unique_sigsnps)
# Export CSVs for record
write.csv(allsigsnps, file = "AllSigSNPs.csv", row.names = FALSE)
write.csv(key, file = "Key_AA_to_Vnum.csv")
write.table(unique_sigsnps, file = "Unique_SigSNPs.txt", row.names = FALSE, col.names = FALSE)
