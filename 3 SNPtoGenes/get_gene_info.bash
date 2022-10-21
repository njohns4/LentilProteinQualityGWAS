#!/usr/bin/env bash

GENES="1000kbcap_ProQualSNPs_genes"
GENE_INFO="Lens_culinaris_2.0.genes.description.renamed.gff3"
awk '{print $5}' ${GENES}.txt | uniq > unique_genes.txt

grep -f unique_genes.txt ${GENE_INFO} | grep "gene" > ${GENES}.description.txt

if [ -e unique_genes.txt ]
then
    rm unique_genes.txt
fi

# awk '{print $5}' range_putative_genes.txt | uniq > unique_genes.txt
# grep -f unique_genes.txt ${GENE_INFO} | grep "gene" > ${GENES}.info.txt
