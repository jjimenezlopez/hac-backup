#!/bin/bash
echo "$CRON_FREQUENCY   root    INCLUDE_DB=$INCLUDE_DB DAYS_TO_KEEP=$DAYS_TO_KEEP /ha-backup.sh" > /etc/cron.d/container_cronjob
chmod 644 /etc/cron.d/container_cronjob