#!/bin/bash

mysql -ponly4sus < ./0000_burnThemAll.sql
mysql -ponly4sus < ./0000_create.basics.sql

#find ./ -maxdepth 1 -type f -name '*.sql' -execdir ./exec.sh {} \; | sort
#find ./ -maxdepth 1 -type f -name '*.sql' -execdir cat \< {} \; | sort
find ./ -maxdepth 2 -type f -name '*.sql' | sort | xargs -i ./exec.sh {}

