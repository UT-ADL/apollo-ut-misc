
# Manuals to run Apollo on the real Lexus car 

**NB!**: In order to use Apollo for the real Lexus, the `apollo-ut` repository must be used. (`https://gitlab.cs.ut.ee/autonomous-driving-lab/apollo-ut.git`) 




## Driving car without Perception, Prediction, and Traffic Light modules.

If you want to engage the Apollo to drive the vehicle, Apollo needs prediction and traffic light messages. That is why prediction and traffic light messages must be mocked so that Apollo can operate. To run the Apollo follow these steps.

- Clone and build the `apollo-ut` repository.
- Add `UT_Lexus` vehicle configurations and desired maps to the Apollo's repository.
- Copy `./init_can0.sh` to a desired directory on the ubuntu (not Apollo's repository).
- Run `bash <path_to_init_can0.sh>` (not in docker container) to initialize the can interface.
- Run `./scripts/bootstrap.sh` (inside docker container).
- Open the `Dreamview`.
- Choose the `UT Lexus` vehicle and the correct map from Dreamview.
- Enable `Localization`, `Routing`, `Planning`, `Control` and `Transform` modules.
- Run `./bazel-bin/modules/tools/perception/empty_prediction` inside docker container to mock prediction messages.
- Run `cyber_launch start modules/tools/manual_traffic_light/manual_traffic_light.launch` to mock traffic light messages (you can change traffic lights status using this node).
- Set the destination on the map in Dreamview.
- Run `./bazel-bin/modules/control/tools/pad_terminal` to engage/disengage vehicle.
- Apollo should start driving the vehicle after engaging.

