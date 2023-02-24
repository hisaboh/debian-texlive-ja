# Build

## Build docker image
```
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx build --platform linux/amd64,linux/arm64 -t hisaboh/debian-texlive-ja .
```

## Push image to Docker Hub
```
docker login
docker buildx build --platform linux/amd64,linux/arm64 -t hisaboh/debian-texlive-ja --push .
```
