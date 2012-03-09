<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'tipo':
            if(!empty($GPC['cul'])){
                $analisis = new Analisis();
                $infoAnalisis = $analisis->listaAnalisis('', '', '', '', 't', 't');
                foreach($infoAnalisis as $valor){
                    $listaAnalisis[$valor['codigo']] = $valor['nombre'];
                }
                ?>
                <tr>
                    <td width="110">An&aacute;lisis: </td>
                    <td><? echo $html->select('Formula.id_analisis', array('options' => $listaAnalisis, 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?></td>
                </tr>
                <?
            }
        break;
        case 'campos':
            $tipo = $GPC['tipo'];
            $condicion = $GPC['cond'];
            if(!empty($tipo) && !empty($condicion)){
                if($tipo == 1 && $condicion == 2){
                    echo "Condici&oacute;n: ".$html->input("desde_1", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                    echo "<&nbsp;&nbsp;".$html->input("hasta_1", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                }elseif($tipo != 1 && ($condicion == 1 || $condicion == 2)){
                    echo "Condici&oacute;n: ".$html->input('otra_condicion_1', '', array('type' => 'text', 'class' => 'otra_con', 'style' => 'width: 100px')).":&nbsp;";
                    echo $html->input('desde_1', '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                    echo "<&nbsp;&nbsp;".$html->input('hasta_1', '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                    echo "Evaluada:&nbsp;&nbsp;".$html->input('condicion_eval', '', array('type' => 'text', 'readOnly' => 'readOnly', 'style' => 'width: 100px'));
                }
            }
        break;
        case 'multiple':
            $formulas = new Formulas();
            $parametros->listaParametros(1, 6);
            $formulas->listaFormulas($idCA);
            $nro = $GPC['nro'];
            ?>
            <legend>F&oacute;rmula <?=$nro?></legend>
            <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" style="padding: 10px 0;">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $html->input("btn_".$parametro['parametro_llave']."_$nro", $parametro['parametro_llave'], array('type' => 'button', 'class' => 'formula_campos constante'));
                        }
                        foreach($formulas->listaF as $formula){
                            echo $html->input("btn_".$formula['codigo']."_$nro", $formula['codigo'], array('type' => 'button', 'class' => 'formula_campos btnFormula', 'onClick' => "asignarFormula($nro, '".$formula['formula']."')"));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <?
                            if(!empty($GPC['tipo']) && $GPC['tipo'] == 2){
                                echo "Condici&oacute;n: ".$html->input('otra_condicion_'.$nro, '', array('type' => 'text', 'readOnly' => 'readOnly', 'class' => 'otra_con', 'style' => 'width: 100px')).":&nbsp;";
                                echo $html->input("desde_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo "<&nbsp;&nbsp;".$html->input("hasta_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo $html->input('formula_exp_'.$nro, $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp'));
                            }else{
                                echo "Condici&oacute;n: ".$html->input("desde_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo "<&nbsp;&nbsp;".$html->input("hasta_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                                echo $html->input('formula_exp_'.$nro, $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp'));
                            }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px 0;"><hr/></td>
                </tr>
                <tr>
                    <th>Comprobar F&oacute;rmula<br/><br/></th>
                </tr>
                <tr>
                    <td align="center" id="td_<?=$nro?>" style="padding: 10px 0;">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $parametro['parametro_llave']."&nbsp;&nbsp;";
                            echo $html->input($parametro['parametro_llave']."_$nro", '', array('type' => 'text', 'length' => '7', 'class' => 'cuadricula valores positive'));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <? echo $html->input('formula_eval_'.$nro, '', array('type' => 'text', 'readOnly' => true, 'class' => 'campo_formula')); ?>
                    </td>
                </tr>
                <tbody id="resultado_<?=$nro?>" class="verif_resul"></tbody>
                <tr align="center">
                    <td style="padding-top: 20px;">
                        <? echo $html->input('Comprobar_'.$nro, 'Comprobar', array('type' => 'button', 'class' => 'comprobar')); ?>
                    <? echo $html->input('Recuperar_'.$nro, 'Corregir Valores', array('type' => 'button', 'class' => 'recuperar')); ?>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                $('.otra_con').val($('#otra_condicion_1').val());
            </script>
            <?
        break;
        case 'formu':
            if(!empty($GPC['formula_eval'])){
                $evaluar = new LaMermelex();
                $evaluar->suppress_errors = true;
                if ($evaluar->evaluate('y(x) = ' . $GPC['formula_eval'])) {
                    $total = $evaluar->e("y(0)");
                    if($total < 0)
                        echo "<tr><th class='error' align='center'><h3>El resultado es: " . number_format($total, 3) . "</h3></th></tr>";
                    else
                        echo "<tr><th class='msj_verde' align='center'><h3>El resultado es: " . number_format($total, 3) . "</h3></th></tr>";
                } else {
                    echo "<tr><th class='error' align='center'><h3>No se puede evaluar la funci&oacute;n: " . $evaluar->last_error . "</h3></th></tr>";
                }
            }
        break;
    }
?>
