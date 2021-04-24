set -e

IMAGE_NAME="hello-erlang"

docker build -t $IMAGE_NAME . && \
docker run --rm -it -p 8080:8080 $IMAGE_NAME