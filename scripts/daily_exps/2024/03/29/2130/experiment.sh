# bash ./scripts/daily_exps/2024/03/29/2130/experiment.sh

DEVICES=0,1,2,3
DATASETS="in200 in500"
LRS="5e-5 1.5e-5 5e-6 1.5e-6"

for DATASET in ${DATASETS}
do
    for LR in ${LRS}
    do
        sbatch ./scripts/daily_exps/2024/03/29/2130/deit_small_patch16_224_finetune_slurm.sh ${DEVICES} ${DATASET} ${LR}
    done
done