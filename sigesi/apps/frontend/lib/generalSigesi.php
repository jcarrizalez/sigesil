<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of generalSigesi
 *
 * @author jrodriguez
 */
class generalSigesi {
    function fechaCompleta(){
        $dia = date('n');
        switch($dia){
            case 1:
                $diaSemana = 'Lunes ';
            break;
            case 2:
                $diaSemana = 'Marter ';
            break;
            case 3:
                $diaSemana = 'Mi&eacute;rcoles ';
            break;
            case 4:
                $diaSemana = 'Jueves ';
            break;
            case 5:
                $diaSemana = 'Viernes ';
            break;
            case 6:
                $diaSemana = 'S&aacute;bado ';
            break;
            case 7:
                $diaSemana = 'Domingo ';
            break;
        }
        return $diaSemana." ".date('d-m-Y');
    }
}

?>
