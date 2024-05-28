cmake_minimum_required(VERSION 3.15)
project(gamedev_env CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/build")

find_package(Bullet REQUIRED)
find_package(Vulkan REQUIRED)
find_package(SDL2 REQUIRED)

add_executable(${PROJECT_NAME} src/gamedev_env.cpp src/main.cpp)

target_link_libraries(${PROJECT_NAME} Bullet::Bullet)
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan)
target_link_libraries(${PROJECT_NAME} SDL2::SDL2)



