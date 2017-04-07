<html>
<body>
<pre>
<?php
    include_once("inc/_consts.php");

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
    function GetcNextCalPipelineRow($id)
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

    $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
    
    $row = GetCalcPipelineRow(1);
    while ($row !== null)
    {
        $dbg = sprintf("Value%s%d\n", $row['Operator'], $row['Operand']); echo $dbg;
        $row = GetcNextCalPipelineRow($row['CalculationPipelineID']);
    }

/* Fehlerhaft, irgendwie
    // $res = $mysql->query("SELECT * FROM CalculationPipeline", MYSQLI_USE_RESULT);
    // if ($res)
    // {
    //     $row=$res->fetch_assoc();
    //     $res->close();
    //     print_r($row);
    //     $id = $row['CalculationPipelineID'];
    //     echo $id;
    //     $break = false;
    //     while (!$break)
    //     {
    //         $qry = sprintf("SELECT * FROM CalculationPipeline Where ParentCalcID=%d", $id);
    //         echo $qry.'\n';
    //         $res = $mysql->query($qry);
    //         if ($res)
    //         {
    //             $row = $res->fetch_assoc();
    //             print_r($row);
    //             $id = $row['CalculationPipelineID'];
    //             echo $id;
    //             if ($id == null)
    //             {
    //                 print "Giving up\n";
    //                 $break=true;
    //             }
    //             $res->close();
    //         }
    //         else
    //         {
    //             print $mysql->error;
    //             $break=true;
    //         }
    //     }
    // }
    // $xml = new DOMDocument();
    // $xml->load("Schema/Raven.Beispiel.xml");
    // if (!$xml->schemaValidate("Schema/Raven.xsd"))
    // {
    //     throw new Exception("Schema Fehler!");
    // }
    // $msgQueue = msg_get_queue($_mqID);
    // if ($msgQueue)
    // {
    //     print_r($msgQueue);
    //     if (!msg_send($msgQueue, /* msg type? / 21, /* data / 123456))
    //         die("msg_send");
    //     // if (!msg_remove_queue($msgQueue))
    //     //     die("msg_remove_queue");
    // }

    // $xml = simplexml_load_file("Schema/Raven.Beispiel.xml");
    // print_r($xml);
    // $root = $xml->Root;
    // print_r($root);
    // $mandant = $xml->Mandant;
    // print_r($mandant);
    // $mandantID = $mandant["MandantID"];
    // print_r($mandantID);
    // echo("\n\n\n".$mandantID);
    */
?>
</pre></body></html>
