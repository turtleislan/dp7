#!/bin/bash


echo "Waiting for $1 $2"

TEST_IP="$(getent hosts $1 | awk 'NR==1{ print $1 }')"


nc -z $TEST_IP $2
n=$?
while [ $n -ne 0 ]; do
    sleep 1
    nc -z $TEST_IP $2
    n=$?
done

echo "Database $1 $2  Ready"