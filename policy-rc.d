#!/bin/bash

DISABLE_ACTIONS=(start)
DISABLED_SERVICES=(rabbitmq-server)

longoptions='quiet,force,try-anyway,disclose-deny,query,no-fallback,help'
getopt=$(getopt -o '' --longoptions $longoptions -- "$@")
if [ $? != 0 ]; then
   echo "ERROR!"
   exit 1;
fi

eval set -- "$getopt"

while true; do
      case "$1" in
      --quiet)
        QUIET=1
        shift
      ;;
      --force)
        FORCE=1
        shift
      ;;
      --try-anyway)
        TRY_ANYWAY=1
        shift
      ;;
      --disclose-deny)
        DISCLOSE_DENY=1
        shift
      ;;
      --query)
        QUERY=1
        shift
      ;;
      --no-fallback)
        NO_FALLBACK=1
        shift
      ;;
      --)
        shift
        break
      ;;
      *)
        echo "There should probably be some help text here!"
        exit 1
      ;;
      esac
done

SRV_NAME=$1
shift
SRV_ACTION=$1
SRV_ARGS=$*

SRV_DISABLED=0
ACT_DISABLED=0

if [ ! -f "/etc/init.d/${SRV_NAME}" ]; then
    exit 100
fi

for i in "${DISABLED_SERVICES}"
do
    if [ $i = $SRV_NAME ]; then
        SRV_DISABLED=1
    fi
done

for i in "${DISABLE_ACTIONS}"
do
    if [ $i = $SRV_ACTION ]; then
        ACT_DISABLED=1
    fi
done

if [ $SRV_DISABLED -eq 1 -a $ACT_DISABLED -eq 1 ]; then
    exit 101
else
    exit 104
fi
