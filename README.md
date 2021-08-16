# docker-for-amc

Docker image generation scripts for [AutoML for Model Compression (AMC)](https://github.com/mit-han-lab/amc.git)

## Prerequisites
- Docker
- Nvidia Driver
- CUDA
- cuDNN


## Usage

```
git clone https://github.com/re-ag/docker-for-amc.git
cd docker-for-amc/
```

GPU와 호환성이 있는 CUDA version에 맞는 원하는 version Pytorch Docker tag 복사 (from [pytorch/pytorch Docker Hub](https://hub.docker.com/r/pytorch/pytorch/tags?page=1&ordering=last_updated))

(ex. CUDA-11.1, pytorch 1.9.0 버전일 경우, tag는 "1.9.0-cuda11.1-cudnn8-devel")


```
./build.sh 1.9.0-cuda11.1-cudnn8-devel
./run.sh 1.9.0-cuda11.1-cudnn8-devel
```

