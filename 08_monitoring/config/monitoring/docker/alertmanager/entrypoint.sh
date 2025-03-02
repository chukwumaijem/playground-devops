#!/bin/sh
set -e

# Replace environment variables using sed
sed "s|\${SLACK_WEBHOOK_URL}|${SLACK_WEBHOOK_URL}|g" /etc/alertmanager/alertmanager.yml.template > /etc/alertmanager/alertmanager.yml

# Start AlertManager with the processed config
exec /bin/alertmanager \
    --config.file=/etc/alertmanager/alertmanager.yml \
    --storage.path=/alertmanager \
    --web.external-url=http://localhost:9093
