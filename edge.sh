#!/bin/bash

# This script is a wrapper for running the vertex:edge Docker image
# As well as running the image itself, it also mounts the Google Cloud secret key
# So that we will be authenticated with GCP while inside the Docker container

ACCOUNT=$(gcloud config get-value account)
HOST_UID=$(id -u)
HOST_GID=$(id -g)
docker run -it \
 -v "$(pwd)":/project/ \
 -v ~/.config/gcloud/:/root/.config/gcloud/ \
 -e ACCOUNT="$ACCOUNT" -e HOST_UID="$HOST_UID" -e HOST_GID="$HOST_GID" \
 --entrypoint bash fuzzylabs/edge ./edge_docker_entrypoint.sh "$@"
