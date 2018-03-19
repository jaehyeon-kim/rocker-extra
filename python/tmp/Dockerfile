FROM rocker/tidyverse:latest
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

ARG PYTHON_VERSION
ENV PYTHON_VERSION=${PYTHON_VERSION:-3.6.4}

## https://unix.stackexchange.com/questions/332641/how-to-install-python-3-6
RUN apt-get update \
    && apt-get install -y \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make -j8 \
    && make altinstall
    
