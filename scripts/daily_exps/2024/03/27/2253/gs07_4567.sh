# bash ./scripts/daily_exps/2024/03/27/2253/gs07_4567.sh

LRS="5e-4 1.5e-4 5e-5"

for LR in ${LRS}
do
    bash ./scripts/deit_small_patch16_224_in100_finetune_full.sh 4,5,6,7 ${LR}
done

for LR in ${LRS}
do
    bash ./scripts/deit_small_patch16_224_in100_finetune_head.sh 4,5,6,7 ${LR}
done