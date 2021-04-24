FROM erlang
WORKDIR /app

RUN wget https://github.com/erlang/rebar3/releases/download/3.15.1/rebar3 && chmod +x rebar3

ADD . /app
RUN ./rebar3 release
CMD _build/default/rel/npumbrella/bin/npumbrella foreground