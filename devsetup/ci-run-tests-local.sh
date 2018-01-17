#!/bin/bash
# Arguments:
#  - Jenkins build id

mkdir -p ~/behat/;

# Change into the vcs root directory.
cd `dirname $0`/..

# First, run PHPCS.
composer cs
if [[ $? -ne 0 ]]; then
  echo Coding style violations found!
  exit 1
fi

# Check security.
composer check-security
if [[ $? -ne 0 ]]; then
  echo Insecure packages used!
  exit 1
fi

# Then, finally run behat!
# We use curl to warm up caches via a regular HTTP request.
export URL=http://`hostname -f`
curl -L $URL | grep 'drupal.org'

if [[ $? -ne 0 ]]; then
  echo Unable to access site.
  exit 1
fi

export BEHAT_PARAMS="{\"extensions\":{\"Behat\\\\MinkExtension\":{\"base_url\":\"$URL/\"}}}"
# Output some debug information.
echo "BEHAT_PARAMS=$BEHAT_PARAMS"
./vendor/bin/behat --format=progress --out=std --format=junit --out=$HOME/behat/$1

exit $?
