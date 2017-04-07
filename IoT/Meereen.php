<?php
/*  Webservice class Mereen
    used by external device (raven) to communicate with database
 */
    include_once("inc/_consts.php");
    include_once("inc/Raven.php");

    $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
    // if ($_SERVER["HTTPS"] != "on")
    // {
    //     throw new Exception("HTTPS is mandatory.");
    // }
    $server = new SoapServer("Meereen.wsdl");
    $server->addFunction("bookMsg");
    $server->addFunction("getRavenResponse");
    $server->handle();
    $mysql->close();
 ?>
