# low-level-gamedev-env

### Things to fix in my current development project:
- set up the environment so that I have single workspace for local and remote directory
- figure out the devcontainer.json. Make it effective so that I trigger container from the this file
- figure out docker-compose
- maybe automate processes like:
    - docker cli
    - cmake cli

## Description
The idea is to develop a dedicated environment to start developing games.
Feel free to contribute to the project, fix issues, or develop it further.

## Objective and why
I've been using UE5 for a while, and it got me frustrated with how resource-demanding and slow the engine is. 
Thus development flow gets abruted by continuous compiling time. I wanna build something lightweight and C++-oriented

Hopefully, I won't abandon this project midway through, if I do you can go ahead and contribute to it.

---
## Getting started
to start a docker, you need to run a couple of Python-based commands:

This is the combination of `docker build` and  `docker run`
```
    python start.py 1 
```
This command is used to perform `docker remove`:
```
    python start.py 2
```
This command is a combo of `git` commands like `git add *`, `git commit`, `git push origin main`:
```
    python start.py 3
```


---
P.S. I would never think building it withing docker container would such a pain in the ass
