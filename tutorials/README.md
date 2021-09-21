# Baidu Apollo Tutorials

## Documentation
* [Software Stack](#software-stack)
* [Prerequisites](#prerequisites)
* [Prerequisites Installation](#prerequisites-installation)
  + [NVIDIA GPU Driver](#nvidia-gpu-driver)
  + [Docker Engine](#docker-engine)
  + [NVIDIA Container Toolkit](#nvidia-container-toolkit)
* [Apollo Installation](#apollo-installation)
* [SVL Simulator Setup](#svl-simulator-setup)
* [Apollo Quick Start](#apollo-quick-start)
* [Apollo Quick Start With UT Lexus Simulation Vehicle](#apollo-quick-start-with-ut-lexus-simulation-vehicle)
  + [Sumulation Setup](#simulation-setup)
  + [Apollo Setup](#apollo-setup)
    - [Adding HD Map](#adding-hd-map)
    - [Adding Vehicle Configurations](#adding-vehicle-configurations)
    - [Run Apollo](#run-apollo)
* [Start and Stop modules using command line](#start-and-stop-modules-using-command-line)
  + [Using Scripts](#using-scripts)
  + [Using Cyber Commands](#using-cyber-commands)
* [Monitoring in Apollo](#monitoring-in-apollo)
  + [Monitoring the cyber topics](#monitoring-the-cyber-topics)
  + [Monitoring the list of running modules and nodes](#monitoring-the-list-of-running-modules-and-nodes)
  + [Visualizing the output of the sensors](#visualizing-the-output-of-the-sensors)
* [Record sensor data](#record-sensor-data)
* [Record the waypoints of a trajectory and replay it](#record-the-waypoints-of-a-trajectory-and-replay-it)
  + [Record](#record)
  + [Replay the record](#replay-the-record)
* [Adding Maps](#adding-maps)
* [Adding Vehicle Configurations](#adding-vehicle-configurations)
* [Using Simualtion Time](#using-simulation-time)
* [Driving Real Lexus Car](./driving_real_lexus/README.md)


## Software Stack

- Baidu Apollo v5.5+ (`git clone` from [here](https://github.com/ApolloAuto/apollo))
- LGSVL Simulator (documentation from [here](https://www.lgsvlsimulator.com/docs/))
- Docker Engine (documentation from [here](https://docs.docker.com/engine/install/ubuntu/))

<br>
<br>

## Prerequisites

- Ubuntu 16.04 or later (Ubuntu 18.04 is preferred)
- Nvidia graphics card (required for Perception)
- Nvidia proprietary driver (>=410.48) must be installed
- Docker 19.03+

<br>
<br>

## Prerequisites Installation

Following installation tutorials are from [Apollo GitHub page](https://github.com/ApolloAuto/apollo/blob/master/docs/specs/prerequisite_software_installation_guide.md)

### NVIDIA GPU Driver

```
sudo apt-get update
sudo apt-add-repository multiverse
sudo apt-get update
sudo apt-get install nvidia-driver-440
```

Type `nvidia-smi` to check if NVIDIA GPU Driver works fine.

### Docker Engine

- Apollo 6.0+ requires Docker 19.03+ to work properly
- Follow this [tutorial](https://docs.docker.com/engine/install/ubuntu/)

### NVIDIA Container Toolkit

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get -y update
sudo apt-get install -y nvidia-container-toolkit
```

Restart Docker daemon for the changes above to take effect.
`sudo systemctl restart docker`

<br>
<br>

## Apollo Installation

- Clone the repository `git clone https://github.com/ApolloAuto/apollo` (Apollo master branch)
- Launch the container `./docker/scripts/dev_start.sh`
- Enter the container `./docker/scripts/dev_into.sh`
- Build apollo `./apollo.sh build_opt_gpu` (optimized, not debug, with GPU support) (this will take some time)
- **NB!** To build just a specific module of the apollo run `./apollo.sh build_opt_gpu [desired module]`
  - Ex: `./apollo.sh build_opt_gpu canbus`

**NB!** The Apollo build may fail on machines with less than 1GB of RAM per CPU core due to aggressive parallelization in the build, as discussed in [Apollo issue 7719](https://github.com/ApolloAuto/apollo/issues/7719).

**NB!** To stop the Apollo, run following command outside the docker container `./docker/scripts/dev_start.sh stop`

<br>
<br>

## SVL Simulator Setup

- Create an account on the [SVL Simulator website](https://www.svlsimulator.com/).
- Follow [here](https://www.svlsimulator.com/docs/installation-guide/installing-simulator/) to install SVL Simulator.
- After installing the SVL Simulator, run the simulation and follow [here](https://www.svlsimulator.com/docs/installation-guide/installing-simulator/#linktocloud) in order to link to the cloud.
- Go to the SVL Simulator [dashbord](https://wise.svlsimulator.com/maps/public).
- Click on `Simulations` on the left side menu, and then click `Add New` on the top right side of the page.
- Add desired name and description for the simulation and select a cluster and click on `Next`.
- Select `Random Traffic` as `Runtime Template`.
- Select `BorregasAve` map.
- Select `Lincoln2017MKZ` vehicle. After selecting the vehicle, select `Apollo 5.0 (full analysis)` as sensor configurations.
- (Optional) Set the Time of Day and weather settings.
- (Optional) Enable Traffic and Pedestrians.
- Click on `Next`.
- Select `Apollo 5.0` as Autopilot.
- Enter `localhost:9090` as Bridge connection. (if Apollo would run on a different machine, put the IP address of that machine) 
- Click `Next` and `Publish`.
- Click on `Run Simulation` to run the simulation.

<br>
<br>

## Apollo Quick Start

- Go to Apollo's directory `cd <apollo-dir>`
- Launch the docker container `./docker/scripts/dev_start.sh`
- Enter the docker container `./docker/scripts/dev_into.sh`
- Start Dreamview `./scripts/bootstrap_lgsvl.sh`
- Start bridge `./scripts/bridge.sh`
- Open Apollo Dreamview in a browser by navigating to `localhost:8888`.
- Select the `Lincoln2017MKZ LGSVL` vehicle and `Borregas Ave` map from the top right dropdowns.
- Select the `Mkz Lgsvl` setup mode from the top menu (on the left side of the vehicle dropdown).
- Open the `Module Controller` tap (from the left side menu)
- Enable `Localization`, `Transform`, `Perception`, `Traffic Light`, `Planning`, `Prediction`, `Routing`, and `Control` modules.
- Open the `Route Editing` tab.
- Select a destination by clicking on a lane line and clicking `Submit Route` on the top of the page.
- Watch the vehicle navigate to the destination
- More instructions from [here](https://www.svlsimulator.com/docs/archive/2020.06/apollo5-0-instructions/)

<br>
<br>

## Apollo Quick Start With UT Lexus Simulation Vehicle

### Simulation Setup
- Go to the SVL Simulator [dashbord](https://wise.svlsimulator.com/maps/public).
- Click on `Simulations` on the left side menu, and then click `Add New` on the top right side of the page.
- Add desired name and description for the simulation and select a cluster and click on `Next`.
- Select `Random Traffic` as `Runtime Template`.
- Select `Tartu` map.
- Select `UT Lexus` vehicle. After selecting the vehicle, select `Apollo_UT_Lexus`, `Apollo_UT_Lexus(Modular)` or `Apollo_UT_Lexus(TrafficLight)`  as sensor configurations.
  + `Apollo_UT_Lexus`: sensor configurations for conducting a full analysis test. I.e., Apollo has to do the perception, traffic light detection, planning, localization, and control.
  + `Apollo_UT_Lexus(TrafficLight)`: sensor configurations for conducting a semi-full analysis. I.e., traffic light status messages will be published by SVL simulator, and Apollo must do the localization, perception, prediction, planning, and control.
  + `Apollo_UT_Lexus(Modular)`: sensor configurations for conducting a modular test. I.e., bounding boxes of the surrounding objects and statuses of the traffic lights will be published by SVL simulator. So, Apollo must do the localization, prediction, planning, and control only.
- (Optional) Set the Time of Day and weather settings.
- (Optional) Enable Traffic and Pedestrians.
- Click on `Next`.
- Select `Apollo 5.0` as Autopilot.
- Enter `localhost:9090` as Bridge connection. (if Apollo would run on a different machine, put the IP address of that machine) 
- Click `Next` and `Publish`.
- Click on `Run Simulation` to run the simulation.

### Apollo Setup
  #### Adding HD Map
  - Go to the SVL Simulator [dashbord](https://wise.svlsimulator.com/maps/public).
  - Click on `Maps` on the left side menu, and then click on the map you have selected for the simulation.
  - Download `Apollo50` map from `HD maps` section.
  - You will get `base_map.bin` file.
  - Go to the directory `/apollo/modules/map/data`
  - `mkdir <your_map_name>`
  - `cd <your_map_name>`
  - Place your `base_map.bin` file in this directory.
  - Run following commands.
    ```
    MAP_NAME="<your_map_name>"

    ./scripts/generate_routing_topo_graph.sh --map_dir=./modules/map/data/$MAP_NAME

    ./bazel-bin/modules/map/tools/sim_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME
    ```
  
  #### Adding Vehicle Configurations
  - Copy `UT_Lexus_LGSVL` directory from repository [`apollo-ut-misc/Apollo_vehicle_calibrations`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut-misc/-/tree/master/Apollo_vehicle_calibrations) to Apollo's docker container at path `apollo/modules/calibration/data/`

  #### Run Apollo
  - Go to Apollo's directory `cd <apollo-dir>`
  - Launch the docker container `./docker/scripts/dev_start.sh`
  - Enter the docker container `./docker/scripts/dev_into.sh`
  - Start Dreamview `./scripts/bootstrap_lgsvl.sh`
  - Start bridge `./scripts/bridge.sh`
  - Open Apollo Dreamview in a browser by navigating to `localhost:8888`.
  - Select the `UT Lexus LGSVL` vehicle and `Tartu` map from the top right dropdowns.
  - Select the `Mkz Lgsvl` setup mode from the top menu (on the left side of the vehicle dropdown).
  - Open the `Module Controller` tap (from the left side menu)
  - Enable `Localization`, `Transform`, `Perception`, `Traffic Light`, `Prediction`, `Routing`, `Planning`, and `Control` modules.
    + **NB!** If you have selected `TrafficLight` sensor configurations in the SVL, enable `Localization`, `Transform`, `Perception`, `Prediction`, `Routing`, `Planning`, and `Control` modules only.
    + **NB!** If you have selected `Modular` sensor configurations in the SVL, enable `Localization`, `Transform`, `Prediction`, `Routing`, `Planning`, and `Control` modules only.
  - Open the `Route Editing` tab.
  - Select a destination by clicking on a lane line and clicking `Submit Route` on the top of the page.
  - Watch the vehicle navigate to the destination


<br>
<br>

## Start and Stop modules using command line

### Using Scripts

- To start a module use command `./scripts/<module_name>.sh start`
  - Ex: `./scripts/control.sh start`
- To stop a module type `./scripts/<module_name>.sh stop`
  - Ex: `./scripts/control.sh stop`

### Using Cyber Commands
- To start a module use command `cyber_launch start ./modules/<module_name>/<path_to_launch_file>`
  - Ex: `cyber_launch start ./modules/control/launch/control.launch`
- To stop a module type `cyber_launch stop ./modules/<module_name>/<path_to_launch_file>`
  - Ex: `cyber_launch stop ./modules/control/launch/control.launch`

<br>
<br>

## Monitoring in Apollo

### Monitoring the cyber topics

- Run `./cyber_monitor` from the `/apollo` directory to list all the topics of sensors and modules of Apollo.

### Monitoring the list of running modules and nodes

- Run `./cyber_node list` from the `/apollo` directory to list all the running modules and nodes.

### Visualizing the output of the sensors

- Run `./cyber_visualizer` from the `/apollo` directory to visualize the outputs of the sensors like Camera and Lidar.

<br>
<br>

## Record sensor data

- Run `cyber_recorder record -c <channel_names>` to record the data of desired channels.
  - Ex:
    ```
    cyber_recorder record -c /apollo/sensor/lidar128/compensator/PointCloud2 /apollo/sensor/gnss/odometry
    ```
  - **NOTE** Channel names can be found using `./cyber_monitor`
- To record the data of all channels, run `cyber_recorder record -a`
- Now drive around in the simulator.
- To stop recording, press `Ctrl+C`
- You can find recordings in `apollo/` directory.

<br>
<br>


## Record the waypoints of a trajectory and replay it

### Record
- Run Apollo and run `Localization` and `Transform` modules.
- Run the LGSVL Simulator.
- Connect to simulator using `./scripts/bridge.sh`
- Setup and run rtk_recorder.sh:

  ```
  ./scripts/rtk_recorder.sh setup
  ./scripts/rtk_recorder.sh start
  ```

- Drive around in the simulator to record waypoints. When you are finished, press `Ctrl + C`.
- The recorded waypoints are stored in the `/apollo/data/log/garage.csv`

### Replay the record

- Put the car into the initial location by pressing the `F12` button in the simulator.
- Run the following to start rtk_player

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

## Adding Maps

Apollo maps can be obtained from the SVL simulator or [`apollo-ut-misc/maps`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut-misc/-/tree/master/maps) repository.

### From `apollo-ut-misc` repository. (`base_map.xml` file) 

  If you have the `base_map.xml` file, follow these instructions to prepare the Apollo OpenDrive map.

  - Go to the directory `/apollo/modules/map/data`
  - `mkdir <your_map_name>`
  - `cd <your_map_name>`
  - Place your `base_map.xml` file in this directory.
  - Run following commands.
    ```
    MAP_NAME="<your_map_name>"

    ./bazel-bin/modules/map/tools/proto_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME

    ./scripts/generate_routing_topo_graph.sh --map_dir=./modules/map/data/$MAP_NAME

    ./bazel-bin/modules/map/tools/sim_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME

    ```

### From SVL Simulator maps. (`base_map.bin` file)

  You can download the Apollo OpenDrive maps from the SVL Simulator. To download a map follow these instructions.
  - Go to the [`SVL Simulator dashboard`](#https://wise.svlsimulator.com/maps/public).
  - Open the `Maps` section from the left side menu.
  - Select the map you want to download.
  - Find the `HD maps` section on the page and click on the download icon of `apollo50`.
  - You will get the `base_map.bin` file.

  If you have the `base_map.bin` file, follow these instructions to prepare the Apollo OpenDrive map.

  - Go to the directory `/apollo/modules/map/data`
  - `mkdir <your_map_name>`
  - `cd <your_map_name>`
  - Place your `base_map.bin` file in this directory.
  - Run following commands.
    ```
    MAP_NAME="<your_map_name>"

    ./scripts/generate_routing_topo_graph.sh --map_dir=./modules/map/data/$MAP_NAME

    ./bazel-bin/modules/map/tools/sim_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME

    ```

<br>
<br>

## Adding Vehicle Configurations

- You can find some vehicle configurations for Apollo in the [`apollo-ut-misc/Apollo_vehicle_calibrations`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut-misc/-/tree/master/Apollo_vehicle_calibrations) repository.

- Copy one of the configurations directory from repository [`apollo-ut-misc/Apollo_vehicle_calibrations`](https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut-misc/-/tree/master/Apollo_vehicle_calibrations) to Apollo's docker container at path `apollo/modules/calibration/data/`
- After running the Apollo and the Dreamview, you can find the vehicle configurations to select in the vehicle dropdown on the top right dropdown menu.

<br>
<br>

## Using Simulation Time

You can use SVL simulated time for cyber time instead of system time. To use simulated time, follow these instructions.

- In order to use the simulated time of the SVL simulator, you should add a clock sensor to the vehicle sensor configurations of the SVL simulator.
  * Go to the [`SVL Simulator dashboard`](#https://wise.svlsimulator.com/maps/public).
  * Click on the `Vehicles` on the left side menu.
  * Select the vehicle you are using with Apollo.
  * Select the sensor configurations that you are using.
  * Check the list of sensors and make sure that the clock is present.
  * If the clock sensor is not present, go to the vehicle configurations list of the selected vehicle.
  * Clone the desired configuration using the clone button.
  * Click on the `+` icon in the list of sensors.
  * Add the `Clock Sensor` to the list of sensors.
  * Add `/clock` to the `Topic` section of the sensor details.
  * Save the configurations.
  * Start a simulation with a vehicle and the sensor configurations that contain a clock sensor in it.

- Change the `clock_mode: MODE_CYBER` to `clock_mode: MODE_MOCK` in the configuration file located at `apollo/cyber/conf/cyber.pb.conf` in the Apollo's repository.
- Start the docker container and enter it.
- After running the bridge, cyber will use the time messages that are being published from the SVL simulator as cyber time.

