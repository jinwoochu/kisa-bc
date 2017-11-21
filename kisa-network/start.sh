#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

starttime=$(date +%s)

if [ ! -d ~/.hfc-key-store/ ]; then
	mkdir ~/.hfc-key-store/
fi
cp $PWD/creds/* ~/.hfc-key-store/

# launch network; create channel and join peer to channel
docker-compose -f docker-compose.yml down

docker-compose -f docker-compose.yml up -d

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
CHANNEL_NAME=kisachannel
CHAINCODE_NAME=kisaCC

echo "-----------------------------------------"
echo "Create channel."
echo "-----------------------------------------"
docker exec cli peer channel create -o orderer.kisa.com:7050 -c $CHANNEL_NAME -f /etc/hyperledger/configtx/channel.tx

# Join peer0.org1.kisa.com to the channel.
echo "-----------------------------------------"
echo "Join peer0.org1.kisa.com to the channel."
echo "-----------------------------------------"
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.kisa.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.kisa.com:7051" cli peer channel join -b $CHANNEL_NAME.block

# Join peer1.org1.kisa.com to the channel.
echo "-----------------------------------------"
echo "Join peer1.org1.kisa.com to the channel."
echo "-----------------------------------------"
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.kisa.com/msp" -e "CORE_PEER_ADDRESS=peer1.org1.kisa.com:7051" cli peer channel join -b $CHANNEL_NAME.block

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "       Harim Blockchain Network"
echo
printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
