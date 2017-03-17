-- execute as dba
create DATABASE if not exists Essos;
create SCHEMA wth;
create user 'drogon'@'%' identified by 'dracarys';
grant all on Essos.* to 'drogon'@'%';

