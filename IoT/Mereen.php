<?php
/*  Webservice class Mereen
    used by external device (raven) to communicate with database
 */
    include_once("inc/_consts.php");
    include_once("inc/Raven.php");

    $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);

    $server = new SoapServer("Mereen.wsdl");
    $server->addFunction("bookMsg");
    $server->addFunction("getRavenResponse");
    $server->handle();
    $mysql->close();
 ?>
