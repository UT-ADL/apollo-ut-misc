
# Apollo maps

## Prepared Apollo OpenDrive maps:

- `./raadi_loop`: Raadi loops map in raadi parking lot.
- `./raadi_near_delta`: Raadi loops map near delta.

    ### How to use
    - Copy each map directory to the Apollo's docker container at directory `/apollo/modules/map/data/`
    - Prepare the map using the instructions below.
    - Start the `Dreamview` with `./scripts/bootstrap.sh` or `./scripts/bootstrap_lgsvl.sh` in docker container.
    - Choose desired map from dreamview map dropdown.



## Prepare Apollo OpenDrive maps

- Manuals to prepare Apollo OpenDrive map from `base_map` file.
    
    ### From `base_map.xml` file 

    If you have the `base_map.xml` file, follow these instructions to prepare the Apollo OpenDrive map.

    - Go to the directory `/apollo/modules/map/data`
    - `mkdir <your_map_name>`
    - `cd <your_map_name>`
    - Place your `base_map.xml` file in this directory.
    - `MAP_NAME="<your_map_name>"`
    - `./bazel-bin/modules/map/tools/proto_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME`
    - `./scripts/generate_routing_topo_graph.sh --map_dir=./modules/map/data/$MAP_NAME`
    - `./bazel-bin/modules/map/tools/sim_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME`



    ### From `base_map.bin` file

    If you have the `base_map.bin` file, follow these instructions to prepare the Apollo OpenDrive map.

    - Go to the directory `/apollo/modules/map/data`
    - `mkdir <your_map_name>`
    - `cd <your_map_name>`
    - Place your `base_map.bin` file in this directory.
    - `MAP_NAME="<your_map_name>"`
    - `./scripts/generate_routing_topo_graph.sh --map_dir=./modules/map/data/$MAP_NAME`
    - `./bazel-bin/modules/map/tools/sim_map_generator --map_dir=./modules/map/data/$MAP_NAME --output_dir=./modules/map/data/$MAP_NAME`


