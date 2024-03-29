# bash ./scripts/daily_exps/2024/03/27/2253/gs07_0123.sh

LRS="5e-4 1.5e-4 5e-5"

for LR in ${LRS}
do
    bash ./scripts/deit_small_patch16_224_in100_scratch.sh 0,1,2,3 ${LR}
done