#!/bin/bash
# 175ykitmqmoru10vrw1q

uaac client delete jumpbox
uaac client add jumpbox \
     --name jumpbox \
     --scope openid \
     --autoapprove true \
     --authorized_grant_types password,refresh_token \
     --secret "foobar"


