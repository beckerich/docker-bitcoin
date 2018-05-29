#!/bin/bash
: ${CONTAINER_NAME:="dockerbitcoin_bitcoind_1"}
docker exec ${CONTAINER_NAME} ./cli "$@"
