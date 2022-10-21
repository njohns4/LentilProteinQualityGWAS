# Admixture, mapPies, and PCA plots for 
# Protein Quality GWAS Paper (Johnson et al. 2022)
# Submitted to G3

# Libraries
library(plyr)
library(RColorBrewer)
library(rworldmap)
library(ggplot2)

setwd("C:/Users/Nathan/OneDrive - Clemson University/Desktop/Papers/AA GWAS Paper/ADMIX")

k6adxacc = read.csv("all_admix_k6.csv")
head(k6adxacc)
# Includes columns: 
# Taxa, V1, V2, V3, V4, V5, V6, group, ISO3, PCA1, PCA2, PCA3
# Admix was generated using run_admixture.bash then sort_admixture.R.

##### Map Pies Figures #####
# Script for mapPie figure to display admixture group percentages by country of origin.
# Because Syria had so many accessions so that the pie covered other countries,
# I generated two plots at the same scale, so that I could move the Syria pie,
# over the ocean. This was done in Adobe Illustrator. 

# K=6 MapPies W/O Syria 

#Calculate mean group percentages for each country and add to same data frame.
k6adxISOV1 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V1=mean(V1)
)

k6adxISOV2 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V2=mean(V2))

k6adxISOV3 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V3=mean(V3))
k6adxISOV4 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V4=mean(V4))
k6adxISOV5 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V5=mean(V5))
k6adxISOV6 <- ddply(k6adxacc, 
                    .(ISO3), 
                    summarize, 
                    V6=mean(V6))
k6adxISO <- k6adxISOV1
k6adxISO$V2 <- k6adxISOV2[,2]
k6adxISO$V3 <- k6adxISOV3[,2]
k6adxISO$V4 <- k6adxISOV4[,2]
k6adxISO$V5 <- k6adxISOV5[,2]
k6adxISO$V6 <- k6adxISOV6[,2]
head(k6adxISO)
k6adxISO
rowSums(k6adxISO[1:53,2:7])

#Count group members and multiply group means by count.
k6ISOCounts <- count(k6adxacc$ISO3)
k6ISOCounts
k6adxISO

#To change Syria from 35 to 0
k6ISOCounts[44,2] <- 0
k6ISOCounts

head(k6adxISO)
colnames(k6ISOCounts) <- c("ISO3","Count")
head(k6ISOCounts)

k6adxISOxCounts <- merge(k6adxISO,k6ISOCounts, by="ISO3")
k6adxISOxCounts


k6adxISOxCounts -> k6isoavmerge
k6isoavmerge$Group1 <- k6isoavmerge$V1 * k6isoavmerge$Count
k6isoavmerge$Group2 <- k6isoavmerge$V2 * k6isoavmerge$Count
k6isoavmerge$Group3 <- k6isoavmerge$V3 * k6isoavmerge$Count
k6isoavmerge$Group4 <- k6isoavmerge$V4 * k6isoavmerge$Count
k6isoavmerge$Group5 <- k6isoavmerge$V5 * k6isoavmerge$Count
k6isoavmerge$Group6 <- k6isoavmerge$V6 * k6isoavmerge$Count
k6isoavmerge$SumGroup <- rowSums(k6isoavmerge[,9:14])
head(k6isoavmerge)

#Join data to map
head(k6isoavmerge)
k6admix <- joinCountryData2Map(k6isoavmerge
                               , joinCode = "ISO3"
                               , nameJoinColumn = "ISO3")

par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

#write.csv(k6isoavmerge, "ISO3_ADMIX_x_Count.csv")

##### K=6 mapPies North Amer and Syria####

#Calculate mean group percentages for each country and add to same dataframe.
k6adxaccDel = read.csv("all_admix_k6.csv")
head(k6adxaccDel)

Dk6adxISOV1 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V1=mean(V1)
)

Dk6adxISOV2 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V2=mean(V2))

Dk6adxISOV3 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V3=mean(V3))
Dk6adxISOV4 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V4=mean(V4))
Dk6adxISOV5 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V5=mean(V5))
Dk6adxISOV6 <- ddply(k6adxaccDel, 
                     .(ISO3), 
                     summarize, 
                     V6=mean(V6))
Dk6adxISO <- Dk6adxISOV1
Dk6adxISO$V2 <- Dk6adxISOV2[,2]
Dk6adxISO$V3 <- Dk6adxISOV3[,2]
Dk6adxISO$V4 <- Dk6adxISOV4[,2]
Dk6adxISO$V5 <- Dk6adxISOV5[,2]
Dk6adxISO$V6 <- Dk6adxISOV6[,2]
tail(Dk6adxISO)
Dk6adxISO
rowSums(Dk6adxISO[1:53,2:7])

#Count group members and multiply group means by count.
Dk6ISOCounts <- count(k6adxaccDel$ISO3)
Dk6ISOCounts
Dk6adxISO

#To change all to 0 except Syria and USA
Dk6ISOCounts[1:43,2] <- 0
Dk6ISOCounts[45:49,2] <- 0
Dk6ISOCounts[51:53,2] <- 0

head(Dk6adxISO)
colnames(Dk6ISOCounts) <- c("ISO3","Count")
head(Dk6ISOCounts)

Dk6adxISOxCounts <- merge(Dk6adxISO,Dk6ISOCounts, by="ISO3")
Dk6adxISOxCounts


Dk6adxISOxCounts -> Dk6isoavmerge
Dk6isoavmerge$Group1 <- Dk6isoavmerge$V1 * Dk6isoavmerge$Count
Dk6isoavmerge$Group2 <- Dk6isoavmerge$V2 * Dk6isoavmerge$Count
Dk6isoavmerge$Group3 <- Dk6isoavmerge$V3 * Dk6isoavmerge$Count
Dk6isoavmerge$Group4 <- Dk6isoavmerge$V4 * Dk6isoavmerge$Count
Dk6isoavmerge$Group5 <- Dk6isoavmerge$V5 * Dk6isoavmerge$Count
Dk6isoavmerge$Group6 <- Dk6isoavmerge$V6 * Dk6isoavmerge$Count
Dk6isoavmerge$SumGroup <- rowSums(Dk6isoavmerge[,9:14])
head(Dk6isoavmerge)
tail(Dk6isoavmerge)

#Join data to map
head(Dk6isoavmerge)
Dk6admix <- joinCountryData2Map(Dk6isoavmerge
                                , joinCode = "ISO3"
                                , nameJoinColumn = "ISO3")

par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

#Make map pie chart

mapPies(k6admix, nameZs = c("Group1", "Group2", "Group3", "Group4", "Group5", "Group6"), 
        ratio=1, zColours = brewer.pal(6,"Dark2"),
        addCatLegend = FALSE, symbolSize = 0.6, maxZVal = 0.5, xlim = NA,
        ylim = NA, mapRegion = "world", borderCol = "black", oceanCol = "light blue",
        landCol = "light grey", add = FALSE, main = "", lwd = 0.5)

mapPies(Dk6admix, nameZs = c("Group1", "Group2", "Group3", "Group4", "Group5", "Group6"), 
        ratio = 1, zColours = brewer.pal(6,"Dark2"),
        addCatLegend = FALSE, symbolSize = 1.25, maxZVal = NA, xlim = NA,
        ylim = NA, mapRegion = "world", borderCol = "black", oceanCol = "light blue",
        landCol = "light grey", add = FALSE, main = "", lwd = 0.5)

#Exported as PDF with dimensions 12 x 18 in.

#### PCA Plots in GGPLOT2 #### 
str(k6adxacc)
head(k6adxacc)
k6adxacc$group <- as.factor(k6adxacc$group)
ggplot(k6adxacc, aes(PCA1, PCA2, color=group, shape=group)) +
  geom_point(size=2, show.legend = FALSE) + 
  scale_color_brewer(palette="Dark2")+
  #scale_color_okabe_ito(order = 1:6) +
  theme_bw() +
  scale_shape_manual(values=c(16, 17, 17, 16, 15, 15)) +
  theme(panel.grid.minor = element_blank())
  
ggplot(k6adxacc, aes(PCA2, PCA3, color=group, shape=group)) +
  geom_point(size=2, show.legend = TRUE) + 
  scale_color_brewer(palette="Dark2")+
  theme_bw() +
  scale_shape_manual(values=c(16, 17, 17, 16, 15, 15)) +
  theme(panel.grid.minor = element_blank())
# Exported as PDF with dimensions 4 x 4 in.
# I merged these into one figure in Illustrator and adjusted the legend.

#### GGPLOT Admixture Plot #### 
# sorted_df was converted to 4 columns in excel
# columns: order, taxa, percent, group
k6sorted_gg <- read.csv("k6sorted_df.csv")
head(k6sorted_gg)
colnames(k6sorted_gg) <- c("order", "taxa", "percent", "Group")
str(k6sorted_gg)
k6sorted_gg[,4] <- as.factor(k6sorted_gg[,4])
ggplot(k6sorted_gg, aes(fill=Group, y=percent, x=reorder(taxa, order))) + 
  geom_bar(position= "fill", stat="identity", width = 1, show.legend = TRUE) + 
  theme_bw() +
  labs(x = "Individuals", y = "Ancestry") +
  #scale_fill_okabe_ito(order = 1:6) +
  scale_fill_brewer(palette="Dark2")+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  scale_y_continuous(expand = c(0,0)) 