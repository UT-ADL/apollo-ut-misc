# Manuals to calibrate the vehicle


## How to use
- Copy the `./calibrating_vehicle` directory to the `/apollo/modules/calibration/` directory of the Apollo's repository.
- Set the driving mode in `/apollo/modules/canbus/conf/canbus_conf.pb.txt` to `AUTO_SPEED_ONLY`.
- Select a wide area site to drive the vehicle for collecting the data.
- Start the docker container.
- Copy `../driving_real_lexus/init_can0.sh` to a desired directory on the ubuntu (not Apollo's repository).
- Run `bash <path_to_init_can0.sh>` (not in docker container) to initialize the can interface.
- Run following commands in the docker container to install necessary packages.
    ```sh
    sudo apt-get update
    sudo apt-get install tcl-dev tk-dev python3-tk
    ```
- Run `./scripts/bootstrap.sh` to setup `Dreamview`.
- Open `Dreamview`.
- Enable `Localization` and `Canbus` modules.


