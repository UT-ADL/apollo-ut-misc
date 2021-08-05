
# Script for setup the Apollo for modular and full analysis tests

#### How to use
Please copy the `launch_files`, `setup_apollo.sh`, and `stop_apollo.sh` to the Apollo's repository at directory `/apollo/`.
After starting the Apollo docker and running the `docker/scripts/dev_into.sh` script.
- Run `./setup_apollo.sh` for running full tests.
- Run `./setup_apollo.sh modular` for running modular tests.
- Run `./setup_apollo.sh tl` for running full tests with traffic light status from simulator.
- Run `./stop_apollo.sh` to stop Apollo.
