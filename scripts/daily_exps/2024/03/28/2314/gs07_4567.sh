# bash ./scripts/daily_exps/2024/03/28/2314/gs07_4567.sh

DEVICES=4,5,6,7
LR=3e-5

bash ./scripts/deit_small_patch16_224_in100_finetune.sh ${DEVICES} ${LR}