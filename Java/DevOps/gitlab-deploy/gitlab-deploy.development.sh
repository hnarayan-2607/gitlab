# !/bin/bash
# Get servers list:
# set — f
# Variables from GitLab server:
# Note: They can’t have spaces!!
# string=$DEPLOY_SERVER
# array=(${string//,/ })
# # Iterate servers for deploy and pull last commit
# # Careful with the ; https://stackoverflow.com/a/20666248/1057052
# for i in “${!array[@]}”; do
#   echo “Deploy project on server ${array[i]}”
# ssh ubuntu@${array[i]} “cd ./Staging/vr && git stash && git checkout $CI_BUILD_REF_NAME && git stash && git pull && sudo yarn install && sudo npm run staging”
# done



# # Output colors
# NORMAL="\\033[0;39m"
# RED="\\033[1;31m"
# BLUE="\\033[1;34m"

# Names to identify images and containers of this app
# registry.gitlab.com/collabera-ces/ava/ita/test_repo/feature-tiqe-336:040ee6954abbb79a84cf15ded37281b006a849bb
IMAGE_NAME='registry.gitlab.com/collabera-ces/ava/ita/test_repo/feature-tiqe-336:040ee6954abbb79a84cf15ded37281b006a849bb'
CONTAINER_NAME="tdm"

# Usefull to run commands as non-root user inside containers
# USER="bob"
# HOMEDIR="/home/$USER"
# EXECUTE_AS="sudo -u bob HOME=$HOME_DIR"

# build() {
#   docker build -t $IMAGE_NAME .
#
#   [ $? != 0 ] && \
#     error "Docker image build failed !" && exit 100
# }




docker_login() {
  # docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
  sudo docker login -u test_deploy_token_user -p $test_deploy_token_pwd registry.gitlab.com
}

docker_pull() {
  # docker pull ${CI_APPLICATION_REPOSITORY}:${CI_APPLICATION_TAG}
  sudo docker pull $IMAGE_NAME
  sudo docker images ls
}

stop_container() {

  sudo echo "Stopping the previous container $CONTAINER_NAME" && \
      docker kill $CONTAINER_NAME &> /dev/null || true
}

delete_container() {
  sudo echo "Removing previous container $CONTAINER_NAME" && \
      docker rm -f $CONTAINER_NAME &> /dev/null || true
}

start_container() {
  # docker start $CONTAINER_NAME
  sudo echo "Starting new instance of the container $CONTAINER_NAME" && \
  docker run --name $CONTAINER_NAME -p 8088:8088 -itd $IMAGE_NAME &> /dev/null || true
}

docker_login;
docker_pull;
stop_container;
delete_container;
start_container;
