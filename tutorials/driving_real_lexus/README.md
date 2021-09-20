
# Manuals to run Apollo on the real Lexus car 

## Documentation
* [Requred Apollo Repository](#required-apollo-repository)
* [Adding UT Lexus Vehicle Configurations](#adding-ut-lexus-vehicle-configurations)
* [Setup Apollo](#setup-apollo)
* [Waypoints Recording and Following](#waypoints-recording-and-following)
* [Autonomous Driving](#autonomous-driving)


## Required Apollo Repository

**NB!**: To use Apollo for the real Lexus, the [`apollo-ut`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut.git) repository must be used. (`https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut.git`) 

## Adding UT Lexus Vehicle Configurations

- Copy `UT_Lexus` directory from repository [`apollo-ut-misc/Apollo_vehicle_calibrations`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut-misc/-/tree/master/Apollo_vehicle_calibrations) to Apollo's docker container at path `apollo/modules/calibration/data/`

## Setup Apollo

- Run these commands in the Ubuntu terminal outside of the docker container to set up canbus interface.
  ```
  sudo modprobe can
  sudo modprobe can_raw
  sudo ip link set can0 type can bitrate 500000
  sudo ip link set can0 up
  ```
- Launch the container `./docker/scripts/dev_start.sh`
- Enter the container `./docker/scripts/dev_into.sh`
- Start Dreamview `./scripts/bootstrap.sh`
- Select correct vehicle configurations by selecting `UT Lexus` from the vehicle selection dropdown in the top-right menu of Dreamview.
- Open the `Module Controller` tap (from the left side menu).
- Enable `Localization`, `Transform`, `Canbus` modules.


<br>
<br>

## Waypoints Recording and Following

### Record
- Run Apollo and run `Localization`, `Transform` and `Canbus` modules.
- Setup and run rtk_recorder.sh:

  ```
  ./scripts/rtk_recorder.sh setup
  ./scripts/rtk_recorder.sh start
  ```

- Drive the car around to record waypoints. When you are finished, press `Ctrl + C`.
- The recorded waypoints are stored in the `/apollo/data/log/garage.csv`

### Replay the record

- Drive the car manually back to the initial location.
- Run the following to start rtk_player.

  ```
  ./scripts/rtk_player.sh setup
  ./scripts/rtk_player.sh start
  ```

- Run following to stop
  ```
  ./scripts/rtk_player.sh stop
  ./scripts/control.sh stop
  ```

<br>
<br>


## Autonomous Driving

If you want to engage the Apollo to drive the vehicle, Apollo needs prediction and traffic light cyber messages. That is why prediction and traffic light messages must be mocked so that Apollo can operate. To run the Apollo, follow these steps.

- Clone and build the `apollo-ut` repository.
- Add `UT_Lexus` vehicle configurations and desired maps to Apollo's repository.
- Copy `./init_can0.sh` to the desired directory on the ubuntu (not Apollo's repository).
- Run `bash <path_to_init_can0.sh>` (not in docker container) to initialize the can interface.
- Launch the container `./docker/scripts/dev_start.sh`
- Enter the container `./docker/scripts/dev_into.sh`
- Run `./scripts/bootstrap.sh` (inside docker container).
- Open the `Dreamview`.
- Choose the `UT Lexus` vehicle and the correct map from Dreamview.
- Enable `Localization`, `Routing`, `Planning`, `Control`, `Canbus` and `Transform` modules.
- Run `./bazel-bin/modules/tools/perception/empty_prediction` inside docker container to mock prediction messages.
- Run `cyber_launch start modules/tools/manual_traffic_light/manual_traffic_light.launch` to mock traffic light messages (you can change traffic lights status using this node).
- Set the destination on the map in Dreamview.
- Run `./bazel-bin/modules/control/tools/pad_terminal` to engage/disengage vehicle.
- Follow instructions of the `pad_terminal` to engage and disengage the Apollo.
- Apollo should start driving the vehicle after engaging.


