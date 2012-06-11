<?
    $armarMenu = $menu->menuPorUsuario($_SESSION['s_id']);
?>
<div id="accordion">
    <?
        foreach($armarMenu as $menuP){
            if($menuP['id_padre'] == 0){
    ?>
    <div>
        <h3><a href="#"><?=$etiqueta[$menuP['nombre']]?></a></h3>
        <div>
            <ul id="lista_accordion">
                <?
                    foreach($armarMenu as $menuH){
                        if($menuH['id_padre'] == $menuP['id']){
                ?>
                <li><a href="<?=DOMAIN_ROOT.$menuH['url']?>"><?=$etiqueta[$menuH['nombre']]?></a></li>
                <?
                        }
                    }
                ?>
            </ul>
        </div>
    </div>
    <?
            }
        }
    ?>
</div>