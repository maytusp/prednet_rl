#!/bin/bash --login
#SBATCH -p gpuL              # A100 GPUs
#SBATCH -G 1                 # 1 GPU
#SBATCH -t 1-0               # Wallclock limit
#SBATCH -n 1                 # One Slurm task
#SBATCH -c 12                # CPU cores available to the host code.


cd ..
SCRIPT_DIR="$(pwd)"
echo "Script directory: ${SCRIPT_DIR}"

source activate habitat

export MUJOCO_GL="${MUJOCO_GL:-egl}"

bash scripts/run_sf_simple_nonstationary.sh
bash scripts/run_ddpg_nonstationary.sh
