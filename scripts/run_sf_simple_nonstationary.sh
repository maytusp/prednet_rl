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

TASKS="${TASKS:-humanoid_run quadruped_jump hopper_flip}"
SEEDS="${SEEDS:-1}"
FRAMES="${FRAMES:-2000000}"
DEVICE="${DEVICE:-cuda}"
OBS_TYPE="${OBS_TYPE:-states}"
FRAME_STACK="${FRAME_STACK:-3}"
ACTION_REPEAT="${ACTION_REPEAT:-1}"
USE_WANDB="${USE_WANDB:-true}"
WANDB_MODE="${WANDB_MODE:-online}"
WANDB_PROJECT="${WANDB_PROJECT:-prednet_rl}"
WANDB_ENTITY="${WANDB_ENTITY:-maytusp}"
WANDB_GROUP="${WANDB_GROUP:-}"
SAVE_EVAL_VIDEO="${SAVE_EVAL_VIDEO:-false}"
EXPERIMENT="${EXPERIMENT:-nonstationary_hard3}"

for task in ${TASKS}; do
  domain="${task%%_*}"
  for seed in ${SEEDS}; do
    python full_train.py \
      agent=sf_simple \
      domain="${domain}" \
      "task_sequence=[${task}]" \
      num_exposures=1 \
      num_train_frames="${FRAMES}" \
      seed="${seed}" \
      device="${DEVICE}" \
      obs_type="${OBS_TYPE}" \
      frame_stack="${FRAME_STACK}" \
      action_repeat="${ACTION_REPEAT}" \
      use_wandb="${USE_WANDB}" \
      wandb_mode="${WANDB_MODE}" \
      wandb_project="${WANDB_PROJECT}" \
      wandb_entity="${WANDB_ENTITY}" \
      wandb_group="${WANDB_GROUP}" \
      save_eval_video="${SAVE_EVAL_VIDEO}" \
      experiment="${EXPERIMENT}_${task}_sf_simple"
  done
done
