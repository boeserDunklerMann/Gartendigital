use Essos;

delimiter //

drop procedure if exists sp_AddRaven//
create procedure sp_AddRaven(mid int, msg text, out RavenID int)
begin
    insert into Raven (MandantID, Message)  values (mid, msg);
    set RavenID = (select last_insert_id());
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
delimiter ;
