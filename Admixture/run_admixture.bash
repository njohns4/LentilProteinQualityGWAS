#!/usr/bin/env bash

# bash run_admixture.bash plink.bed
# plink.bed file was generated from 

PLINK_FILE=$1

for K in 1 2 3 4 5 6 7 8 9 10
do
    /zfs/dilthavar/software/admixture ${PLINK_FILE} $K -j16 --cv=5 | tee log${K}.out
done

# I generated a ggplot figure instead of the sort_admixture.R figure. 
# See MapPies_PCA_ADMIX_Plots.R and the exported file "all_admix.csv" from sort_admixture.R
# The lowest CV error (k=6) was selected.
