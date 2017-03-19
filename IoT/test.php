<html>
<body>
<pre>
<?php
    include_once("inc/_consts.php");
 
    $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
    if ($_SERVER["HTTPS"] != "on")
    {
        throw new Exception("HTTPS is mandatory.");
    }
    $xml = new DOMDocument();
    $xml->load("Schema/Raven.Beispiel.xml");
    if (!$xml->schemaValidate("Schema/Raven.xsd"))
    {
        throw new Exception("Schema Fehler!");
    }
    $msgQueue = msg_get_queue($_mqID);
    if ($msgQueue)
    {
        print_r($msgQueue);
        if (!msg_send($msgQueue, /* msg type? */ 21, /* data */ 123456))
            die("msg_send");
        if (!msg_remove_queue($msgQueue))
            die("msg_remove_queue");
    }

    // $xml = simplexml_load_file("Schema/Raven.Beispiel.xml");
    // print_r($xml);
    // $root = $xml->Root;
    // print_r($root);
    // $mandant = $xml->Mandant;
    // print_r($mandant);
    // $mandantID = $mandant["MandantID"];
    // print_r($mandantID);
    // echo("\n\n\n".$mandantID);
?>
</pre></body></html>
