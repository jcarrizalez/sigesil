<?php
    require_once("../lib/core.lib.php");
    include("../lib/class/mpdf/mpdf.php");

    /*echo $_SESSION["s_org_nombre"]." - SILOS ".$_SESSION["s_ca_nombre"];
    echo $general->caracter(80,'&nbsp;');
    echo " Fecha: ".date("d/m/Y")."<br/>";
    echo "Hora: ".date("h:i a");*/
    $cadena = '<html><body><table border="0" width="800px"><tr><td width="500px">AGROPATRIA - SILOS - CHAGUARAMAS</td>';
    $cadena .= '<td align="right">Fecha: '.date("d/m/Y").'</td></tr><tr><td colspan="2" align="right">Hora: '.date("h:i a").'</td>';
    $cadena .= '</tr><tr><td colspan="2" align="center">CONSTANCIA DE '.$proceso = ($GPC['mov'] == 'rec') ? "RECEPCION" : "DESPACHO".'</td>';
    $cadena .= '</tr></table></body></html>';
    
    $mpdf=new mPDF();
    $mpdf->WriteHTML($cadena);
    $mpdf->Output('prueba.pdf');
    //exit;
    
    //specify the pdf you'd like to print
    $file = 'prueba.pdf';
    //Change PrinterName to the name of the printer you set up in CUPS
    $cmd = "lpr -P HP-LaserJet-p1606dn ";
    //append any files you'd like to print to the end of the command
    $cmd .= $file;
    //Runs "lpr -PPrinterName  /var/www/data/myfile.pdf" and brings back any output to the console.
    $response = shell_exec($cmd);
?>