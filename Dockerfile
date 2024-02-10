ARG NODE_VERSION=18.18.2-slim
FROM node:${NODE_VERSION} as base

ENV USER=evobot

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 build-essential && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r ${USER} && \
    useradd --create-home --home /home/evobot -r -g ${USER} ${USER}

USER ${USER}
WORKDIR /home/evobot

FROM base as build

COPY --chown=${USER}:${USER}  . .
RUN npm ci

CMD [ "yarn", "start" ]
