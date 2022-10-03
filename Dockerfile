FROM klakegg/hugo:edge-ext-alpine AS builder

WORKDIR /home/hugo

ADD . .

RUN hugo

FROM flashspys/nginx-static:latest

RUN apk update && apk upgrade

COPY --from=builder /home/hugo/public /static/

COPY nginx.conf /etc/nginx/conf.d/default.conf