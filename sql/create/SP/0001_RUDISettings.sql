use Essos;
delimiter //

drop PROCEDURE if exists sp_GetSettingsTypes//
create procedure sp_GetSettingsTypes()
BEGIN
    select stID, stDes from SettingsType;
end//

drop PROCEDURE if exists sp_AddSettingsType//
create procedure sp_AddSettingsType(Des varchar(50))
begin
    insert into SettingsType (stDes) values (Des);
end//

drop PROCEDURE if EXISTS sp_DelSettingsType//
create procedure sp_DelSettingsType(stID int)
begin
    delete from SettingsType where SettingsType.stID=stID;
end//

drop procedure if EXISTS sp_UpdSettingsType//
create procedure sp_UpdSettingsType(stID int, Des varchar(50))
begin
    update SettingsType
    set stDes=Des
    where SettingsType.stID=stID;
end//

/* **************************************************** */
drop procedure if exists sp_GetSettings//
create procedure sp_GetSettings(name varchar(30), stID int, out value varchar(255))
begin
    set value = (select settingsValueString
    from Settings
    where settingsName=name and Settings.stID=stID);
end//

drop procedure if exists sp_SetSettings//
create procedure sp_SetSettings(name varchar(30), stID int, value varchar(255))
begin
    declare cnt int;
    set cnt = (select count(*) from Settings where settingsName=name and Settings.stID=stID);
    if (cnt = 0) then
        insert into Settings (stID, settingsName, settingsValueString, settingsValueBin, Remarks)
        values (stID, name, value, null, null);
    else
        update Settings set settingsValueString = value
        where Settings.stID = stID and settingsName=name;
    end if;
end//

drop procedure if exists sp_GetAllSettings//
create procedure sp_GetAllSettings()
begin
    select SettingsID, stID, settingsName, settingsValueString, Remarks
    from Settings
    order by SettingsID;
end //
delimiter ;

call sp_SetSettings('DBVersion', 1, '0.2 ante');
