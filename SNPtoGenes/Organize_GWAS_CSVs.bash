#!/bin/bash

BASE_DIR="/scratch1/njohns9"
CP_DIR="/scratch1/njohns9/GWAS_CSVs_Traits"
MODEL=("GLM" "MLM" "MLMM" "CMLM" "SUPER" "FarmCPU" "Blink") # CHANGE
for i in {2..37}
do
cd ${BASE_DIR}/GWAS_CSVs
TRAIT=$(head -n ${i} /scratch1/njohns9/trait.key.txt | tail -n 1)
if [ ! -d ${TRAIT} ]
then
    mkdir ${CP_DIR}/${TRAIT}
fi

for j in ${MODEL[@]}
do

cp ${BASE_DIR}/GWAS_CSVs/GAPIT.${j}.${TRAIT}.GWAS.Results.csv ${CP_DIR}/${TRAIT}
done
done





