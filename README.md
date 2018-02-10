# Rocker Extra

Extra docker images from `rocker/tidyverse`. All images will be found in [DockerHub](https://hub.docker.com/u/rockerextra/).

## Structure of [rocker](https://github.com/rocker-org/rocker-versioned) project

All extra images will be from `rocker/tidyverse`.

```
debian:stretch
    --> rocker/r-ver
        --> rocker/rstudio
            --> rocker/tidyverse
```

## Structure of [rockerextra](https://github.com/jaehyeon-kim/rocker-extra) project

See the links for [ssh](https://github.com/krlmlr/debian-ssh) and [Architecture Server](https://www.getarchitect.io/) of [OpenAnalytics](https://www.openanalytics.eu/).

```
rocker/tidyverse
    --> rockerextra/python
    --> rockerextra/remote (ssh + architecture server)
        --> rockerextra/rserve
        --> rockerextra/spark
            --> rockerextra/spark-master
            --> rockerextra/spark-worker
```