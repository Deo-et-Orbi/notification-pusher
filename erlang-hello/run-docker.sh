docker run -it --rm \
    --name erlang-hello -v "$PWD":/app -w /app erlang escript hello.erl