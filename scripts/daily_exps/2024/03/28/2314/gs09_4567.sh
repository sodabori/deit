# bash ./scripts/daily_exps/2024/03/28/2314/gs09_4567.sh

DEVICES=4,5,6,7
LRS="5e-5 1.5e-5"

for LR in ${LRS}
do
    bash ./scripts/deit_small_patch16_224_in500_finetune.sh ${DEVICES} ${LR}
done