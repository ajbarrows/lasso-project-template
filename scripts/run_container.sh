#!/bin/bash
# run_container.sh
SCRIPT_DIR=$(dirname "$(realpath "$0")")
apptainer shell --bind /shared:${SCRIPT_DIR}/data/raw "$SCRIPT_DIR/mycontainer.sif"