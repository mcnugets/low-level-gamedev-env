# syntax=docker/dockerfile:1

FROM ubuntu:latest

LABEL key="ubtuntu environment for cpp"

ARG parent_dir=/workdir/dep
ARG cmake_build=${parent_dir}/build/build/Release/generators/conan_toolchain.cmake 

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends make cmake build-essential &&\
    apt-get install -y curl zip unzip tar &&\
    apt install -y pkg-config
    

RUN apt install -y python3-pip &&\
    pip install conan 

WORKDIR ${parent_dir}
ENV dep=" -d name=gamedev_env -d version=1.0 -d requires=bullet3/3.25 -d requires=vulkan-loader/1.3.268.0"



RUN conan new basic ${dep} &&\
    conan profile detect 

COPY . .
RUN conan install . -c tools.system.package_manager:mode=install --output-folder=build --build=missing &&\
    cd build && cmake .. -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${cmake_build} -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE=Release &&\
    cmake --build .
   


# RUN apt-get -y install git &&\
#     cd .. && mkdir gir_repos && cd gir_repos &&\
#     git clone ${vpkg} &&\
#     cd vcpkg && ./bootstrap-vcpkg.sh
    
# ENV VCPKG_ROOT=/gir_repos/vcpkg 
# ENV PATH=$VCPKG_ROOT:$PATH



# RUN vcpkg new --application 


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
    

# COPY . ${parent_dir}

# run the cmake
# RUN cmake ${parent_dir} -G "Unix Makefiles" -B build &&\
#     make




# install other dependencies
    # bullet
    # vulkan