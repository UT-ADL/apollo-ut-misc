#!/bin/bash

filenames=`ls /apollo/calibrating_vehicle/*recorded.csv`

rm /apollo/calibrating_vehicle/result.csv

for file in $filenames
do
   /apollo/bazel-bin/modules/tools/vehicle_calibration/process_data $file
done
