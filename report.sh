#!/bin/sh

cd /usr/local/sbin/reporter/

# directories
CWD=$(pwd)

LOGDIR=$CWD/log

INPUTDIR=$CWD/catalog

TEMPDIR=$CWD/temp

# now
NOW=$(date "+%Y-%m-%d %H:%M:%S")

# files
LOG=${LOGDIR}/$1_${NOW}.log

INPUT=${INPUTDIR}/$1.sql

TEMP=${TEMPDIR}/$1_${NOW}.csv

if [ -z "$2" ]
  then
    TO=$(cat ${INPUTDIR}/$1.to)
  else
  	TO=$2
fi

echo "[$NOW] Starting report: $1" >> ${LOG}

# run report
mysql --defaults-file=$CWD/my.cnf smc < "$INPUT" | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" 2>> "$LOG" 1> "$TEMP"

echo "[$NOW] Completed report: $1" >> ${LOG}

# send email
php send.php "$1 Report $NOW" "$TEMP" "$TO" $(cat from) >> ${LOG}

rm ${TEMPDIR}/*