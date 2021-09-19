# Pulling ubuntu image with a specific tag from the docker hub.
FROM ubuntu:21.04

MAINTAINER jjimenezlopez

# Updating the packages and installing cron and vim editor if you later want to edit your script from inside your container.
RUN apt-get update && apt-get install cron vim zip curl -y

COPY ./scripts/generate_cronfile.sh /generate_cronfile.sh
COPY ./scripts/ha-backup.sh /ha-backup.sh
COPY ./cronjob.log /cronjob.log

RUN chmod a+x /generate_cronfile.sh
RUN chmod a+x /ha-backup.sh
RUN chmod a+rw /cronjob.log

# Running commands for the startup of a container.
CMD ["/bin/bash", "-c", "/generate_cronfile.sh && cron && tail -f /cronjob.log"]