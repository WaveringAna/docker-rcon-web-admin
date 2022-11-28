FROM node:12
ENV NODE_ENV=production

ARG RCON_WEB_ADMIN_VERSION=0.14.1

ADD https://github.com/WaveringAna/rcon-web-admin/archive/${RCON_WEB_ADMIN_VERSION}.tar.gz /tmp/rcon-web-admin.tgz

RUN tar -C /opt -xf /tmp/rcon-web-admin.tgz && \
    rm /tmp/rcon-web-admin.tgz && \
    ln -s /opt/rcon-web-admin-${RCON_WEB_ADMIN_VERSION} /opt/rcon-web-admin

WORKDIR /opt/rcon-web-admin

RUN npm install --production && \
    node src/main.js install-core-widgets && \
    chmod 0755 -R startscripts *

EXPOSE 4326

VOLUME ["/opt/rcon-web-admin/db"]

ENV RWA_ENV=TRUE

ENTRYPOINT ["/usr/local/bin/node", "src/main.js", "start"]
