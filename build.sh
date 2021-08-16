#!/bin/bash

set -e

IMAGE_NAME="pytorch/pytorch"
TAG_PREFIX="local"
TAG=$1
BASE=$IMAGE_NAME:$TAG_PREFIX-$TAG


docker build \
    --rm \
    --network=host \
    --tag=$BASE \
    --build-arg BASE=$IMAGE_NAME:$TAG\
    --file Dockerfile .
