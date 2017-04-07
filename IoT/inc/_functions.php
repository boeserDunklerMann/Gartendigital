<?php
    function printMySqlError($mysql)
    {
        echo "Error: Our query failed to execute and here is why: \n";
        echo "Errno: " . $mysql->errno . "\n";
        echo "Error: " . $mysql->error . "\n";
    }
 ?>