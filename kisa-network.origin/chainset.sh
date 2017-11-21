#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

starttime=$(date +%s)

# Create the channel
CHANNEL_NAME=kisachannel
GO_NAME=kisa
CHAINCODE_NAME=kisaCC

echo
echo "@.@ Install chaincode"
echo
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.kisa.com/users/Admin@org1.kisa.com/msp" cli peer chaincode install -n $CHAINCODE_NAME -v 1.0 -p $GO_NAME
sleep 10

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer1.org1.kisa.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.kisa.com/users/Admin@org1.kisa.com/msp" cli peer chaincode install -n $CHAINCODE_NAME -v 1.0 -p $GO_NAME

echo
echo "@.@ Initialize"
echo
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.kisa.com/users/Admin@org1.kisa.com/msp" cli peer chaincode instantiate -o orderer.kisa.com:7050 -C $CHANNEL_NAME -n $CHAINCODE_NAME -v 1.0 -c '{"Args":["init"]}' -P "OR ('Org1MSP.member')"
sleep 10

printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
