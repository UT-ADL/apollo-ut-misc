#!/bin/bash	

map_=$(tail -n 1 modules/common/data/global_flagfile.txt)
#desired_map='--map_dir=/apollo/modules/map/data/borregas_ave'
desired_map='--map_dir=/apollo/modules/map/data/tartu3'

#desired_car='modules/calibration/data/Lincoln2017MKZ_LGSVL'
desired_car='modules/calibration/data/UT_Lexus_LGSVL'


echo "Select map"
if [[ $map_ != $desired_map  ]]
then
  echo $desired_map >> modules/common/data/global_flagfile.txt
  echo 'set map'
fi


# start dreamview
echo "Start Dreamview"
scripts/bootstrap_lgsvl.sh 

# select car config
echo "Select Vehicle"
nohup scripts/switch_vehicle.sh $desired_car

# start bridge
echo "Setup Bridge"
nohup scripts/bridge.sh & disown


# start modules
case "$1" in
    modular)
        echo "Start modules for modular testing"
        nohup cyber_launch start launch_files/localization.launch & disown
	nohup cyber_launch start launch_files/static_transform.launch & disown
	nohup cyber_launch start launch_files/prediction.launch & disown
	nohup cyber_launch start launch_files/routing.launch & disown
	nohup cyber_launch start launch_files/planning.launch & disown
	sleep 2
	nohup cyber_launch start launch_files/control.launch & disown
	echo "Done"
        ;;
    tl)
	echo "Start modules for full testing with traffic light"
	nohup cyber_launch start launch_files/localization.launch & disown
	nohup cyber_launch start launch_files/static_transform.launch & disown
	nohup cyber_launch start launch_files/perception.launch & disown
	nohup cyber_launch start launch_files/prediction.launch & disown
	nohup cyber_launch start launch_files/routing.launch & disown
	nohup cyber_launch start launch_files/planning.launch & disown
	sleep 2
	nohup cyber_launch start launch_files/control.launch & disown
	echo "Done"
        ;;
    *)
	echo "Start modules for full testing"
	nohup cyber_launch start launch_files/localization.launch & disown
	nohup cyber_launch start launch_files/static_transform.launch & disown
	nohup cyber_launch start launch_files/perception.launch & disown
	nohup cyber_launch start launch_files/perception_trafficlight.launch & disown
	nohup cyber_launch start launch_files/prediction.launch & disown
	nohup cyber_launch start launch_files/routing.launch & disown
	nohup cyber_launch start launch_files/planning.launch & disown
	sleep 2
	nohup cyber_launch start launch_files/control.launch & disown
	echo "Done"
        ;;
esac



