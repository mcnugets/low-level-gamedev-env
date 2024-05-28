# syntax=docker/dockerfile:1


FROM ubuntu:latest

LABEL key="ubuntu environment for cpp"

ARG parent_dir=/workdir/dep
ARG cmake_build=${parent_dir}/build/build/Release/generators/conan_toolchain.cmake 


RUN apt-get -y update && \
    apt-get install -y --no-install-recommends make cmake build-essential curl zip unzip tar pkg-config python3-venv &&\
    python3 -m venv /opt/venv

# RUN python3 -m venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"

# RUN pip install conan --upgrade

ENV PATH="/opt/venv/bin:$PATH"

RUN python3 -m pip install conan --upgrade

WORKDIR ${parent_dir}
ENV dep="-d name=gamedev_env -d version=1.0 -d requires=bullet3/3.25 -d requires=vulkan-loader/1.3.268.0 -d requires=sdl/2.30.3"



RUN conan new basic ${dep} &&\
    conan profile detect 

COPY . .
RUN conan install . -c tools.system.package_manager:mode=install --output-folder=build --build=missing &&\
    cd build && cmake .. -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${cmake_build} -DCMAKE_BUILD_TYPE=Release &&\
    cmake --build . 






# install other dependencies
# bullet
# vulkan