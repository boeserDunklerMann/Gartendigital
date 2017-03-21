<?php
    
    include_once("inc/_consts.php");
    if (!openlog($_logIdentifier, LOG_PID | LOG_PERROR , LOG_LOCAL0))
        die ("openlog");
    syslog(LOG_DEBUG, "starting execution pipeline");
    
    $mq = msg_get_queue($_mqID);
    if (msg_receive($mq, 0, $_msgTypeNewRaven, 40, $ravenID, true, MSG_IPC_NOWAIT) == true)
    {
        msg_remove_queue($mq);
        $strLogMsg = sprintf("Got raven with ID #%d", $ravenID);
        syslog(LOG_DEBUG, $strLogMsg);

        // DONE: OK, ich hab jetzt meinen Raben, jetzt hole dem seine Nachricht aus der Datenbank und mach was draus.
        $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
        $res = $mysql->query(sprintf("call sp_GetRaven(%d)", $ravenID));
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        $ravenMsg = $row["Message"];

        $xml = simplexml_load_string($ravenMsg);
        $data = $xml->Data;
        syslog(LOG_DEBUG, $data);
    }
    syslog(LOG_DEBUG, "exiting execution pipeline");
 ?>
