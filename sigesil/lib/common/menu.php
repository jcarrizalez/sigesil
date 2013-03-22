<?php
    $armarMenu = $menu->menuPorUsuario($_SESSION['s_id']);
?>
<div id="accordion">
    <?php
        foreach($armarMenu as $menuP){
            if($menuP['id_padre'] == 0){
    ?>
    <div>
        <h3><a href="#"><?php echo $etiqueta[$menuP['nombre']]?></a></h3>
        <div>
            <ul id="lista_accordion">
                <?php
                    foreach($armarMenu as $menuH){
                        if($menuH['id_padre'] == $menuP['id']){
                ?>
                <li><a href="<?php echo DOMAIN_ROOT.$menuH['url']?>"><?php echo $etiqueta[$menuH['nombre']]?></a></li>
                <?php
                        }
                    }
                ?>
            </ul>
        </div>
    </div>
    <?php
            }
        }
    ?>
</div>