FROM node:10.16-alpine as front_app

WORKDIR /work

ARG github_token

RUN set -x && \
    apk update && \
    apk add --no-cache git && \
    npm install -g yarn && \
    git clone https://$github_token:x-oauth-basic@github.com/[[repo_url]] . && \
    yarn add chalk && \
    yarn build

FROM nginx:1.16.1-alpine

WORKDIR /opt/gke_prac_front/dist

COPY --from=front_app /work/dist/ .

WORKDIR /etc/nginx

RUN set -x && \
    mkdir custom && \
    mv nginx.conf custom/

CMD ["nginx", "-c", "/etc/nginx/custom/nginx.conf",  "-g", "daemon off;"]
