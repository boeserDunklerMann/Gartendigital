<?php
    function testfunktion($a)
    {
        return "Valar Morguhlis. " . $a;
    }

    function add($a, $b)
    {
        return $a+$b;
    }
    $server = new SoapServer("math.wsdl");
    $server->addFunction("add");
    $server->handle();
 ?>