# syntax=docker/dockerfile:1

FROM ubuntu:latest

LABEL key="ubtuntu environment for cpp"

ARG parent_dir=/workdir/env


WORKDIR ${parent_dir}

RUN apt-get -y update && \
    apt-get install -y  make cmake build-essential

ARG sdl2=https://github.com/libsdl-org/SDL.git

WORKDIR ${parent_dir}/sdl2_repo

RUN apt-get -y install git &&\
    git clone --branch release-2.30.0 ${sdl2} 

WORKDIR ${parent_dir}/sdl2_repo/SDL/build

RUN cmake .. &&\
    make &&\
    make install &&\
    cd .. && cd .. &&\
    rm -r  SDL

COPY . ${parent_dir}


# # run the cmake
# RUN cmake ${parent_dir} -G "Unix Makefiles" -B build &&\
#     make




# install other dependencies