<?php
    require("../lib/core.lib.php"); 

    session_unset();
    session_destroy();

    header("location: ".DOMAIN_ROOT."pages/index.php");
    exit; 
?>