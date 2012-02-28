<?php
    require_once('../lib/core.lib.php');
    
    $recepcion = "SELECT re.fecha_recepcion, guia.numero_guia, re.numero, 
FROM si_recepcion re
INNER JOIN si_guiarec guia ON guia.id = re.id_guia
INNER JOIN si_productor pro ON pro.id = re.id_productor
LEFT JOIN si_asociado aso ON aso.id = re.id_asociado
INNER JOIN si_vehiculos ve ON ve.id = re.id_vehiculo
WHERE re.id = '1'";
?>
