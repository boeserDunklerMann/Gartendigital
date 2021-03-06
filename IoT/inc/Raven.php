<?php
    ///
    /// Verbucht eine einkommende Nachricht von einem Raben in die Datenbank
    /// TODO: Hier müsste noch ein Handle zurückgegeben werden, mit welchem
    /// der Rabe sich seine Antwort abholt.
    /// NOTODO: die RavenID von sp_AddRaven ist dieses Handle.
    function bookMsg( $message_from_raven)
    {
        $msg = (string)$message_from_raven;
        openlog($GLOBALS["_logIdentifier"], LOG_PID | LOG_PERROR, LOG_LOCAL0);
        syslog(LOG_DEBUG, "Got raven");

        // DONE: XML Schema-check
        $xml = new DOMDocument();
        $xml->loadXML($msg);
        if (!$xml->schemaValidate("Schema/Raven.xsd"))
        {
            syslog(LOG_ERR, "Schema validation failed.");
            return $GLOBALS["_bookMsgFailure"];
        }

        // DONE: Message nach MandantID parsen
        $xml = simplexml_load_string($msg);
        $mandant = $xml->Mandant;
        $mandantID = $mandant["MandantID"];

        // DONE: Execution pipeline informieren, dass ein Rabe gekommen ist.
        $res = $GLOBALS["mysql"]->query("call sp_AddRaven(".$mandantID.", \"".addslashes($msg)."\")", MYSQLI_USE_RESULT);
        if ($res)
        {
            // Hole die RavenID, die müssmer zurückgeben.
            $row = $res->fetch_assoc();
            $rid = $row['RavenID'];
            $retVal = sprintf($GLOBALS['_bookMsgSuccess'], $rid);
            $res->close();

            // hole/öffne SYSV-MessageQueue
            $msgQueue = msg_get_queue($GLOBALS["_mqID"]);
            if ($msgQueue)
            {
                // schreibe Nachricht mit RavenID da rein
                if (!msg_send($msgQueue, /* msg type */ $GLOBALS["_msgTypeNewRaven"], /* data */ $rid))
                {
                    syslog(LOG_ERR, "Writing msg queue failed.");
                    throw new Exception("msg_send");
                }
                // TODO: execute the pipeline (async)
                // exec("php ExecPipeline.php");
            }
            else
            {
                syslog(LOG_ERR, "Opening msg queue failed.");
            }

        }
        else
        {
            syslog(LOG_ERR, "Adding raven in DB failed.");
            $retVal = $GLOBALS['_bookMsgFailure'];
        }
        closelog();
        return $retVal;
    }

    ///
    /// Die Antwort für unseren Raben
    ///
    function getRavenResponse($ravenID)
    {
        $rid = (int)$ravenID;

        $res = $GLOBALS["mysql"]->query(sprintf("call sp_GetRaven(%d)", $rid)); // TODO: eigentlich sp_GetRavenResponse
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        $res->close();
        return $row["Message"];
    }
 ?>