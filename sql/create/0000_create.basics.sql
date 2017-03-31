-- execute as dba
create DATABASE if not exists Essos;
create user 'meraxes'@'%' identified by 'dracarys'; -- Master user
grant all on Essos.* to 'meraxes'@'%' with grant option;
create user 'drogon'@'%' identified by 'dracarys';  -- Web Service user
grant Select, Insert, Update, Delete on Essos.* to 'drogon'@'%';

