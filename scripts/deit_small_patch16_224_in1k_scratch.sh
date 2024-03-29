# bash ./scripts/deit_small_patch16_224_in1k_scratch.sh 0,1,2,3

DEVICES=${1}
PORT_NUM=$(( ( RANDOM % 10000 )  + 10000 ))
TODAY=`date +%y%m%d%H%M`

DATA=/SSD/ILSVRC2012
DATASET=IMNET

# DATA=/SSD/ImageNet100
# DATASET=IMNET100

# MODEL=deit_base_patch16_224
# CKPT=https://dl.fbaipublicfiles.com/deit/deit_base_patch16_224-b5f2ef4d.pth

MODEL=deit_small_patch16_224
# CKPT=https://dl.fbaipublicfiles.com/deit/deit_small_patch16_224-cd65a155.pth

# MODEL=deit_tiny_patch16_224
# CKPT=https://dl.fbaipublicfiles.com/deit/deit_tiny_patch16_224-a1311bcf.pth

# BATCH_SIZE=128
BATCH_SIZE=256

OUTPUT_DIR=output/${MODEL}_in1k_scratch


CUDA_VISIBLE_DEVICES=${DEVICES} torchrun --nproc_per_node=4 --master_port ${PORT_NUM} main.py \
--model ${MODEL} \
--data-path ${DATA} \
--data-set ${DATASET} \
--batch-size ${BATCH_SIZE} \
--output_dir ${OUTPUT_DIR} \
--dist-eval \
