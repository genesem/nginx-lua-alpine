
# docker.io/genesem/nginx-lua-alpine
# https://github.com/genesem/nginx-lua-alpine

FROM alpine:latest
LABEL maintainer "Gene Semerenko - https://github.com/genesem"
COPY about /usr/local/bin/ 
COPY setconf.sh /etc/nginx/setconf

RUN set -eux; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update && apk add -u nginx procps bind-tools \
    nginx-mod-http-lua \
    luajit lua5.1 lua5.1-libs lua5.1-redis \
    lua-resty-core lua-resty-lrucache lua-resty-redis lua-resty-session; \
    rm -rf /etc/nginx/conf.d /etc/nginx/nginx.conf /var/cache/apk/*; \
    chmod +x /usr/local/bin/about /etc/nginx/setconf; \
    mkdir -p /var/www/logs /var/www/default/html /var/lib/nginx/temp;

# lua5.1-iconv lua5.1-say lua5.1-md5 nginx-mod-http-lua-upstream nginx-mod-http-echo 
# luarocks5.1 lua-resty-http lua-resty-string lua-resty-hmac 

COPY *.conf /etc/nginx/
COPY conf.d /etc/nginx/conf.d
COPY www    /var/www
WORKDIR     /etc/nginx/

# Execute the script to set internal dns resolver:
# ENTRYPOINT ["/bin/ash", "setconf.sh"]  # must be called from pod post init

STOPSIGNAL SIGTERM
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
