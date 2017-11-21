#!/bin/bash
#
# Exit on first error
set -e
rm -f myc.block
docker-compose -f docker-compose-simple.yaml up
