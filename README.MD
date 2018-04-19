# oauth jumpbox release
this will deploy a jumpbox connected to an oauth server (e.g UAA)
each user that logs-in will be assigned to there own global specified docker container

## Deploy
configure the manifest see options below.

`bosh deploy manifests/oauth-jumpbox.yml -d oauth-jumpbox`

## How to use
please not that if there are any special characters use double quotes around the username.

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
uaac client add jumpbox \
     --name jumpbox \
     --scope openid \
     --autoapprove true \
     --authorized_grant_types password,refresh_token \
     --secret "foobar"
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
Depdencies:
- git-lfs: https://git-lfs.github.com/
this repository use `GIT LFS` to store blobs

```
git clone https://github.com/cloudfoundry-community/oauth-jumpbox-boshrelease.git
git lfs pull
```
