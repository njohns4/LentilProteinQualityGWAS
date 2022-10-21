#!/usr/bin/env bash

# See phython featuresFromSnpsLentil.py --help
# Set the GWAS file of interest -- BE SURE TO REMOVE ".csv"
GWAS="1000kbcap_ProQualSNPs"

# FIX chromosome names -- the periods cause issues
# sed 's/LCU.2RBY.//g' ${GWAS}.csv > ${GWAS}.renamed.csv
# EXTRACT features from the GFF SQLITE database
python featuresFromSnpsLentil.py --gff Lens_culinaris_2.0.genes.description.renamed.gff3.sqlite --input ${GWAS}.csv --input_type range --output ${GWAS}_genes.txt
# REMOVE the temporary GWAS results file
if [ -e ${GWAS}.txt ]
 then
   rm ${GWAS}.txt
fi
