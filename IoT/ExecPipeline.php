<?php
    
    include_once("inc/_consts.php");
    if (!openlog($_logIdentifier, LOG_PID | LOG_PERROR , LOG_LOCAL0))
        die ("openlog");
    syslog(LOG_DEBUG, "starting execution pipeline");
    
    $mq = msg_get_queue($_mqID);
//    if (msg_receive($mq, 0, $_msgTypeNewRaven, 40, $ravenID, true, MSG_IPC_NOWAIT) == true)
    if (msg_receive($mq, 0, $_msgTypeNewRaven, 40, $ravenID, true, MSG_IPC_NOWAIT) != true)
    {
        $ravenID = 54;
    }
    {
        // msg_remove_queue($mq);
        $strLogMsg = sprintf("Got raven with ID #%d", $ravenID);
        syslog(LOG_DEBUG, $strLogMsg);

        // DONE: OK, ich hab jetzt meinen Raben, jetzt hole dem seine Nachricht aus der Datenbank und mach was draus.
        $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
        $res = $mysql->query(sprintf("call sp_GetRaven(%d)", $ravenID));
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        $ravenMsg = $row["Message"];

        $xml = simplexml_load_string($ravenMsg);
        $sensors = $xml->Data->Sensors;
        $mandant = $xml->Mandant["MandantID"];
        print_r($sensors);
        // jeden Sensor durchgehen
        foreach($sensors->Sensor as $sensor)
        {
            $meteringType = $sensor["MeteringType"];
            $meteringName = $sensor["MeteringName"];
            $vmp = $sensor["VirtualMeteringPoint"];
            $meteringValue = $sensor;
            printf("Name: %s - Type: %s - Value: %s - VMP: %d\n", $meteringName, $meteringType, $meteringValue, $vmp);
        }
    }
    syslog(LOG_DEBUG, "exiting execution pipeline");
 ?>
