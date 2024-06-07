# syntax=docker/dockerfile:1


FROM sullmeister/game_env_container:0.1v
LABEL key="ubuntu environment for cpp"

ARG parent_dir=/workdir/dep
ARG cmake_build=${parent_dir}/build/build/Release/generators/conan_toolchain.cmake 
ENV PATH="/opt/venv/bin:$PATH"
WORKDIR ${parent_dir}

COPY . .

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends make cmake build-essential curl zip unzip tar pkg-config python3-venv &&\
    python3 -m venv /opt/venv &&\
    python3 -m pip install conan --upgrade &&\
    # conan profile detect &&\
    conan install . -c tools.system.package_manager:mode=install --output-folder=build --build=missing --update &&\
    cd build && cmake .. -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${cmake_build} -DCMAKE_BUILD_TYPE=Release &&\
    cmake --build . 

