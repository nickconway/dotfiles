FROM node:lts-alpine AS build

WORKDIR /app

COPY . .

RUN npm ci
RUN npm i -D @sveltejs/adapter-node
RUN sed -i "s/'\@sveltejs\/adapter-.*'/'@sveltejs\/adapter-node'/g" svelte.config.js
RUN npm run build
RUN npm prune --omit dev

FROM node:lts-alpine

LABEL Developers="Nick Conway"

WORKDIR /app

ENV NODE_ENV production

RUN apk --no-cache add curl

USER node

COPY --from=build /app/build build/
COPY --from=build /app/node_modules node_modules/
COPY --from=build /app/package.json package.json

EXPOSE 3000

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

CMD ["node","build"]
