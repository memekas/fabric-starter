#!/usr/bin/env bash
source lib.sh

#docker rm -f $(docker ps -aq)
set - x
[ -z "$DOCKER_HOST" ] && sudo rm -rf crypto-config/ || docker-machine ssh ${DOCKER_MACHINE_NAME} sudo rm -rf crypto-config
set +x
[ "${DOCKER_MACHINE_NAME}" == "orderer" ]  && EXECUTE_BY_ORDERER=1 runCLIWithComposerOverrides down || runCLIWithComposerOverrides down
docker volume prune -f
docker rmi -f $(docker images -q -f "reference=dev-*")
#docker rmi -f $(docker images -q -f "reference=olegabu/fabric-starter-client")
docker network rm `(docker network ls -q)`
