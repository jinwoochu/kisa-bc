#!/bin/bash
#
# Exit on first error
set -e

docker stop $(docker ps -aq) && docker rm $(docker ps -qa)
