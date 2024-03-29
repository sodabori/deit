# bash ./scripts/deit_small_patch16_224_in200_finetune.sh 0,1,2,3 5e-5

DEVICES=${1}
PORT_NUM=$(( ( RANDOM % 10000 )  + 10000 ))
TODAY=`date +%y%m%d%H%M`

# DATA=/SSD/ILSVRC2012
# DATASET=IMNET

# DATA=/SSD/ImageNet100
# DATASET=IMNET100

DATA=/SSD/ImageNet200
DATASET=IMNET200

# DATA=/SSD/ImageNet500
# DATASET=IMNET500

# MODEL=deit_base_patch16_224
# CKPT=https://dl.fbaipublicfiles.com/deit/deit_base_patch16_224-b5f2ef4d.pth

MODEL=deit_small_patch16_224
CKPT=https://dl.fbaipublicfiles.com/deit/deit_small_patch16_224-cd65a155.pth

# MODEL=deit_tiny_patch16_224
# CKPT=https://dl.fbaipublicfiles.com/deit/deit_tiny_patch16_224-a1311bcf.pth

# BATCH_SIZE=128
BATCH_SIZE=256
LR=${2}

OUTPUT_DIR=output/${MODEL}_in200_finetune/lr_${LR}/


CUDA_VISIBLE_DEVICES=${DEVICES} torchrun --nproc_per_node=4 --master_port ${PORT_NUM} main.py \
--model ${MODEL} \
--data-path ${DATA} \
--data-set ${DATASET} \
--finetune ${CKPT} \
--batch-size ${BATCH_SIZE} \
--output_dir ${OUTPUT_DIR} \
--dist-eval \
--lr ${LR} \
