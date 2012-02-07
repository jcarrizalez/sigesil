        </div>
        </div>
        </div>
        <div id="pie_pagina">
            <div id="izq_pie_pagina"></div>
            <div id="pie_pagina_central"><br/>
                <span>
                    SIGESI<br/>
                    &copy; 2012 Todos los Derechos Reservados.<br/>
                    Desarrollado por Agropatria.
                </span>
            </div>
            <div id="der_pie_pagina"></div>
        </div>
    </body>
</html>
<?
    if(DEBUG) {
        Debug::$executeQueryPage = DOMAIN_ROOT.'admin/debug_execute_query.php';
        //Debug::showReport(array('hidden'=>true));
        include(APPROOT."lib/common/WebDebug.php");
    }
?>