IMAGE_NAME=codechecker
IMAGE_VERSION=1.0.0

docker build \
    -t ${IMAGE_NAME} \
    -t ${IMAGE_NAME}:${IMAGE_VERSION} \
    -t ${IMAGE_NAME}:latest \
    .