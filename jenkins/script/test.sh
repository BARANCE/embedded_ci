PROJECT_DIR_NAME=project_sensor
PROJECT_DIR=

function get_project_dir() {
    SCRIPT_DIR=${0%/*}
    cd ${SCRIPT_DIR}
    CURRENT_DIR=$(pwd)
    if [ ! "`echo ${CURRENT_DIR} | grep ${PROJECT_DIR_NAME}`" ]; then
        echo "[ERROR] Cannot find PROJECT_DIR_NAME='${PROJECT_DIR_NAME}'."
        exit 1
    fi

    while [ ${CURRENT_DIR##*/} != ${PROJECT_DIR_NAME} ]
    do
        NEXT_DIR=${CURRENT_DIR}/..
        cd ${NEXT_DIR}
        CURRENT_DIR=$(pwd)
        
        if [ ${CURRENT_DIR} = / ]; then
            echo "[ERROR] Cannot find PROJECT_DIR_NAME='${PROJECT_DIR_NAME}'."
            exit 1
        fi
    done
    PROJECT_DIR=$(pwd)
}

# Move to project root directory
get_project_dir ${0}
pwd

# Create directory for jenkins build
JENKINS_WORK_DIR=./jenkins/work
JENKINS_BUILD_DIR=${JENKINS_WORK_DIR}/test
mkdir -p ${JENKINS_BUILD_DIR}
cd ${JENKINS_BUILD_DIR}
rm -rf ./*

# Copy project sources from working-tree
git clone --recursive ${PROJECT_DIR}
cd ${PROJECT_DIR_NAME}
git pull
git checkout master

# Build
make debug
make dclean