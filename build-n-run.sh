IMAGE_NAME="hello-erlang"

docker build -t $IMAGE_NAME .
docker run --rm -it $IMAGE_NAME