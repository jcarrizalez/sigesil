<?php
    require_once('../lib/core.lib.php');
    $contrato = new Contrato();
    $listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    
    switch ($GPC['ac']){
        case 'validar':
            $productor = new Productor();
            $infoProductor = $productor->find(array('ced_rif' => $GPC['cpro']));
            if(!empty($infoProductor)){
                $infoContrato = $contrato->buscarContrato(null, $_SESION['s_ca_id'], $GPC['co'], '', $GPC['cpro']);
                if(!empty($infoContrato)){
                    echo "&nbsp;".$html->select('nacionalidad',array('options'=>$listaNacion));
                    echo "&nbsp;".$html->input('productor', '', array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width:152px'));
                    ?>
                    <script type="text/javascript">
                        $(document).ready(function(){
                            alert('Este Productor ya posee un contrato para esta Cosecha');
                        });
                    </script>
                    <?
                }else{
                    echo "&nbsp;".$html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoProductor[0]['ced_rif']), 0, 1)));
                    echo "&nbsp;".$html->input('productor', substr(trim($infoProductor[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width:152px'));
                    echo "<br/>&nbsp;".$html->input('nombre_pro', $infoProductor[0]['nombre'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos', 'style' => 'width:152'));
                    echo "&nbsp;".$html->input('Contrato.id_productor', $infoProductor[0]['id'], array('type' => 'hidden'));
                }
            }else{
                echo "&nbsp;".$html->select('nacionalidad',array('options'=>$listaNacion));
                echo "&nbsp;".$html->input('productor', '', array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width:152px'));
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        alert('Cedula/Rif No Encontrado');
                    });
                </script>
                <?
            }
        break;
        case 'buscar':
            $dataContrato = $contrato->find(array('nro_contrato' => $GPC['nro']));
            if(!empty($dataContrato)){
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        alert('El Nro de Contrato ya existe');
                    });
                </script>
                <?
            }else{
                echo $html->input('Contrato.nro_contrato', $GPC['nro'], array('type' => 'text', 'class' => 'estilo_campos'));
            }
        break;
        case 'recepcion':
            $infoContrato = $contrato->buscarContrato(null, $_SESION['s_ca_id'], $GPC['co'], '', $GPC['cp']);
            if(!empty($infoContrato))
                echo $html->input('Guia.contrato', $infoContrato[0]['nro_contrato'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
            else
                echo $html->input('Guia.contrato', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
        break;
    }
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>