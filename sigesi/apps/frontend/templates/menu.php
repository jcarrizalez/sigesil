<?
    $menuRegistro = array('Programa'=>'programa/index',
                            'Silos'=>'silos/index',
                            'Productor'=>'productor/index',
                            'Cultivo'=>'cultivo/index'
    );
    
    $menuProcesos = array('Recepción'=>'recepcion/index',
                            'Despacho'=>'despacho/index'
        
    );
    
    $menuReportes = array('Programas'=>'reporte_programas/index',
                            'Cosecha'=>'reporte_cosecha/index',
                            'Cultivos'=>'reporte_cultivos/index',
                            'Productores'=>'reporte_productores/index',
                            'Recepciones'=>'reporte_recepciones/index',
                            'Despacho'=>'reporte_despacho/index'
    );
    
    $menuPanelControl = array('Silos' => 'silos/index',
                                'Usuarios'=>'admin_usuarios/index',
                                'Formulas'=>'admin/formulacion/index',
                                'Configuración'=>'admin_configuracion_sistema/index'
        
    );
    
    $menuCuenta = array('Config. Cuenta'=>'cuenta/index',
                                'Salir'=>'salir/index'
        
    );
    
    /*$q = Doctrine_Query::create()->from('Nombre de mi tabla');
    $sql = $q->getSqlQuery();
    registras el sql donde quieras*/
?>
<div id="accordion">
    <div>
        <h3><a href="#">Maestro</a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($menuRegistro as $nombre => $url){ ?>
                <li><a href="<?=url_for($url)?>"><?=$nombre?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <div>
        <h3><a href="#">Procesos</a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($menuProcesos as $nombre => $url){ ?>
                    <li><a href="<?=url_for($url)?>"><?=$nombre?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <div>
        <h3><a href="#">Reportes</a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($menuReportes as $nombre => $url){ ?>
                    <li><a href="<?=url_for($url)?>"><?=$nombre?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <div>
        <h3><a href="#">Panel de Control</a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($menuPanelControl as $nombre => $url){ ?>
                    <li><a href="<?=url_for($url)?>"><?=$nombre?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <div>
        <h3><a href="#">Cuenta</a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($menuCuenta as $nombre => $url){ ?>
                    <li><a href="<?=url_for($url)?>"><?=$nombre?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
</div>