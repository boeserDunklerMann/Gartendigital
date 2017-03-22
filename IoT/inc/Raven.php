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
        $res = $mysql->query("call sp_AddRaven(".$mandantID.", \"".addslashes($msg)."\")", MYSQLI_USE_RESULT);
        if ($res)
        {
            //$res->data_seek(0);
            $row = $res->fetch_assoc();
            $rid = $row['RavenID'];
            $retVal = sprintf($GLOBALS['_bookMsgSuccess'], $rid);
            $res->close();

            $msgQueue = msg_get_queue($GLOBALS["_mqID"]);
            if ($msgQueue)
            {
                if (!msg_send($msgQueue, /* msg type */ $GLOBALS["_msgTypeNewRaven"], /* data */ $rid))
                {
                    syslog(LOG_ERR, "Writing msg queue failed.");
                    throw new Exception("msg_send");
                }
                // if (!msg_remove_queue($msgQueue))
                //     throw new Exception("msg_remove_queue");
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

    function getRavenResponse($ravenID)
    {
        global $mysql;
        $rid = (int)$ravenID;

        $res = $mysql->query(sprintf("call sp_GetRaven(%d)", $rid)); // TODO: eigentlich sp_GetRavenResponse
        $res->data_seek(0);
        $row = $res->fetch_assoc();
        return $row["Message"];
    }
 ?>