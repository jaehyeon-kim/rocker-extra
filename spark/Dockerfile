FROM rockerextra/python:3.4.3
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

ARG SPARK_VERSION
ENV SPARK_VERSION=${SPARK_VERSION:-2.2.0}
ARG HADOOP_VERSION
ENV HADOOP_VERSION=${HADOOP_VERSION:-2.7.3}
ARG DOWNLOAD_URL
ENV DOWNLOAD_URL=${DOWNLOAD_URL:-http://d3kbcqa49mib13.cloudfront.net}
ARG SPARK_PACKAGE
ENV SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop2.7

## extra packages/locale
RUN apt-get update \
    && apt-get install -y \
        procps \
        curl \
        locales \
    && dpkg-reconfigure -f noninteractive locales \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

## jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk

## hadoop
ENV HADOOP_HOME=/usr/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
ENV PATH $PATH:${HADOOP_HOME}/bin
RUN wget -nv ${DOWNLOAD_URL}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xf hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && chown -R root:root ${HADOOP_HOME}

## spark
ENV SPARK_HOME=/usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN wget -nv ${DOWNLOAD_URL}/${SPARK_PACKAGE}.tgz \
    && tar xf spark-${HADOOP_VERSION}.tgz \
    && mv ${SPARK_PACKAGE} ${SPARK_HOME} \
    && chown -R root:root ${SPARK_HOME}


