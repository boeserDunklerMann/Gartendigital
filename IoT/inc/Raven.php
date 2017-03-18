<?php
    ///
    /// Verbucht eine einkommende Nachricht von einem Raben in die Datenbank
    /// TODO: Hier müsste noch ein Handle zurückgegeben werden, mit welchem
    /// der Rabe sich seine Antwort abholt.
    ///

    function bookMsg( $message_from_raven)
    {
        global $mysql;
        $msg = (string)$message_from_raven;

        // TODO: Execution pipeline informieren, dass ein Rabe gekommen ist.
        $res = $mysql->query("call sp_AddRaven(1, \"".$msg."\")");
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        $rid = $row['RavenID'];
        $retVal = sprintf($GLOBALS['_bookMsgSuccess'], $rid);
        return $retVal;
    }

    function getRavenResponse($ravenID)
    {
        global $mysql;
        $rid = (int)$ravenID;

        $res = $mysql->query(sprintf("call sp_GetRaven(%d)", $rid));
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        return $row["Message"];
    }
 ?>