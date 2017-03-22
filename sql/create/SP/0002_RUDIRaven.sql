use Essos;

delimiter //

drop procedure if exists sp_AddRaven//
create procedure sp_AddRaven(mid int, msg text)
begin
    declare RavenID int;
    insert into Raven (MandantID, Message)  values (mid, msg);
    set RavenID = (select last_insert_id());
    select RavenID;
end //

drop procedure if exists sp_DelRaven//
create procedure sp_DelRaven(ravenID int)
begin
    delete from Raven where Raven.RavenID = ravenID;
end//

drop procedure if exists sp_UpdRaven//
create procedure sp_UpdRaven(ravenID int, mid int, msg text)
begin
    update Raven
    set
        MandantID=mid,
        Message=msg,
        tstamp=CURRENT_TIMESTAMP
    where Raven.RavenID=ravenID;
end//

drop procedure if exists sp_GetRaven//
create procedure sp_GetRaven(ravenID int)
begin
    select Message from Raven where Raven.RavenID=ravenID;
end//

drop procedure if exists sp_GetRavenResponse//
create procedure sp_GetRavenResponse(ravenID int)
begin
    select MessageResponse from Raven where Raven.RavenID=ravenID;
end//

drop procedure if exists sp_GetAllRavensForMandant//
create procedure sp_GetAllRavensForMandant(mandantID int)
begin
    select ravenID from Raven where Raven.MandantID=mandantID;
end//

delimiter ;
