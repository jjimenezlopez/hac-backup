# Home Assistant Container Backup | hac-backup

**hac-backup** is a very simple Docker container that will create a backup periodically of a Home Assistant's config directory. The `ha-backup.sh` script *doing all the job* comes from [this gist](https://gist.github.com/riemers/041c6a386a2eab95c55ba3ccaa10e7b0) from [riemers](https://github.com/riemers).

## Usage
The easiest way to use this is through docker compose. Here is a sample configuration:

```yaml
version: '3'
services:
  hac-backup:
    container_name: hac-backup
    restart: unless-stopped
    environment:
      - CRON_FREQUENCY=0 3 * * *
      - INCLUDE_DB=true
      - DAYS_TO_KEEP=5
    volumes:
      - './config:/config'
      - '/mnt/backups/HA:/backups'
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    image: 'jjimenezlopez/hac-backup:beta'
    privileged: true
```

### Volumes
 - `/config`: Where your home assistant configuration lives.
 - `/backups`: The directory where the backups will be stored. For example, a USB drive, or a NFS/SMB volume.

### Environment Variables
 - `CRON_FREQUENCY`: Frequency for the backup in cron format, for example: 0 1 * * * for doing a backup every day at 1 AM. See https://crontab.guru/ for more advanced usage.
 - `INCLUDE_DB`: Wheter or not include the database in the backup. Values are: true or false.
 - `DAYS_TO_KEEP`: Days to keep backups. Set it to 0 to keep them forever.
