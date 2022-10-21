VCF="/zfs/dilthavar/njohns9/LentilRefandVariantFiles/Lentil.AAsamples.final2.vcf" # Your VCF file
PLINK_OUTPUT="Lentil.AAsamples.final2.plink" # The output name for Plink data
PHENOTYPES="Lentil.AA.blups.tsv" # tab-separate file with header = IID\tFID\tPhenotype1\tPhenotype2\t...PhenotypeN
# Note that phenotypes are not important for admix or LD analysis, but incorrect formatting will throw error.
NUM_PHENOTYPES="35" # example for seven phenotypes

TMPDIR="."

/zfs/dilthavar/software/Plink/plink --noweb --file ${PLINK_OUTPUT} --pheno ${PHENOTYPES} --allow-no-sex --make-bed --out ${PLINK_OUTPUT} 

#previously build_gemma_files_from_vcf.bash