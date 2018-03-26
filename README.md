# Rocker Extra

Extra docker images from `rocker/tidyverse`. All images will be found in [DockerHub](https://hub.docker.com/u/rockerextra/).

## Structure of [rocker](https://github.com/rocker-org/rocker-versioned) project

All **rockerextra** images will be from `rocker/tidyverse`.

```
debian:stretch
    --> rocker/r-ver
        --> rocker/rstudio
            --> rocker/tidyverse
```

## Structure of [rockerextra](https://github.com/jaehyeon-kim/rocker-extra) project

```
rocker/tidyverse
    --> rockerextra/spark
    --> rockerextra/python
        --> rockerextra/ssh
```

* _rockerextra/spark_
    - hadoop 2.8.2 + spark 2.2.1
    - sources from [SingularitiesCR/hadoop-docker](https://github.com/SingularitiesCR/hadoop-docker) and [SingularitiesCR/spark-docker](https://github.com/SingularitiesCR/spark-docker)
    - see for [further details](https://github.com/jaehyeon-kim/sparkr-demo)
* _rockerextra/python_ - python 3.6.4 + [pyenv](https://github.com/pyenv/pyenv)
* _rockerextra/ssh_ - SSH connection + emacs 25
    + docker run --name ssh -d -p 2222:22 -p 8787:8787 -e SSH_KEY="$(cat ./sample/id_rsa.pub)" rockerextra/python:tag