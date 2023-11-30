FROM elixir:1.13.4-slim AS base
RUN mix local.hex --force && mix local.rebar --force

FROM base as build
WORKDIR /app

COPY . .

RUN mix deps.get
RUN mix compile

EXPOSE 4000

FROM build AS launch

COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]