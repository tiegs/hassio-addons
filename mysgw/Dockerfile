ARG BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

FROM ${BUILD_FROM}

VOLUME /data

ENV CONFIG_PATH=/data/options.json
ENV APPDIR=/opt/MySensors
COPY rootfs /
RUN  chmod a+x /run.sh && \
     apk add g++ make git linux-headers && \
     git clone https://github.com/mysensors/MySensors.git --branch master $APPDIR

# Labels
LABEL \
    io.hass.name="MySensors Gateway" \
    io.hass.description="MySensors Gateway" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Tilman Eggers <dev@tilmaneggers.de>" \
    org.label-schema.description="MySensors Gateway" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="MySensors Gateway" \
    org.label-schema.schema-version="0.1" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/tiegs/hassio-addons/src/branch/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/tiegs/hassio-addons/mysgw" \
    org.label-schema.vendor="Tilman Egger Hass.io MySensors Add-on"

CMD [ "/run.sh" ]
