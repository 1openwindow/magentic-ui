#!/bin/bash

CWD="$(pwd)"
if [[ "${CWD##*/}" != "docker" ]]; then
    echo "Error: Must run this script from the docker folder."
    exit 1
fi

# Run all build scripts in parallel in their respective directories
(
    cd magentic-ui-browser-docker && sh build.sh
) &

(
    cd magentic-ui-python-env && sh build.sh
) &

(
    cd magentic-ui-vscode-docker && sh build.sh
) &

wait
echo "All builds completed."