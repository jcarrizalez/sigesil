        </div>
        </div>
        </div>
        <div id="pie_pagina"><hr/>
                <span>
                    Sistema de Gesti&oacute;n de Silos - <?=SYSTEM_NAME?><br/>
                    &copy; 2012 Todos los Derechos Reservados.<br/><br/>
                </span>
        </div>
    </body>
</html>
<!--
PIE DE PAGINA ANTERIOR
        </div>
        </div>
        </div>
        <div id="pie_pagina">
            <div id="izq_pie_pagina"></div>
            <div id="pie_pagina_central">
                <span>
                    SIGESI<br/>
                    &copy; 2012 Todos los Derechos Reservados.<br/>
                </span>
            <img alt="Inicio" title="Inicio" src="../images/logo_agropatria.png" width="70" height="20"/>
            </div>
            <div id="der_pie_pagina"></div>
        </div>
    </body>
</html>
-->
<?
    if(DEBUG) {
        Debug::$executeQueryPage = DOMAIN_ROOT.'admin/debug_execute_query.php';
        //Debug::showReport(array('hidden'=>true));
        include(APPROOT."lib/common/WebDebug.php");
    }
?>