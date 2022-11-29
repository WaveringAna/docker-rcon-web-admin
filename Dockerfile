FROM node:12

ARG RCON_WEB_ADMIN_VERSION=0.14.4

ADD https://github.com/Emilgardis/rcon-web-admin/archive/refs/tags/v${RCON_WEB_ADMIN_VERSION}.tar.gz /tmp/rcon-web-admin.tgz


RUN tar -C /opt -xf /tmp/rcon-web-admin.tgz && \
    rm /tmp/rcon-web-admin.tgz && \
    ln -s /opt/RCON-Web-Admin-${RCON_WEB_ADMIN_VERSION} /opt/rcon-web-admin

WORKDIR /opt/rcon-web-admin

RUN npm install && \
    node src/main.js install-core-widgets && \
    chmod 0755 -R startscripts *

EXPOSE 4326

VOLUME ["/opt/rcon-web-admin/db"]

ENV RWA_ENV=TRUE

ENTRYPOINT ["/usr/local/bin/node", "src/main.js", "start"]
