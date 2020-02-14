
# docker.io/genesem/nginx-lua-alpine
# https://github.com/genesem/nginx-lua-alpine

FROM alpine:3.11
LABEL maintainer "Gene Semerenko - https://github.com/genesem"
COPY about /usr/local/bin/ 


RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update && apk add -u nginx procps luajit-dev \
	nginx-mod-http-lua lua-resty-lrucache lua-resty-redis lua-resty-core; \
    rm -rf /etc/nginx/conf.d /etc/nginx/nginx.conf /var/cache/apk/*; \
    mkdir -p /var/www/logs /var/www/default/html /var/lib/nginx/temp;

COPY nginx.conf /etc/nginx/
COPY conf.d /etc/nginx/conf.d
COPY www    /var/www

STOPSIGNAL SIGTERM
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
