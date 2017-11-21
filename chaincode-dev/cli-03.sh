#!/bin/bash
#
# Exit on first error
set -e

# Create the channel
docker exec -e "CORE_PEER_ADDRESS=peer:7051" -e "CORE_CHAINCODE_ID_NAME=mycc:0" -it cli bash
