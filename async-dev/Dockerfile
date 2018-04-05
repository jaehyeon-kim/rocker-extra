FROM rocker/tidyverse:3.4
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

## need to build httpuv from source when installing shiny from GitHub
## build from https://github.com/rocker-org/shiny in production
RUN apt-get update \
  && apt-get install -y autoconf automake libtool

## promises package installed with rstudio/shiny
## https://rstudio.github.io/promises/index.html
RUN R -e 'devtools::install_github("rstudio/shiny")' \
  && R -e 'devtools::install_github("ramnathv/htmlwidgets@async")' \
  && R -e 'devtools::install_github("jcheng5/plotly@joe/feature/async")' \
  && R -e 'devtools::install_github("rstudio/DT@async")' \
  && R -e 'devtools::install_github("rstudio/leaflet")' # optional

## testing packages
RUN apt-get install -y bzip2
RUN R -e 'devtools::install_github("rstudio/profvis")' \
  && R -e 'devtools::install_github("rstudio/shinytest")' \
  && R -e 'devtools::install_github("rstudio/shinyloadtest")'

USER rstudio

RUN R -e 'shinytest::installDependencies()'
RUN wget --no-verbose https://s3-us-west-2.amazonaws.com/rstudio-proxyrec-execs/rstudio/proxyrec/44/44.1/main-linux -O /home/rstudio/proxyrec

USER root

RUN chmod 766 /home/rstudio/proxyrec

## mostly from Rocker project
## https://github.com/rocker-org/rocker-versioned/blob/master/rstudio/add_shiny.sh
RUN apt-get -y install gdebi-core libxt-dev \
  && wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" \
  && VERSION=$(cat version.txt) \
  && wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb \
  && gdebi -n ss-latest.deb \
  && rm -f version.txt ss-latest.deb \
  && cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /var/log/shiny-server \
  && chown shiny.shiny /var/log/shiny-server \
  && mkdir -p /etc/services.d/shiny-server \
  && echo '#!/usr/bin/with-contenv bash \
          \n exec shiny-server > /var/log/shiny-server.log' \
          > /etc/services.d/rstudio/run

EXPOSE 3838

CMD ["/init"]