<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'tipo':
            if(!empty($GPC['cul'])){
                if($GPC['cul'] == 1){
                    $analisis = new Analisis();
                    $infoAnalisis = $analisis->listaAnalisis('', '', '', '', 't', 't');
                    foreach($infoAnalisis as $valor){
                        $listaAnalisis[$valor['codigo']] = $valor['nombre'];
                    }
                    ?>
                    <tr>
                        <td width="110">An&aacute;lisis: </td>
                        <td><? echo $html->select('id_analisis', array('options' => $listaAnalisis, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
                    </tr>
                    <?
                }
            }
        break;
        case 'multiple':
            $formulas = new Formulas();
            $parametros->listaParametros(1, 6);
            $formulas->listaFormulas($idCA);
            ?>
            <legend>F&oacute;rmula <?=$GPC['nro']?></legend>
            <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <span class="msj_rojo">* </span>C&oacute;digo de la Formula: 
                        <? echo $html->input('codigo', '', array('type' => 'text', 'length' => '5', 'class' => 'cuadricula')); ?>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="padding: 15px 0; line-height: 30px;">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $html->input($parametro['parametro_llave'], $parametro['parametro_llave'], array('type' => 'button', 'class' => 'formula_campos constante'));
                        }
                        foreach($formulas->listaF as $formula){
                            echo $html->input($formula['codigo'], $formula['codigo'], array('type' => 'button', 'class' => 'formula_campos btnFormula', 'onClick' => "asignarFormula('".$formula['formula']."')"));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <? echo $html->input('formula_exp', $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula')); ?>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px 0;"><hr/></td>
                </tr>
                <tr>
                    <th>COMPROBAR F&Oacute;RMULA<br/><br/></th>
                </tr>
                <tr>
                    <td align="center">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $parametro['parametro_llave']."&nbsp;&nbsp;";
                            echo $html->input($parametro['parametro_llave'], '', array('type' => 'text', 'length' => '7', 'class' => 'cuadricula valores positive'));
                        }
                        foreach($formulas->listaF as $formula){
                            echo $formula['codigo']."&nbsp;&nbsp;";
                            echo $html->input($formula['codigo'], '', array('type' => 'text', 'class' => 'formula_campos btnFormula', 'onClick' => "asignarFormula('".$formula['formula']."')"));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <? echo $html->input('formula_eval', '', array('type' => 'text', 'readOnly' => true, 'class' => 'campo_formula')); ?>
                    </td>
                </tr>
                <tbody id="resultado"></tbody>
                <tr align="center">
                    <td style="padding-top: 20px;">
                        <? echo $html->input('Comprobar', 'Comprobar', array('type' => 'button')); ?>
                        <? echo $html->input('Recuperar', 'Corregir Valores', array('type' => 'button')); ?>
                    </td>
                </tr>
            </table>
            <?
        break;
        case 'formu':
            if(!empty($GPC['formula_eval'])){
                $evaluar = new Matematica();
                $evaluar->suppress_errors = true;
                if ($evaluar->evaluate('y(x) = ' . $GPC['formula_eval'])) {
                    echo "<tr><th class='msj_verde' align='center'><h3>El resultado es: " . number_format($evaluar->e("y(0)"), 3) . "</h3></th></tr>";
                } else {
                    echo "<tr><th class='error' align='center'><h3>No se puede evaluar la funci&oacute;n: " . $evaluar->last_error . "</h3></th></tr>";
                }
            }
        break;
    }
?>
