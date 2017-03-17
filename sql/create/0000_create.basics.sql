-- execute as dba
create DATABASE if not exists Essos;
create user 'drogon'@'%' identified by 'dracarys';  -- lokaler user für php bspw.
grant all on Essos.* to 'drogon'@'%';

