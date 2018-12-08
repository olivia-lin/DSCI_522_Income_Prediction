# Docker file for DSCI_522_Income_Predction
# Olivia Lin and Mani Kohli
# Created on Dec 6, 2018

# Description: This Dockerfile will create an automatic data analysis pipeline

# Usage:
#   To build the docker image: docker build --tag incomeprediction:2.2 .
#   To create the report: docker run --rm -e PASSWORD=income -v /Users/olivia/Documents/MDS/522/DSCI_522_Income_Prediction:/home/income incomeprediction:2.2 make -C 'home/income' all
#   To get a clean start: docker run --rm -e PASSWORD=income -v /Users/olivia/Documents/MDS/522/DSCI_522_Income_Prediction:/home/income incomeprediction:2.2 make -C 'home/income' clean


# use rocker/tidyverse as the base image
From rocker/tidyverse

# install R packages
# rmarkdown
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
rmarkdown

RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('GGally')"


# Install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# python package dependencies
RUN apt-get install -y python3-tk

# install python packages
RUN pip3 install argparse
RUN pip3 install pandas
RUN pip3 install sklearn
RUN apt-get install -y graphviz && pip install graphviz
RUN apt-get update && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/*
