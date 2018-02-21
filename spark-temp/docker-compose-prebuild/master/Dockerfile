FROM rockerextra/spark:3.4.3
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

RUN mkdir -p /etc/services.d/spark-master \
    && echo '#!/bin/bash \n /opt/util/bin/start-spark master' > /etc/services.d/spark-master/run

