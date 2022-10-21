#!/bin/bash

# This script copies the GWAS csv files into a common directory.
# An R script then creates a csv file with all rows of p-value below an adjustable threshold.

#Create paste directory in WORK_DIR called GWAS.CSVs
BASE_DIR="/scratch1/njohns9/AA_GAPIT4" #CHANGE
MODEL=("GLM" "MLM" "MLMM" "CMLM" "FarmCPU" "Blink") # CHANGE

cd ${BASE_DIR}

for i in {2..36} # CHANGE
do
for j in ${MODEL[@]}
do
cp ${BASE_DIR}/GAPITtrait${i}/GAPIT.${j}.V${i}.GWAS.Results.csv ./GWAS_CSVs/
done
done
