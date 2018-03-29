#!/bin/bash

set -e
set pipefail

LOG_DIR=/var/vcap/sys/log/oauth
mkdir -p /var/vcap/sys/log/oauth

export PAM_USER=$PAM_USER
PASS=`cat -`
echo "$PASS" | $(dirname "$0")/pam-exec-oauth2 \
			      --config /var/vcap/jobs/oauth/config/pam-exec-oauth2.yaml
			      --debug &> /var/vcap/sys/log/oauth/pam-exec-oauth2.log
