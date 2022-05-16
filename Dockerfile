FROM alpine
LABEL maintainer="gorkarevilla"

RUN apk add --no-cache curl bind-tools

COPY dynhost.sh /usr/local/bin/dynhost.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/dynhost.sh
RUN chmod +x /entrypoint.sh

ARG CRON_SCHEDULE="00/15 * * * *"

# Generate logfile
RUN touch /var/log/dynhost.log

# Add crontab rule
RUN crontab -l | { cat; echo "${CRON_SCHEDULE}       /usr/local/bin/dynhost.sh"; } | crontab -

#Run script. 
ENTRYPOINT [ "/entrypoint.sh" ]