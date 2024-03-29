# bash ./scripts/daily_exps/2024/03/28/2314/gs09_0123.sh

DEVICES=0,1,2,3
LRS="5e-5 1.5e-5"

for LR in ${LRS}
do
    bash ./scripts/deit_small_patch16_224_in200_finetune.sh ${DEVICES} ${LR}
done