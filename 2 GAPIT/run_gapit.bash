#Run after "make_gapit.bash".
BASE_DIR="/scratch1/njohns9/AA_GAPIT3/"

for i in {2..36}
do

cd ${BASE_DIR}/GAPITtrait${i}

qsub GAPITtrait${i}.qsub

done

