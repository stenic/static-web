FROM nginxinc/nginx-unprivileged:stable-alpine as base

# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ARG TIME_ZONE=UTC

USER root
RUN mkdir -p /opt/var/cache/nginx && \
    cp -aL --parents /usr/lib/nginx /opt && \
    cp -a --parents /usr/share/nginx /opt && \
    cp -a --parents /var/log/nginx /opt && \
    cp -aL --parents /var/run /opt && \
    cp -a --parents /etc/nginx /opt && \
    cp -a --parents /etc/passwd /opt && \
    cp -a --parents /etc/group /opt && \
    cp -a --parents /usr/sbin/nginx /opt && \
    cp -a --parents /usr/sbin/nginx-debug /opt && \
    cp -a --parents /lib/libcrypto.so.* /opt && \
    cp -a --parents /lib/libz.* /opt && \
    cp -a --parents /lib/libc.* /opt && \
    cp -a --parents /lib/ld-musl-* /opt && \
    cp -a --parents /lib/libssl.so.* /opt && \
    cp -a --parents /usr/lib/lib* /opt && \
    cp /usr/share/zoneinfo/$TIME_ZONE /opt/etc/localtime

FROM gcr.io/distroless/static:nonroot

COPY --from=base /opt /
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

STOPSIGNAL SIGTERM
ENTRYPOINT ["nginx", "-g", "daemon off;"]
