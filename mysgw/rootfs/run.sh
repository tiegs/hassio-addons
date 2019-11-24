#!/bin/ash

echo "MySensors Gateway Init..."
MYSGW_TYPE=$(jq ".type" "${CONFIG_PATH}")
MYSGW_TRN=$(jq ".transport" "${CONFIG_PATH}")
MQTT_SERVER=$(jq ".mqtt_server" "${CONFIG_PATH}")
MQTT_CLIENTID=$(jq ".mqtt_clientid" "${CONFIG_PATH}")
MQTT_TOPIC_IN=$(jq ".mqtt_topicin" "${CONFIG_PATH}")
MQTT_TOPIC_OUT=$(jq ".mqtt_topicout" "${CONFIG_PATH}")

MQTT_OPTS="--my-mqtt-client-id=$MQTT_CLIENTID --my-controller-url-address=$MQTT_SERVER --my-mqtt-publish-topic-prefix=$MQTT_TOPIC_OUT --my-mqtt-subscribe-topic-prefix=$MQTT_TOPIC_IN"

cd $APPDIR
./configure --spi-spidev-device=/dev/spidev0.0 --my-transport=$MYSGW_TRN --my-gateway=$MYSGW_TYPE $MQTT_OPTS
make && make install

echo "Starting MySensors Gateway..."
./bin/mysgw --daemon
