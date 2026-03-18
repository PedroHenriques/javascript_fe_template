FROM node:24-bullseye-slim AS build
WORKDIR /app
ARG BUILD_ENV_FILE
COPY package.json package-lock.json .
COPY src/App/package.json ./src/App/
RUN npm ci --workspaces --include-workspace-root --include=dev
COPY . .
RUN echo "$BUILD_ENV_FILE" > /app/.env && export $(cat /app/.env | xargs) && chmod +x ./cli/build_dist.sh && ./cli/build_dist.sh --base-per-service App

FROM nginx:1.27-alpine
ENV BASE_PATH=/
ENV DEFAULT_SERVICE=App
COPY ./setup/local/nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist/ /app/
HEALTHCHECK --interval=10s --timeout=3s --retries=5 \
CMD wget --spider -q "http://localhost${BASE_PATH:-/}" || exit 1
