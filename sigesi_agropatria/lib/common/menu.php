<?
/*$menu = array();

    switch ($_SESSION['s_perfil_id']){
        case GERENTEG:
            $menu['Maestro'] = array('Centros de Acopio' => DOMAIN_ROOT . 'admin/centros_acopio_listado.php',
                                    'Cultivo' => DOMAIN_ROOT . 'admin/cultivo_listado.php',
                                    //'Tipos de Cultivo' => DOMAIN_ROOT . 'admin/tipo_cultivo_listado.php',
                                    'Programa' => DOMAIN_ROOT . 'admin/programa_listado.php',
                                    'Silos' => DOMAIN_ROOT.'admin/silos_listado.php',
                                    'Productor' => DOMAIN_ROOT.'admin/productor_listado.php'
            );

            $menu['Reportes'] = array('Programas' => 'reporte_programas/index',
                                    'Cosecha' => 'reporte_cosecha/index',
                                    'Cultivos' => 'reporte_cultivos/index',
                                    'Productores' => 'reporte_productores/index',
                                    'Recepciones' => 'reporte_recepciones/index',
                                    'Despacho' => 'reporte_despacho/index'
            );

            $menu['Panel de Control'] = array('Silos' => 'silos/index',
                                        'Usuarios' => 'admin_usuarios/index',
                                        'Formulas' => 'admin/formulacion/index',
                                        'Configuración' => 'admin_configuracion_sistema/index'
            );

            $menu['Cuenta'] = array('Config. Cuenta' => DOMAIN_ROOT.'admin/cuenta.php',
                                'Salir' => DOMAIN_ROOT . 'pages/cerrar_sesion.php'
            );
        break;
        case GERENTES:
            $menu['Maestro'] = array('Programa' => DOMAIN_ROOT . 'admin/programa_listado.php',
                                    'Silos' => DOMAIN_ROOT.'admin/silos_listado.php',
                                    'Productor' => DOMAIN_ROOT.'admin/productor_listado.php'
            );

            $menu['Procesos'] = array('Recepción' => 'recepcion/index',
                                    'Despacho' => 'despacho/index'
            );

            $menu['Reportes'] = array('Programas' => 'reporte_programas/index',
                                    'Cosecha' => 'reporte_cosecha/index',
                                    'Cultivos' => 'reporte_cultivos/index',
                                    'Productores' => 'reporte_productores/index',
                                    'Recepciones' => 'reporte_recepciones/index',
                                    'Despacho' => 'reporte_despacho/index'
            );

            $menu['Panel de Control'] = array('Silos' => 'silos/index',
                                        'Usuarios' => 'admin_usuarios/index',
                                        'Formulas' => 'admin/formulacion/index',
                                        'Configuración' => 'admin_configuracion_sistema/index'
            );

            $menu['Cuenta'] = array('Config. Cuenta' => DOMAIN_ROOT.'admin/cuenta.php',
                                'Salir' => DOMAIN_ROOT . 'pages/cerrar_sesion.php'
            );
        break;
    }
*/
$objMenu = new Menu();
$armarMenuP = $objMenu->menuPorUsuario($_SESSION['s_id']);
?>
<div id="accordion">
    <?
        foreach($armarMenuP as $valorPadre){
            $armarMenuH = $objMenu->menuPorUsuario($_SESSION['s_id'], $valorPadre['id']);
    ?>
    <div>
        <h3><a href="#"><?=$valorPadre['nombre']?></a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($armarMenuH as $valorHijo){ ?>
                <li><a href="<?=DOMAIN_ROOT.$valorHijo['url']?>"><?=$valorHijo['nombre']?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <? } ?>
</div>