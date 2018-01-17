#!/bin/bash

cd ../behat/$1
source container-vars.sh
ssh_name=$deploy_name.ci.drunomics.com

# Run the tests on the container.
ssh $ssh_name -C "cd $deploy_target_web/ && cd ../vcs && ./devsetup/ci-run-tests-local.sh $build_number"
EXIT_CODE=$?
rsync -az $ssh_name:behat/$build_number/ .

# Make sure the test result are recent enough for jenkins:
touch -m *.xml
exit $EXIT_CODE
