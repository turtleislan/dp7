#!/bin/bash


echo "Waiting for mysql"
nc -z $1 3306
n=$?
while [ $n -ne 0 ]; do
    sleep 1
    nc -z $1 3306
    n=$?
done

echo "MySQL Ready"