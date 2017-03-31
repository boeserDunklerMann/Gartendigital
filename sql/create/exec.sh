#!/bin/bash

echo $1
if [ "$1" != "./0000_burnThemAll.sql" -a "$1" != "./0000_create.basics.sql" ]
    then
     mysql -u meraxes -pdracarys Essos < $1
fi
