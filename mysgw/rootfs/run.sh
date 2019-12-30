#!/bin/ash

echo "MySensors Gateway Init..."
MYSGW_TYPE=$(jq ".type" "${CONFIG_PATH}")
MYSGW_TRN=$(jq ".transport" "${CONFIG_PATH}")
MQTT_SERVER=$(jq ".mqtt_server" "${CONFIG_PATH}")
MQTT_CLIENTID=$(jq ".mqtt_clientid" "${CONFIG_PATH}")
MQTT_TOPIC_IN=$(jq ".mqtt_topicin" "${CONFIG_PATH}")
MQTT_TOPIC_OUT=$(jq ".mqtt_topicout" "${CONFIG_PATH}")

## DEBUG
echo MYSGW_TYPE: $MYSGW_TYPE
echo MYSGW_TRN: $MYSGW_TRN
echo MQTT_SERVER: $MQTT_SERVER
echo MQTT_CLIENTID: $MQTT_CLIENTID
echo MQTT_TOPIC_IN: $MQTT_TOPIC_IN
echo MQTT_TOPIC_OUT: $MQTT_TOPIC_OUT

# SPI listing
ls /dev/spidev*

CONF_OPTS="--my-config-file=/data/mysensors.conf --spi-driver=BCM --soc=BCM2836 --cpu-flags=\"-mcpu=cortex-a53 -mfloat-abi=hard -mfpu=neon-fp-armv8 -mneon-for-64bits -mtune=cortex-a53\""
MQTT_OPTS="--my-mqtt-client-id=$MQTT_CLIENTID --my-controller-url-address=$MQTT_SERVER --my-mqtt-publish-topic-prefix=$MQTT_TOPIC_OUT --my-mqtt-subscribe-topic-prefix=$MQTT_TOPIC_IN"

cd $APPDIR
echo "./configure --my-transport=$MYSGW_TRN --my-gateway=$MYSGW_TYPE $MQTT_OPTS $CONF_OPTS"
LDFLAGS="-static" ./configure \
  --my-transport=$MYSGW_TRN \
  --my-gateway=$MYSGW_TYPE \
  $MQTT_OPTS \
  $CONF_OPTS
  
make

echo "Starting MySensors Gateway..."
./bin/mysgw
