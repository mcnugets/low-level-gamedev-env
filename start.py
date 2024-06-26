#!/usr/bin/env python3

import subprocess
import sys
import os


def a():
    # subprocess.run(["docker", "build", "--tag", "game_dev_env_image:0.1v", "."])

    dir = os.getcwd().replace("\\", "/")
    mounting = f"{dir}/src:/workdir/dep/src"

    subprocess.run(
        [
            "docker",
            "run",
            "-it",
            "--name",
            "gameenv_container",
            "-v",
            mounting,
            "-d",
            "sullmeister/game_env_container:0.2v", # make the tag version editable manualy in the future
        ]
    )


def b():
    subprocess.run(["docker", "rm", "gameenv_container"])


def c():
    message = input("Enter your commit message: ")
    subprocess.run(["git", "add", "*"])
    subprocess.run(["git", "commit", "-m", message])
    subprocess.run(["git", "push", "origin", "main"])


def coms(command_count):

    if command_count == 1:
        a()
    elif command_count == 2:
        b()
    elif command_count == 3:
        c()


if __name__ == "__main__":

    arg = sys.argv[1]
    arg = arg.lower()

    coms(int(arg))
