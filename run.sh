#!/bin/bash

set -e
USER_ID="$(id -u)"

IMAGE_NAME="pytorch/pytorch"
TAG=$1
XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority

SHARED_DOCKER_DIR=/home/misys/shared_dir
SHARED_HOST_DIR=$HOME/shared_dir


VOLUMES="--volume=$XSOCK:$XSOCK:rw
         --volume=$XAUTH:$XAUTH:rw
         --volume=$SHARED_HOST_DIR:$SHARED_DOCKER_DIR:rw"

mkdir -p $SHARED_HOST_DIR

IMAGE=$IMAGE_NAME:$TAG
echo "Launching $IMAGE"

docker run \
    -it --rm \
    $VOLUMES \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    --env="USER_ID=$USER_ID" \
    --privileged \
    --net=host \
    --gpus all \
    $IMAGE