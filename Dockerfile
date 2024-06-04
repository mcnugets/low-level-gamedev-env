# syntax=docker/dockerfile:1


FROM nvidia/cuda:12.5.0-runtime-ubuntu22.04


LABEL key="ubuntu environment for cpp"

ARG parent_dir=/workdir/dep
ARG cmake_build=${parent_dir}/build/build/Release/generators/conan_toolchain.cmake 
ENV PATH="/opt/venv/bin:$PATH"
WORKDIR ${parent_dir}
ENV dep="-d name=gamedev_env -d version=1.0 -d requires=bullet3/3.25 -d requires=vulkan-loader/1.3.268.0 -d requires=sdl/2.28.3 -d requires=sdl_image/2.6.3"

COPY . .

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends make cmake build-essential curl zip unzip tar pkg-config python3-venv &&\
    python3 -m venv /opt/venv &&\
    python3 -m pip install conan --upgrade &&\
    conan profile detect &&\
    apt-get -y update && conan install . -c tools.system.package_manager:mode=install --output-folder=build --build=missing --update &&\
    cd build && cmake .. -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${cmake_build} -DCMAKE_BUILD_TYPE=Release &&\
    cmake --build . 

# RUN python3 -m venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"

# RUN pip install conan --upgrade













# install other dependencies
# bullet
# vulkan