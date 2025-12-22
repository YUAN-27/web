FROM node:20-alpine AS base
WORKDIR /app

FROM base AS deps
COPY package*.json ./
RUN npm install

FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
ENV ASTRO_TELEMETRY_DISABLED=1
RUN npm run build 2>&1 | tee /tmp/build.log || (cat /tmp/build.log && exit 1)
RUN echo "=== Build completed, checking dist directory ===" && \
    ls -la /app/dist || echo "ERROR: dist directory not found!"

FROM nginx:stable-alpine AS deploy
COPY --from=build /app/dist /usr/share/nginx/html
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
RUN echo "=== Checking nginx html directory ===" && \
    ls -la /usr/share/nginx/html && \
    echo "=== nginx content ready ==="

EXPOSE 8080
