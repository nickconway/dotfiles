FROM node:lts-slim

LABEL Developers="Nick Conway"

WORKDIR /app

COPY . .

RUN npm ci
RUN npm run build
RUN npm prune --production

USER node:node

CMD ["node","build"]
