<?php
    
    include_once("inc/_consts.php");
    include_once("inc/_functions.php");
    if (!openlog($_logIdentifier, LOG_PID | LOG_PERROR , LOG_LOCAL0))
        die ("openlog");
    syslog(LOG_DEBUG, "starting execution pipeline");

    ///
    /// Liefert die CalculationPipeline als mysql-row zu einer CalculationPipelineID
    ///
    function GetCalcPipelineRow($id)
    {
        $qry = sprintf("SELECT * FROM CalculationPipeline Where CalculationPipelineID=%d", $id);
        $res = $GLOBALS["mysql"]->query($qry);
        if ($res)
        {
            $row = $res->fetch_assoc();
            $res->close();
            return $row;
        }
        else
            return null;
    }

    ///
    /// Liefert die NÄCHSTE CalculationPipeline als mysql-row zu einer CalculationPipelineID
    ///    
    function GetcNextCalcPipelineRow($id)
    {
        $qry = sprintf("SELECT * FROM CalculationPipeline Where ParentCalcID=%d", $id);
        $res = $GLOBALS["mysql"]->query($qry);
        if ($res)
        {
            $row = $res->fetch_assoc();
            $res->close();
            return $row;
        }
        else
            return null;
    }

    $mq = msg_get_queue($_mqID);
    if (msg_receive($mq, 0, $_msgTypeNewRaven, 40, $ravenID, true, MSG_IPC_NOWAIT) != true)
    {
        $ravenID = 2;
    }
    {
        // msg_remove_queue($mq);
        $strLogMsg = sprintf("Got raven with ID #%d", $ravenID);
        syslog(LOG_DEBUG, $strLogMsg);

        // DONE: OK, ich hab jetzt meinen Raben, jetzt hole dem seine Nachricht aus der Datenbank und mach was draus.
        $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
        $res = $mysql->query(sprintf("call sp_GetRaven(%d)", $ravenID));
        if ($res)
        {
            //$res->data_seek(0);
            $row = $res->fetch_assoc();
            $ravenMsg = $row["Message"];
            $res->close();
        }
        else
        {
            printMySqlError($mysql);
        }
        
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
            // hole die CalcPipeline zum VMP und Mandant
            $sql = sprintf("select CalculationPipelineID from VirtualMeteringPoint where VmpID=%d and MandantID=%d", $vmp, $mandant);
            syslog(LOG_DEBUG, $sql);
            // reconnect to avoid "out of sync"
            $mysql->close();
            $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
            $result = $mysql->query($sql);
            $value = $meteringValue;

            if ($result)
            {
                if ($result->num_rows === 0)
                    syslog(LOG_DEBUG, "no calc pipeline found.");
                else
                    syslog(LOG_DEBUG, "Entering calc pipeline");

                while(($result != null) )
                {
                    if (method_exists($result, "fetch_assoc"))
                        $row = $result->fetch_assoc();
                    else
                        $row = $result; // result ist von GetNextCalcPipelineRow, daher schon eine row
                    
                    $calcpipeid = $row["CalculationPipelineID"];
                    // hole die kompletten Pipelinedaten
                    $result = GetCalcPipelineRow($calcpipeid);
                    if ($result != null)
                    {
                        $row = $result;
                        // DONE: berechne 
                        $operand = $row["Operand"];
                        $operator = $row["Operator"];
                        switch($row["Operator"])
                        {
                            case "+":
                                $value = $value + $operand;
                                break;
                            case "-":
                                $value -= $operand;
                                break;
                            case "*":
                                $value *= $operand;
                                break;
                            case "/":
                                $value = $value / $operand;
                                break;
                            case "<<":
                                $value = $value << $operand;
                                break;
                            case ">>":
                                $value = $value >> $operand;
                                break;
                            case "|":
                                $value = $value | $operand;
                                break;
                            case "&":
                                $value = $value & $operand;
                                break;
                        }
                        syslog(LOG_DEBUG, "Calculated value: ".$value);
                        // TODO: berechneten Wert irgendwo hin speichern und dann die ExecPipeline starten
                        
                        // hole nächsten
                        $result = GetcNextCalcPipelineRow($calcpipeid);
                    }
                }
            }
            else
            {
                printMySqlError($mysql);
            }
        }
    }
    syslog(LOG_DEBUG, "exiting execution pipeline");
 ?>
