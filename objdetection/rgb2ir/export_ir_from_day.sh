#!/usr/bin/env bash

cd $HOME/models/research
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

# Job_name can't have spaces
job_name=ir_002_norm_m127s42
ckpt_number=471991

# Actual call
CUDA_VISIBLE_DEVICES=1 python3 object_detection/export_inference_graph.py \
    --input_type image_tensor \
    --pipeline_config_path $HOME/zauron/resources/nets_cfgs/configs/ssd_inceptionv2_$job_name.config \
    --trained_checkpoint_prefix /shared_experiments/kaist/models/obj_detector_retrain/models/train_$job_name/model.ckpt-$ckpt_number \
    --output_directory /shared_experiments/kaist/models/obj_detector_retrain/$job_name/