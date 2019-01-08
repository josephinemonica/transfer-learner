#!/usr/bin/env bash

cd $HOME/models/research
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

# Job_name can't have spaces
job_name=rgb_daynight
dataset=zurich
additional_tags=_ckpt
ckpt_number=197467

# Actual call
CUDA_VISIBLE_DEVICES=3 python3 object_detection/export_inference_graph.py \
    --input_type image_tensor \
    --pipeline_config_path $HOME/WormholeLearning/resources/nets_cfgs/configs/ssd_inceptionv2_${job_name}.config \
    --trained_checkpoint_prefix /media/sdc/andya/wormhole_learning/models/obj_detector_retrain/train_${job_name}/model.ckpt-${ckpt_number} \
    --output_directory /media/sdc/andya/wormhole_learning/models/obj_detector_retrain/ssd_inception_v2_${dataset}_${job_name}${additional_tags}/