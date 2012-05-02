<?php
require_once('../lib/core.lib.php');
//$romana = new Tolcarom();
//if (!empty($GPC['puerto']) and !empty($GPC['idCA'])) {
//    $infoRomana = $romana->find(array('id_centro_acopio' => 2));
//    if (!empty($infoRomana)) {
//        $protocolo="http://";
//        $ip=$infoRomana[0]['ip'];
//        $conexion=(!empy($infoRomana[0]['conexion1'])) ? ":"+$infoRomana[0]['conexion1'] : "";
//        if (empty($ip)) {
//            $peso=file_get_contents("http://192.168.56.89:9600");
//            echo $html->input('peso', substr($peso, 0, -1), array('type' => 'text', 'class' => 'estilo_campos'));
//        }
//    }
//}
$peso=file_get_contents("http://192.168.56.89:9600");
echo $html->input('peso', substr($peso, 0, -1), array('type' => 'text', 'class' => 'estilo_campos'));
?>