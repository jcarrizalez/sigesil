<?
$objMenu = new Menu();
$armarMenuP = $objMenu->menuPorUsuario($_SESSION['s_perfil_id'], $_SESSION['s_id'], 0);
?>
<div id="accordion">
    <?
        foreach($armarMenuP as $valorPadre){
            $armarMenuH = $objMenu->menuPorUsuario($_SESSION['s_perfil_id'], $_SESSION['s_id'], $valorPadre['id']);
    ?>
    <div>
        <h3><a href="#"><?=$etiqueta[$valorPadre['nombre']]?></a></h3>
        <div>
            <ul id="lista_accordion">
                <? foreach($armarMenuH as $valorHijo){ ?>
                <li><a href="<?=DOMAIN_ROOT.$valorHijo['url']?>"><?=$etiqueta[$valorHijo['nombre']]?></a></li>
                <? } ?>
            </ul>
        </div>
    </div>
    <? } ?>
</div>