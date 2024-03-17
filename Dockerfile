# syntax=docker/dockerfile:1

FROM ubuntu:latest

LABEL key="ubtuntu environment for cpp"

ARG parent_dir=/workdir/env
ARG sdl2=https://github.com/libsdl-org/SDL.git
ARG bullet=https://github.com/bulletphysics/bullet3.git
ARG vpkg=https://github.com/microsoft/vcpkg.git



WORKDIR ${parent_dir}

RUN apt-get -y update && \
    apt-get install -y  --no-install-recommends make cmake build-essential &&\
    apt-get install -y curl zip unzip tar

RUN apt-get -y install git &&\
    cd .. && mkdir gir_repos && cd gir_repos &&\
    git clone ${vpkg} &&\
    cd vcpkg && ./bootstrap-vcpkg.sh
    
ENV VCPKG_ROOT=/workdir/gir_repos/vcpkg 
ENV PATH=$VCPKG_ROOT:$PATH

RUN vcpkg new --application &&\
    vcpkg add port sdl2 &&\
    vcpkg add port bullet3 &&\
    vcpkg install


# WORKDIR ${parent_dir}/git_repos

# RUN apt-get -y install git &&\
#     git clone --branch release-2.30.0 ${sdl2} &&\
#     git clone ${bullet} &&\
#     cd SDL && mkdir build && cd build &&\
#     cmake .. &&\
#     make &&\
#     make install &&\
#     make clean &&\
#     cd ../../ && cd bullet3 && mkdir build && cd build &&\
#     cmake .. &&\
#     make &&\
#     make install &&\
#     make clean 

# WORKDIR ${parent_dir}/sdl2_repo/SDL/build



# cleaning up through deletion 
# WORKDIR ${parent_dir}

# RUN apt-get remove -y git && \
#     apt-get autoremove -y && \
#     rm -rf /var/lib/apt/lists/* && \
#     apt-get clean -y &&\
#     rm -rf /workdir/env/git_repos
    

COPY . ${parent_dir}

# run the cmake
# RUN cmake ${parent_dir} -G "Unix Makefiles" -B build &&\
#     make




# install other dependencies
    # bullet
    # vulkan