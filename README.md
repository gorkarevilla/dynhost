# dynhost
Update your OVH Dynhost with your public IP

## Introduction

Dynhost allows you to update your OVH Dynhost with your actual Public IP Address. You can run it in a docker container that updates the IP periodically (every 15 minutes by default).

## Requirements

If you want to run in the docker (recommended option), you only need Docker
If you want to run locally, you need a linux machine with sh, dig and curl.

You also need to know some information about you Dynhost and set as environment variables.

 - DYNHOST_DOMAIN_NAME: DNS name to update created with Dynhost. e.g: `DYNHOST_DOMAIN_NAME="myhost.mydomain.com"`
 - DYNHOST_LOGIN: You user for dynhost with permissions to update the Dynhost IP. e.g: `DYNHOST_LOGIN="my_user"`
 - DYNHOST_PASSWORD: The password of your user to update the Dynhost IP. e.g: `DYNHOST_PASSWORD="my_Sup3rSecreTPasS7"`

## How to use it

You can run with Docker (or any related solution like docker-compose) and locally (not recommended)

### Docker
With docker it runs one update at start and every 15minutes check if it needs and update. 

Usage:
```sh
docker run -e DYNHOST_DOMAIN_NAME -e DYNHOST_LOGIN -e DYNHOST_PASSWORD gorkarevilla/dynhost
```

If you want to change the update time, you need to build your own image with the Dockerfile.
For example, to build every 30minutes:

```sh
docker build . --build-arg CRON_SCHEDULE="*/30 * * * *" -t dynhost
```

And then run your new image:
```sh
docker run -e DYNHOST_DOMAIN_NAME -e DYNHOST_LOGIN -e DYNHOST_PASSWORD dynhost
```


### Docker-compose

### Locally

