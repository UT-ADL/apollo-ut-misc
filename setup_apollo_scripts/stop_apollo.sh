#!/bin/bash






# stop modules
cyber_launch stop launch_files/localization.launch 
cyber_launch stop launch_files/static_transform.launch 
cyber_launch stop launch_files/perception.launch 
cyber_launch stop launch_files/perception_trafficlight.launch 
cyber_launch stop launch_files/prediction.launch 
pkill -f prediction
cyber_launch stop launch_files/routing.launch 
cyber_launch stop launch_files/planning.launch
pkill -f planning 
cyber_launch stop launch_files/control.launch 
cyber_launch stop modules/monitor/launch/monitor.launch
cyber_launch stop modules/dreamview/launch/dreamview.launch

pkill -f bridge



# stop dreamview
scripts/bootstrap_lgsvl.sh stop
