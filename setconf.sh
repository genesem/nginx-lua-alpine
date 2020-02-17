#!/bin/sh
echo "Set nginx resolver.."
conf="resolver $(/usr/bin/awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf); resolver_timeout 2s;" 
echo "Got: $conf" 
echo "$conf" >/etc/nginx/common.conf
nginx -s reload >/dev/null
exit 0


