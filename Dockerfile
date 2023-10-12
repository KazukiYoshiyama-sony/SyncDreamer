ARG TAG=11.8.0-cudnn8-devel-ubuntu22.04

FROM nvidia/cuda:${TAG}

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  \
    && apt-get install -y wget \
        git \
        python3 \
        python3-venv \
        python3-dev \
        python3-pip \
        less \
        build-essential \
        gfortran \
        libibverbs-dev \
        ca-certificates \
        bzip2 \
        ca-certificates \
        curl \
        libgl1-mesa-glx \
        openssh-client \
        zip \
        libxi6 \
        libglib2.0-0 \
        ffmpeg \
        libcairo2 \
        libcairo2-dev

RUN pip3 install -U pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 100
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 100

RUN pip install -U torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu118

COPY ./requirements.txt /opt/requirements.txt
RUN export TCNN_CUDA_ARCHITECTURES=80 \
    && pip install -r /opt/requirements.txt

ENV PYTHONPATH=.:${PYTHONPATH}

