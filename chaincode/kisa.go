/**
 * 목적:
 * Watson IoT Platform에서 전달된 디바이스 이벤트 정보를 저장한다.
 *
 * @author 최의신 (choies@kr.ibm.com)
 *
 */
/*
 * 체인코드 TEST
 *
peer chaincode install -p kisa -n mycc -v 0

peer chaincode instantiate -n mycc -v 0 -c '{"Args":["Init"]}' -C myc

peer chaincode invoke -n mycc -c '{"Args":["fireAlert", "FINTECH", "HOME", "2017-11-01 11:23:00", "50"]}' -C myc

peer chaincode query -n mycc -c '{"Args":["getAlert", "b14794a2970c2d621ba177561a276026e597378f2dce8a5862c176f1ded670c2"]}' -C myc

 *
 */

package main

