# Docker file for DSCI_522_Income_Predction
# Olivia Lin and Mani Kohli
# Created on Dec 6, 2018

# Description: This Dockerfile will create an automatic data analysis pipeline

# Usage:
#   To build the docker image: docker build --tag dsci522_sreya_fwu:0.1 .
#   To create the report: docker run --rm -e PASSWORD=123456 -v `pwd`:/home/rstudio/dsci522_sreya_fwu:0.1 make -C '/home/rstudio/dsci522_sreya_fwu' all
#   To get a clean start: docker run --rm -e PASSWORD=123456 -v `pwd`:/home/rstudio/dsci522_sreya_fwu:0.1 make -C '/home/rstudio/dsci522_sreya_fwu' clean


# use rocker/tidyverse as the base image
From rocker/tidyverse

# install R packages
# rmarkdown
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
rmarkdown

RUN Rscript -e "install.packages('dplyr')"
RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('ggplot2')"


# Install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN apt-get install -y python3-tk

# install numpy, pandas, and matpotlib
RUN pip3 install pandas
RUN pip3 install sklearn
RUN pip3 install matpotlib.pyplot
RUN pip3 install graphviz


RUN apt-get update && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/*


# install graphviz
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    graphviz
