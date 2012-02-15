<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'mcpos':
            if(!empty($GPC['idE'])){
                $div_pol = new DivPol();
    
                $mcpos = $div_pol->obtenerMcpo('', $GPC['idE']);
                foreach($mcpos as $campo => $valor){
                    $listaM[$valor['id']] = $valor['nombre'];
                }
                
                echo "<div id='mcpo'>".$html->select('Org.id_municipio',array('options'=>$listaM, 'default' => 'Seleccione'))."</div>";
            }else{
                echo "<div id='mcpo'>".$html->select('Org.id_municipio',array('default' => 'Seleccione')) ."</div>";
            }
        break;
    }
?>
