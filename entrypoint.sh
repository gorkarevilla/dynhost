#!/usr/bin/env sh
pid=0

# SIGTERM-handler
term_handler() {
  echo "Finishing..."
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; term_handler' SIGTERM

# run application
crond &
pid="$!"

# wait forever
while true
do
  tail -f /var/log/dynhost.log & wait ${!}
done