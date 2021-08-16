#!/bin/bash

set -e

IMAGE_NAME="pytorch/pytorch"
TAG=$1
BASE=$IMAGE_NAME:$TAG


docker build \
    --rm \
    --network=host \
    --tag=$BASE \
    --build-arg BASE=$IMAGE_NAME:$TAG\
    --file Dockerfile .
