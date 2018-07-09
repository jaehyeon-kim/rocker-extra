FROM rocker/tidyverse:3.4
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

RUN apt-get update \
  && apt-get install -y libssl-dev wget curl procps \
  && wget https://www.rforge.net/src/contrib/Rserve_1.8-5.tar.gz \
  && /usr/local/bin/R CMD INSTALL Rserve_1.8-5.tar.gz

EXPOSE 8000

CMD ["/init"]
