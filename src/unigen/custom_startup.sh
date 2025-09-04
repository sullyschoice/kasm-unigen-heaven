#!/usr/bin/env bash
set -ex
START_COMMAND="/opt/unigen/Unigine_Heaven-4.0/heaven"
PGREP="heaven"
export MAXIMIZE="false"
export MAXIMIZE_NAME="heaven"
MAXIMIZE_SCRIPT=$STARTUPDIR/maximize_window.sh
DEFAULT_ARGS=""

ARGS=${APP_ARGS:-$DEFAULT_ARGS}


FORCE=$2

cd /opt/unigen/Unigine_Heaven-4.0/

# run with vgl if GPU is available
if [ -f /opt/VirtualGL/bin/vglrun ] && [ ! -z "${KASM_EGL_CARD}" ] && [ ! -z "${KASM_RENDERD}" ] && [ -O "${KASM_RENDERD}" ] && [ -O "${KASM_EGL_CARD}" ] ; then
    START_COMMAND="/opt/VirtualGL/bin/vglrun -d ${KASM_EGL_CARD} $START_COMMAND"
fi


kasm_startup() {

    if [ -z "$DISABLE_CUSTOM_STARTUP" ] ||  [ -n "$FORCE" ] ; then

        echo "Entering process startup loop"
        set +x
        while true
        do
            if ! pgrep -x $PGREP > /dev/null
            then
                /usr/bin/filter_ready
                /usr/bin/desktop_ready
                set +e
                bash ${MAXIMIZE_SCRIPT} &
                $START_COMMAND $ARGS $URL
                set -e
            fi
            sleep 1
        done
        set -x

    fi
}

kasm_startup
