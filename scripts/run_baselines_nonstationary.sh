#!/bin/bash --login
#SBATCH -p gpuL              # A100 GPUs
#SBATCH -G 1                 # 1 GPU
#SBATCH -t 1-0               # Wallclock limit
#SBATCH -n 1                 # One Slurm task
#SBATCH -c 12                # CPU cores available to the host code.

set -euo pipefail

cd "$(dirname "$0")/.."
SCRIPT_DIR="$(pwd)"
echo "Script directory: ${SCRIPT_DIR}"

CONDA_ENV="${CONDA_ENV:-simple_sfs}"
source activate "${CONDA_ENV}"

bash scripts/run_sf_simple_nonstationary.sh
bash scripts/run_ddpg_nonstationary.sh
