#!/bin/sh
mysqladmin -u root --password=only4sus drop Essos
mysql -u root --password=only4sus < ./0000_create.basics.sql
mysql -u drogon -p dracarys < ./0001_create.Mandant.table.sql
