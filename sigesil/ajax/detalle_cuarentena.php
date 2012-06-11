<?php
require_once('../lib/core.lib.php');
//$Ctna = new Cuarentena();
$Plagas = new Plaga();
$listaPlagas = $Plagas->find('', null, array('id', 'nombre'), 'list', 'id');
$idCA=(!empty($GPC['idCA'])) ? $GPC['idCA']: $_SESSION['s_ca_id'];
switch ($GPC['ac']){
    case 'nuevo':
        if (!empty($idCA) && !empty($GPC['idCtna']) && !empty($GPC['cantidad'])) {
            //$listaCP = $Ctna->listadoPlaga($idCA, $idCtna);
            for ($i=0; $i < $GPC['cantidad']; $i++) {
                $listaCP[$i]['id_cuarentena']=$GPC['idCtna'];
                $listaCP[$i]['cantidad']=0;
                $listaCP[$i]['id_plaga']="";
                $listaCP[$i]['nombre_plaga']="";                
            }            
            ?>
            <table border="0" align="center">
                <tr align="center" class="titulos_tabla">
                    <th>Insecto</th>
                    <th>Muestra</th>
                    <th>Valor</th>
                </tr>
                <?
                $i=0;                
                foreach($listaCP as $dataCP) {
                    $clase = $general->obtenerClaseFila($i); 
                ?>
                <tr class="<?=$clase?>">
                    <td>
                    <? 
                    if ($soloLectura)
                        echo $html->select('dataCP_id_'.$i, array('options' => $listaPlagas, 'selected' => $dataCP['id_plaga'], 'default' =>'Seleccione', 'readOnly' => true, 'class'=>'plaga')); 
                    else
                        echo $html->select('dataCP_id_'.$i, array('options' => $listaPlagas, 'selected' => $dataCP['id_plaga'], 'default' =>'Seleccione', 'class'=>'plaga')); 
                    ?>
                    </td>                    
                    <td>
                    <?
                    echo $html->select('esContable_'.$i, array('options' => array('C'=>'CONTABLE','I'=>'INCONTABLE'), 'selected' => (($dataCP['cantidad'] >= 0) ? 'C': 'I'), 'default' =>'Seleccione', 'readOnly' => $soloLectura,'class' => 'contable'));
                    ?>
                    </td>
                    <td>
                    <?                
                        if ($dataCP['cantidad'] >= 0)
                            echo $html->input('dataCP_cantidad_'.$i, $dataCP['cantidad'], array('type' => 'text', 'readOnly' => $soloLectura, 'class' => 'positive cuadricula cantidad'));
                    ?>
                    </td>
                </tr>
                <? 
                $i++;
                }
                ?>
                </table>
            <?php 
            }
            break;
}
?>
<script type="text/javascript">
    $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
</script>