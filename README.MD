# oauth jumpbox release
this will deploy a jumpbox connected to an oauth server (e.g UAA)
each user that logs-in will be assigned to their own global specified docker container

## Deploy
configure the manifest see options below.

`bosh deploy manifests/oauth-jumpbox.yml -d oauth-jumpbox`

## How to use
please note that if there are any special characters use double quotes around the username.

`ssh "username@mail.com"@JUMPBOXIP`

## oauth settings
example:
UAA deployed with [BUCC](https://github.com/starkandwayne/bucc)
```
  - name: oauth
    release: oauth-jumpbox
    properties:
      pam_oauth:
        client-id: jumpbox
        client-secret: foobar
        redirect-url: "urn:ietf:wg:oauth:2.0:oob"
        scopes: ["openid"]
        endpoint-auth-url: "((/concourse/main/concourse_url)):8443/oauth/authorize"
        endpoint-token-url: "((/concourse/main/concourse_url)):8443/oauth/token"
        username-format: "%s"
```

for this example to work you would also need create a client in the UAA
```
secret_path=$(credhub find -n oauth-jumpbox/client_secret -j | jq -r '.credentials[0].name')
secret=$(credhub get -j -n ${secret_path} | jq -r '.value')

uaa create-client jumpbox \
    --client_secret ${secret} \
    --authorized_grant_types password,refresh_token \
    --scope openid
```
## Configure docker container settings

example:
```
- name: dockersh
  release: oauth-jumpbox
  properties:
    image: busybox
    command: /bin/ash
    user: root
    env:
      CONCOURSE_URL: ((/concourse/main/concourse_url))
      CONCOURSE_USER: ((/concourse/main/concourse_username))
      CONCOURSE_PASSWORD: ((/concourse/main/concourse_password))
```

## From Source
Dependencies:
- git-lfs: https://git-lfs.github.com/
this repository uses `GIT LFS` to store blobs

```
git clone https://github.com/cloudfoundry-community/oauth-jumpbox-boshrelease.git
git lfs pull
```
