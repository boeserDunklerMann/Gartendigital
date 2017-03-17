use Essos;
delimiter //

drop procedure if exists sp_GetMandants//
CREATE PROCEDURE sp_GetMandants()
BEGIN
    select MandantID, ParentMandantID, Des, SecurityToken from Mandant;
END//

drop PROCEDURE if EXISTS sp_GetChildMandants//
create PROCEDURE sp_GetChildMandants(in MandantID int)
BEGIN
    select MandantID, ParentMandantID, Des, SecurityToken from Mandant where ParentMandantID=MandantID;
END//

drop PROCEDURE if EXISTS sp_DeleteMandant//
create procedure sp_DeleteMandant(MandantID int)
BEGIN
    delete from Mandant where MandantID=MandantID;
END//

drop PROCEDURE if EXISTS sp_CreateMandant//
create procedure sp_CreateMandant(ParentMandantID int, Des varchar(50))
BEGIN
    insert into Mandant (ParentMandantID, Des)
    VALUES (ParentMandantID, Des);
END//

drop PROCEDURE IF EXISTS sp_UpdateMandant//
CREATE PROCEDURE sp_UpdateMandant(MandantID int, ParentMandantID int, Des varchar(50))
BEGIN
    update Mandant
    set
        ParentMandantID=ParentMandantID,
        Des=Des
    where Mandant.MandantID=MandantID;
end//

delimiter ;

