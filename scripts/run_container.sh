#!/bin/bash
# run_container.sh
SCRIPT_DIR=$(dirname "$(realpath "$0")")
apptainer shell --bind /shared:/data/raw "$SCRIPT_DIR/../project-container.sif"