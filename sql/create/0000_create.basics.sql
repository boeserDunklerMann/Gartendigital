--execute as dba
create DATABASE Essos
create user 'drogon'@'%' identified by 'dracarys' PASSWORD expire never;
grant all Essos.* to 'drogon'@'%';

