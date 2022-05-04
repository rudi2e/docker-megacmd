#!/bin/sh
### Copyright (c) Rudi2e

if [ "$1" = "mega-cmd-server" ]; then
    mega_pid=-1

    SigTermHandler() {
        if [ "$mega_pid" -ne "-1" ]; then
            #kill -SIGTERM "${mega_pid}"
            #mega-exec exit
            mega-quit
            wait "${mega_pid}"
        fi

        exit 143
    }

    trap 'SigTermHandler' TERM

    mega-cmd-server >> /dev/stdout 2>&1 &
    mega_pid="${!}"

    while true; do
        tail -f /dev/null & wait ${!}
    done
else
    exec "$*"
fi
