#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "You have to be root/sudo to execute this script"
    exit 1
fi

LOG_FILE_PATH="logs/script.log"

log() {
    local current_time=$(date '+%Y-%m-%d %H:%M:%S')
    message="[$current_time] $1"
    echo -e "$message" | tee -a "$LOG_PATH_FILE"
}

error_log() {
    local error_message="$1"
    echo "[ERROR] `log "$error_message"`"
}

log "\n-----------------------------------------
WELCOME IN DATASCIENTEST API TEST SCRIPT\n\
-----------------------------------------"

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
docker-compose build 2>&1 | tee -a "$LOG_PATH_FILE"
docker-compose up 2>&1 -d | tee -a "$LOG_PATH_FILE"
log "Tests completed : ./logs/api_test.log"
docker-compose down 2>&1 | tee -a "$LOG_PATH_FILE"