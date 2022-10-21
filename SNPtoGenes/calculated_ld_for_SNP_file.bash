#!/usr/bin/env bash

# Directions for creating .ped and .map plink files.
# sed 's/LCU.2RBY.CHR/NP_/g' ./Lentil.AAsamples.final2.vcf > Fix.Lentil.AAsamples.final2.vcf
# sed 's/LCU.2RBY.CHR/NP_/g' ./unique_ProQualSNPs.txt > fix_ProQualSNPs.txt
# May need to run TMPDIR="." if Segementation fault (core dumpted) error
# vcftools --vcf Fix.Lentil.AAsamples.final2.vcf --plink --out Lens.plink

# if 10 SNPs, second number should be 10 that is 1..10
for i in {1..50}
do
    SNP_NAME=$(head -n ${i} fix_ProQualSNPs.txt | tail -n 1)
    ~/plink/plink --noweb --file ./Lens.plink \
        --r2 --ld-snp ${SNP_NAME} --ld-window-kb 1000 --ld-window 99999 --ld-window-r2 0
    mv plink.ld ${SNP_NAME}.plink.ld
done
