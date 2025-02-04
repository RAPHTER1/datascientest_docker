#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "You have to be root/sudo to execute this script"
    exit 1
fi

LOG_FILE_PATH="logs/api_test.log"

log() {
    local current_time=$(date '+%Y-%m-%d %H:%M:%S')
    message="[$current_time] $1"
    echo -e "$message" | tee -a "$LOG_FILE_PATH"
}

log "\n-----------------------------------------
WELCOME IN DATASCIENTEST API TEST SCRIPT\n\
-----------------------------------------"

# ICI j'ai laissé l'ancien script que création des images docker même si je ne m'en sers plus

# for dir in *; do
#     if [[ $dir =~ ^test ]]; then
#         if [[ -f "$dir/Dockerfile" ]]; then
#             docker build -t "datascientest/$dir" "$dir"
#             log "[SUCCESS] Creating docker image datascientest/$dir"
#         else
#             error_log "/$dir/Dockerfile - No such file in directory"
#         fi
#     fi
# done
# docker-compose build
log "Starting tests ..."
docker-compose build
docker-compose up -d
log "Tests completed : ./logs/api_test.log"
docker-compose down