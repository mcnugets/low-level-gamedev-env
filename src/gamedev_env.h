#pragma once

#include <vector>
#include <string>


#ifdef _WIN32
  #define GAMEDEV_ENV_EXPORT __declspec(dllexport)
#else
  #define GAMEDEV_ENV_EXPORT
#endif

GAMEDEV_ENV_EXPORT void gamedev_env();
GAMEDEV_ENV_EXPORT void gamedev_env_print_vector(const std::vector<std::string> &strings);
