
# docker.io/genesem/nginx-lua-alpine
# https://github.com/genesem/nginx-lua-alpine

FROM alpine:3.11
LABEL maintainer "Gene Semerenko - https://github.com/genesem"
COPY about /usr/local/bin/ 

RUN apk add --no-cache nginx nginx-mod-http-lua procps tcpdump;\
    rm -rf /etc/nginx/conf.d; rm /etc/nginx/nginx.conf; \
    mkdir -p /var/www/logs /var/www/default/html /var/lib/nginx/temp /usr/local/lib/lua;

COPY nginx.conf /etc/nginx/
COPY lua    /usr/local/lib/lua
COPY conf.d /etc/nginx/conf.d
COPY www    /var/www

RUN chown nginx:nginx /var/www && chmod +x /usr/local/bin/about;

STOPSIGNAL SIGTERM
EXPOSE 80 
# ENTRYPOINT ["nginx", "-g", "daemon off;"]
CMD ["nginx", "-g", "daemon off;"]
