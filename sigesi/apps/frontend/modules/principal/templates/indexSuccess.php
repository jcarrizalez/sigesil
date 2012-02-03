<?php
    $general = new generalSigesi();
?>
<div id="div_fecha">
    <span style="font-weight: bold;"><? echo $general->fechaCompleta(); ?></span>
    <div id="hora"></div>
</div>
<span style="text-align: center">
    <h1>Bienvenido al <span style="color: #73B65A;">SIGESI<br/>SISTEMA DE GESTIÓN DE SILOS</span></h1>
</span>
<table id="titulos_tabla">
    <tr>
        <th>Usuario: </th>
        <td style="text-transform: uppercase">jpeluzo</td>
    </tr>
    <tr>
        <th>Nombres y Apellidos: </th>
        <td>José M. Peluzzo</td>
    </tr>
    <tr>
        <th>Perfil: </th>
        <td>Administrador</td>
    </tr>
</table>
<script type="text/javascript">
    $(document).ready(function(){
        hora_sistema("<?= date('d m Y h:i:s'); ?>");
    });
</script>