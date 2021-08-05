
# Apollo miscellaneous repository

## This repository contains manuals, scripts, and configurations of Apollo.



- **`Apollo_vehicle_calibrations:`** Vehicle calibrations for Apollo.
- **`calibrating_vehicle:`** Manuals to generate the vehicle longitude dynamic calibrations for Apollo's control module.
- **`driving_real_lexus:`** Manuals to use Apollo on the real Lexus car.
- **`UT_Lexus_SVL_sensor_config:`** Sensor configurations of the UT_Lexus car for LGSVL.
- **`setup_apollo_scripts:`** Scripts to setup the apollo for modular and full analysis testing.
- **`maps:`** Apollo maps.

## Other manuals

### Using SVL simulated time
 - In order to use simulated time of the SVL simulator, you should add a clock sensor to the vehicle sensor configurations of the SVL simulator.
 - Change the `clock_mode: MODE_CYBER` to `clock_mode: MODE_MOCK` in the configuration file located at `apollo/cyber/conf/cyber.pb.conf` in the Apollo's repository.
 - Start the docker.






