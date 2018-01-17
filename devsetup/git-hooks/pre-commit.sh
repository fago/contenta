#!/bin/bash

PROJECT=`php -r "echo dirname(dirname(dirname(realpath('$0'))));"`
STAGED_FILES_CMD=`git diff --cached --name-only --diff-filter=ACMR HEAD | grep \\\\.php`

# Determine if a file list is passed
if [ "$#" -eq 1 ]
then
    oIFS=$IFS
    IFS='
    '
    SFILES="$1"
    IFS=$oIFS
fi
SFILES=${SFILES:-$STAGED_FILES_CMD}

# Checking PHP Lint...
for FILE in $SFILES
do
    php -l -q -d display_errors=0 $PROJECT/$FILE > /dev/null
    if [ $? != 0 ]
    then
        echo "Fix the error before commit."
        exit 1
    fi
    FILES="$FILES $PROJECT/$FILE"
done

if [ "$FILES" != "" ]
then
    echo "Running Code Sniffer..."
    composer cs -- -p $FILES
    if [ $? != 0 ]
    then
        echo "Fix the error before commit!"
        echo "Run"
        echo "composer cbf"
        echo "for automatic fix or fix it manually."
        exit 1
    fi
fi

exit $?
