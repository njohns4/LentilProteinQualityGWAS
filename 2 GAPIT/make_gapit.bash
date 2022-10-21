#PBS -N make_gapit
#PBS -l select=1:ncpus=16:mem=100gb:interconnect=fdr,walltime=24:00:00

#This script will prepare to run all traits in a csv file through GAPIT, placing each trait in a seperate directory. Run "run_gapit.bash" after.
BASE_DIR="/scratch1/njohns9/AA_GAPIT3/" #CHANGE
TRAIT_FILE="/scratch1/njohns9/AA_GAPIT3/Lentil.AA.bayesian.blups.nohead.csv" #CHANGE
GENO_FILE="/zfs/dilthavar/njohns9/LentilRefandVariantFiles/Lentil.AAsamples.final2.hmp.txt" #CHANGE

# if 10 traits, second number should be 11 that is 2..11
for i in {2..36}
do

cd ${BASE_DIR}
mkdir GAPITtrait${i}
cd GAPITtrait${i}

echo "source('"http://zzlab.net/GAPIT/GAPIT.library.R"')
source('"http://zzlab.net/GAPIT/gapit_functions.txt"')

myY <- read.csv("'"'"${TRAIT_FILE}"'"'", head = FALSE)
myG <- read.delim("'"'"${GENO_FILE}"'"'", head = FALSE) 

myGAPIT <- GAPIT(
                 Y=myY[,c(1,${i})],
                 G=myG,
                 PCA.total=0,
                 model=c('"GLM"', '"MLM"', '"CMLM"', '"SUPER"', '"MLMM"', '"FarmCPU"', '"Blink"'),
                 Multiple_analysis=TRUE)
" > GAPITtrait${i}.R

echo "#PBS -N GAPITtrait${i}
#PBS -l select=1:ncpus=16:mem=100gb,walltime=10:00:00

module load anaconda3/5.1.0-gcc
source activate r_env

cd ${BASE_DIR}GAPITtrait${i} #Change

Rscript GAPITtrait${i}.R
" > GAPITtrait${i}.qsub
done


