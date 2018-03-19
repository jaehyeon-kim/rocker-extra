FROM rockerextra/python:3.4
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

RUN http_proxy=http://10.74.1.25:8080 apt-get update \
    && http_proxy=http://10.74.1.25:8080 apt-get install -y procps

RUN curl -x http://10.74.1.25:8080 https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py --proxy 10.74.1.25:8080 
    
RUN pip --proxy=http://10.74.1.25:8080 install jupyterlab

RUN mkdir -p /etc/services.d/jupyter \
    && echo '#!/usr/bin/with-contenv sh \n jupyter lab --ip=0.0.0.0 --port=8888 --allow-root' > /etc/services.d/jupyter/run
