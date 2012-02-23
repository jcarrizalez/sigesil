<?php

require_once('../lib/core.lib.php');
require('../lib/common/header.php');
?>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        NUEVO ANALISIS DE RECEPCI&Oacute;N<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td>Nro. Entrada</td>
            <td><? echo $html->input('res.codigo', $infoOrg[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            <td>Fecha</td>
            <td><? echo $html->input('res.fecha', $infoOrg[0]['fecha'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>            
        </tr>
        <tr>
            <td>Carril</td>
            <td><? echo $html->input('res.carril', $infoOrg[0]['carril'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            <td>Hora</td>
            <td><? echo $html->input('res.hora', $infoOrg[0]['hora'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><? echo $html->input('res.cultivo', $infoOrg[0]['cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            <td>.</td>
            <td>.</td>
        </tr>
        
    </table>
</form>    
    
<?
    require('../lib/common/footer.php');
?>
