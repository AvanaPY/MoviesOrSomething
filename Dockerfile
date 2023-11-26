FROM elixir:1.13

WORKDIR /app

COPY . .

RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get
RUN mix compile

EXPOSE 4000

ENTRYPOINT [ "./entrypoint.sh" ]