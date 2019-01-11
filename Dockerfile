FROM continuumio/miniconda3

# docker build -t poldracklab/coupling .

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y git wget && \
    mkdir -p /code && \
    conda update -n base -c defaults conda && \
    conda install -y pandas==0.18.0 numpy


ADD . /code
WORKDIR /code
RUN chmod u+x /code/coupling.py
ENTRYPOINT ["python"]
CMD ["/code/coupling.py"]
