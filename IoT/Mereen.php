<?php
/*  Webservice class Mereen
    used by external device to communicate with database
 */
    include_once("inc/_consts.php");

    $mysql = new mysqli($_dbServer, $_dbUser, $_dbPass, $_dbName);
    echo $mysql->host_info;

    ///
    /// Verbucht eine einkommende Nachricht von einem Raben in die Datenbank
    /// TODO: Hier müsste noch ein Handle zurückgegeben werden, mit welchem
    /// der Rabe sich seine Antwort abholt.
    ///
    function bookMsg(string $message_from_raven)
    {
        // TODO: Do something
        return $_bookMsgSuccess;
    }

    $server = new SoapServer("Mereen.wsdl");
    $server->addFunction("bookMsg");
    $server->handle();
    $mysql->close();
 ?>
