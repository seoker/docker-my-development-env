# My Development Environment

## Build

```
# confirm docker daemon is running and connected
docker version

# build the image based on the Dockerfile and name it `seoker-dev-env`
docker build -t seoker-dev-env .

# confirm image is present
docker images

# enter container terminal
docker run -it seoker-dev-env bash
```