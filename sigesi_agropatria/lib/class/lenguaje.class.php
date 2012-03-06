<?php

class Lenguaje extends Model {

    /*function __construct() {
        //Find all the available languages
        //$this->languagesList = $this->find(array(),null,array('short_name', 'name'),'list','default1 DESC');
        $this->languagesList = $this->find(array('active' => 1), null, array('short_name', 'name'), 'list', 'default1 DESC');
        //Get the first one by default
        $first = each($this->languagesList);
        //Set the first one by default
        $this->setLanguage($first['key']);
    }*/

    function etiquetasPorPagina($nombrePagina, $fullPath = true) {
        $pagina = $nombrePagina;
        if ($fullPath) {
            $pagina = substr($_SERVER["SCRIPT_NAME"], strrpos($_SERVER["SCRIPT_NAME"], "/") + 1); //review REMOVE SCRIPT_NAME
        }
        $query = "SELECT etiqueta.nombre, etiqueta.valor AS traduccion
                    FROM si_recursos recurso 
                    RIGHT JOIN si_recursos_etiquetas etiqueta ON etiqueta.id_recurso = recurso.id
                    WHERE (recurso.nombre_archivo = '" . $pagina . "' OR  etiqueta.global = 1)";

        // echo $query;
        $resultQuery = $this->_SQL_tool($this->SELECT, __METHOD__, $query);

        $result = array();
        foreach ($resultQuery as $row) {
            $result[$row['nombre']] = htmlspecialchars_decode(htmlentities($row['traduccion']));
        }

        return $result;
    }

    /*function setLanguage($languageShortName) {
        //If the language exist, then set it's attributes
        if (isset($this->languagesList[$languageShortName])) {
            $this->lang = $this->languajes[$languageShortName];
        } else {
            $this->lang = $this->languajes['es'];
        }

        $_SESSION['lng'] = ($this->lang['code']) ? $this->lang['code'] : 'es';
        $_SESSION['lng_id'] = ($this->lang['id']) ? $this->lang['id'] : 2;
        $_SESSION['lng_name'] = ($this->lang['name']) ? $this->lang['name'] : 'espa&ntilde;ol';
        if ($_SESSION['s_languaje_id']) {
            $_SESSION['s_languaje_id'] = $_SESSION['lng_id'];
        }
        $this->currentLanguageName = $_SESSION['lng_name'];
        $this->lenguajeActualCorto = $_SESSION['lng'];
        $this->currentLanguageId = $_SESSION['lng_id'];

        //If doesn't exist then leave the default values
    }

    function getLanguagesShort($short_name = null, $id = null) {
        $arrayList = array();
        $query = "SELECT * FROM languages WHERE 1=1";
        if (!is_null($short_name)) {
            $query.=" AND short_name='$short_name'";
        }
        if (!is_null($id)) {
            $query.=" AND id='$id'";
        }
        $result = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
        if ($result) {

            return $result;
        } else
            return false;
    }

    function getLanguage($id_lang = null, $campos = array()) {
        $query = "SELECT * FROM languages WHERE 1 ";
        if ($id_lang) {
            $query.=" AND id='$id_lang' ";
        }
        foreach ($campos as $campo => $valor) {
            $query .= " AND $campo='$valor' ";
        }
        //die($query)
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    function cambia_a_etiqueta($texto) {
        $blancos = array(" ", "\t", "\n", "\r", "\0", "\x0B");
        $nuevo_texto = strip_tags(html_entity_decode(trim($texto)));
        $nuevo_texto = preg_replace('#[^\\pL\d]+#u', ' ', $nuevo_texto);
        $nuevo_texto = preg_replace('#[^-\w]+#', '', ucwords($nuevo_texto));
        $nuevo_texto = 'txt' . $nuevo_texto;
        return $nuevo_texto;
    }

    function getLabelsOfCurrentPage($pageName, $fullPath = true) {
        $page = $pageName;
        if ($fullPath) {
            $page = substr($_SERVER["SCRIPT_NAME"], strrpos($_SERVER["SCRIPT_NAME"], "/") + 1); //review REMOVE SCRIPT_NAME
        }
        $query = "SELECT  ResourceLabel.name as resourceLabel_name,ResourceLabelValue.value  as resourceLabelValue_value
                    FROM resources Resource
                    RIGHT JOIN resource_labels ResourceLabel
                    ON ResourceLabel.resource_id = Resource.id
                    INNER JOIN resource_label_values ResourceLabelValue
                    ON ResourceLabelValue.resource_label_id = ResourceLabel.id
                    INNER  JOIN languages Language
                    ON Language.id = ResourceLabelValue.language_id
                    WHERE (Resource.file_name='" . $page . "')
                    AND Language.short_name='" . $this->lenguajeActualCorto . "';";

        // echo $query;
        $resultQuery = $this->_SQL_tool($this->SELECT, __METHOD__, $query);

        $result = array();
        foreach ($resultQuery as $row) {
            $result[$row['resourceLabel_name']] = htmlspecialchars_decode(htmlentities($row['resourceLabelValue_value']));
        }

        return $result;
    }*/

}

?>