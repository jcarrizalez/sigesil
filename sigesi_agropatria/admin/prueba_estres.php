<?php
    require_once('../lib/core.lib.php');
    
    if($GPC['ac'] == 'guardar'){
        system('echo RECEPCIONES >> log.txt');
        system('echo '.date('d-m-Y H:i:s').' >> log.txt');
        if(!empty($GPC['cant'])){
            $recepcion = new Recepcion();
            $guia = new Guia();

            $recepcion->_begin_tool();

            for($i=1; $i<=$GPC['cant']; $i++){
                $GPC['Guia']['id_usuario'] = $_SESSION['s_id'];
                $numero = $i+11;
                $GPC['Guia']['numero_guia'] = $numero;
                $GPC['Guia']['fecha_emision'] = 'now()';
                $GPC['Guia']['contrato'] = $numero * rand(2, 1000);

                $guia->save($GPC['Guia']);
                $idGuia = $guia->id;
                $guia->id = null;

                $GPC['Recepcion']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $GPC['Recepcion']['id_cosecha'] = '1';
                $GPC['Recepcion']['id_productor'] = '2';
                $GPC['Recepcion']['id_guia'] = $idGuia;
                $GPC['Recepcion']['id_usuario'] = $_SESSION['s_id'];
                $GPC['Recepcion']['numero'] = $i;
                $GPC['Recepcion']['fecha_recepcion'] = 'now()';
                $GPC['Recepcion']['carril'] = 1;
                $GPC['Recepcion']['fecha_pel'] = 'now()';
                $GPC['Recepcion']['peso_01l'] = rand(10000, 50000);
                $GPC['Recepcion']['peso_02l'] = rand(10000, 50000);
                $GPC['Recepcion']['fecha_v'] = 'now()';
                $GPC['Recepcion']['peso_01v'] = rand(10000, 50000);
                $GPC['Recepcion']['peso_02v'] = rand(10000, 50000);
                $GPC['Recepcion']['humedad'] = rand(1, 25);
                $GPC['Recepcion']['impureza'] = rand(1, 25);
                $GPC['Recepcion']['humedad_des'] = rand(1, 2000);
                $GPC['Recepcion']['impureza_des'] = rand(1, 2000);
                $GPC['Recepcion']['cant_muestras'] = 1;
                $GPC['Recepcion']['id_vehiculo'] = 18;
                $GPC['Recepcion']['id_chofer'] = 13;
                $GPC['Recepcion']['romana_ent'] = 1;
                $GPC['Recepcion']['romana_sal'] = 1;
                $GPC['Recepcion']['peso_acon'] = ($GPC['Recepcion']['peso_01l'] + $GPC['Recepcion']['peso_02l']) - ($GPC['Recepcion']['peso_01v'] + $GPC['Recepcion']['peso_02v']);
                $GPC['Recepcion']['peso_acon_liq'] = $GPC['Recepcion']['peso_acon'];
                $GPC['Recepcion']['estatus_rec'] = 1;
                $GPC['Recepcion']['id_asociacion'] = 4;
                $GPC['Recepcion']['id_asociado'] = 7;

                $recepcion->save($GPC['Recepcion']);
                $idRecepcion = $recepcion->id;
                $recepcion->id = null;
            }
            if(!empty($idRecepcion)){
                $recepcion->_commit_tool();
                $rec=  true;
            }
            
            system('echo '.str_repeat('-', 25).' >> log.txt');
            system('echo FIN RECEPCIONES >> log.txt');
            system('echo '.date('d-m-Y H:i:s').' >> log.txt');
            system('echo '.str_repeat('-', 50).' >> log.txt');
        }
        
        if(!empty($GPC['cant2'])){
            system('echo DESPACHOS >> log.txt');
            system('echo '.date('d-m-Y H:i:s').' >> log.txt');
            $cliente = new Cliente();
            $chofer = new Chofer();
            $vehiculo = new Vehiculo();
            $orden = new Orden();
            $despacho = new Despacho();
            $cultivo = 1;

            $despacho->_begin_tool();

            for($j=1; $j<=$GPC['cant2']; $j++){
                $GPC['Cliente']['id_org'] = $_SESSION['s_org_id'];
                $GPC['Cliente']['ced_rif'] = 'V'.rand(10000,30000);
                $GPC['Cliente']['nombre'] = "CLIENTE PRUEBA$j";
                $GPC['Cliente']['estatus'] = "t";
                $cliente->save($GPC['Cliente']);
                $idCliente = $cliente->id;
                $cliente->id = null;
                
                $GPC['Chofer']['ced_rif'] = $GPC['Cliente']['ced_rif'];
                $GPC['Chofer']['nombre'] = "CHOFER PRUEBA$j";
                $GPC['Chofer']['estatus'] = "t";
                $chofer->save($GPC['Chofer']);
                $idChofer = $chofer->id;
                $chofer->id = null;
                
                $GPC['Vehiculo']['placa'] = "QWEQWE$j";
                $GPC['Vehiculo']['marca'] = ($j % 2) ? "FORD" : "CHEVROLET";
                $GPC['Vehiculo']['color'] = "VERDE";
                $GPC['Vehiculo']['placa_remolques'] = "ASDASD$j";
                $vehiculo->save($GPC['Vehiculo']);
                $idVehiculo = $vehiculo->id;
                $vehiculo->id = null;
                
                $GPC['Orden']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $GPC['Orden']['id_cliente'] = 4;
                $resultado = $j % 26;
                if($resultado == 0) $cultivo = 1;
                $GPC['Orden']['id_cultivo'] = $cultivo;
                $GPC['Orden']['numero_orden'] = $j;
                $GPC['Orden']['fecha_emision'] = 'now()';
                $GPC['Orden']['cod_verificacion'] = ($j+100);
                $GPC['Orden']['estatus'] = 'N';

                $orden->save($GPC['Orden']);
                $idOrden = $orden->id;
                $orden->id = null;

                $GPC['Despacho']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $GPC['Despacho']['id_cultivo'] = $cultivo++;
                $GPC['Despacho']['id_orden'] = $idOrden;
                $GPC['Despacho']['id_cliente'] = $idCliente;
                $GPC['Despacho']['id_chofer'] = $idChofer;
                $GPC['Despacho']['id_vehiculo'] = $idVehiculo;
                $GPC['Despacho']['id_usuario'] = $_SESSION['s_id'];
                $GPC['Despacho']['id_transporte'] = 2;
                $GPC['Despacho']['id_punto_entrega'] = 4;
                $GPC['Despacho']['id_silo'] = '2';
                $GPC['Despacho']['numero'] = $j;
                $GPC['Despacho']['fecha_des'] = 'now()';

                $despacho->save($GPC['Despacho']);
                $idDespacho = $despacho->id;
                $despacho->id = null;
            }
            if(!empty($idDespacho)){
                $despacho->_commit_tool();
                $des = true;
            }
            system('echo '.str_repeat('-', 25).' >> log.txt');
            system('echo FIN DESPACHOS >> log.txt');
            system('echo '.date('d-m-Y H:i:s').' >> log.txt');
            system('echo '.str_repeat('-', 50).' >> log.txt');
        }
        
        if($rec && $des){
            header("location: prueba_estres.php?msg=exitoso");
            die();
        }elseif($rec){
            header("location: prueba_estres.php?msg=errorDes");
            die();
        }elseif($des){
            header("location: prueba_estres.php?msg=errorRec");
            die();
        }else{
            header("location: prueba_estres.php?msg=error");
            die();
        }
    }
    
    require('../lib/common/header.php');
?>
<div id="titulo_modulo">
    PRUEBA DE STRESS<br/><hr/>
</div>
<div id="mensajes">
    <?
        switch($GPC['msg']){
            case 'exitoso':
                echo "<span class='msj_verde'>Registro Guardado !</span>";
            break;
            case 'error':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !!!</span>";
            break;
            case 'errorDes':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema con Despacho !!!</span>";
            break;
            case 'errorRec':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema con Recepcion !!!</span>";
            break;
        }
    ?>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar">
    <table border="0" align="center">
        <tr>
            <td width="180">Cantidad de Recepciones</td>
            <td><? echo $html->input('cant', '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>
        </tr>
        <tr>
            <td>Cantidad de Despachos</td>
            <td><? echo $html->input('cant2', '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>
        </tr>
    </table>
    <table align="center" width="100%">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>