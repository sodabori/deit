#!/bin/sh
## sbatch ./scripts/daily_exps/2024/03/29/2130/deit_small_patch16_224_finetune_slurm.sh 0,1,2,3 in200 5e-5

#SBATCH -J  vdp           # Job name
#SBATCH -o  %j.out    # Name of stdout output file (%j expands to %jobId)


#### Select  GPU
#SBATCH -p 3090           # queue  name  or  partiton
#SBATCH   --gres=gpu:4           # gpus per node

##  node 지정하기
#SBATCH   --nodes=1              # the number of nodes 
#SBATCH   --ntasks-per-node=1
#SBATCH   --cpus-per-task=32

# function to init cleanup file -> 따로 만들어둔 cleanup.sh 실행
function cleanup {
	## docker container 종료
	docker stop ${DOCKER_NAME}

	## docker container 삭제
	docker rm -f ${DOCKER_NAME}
	
	exit
}

# Set Trap -> Slurm에서 SIGTERM signal을 사용
trap cleanup 0

cd  $SLURM_SUBMIT_DIR

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"

srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date

HOME_DIR=/home/jwshin0610

GPUS=${1}
DATASET_ALIAS=${2}
LR=${3}

TODAY=`date +%y%m%d%H%M%S`
DOCKER_NAME=jwshin0610_${TODAY}

echo $DOCKER_NAME

## 사용할 docker image 다운로드
## 버전 예시
## nvcr.io/nvidia/pytorch:23.03-py3: PyTorch Version 2.0.0a0+1767026
## nvcr.io/nvidia/pytorch:22.04-py3: PyTorch Version 1.12.0
## docker pull nvcr.io/nvidia/pytorch:23.03-py3

## 사용할 GPU의 UUID 구하기

echo "UUID GPU List"

UUIDLIST=$(nvidia-smi -L | cut -d '(' -f 2 | awk '{print$2}' | tr -d ")" | paste -s -d, -)
GPULIST=\"device=${UUIDLIST}\"
docker run -t --gpus ${GPULIST} ubuntu nvidia-smi -L

## docker container background(-d)로 생성
docker run -itd --gpus ${GPULIST} --name ${DOCKER_NAME} --ipc=host \
	-v ${HOME_DIR}:/NAS -v ${HOME_DIR}/data:/SSD \
	sodabori/vdp:240315 \

## 실행할 명령어 기술 (아래는 예시 코드) ##
## 실행할 명령어들은 docker exec bash -c <명령어> 를 통해서 가능함

# script 실행

docker exec ${DOCKER_NAME} bash -c "cd /NAS/JW/deit && bash ./scripts/deit_small_patch16_224_${DATASET_ALIAS}_finetune.sh ${GPUS} ${LR}"

#####################################

## docker container 종료
docker stop ${DOCKER_NAME}

## docker container 삭제
docker rm -f ${DOCKER_NAME}

## slurm 실행 정보 출력
date
squeue  --job  $SLURM_JOBID

echo  "##### END #####"