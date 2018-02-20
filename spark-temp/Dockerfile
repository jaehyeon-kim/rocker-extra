FROM rocker/tidyverse:3.4.3
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

ARG SPARK_VERSION
ENV SPARK_VERSION=${SPARK_VERSION:-2.2.0}
ARG HADOOP_VERSION
ENV HADOOP_VERSION=${HADOOP_VERSION:-2.7.3}
ARG DOWNLOAD_URL
ENV DOWNLOAD_URL=${DOWNLOAD_URL:-http://d3kbcqa49mib13.cloudfront.net}
ARG SPARK_DOWNLOAD_URL
ENV SPARK_DOWNLOAD_URL=${SPARK_DOWNLOAD_URL:-https://s3-ap-southeast-2.amazonaws.com/rocker-extra/spark-bin}
ARG SPARK_PACKAGE
ENV SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop2.7-hive-sparkr

# Install dependencies/utils, set locale
RUN apt-get update \
    && apt-get install -y \
        procps \
        curl \
        locales \
        netcat \
    && dpkg-reconfigure -f noninteractive locales \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Install JDK
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH=$PATH:$JAVA_HOME/bin
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk

#### Setup Hadoop
# Install Hadoop and set paths
ENV HADOOP_HOME=/usr/local/hadoop \
    HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop \
    PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
RUN wget -nv ${DOWNLOAD_URL}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xf hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && chown -R root:staff ${HADOOP_HOME}

# HDFS volume
VOLUME /opt/hdfs

# Copy and fix configuration files
COPY ./hadoop-conf/*.xml $HADOOP_CONF_DIR/
RUN sed -i.bak 's/hadoop-daemons.sh/hadoop-daemon.sh/g' $HADOOP_HOME/sbin/start-dfs.sh \
    && rm -f $HADOOP_HOME/sbin/start-dfs.sh.bak \
    && sed -i.bak 's/hadoop-daemons.sh/hadoop-daemon.sh/g' $HADOOP_HOME/sbin/stop-dfs.sh \
    && rm -f $HADOOP_HOME/sbin/stop-dfs.sh.bak

# Copy start scripts
COPY ./hadoop-conf/start-hadoop /opt/util/bin/start-hadoop
COPY hadoop-conf/start-hadoop-namenode /opt/util/bin/start-hadoop-namenode
COPY hadoop-conf/start-hadoop-datanode /opt/util/bin/start-hadoop-datanode
RUN sed -i -e 's/\r$//' /opt/util/bin/start-hadoop \
    && sed -i -e 's/\r$//' /opt/util/bin/start-hadoop-namenode \
    && sed -i -e 's/\r$//' /opt/util/bin/start-hadoop-datanode
ENV PATH=$PATH:/opt/util/bin

# Fix environment for other users
RUN echo "export HADOOP_HOME=$HADOOP_HOME" > /etc/bash.bashrc.tmp \
    && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:/opt/util/bin'>> /etc/bash.bashrc.tmp \
    && cat /etc/bash.bashrc >> /etc/bash.bashrc.tmp \
    && mv -f /etc/bash.bashrc.tmp /etc/bash.bashrc

#### Setup Spark
# Install Spark
ENV SPARK_HOME=/usr/local/spark \
    PATH=$PATH:${SPARK_HOME}/bin
RUN wget -nv ${SPARK_DOWNLOAD_URL}/${SPARK_PACKAGE}.tgz \
    && tar xf ${SPARK_PACKAGE}.tgz \
    && mv ${SPARK_PACKAGE} ${SPARK_HOME} \
    && chown -R root:staff ${SPARK_HOME}
COPY ./spark-conf/spark-env.sh $SPARK_HOME/conf/spark-env.sh
RUN sed -i -e 's/\r$//' $SPARK_HOME/conf/spark-env.sh

# Copy start script
COPY ./spark-conf/start-spark /opt/util/bin/start-spark
RUN sed -i -e 's/\r$//' /opt/util/bin/start-spark

# Fix environment for other users
RUN echo "export SPARK_HOME=$SPARK_HOME" >> /etc/bash.bashrc \
  && echo 'export PATH=$PATH:$SPARK_HOME/bin'>> /etc/bash.bashrc

# HDFS
EXPOSE 8020 9000 14000 50010 50020 50070 50075 50090 50470 50475

# MapReduce
EXPOSE 10020 13562 19888

# Spark
EXPOSE 6066 7077 8080 8081
