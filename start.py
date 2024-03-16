#!/usr/bin/env python3

import subprocess
import sys

def s():
    subprocess.run(["docker", "build", "--tag", "game_dev_env_image:0.1v", "."])
    subprocess.run(['docker',  'run','-it', '--name', 'gameenv_container', 'game_dev_env_image:0.1v'])
def d():
    subprocess.run('docker', 'rm', 'gameenv_container')

def coms(is_true):

    if is_true:
        s()
    else:
        d()
if __name__ == '__main__':
    
    arg = sys.argv[1]
    coms(arg)