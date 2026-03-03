#!/bin/bash
# Usage: ./start_rstudio.sh [port]

PORT=${1:-8888}
SIF="$(dirname "$0")/../project-container.sif"
WORKDIR=$(mktemp -d)

echo "Starting RStudio Server on port $PORT"
echo "Open browser at: http://localhost:$PORT"
echo "Username: $(whoami)"
echo "Password: Set PASSWORD env variable (default: rstudio)"
echo ""

PASSWORD=${PASSWORD:-rstudio}

singularity exec \
    --scratch /run,/var/lib/rstudio-server \
    --workdir "$WORKDIR" \
    --bind "$(pwd):/project" \
    --bind /shared:/data/raw \
    --env PASSWORD=$PASSWORD \
    --env RS_INITIAL_PROJECT=/project/project.Rproj \
    "$SIF" \
    rserver \
        --www-address=0.0.0.0 \
        --www-port=$PORT \
        --server-user=$(whoami) \
        --auth-none=0 \
        --auth-pam-helper-path=pam-helper
