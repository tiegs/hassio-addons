ARG BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

FROM ${BUILD_FROM}

ENV CONFIG_PATH=/data/options.json
ENV APPDIR=/opt/MySensors
COPY rootfs /
RUN  chmod a+x /run.sh && \ 
     apt-get update && apt-get install -y --force-yes \
     make \
     g++ \
     git \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache \
     && git clone https://github.com/mysensors/MySensors.git --branch master $APPDIR

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
    org.label-schema.usage="https://git.home/teggers/hassio-mysensors-addon/src/branch/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://git.home/teggers/hassio-mysensors-addon" \
    org.label-schema.vendor="Tilman Egger Hass.io MySensors Add-on"

CMD [ "/run.sh" ]
