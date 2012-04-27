                </div>
            </div>
            <div id="pie_pagina"><hr/>
                    <span>
                        <?=$etiqueta['txtPiePagina']?>
                    </span>
            </div>
        </div>
        </div>
<script language="javascript">
    hide_div_loader();
</script>
<?
    if(DEBUG) {
        Debug::$executeQueryPage = DOMAIN_ROOT.'admin/debug_execute_query.php';
        //Debug::showReport(array('hidden'=>true));
        include(APPROOT."lib/common/WebDebug.php");
    }
?>
    </body>
</html>