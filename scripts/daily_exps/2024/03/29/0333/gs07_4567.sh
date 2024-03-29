# bash ./scripts/daily_exps/2024/03/29/0333/gs07_4567.sh

DEVICES=4,5,6,7
LR=1.5e-5

sleep 1h

bash ./scripts/deit_small_patch16_224_in100_finetune.sh ${DEVICES} ${LR}