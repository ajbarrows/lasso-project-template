#!/bin/bash
# run_container.sh [script]

if [ -z "$1" ]; then
    apptainer shell --bind /shared:/data/raw project-container.sif
else
    apptainer exec --bind /shared:/data/raw project-container.sif "$@"
fi