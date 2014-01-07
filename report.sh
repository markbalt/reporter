#!/bin/sh

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

echo "[$NOW] Starting report: $1" >> ${LOG}

# run report
mysql --defaults-file=$CWD/my.cnf smc < "$INPUT" | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" 2>> "$LOG" 1> "$TEMP"

echo "[$NOW] Completed report: $1" >> ${LOG}

# send email
php send.php "$1 Report $NOW" "$TEMP" "$2" $(cat from) >> ${LOG}

#rm ${TEMPDIR}/*