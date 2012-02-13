--
-- PostgreSQL database dump
--

-- Started on 2012-02-13 16:35:03 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 20104)
-- Dependencies: 6
-- Name: si_almacenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_almacenes (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion character varying(255),
    id_pais smallint NOT NULL,
    id_estado smallint NOT NULL,
    id_municipio bigint NOT NULL,
    telefono character varying(32),
    fax character varying(255),
    email character varying(255),
    estatus boolean NOT NULL,
    coordenadas_utm character varying(255),
    creado timestamp without time zone,
    modificado timestamp without time zone,
    id_tipo_almacen bigint NOT NULL
);


ALTER TABLE public.si_almacenes OWNER TO admin;

--
-- TOC entry 141 (class 1259 OID 20110)
-- Dependencies: 6 140
-- Name: si_almacenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_almacenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_almacenes_id_seq OWNER TO admin;

--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 141
-- Name: si_almacenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_almacenes_id_seq OWNED BY si_almacenes.id;


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 141
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 6, true);


--
-- TOC entry 142 (class 1259 OID 20112)
-- Dependencies: 1922 1923 6
-- Name: si_analisis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis (
    id bigint NOT NULL,
    descrip character varying(255),
    max integer DEFAULT 0 NOT NULL,
    min integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_analisis OWNER TO admin;

--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'Tabla de los Análisis para los Cultivos';


--
-- TOC entry 143 (class 1259 OID 20117)
-- Dependencies: 6
-- Name: si_analisis_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_centro_acopio (
    analisis_id bigint NOT NULL,
    centro_acopio_id bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_centro_acopio OWNER TO admin;

--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 143
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla puente entre Analisis y Centros de Acopio';


--
-- TOC entry 144 (class 1259 OID 20120)
-- Dependencies: 1924 6
-- Name: si_analisis_resultado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_resultado (
    movimiento_id bigint NOT NULL,
    analisis_id bigint NOT NULL,
    observacion character varying(255),
    valor real DEFAULT 0.0 NOT NULL,
    usuario_id bigint NOT NULL,
    id_analsis_resultado bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 145 (class 1259 OID 20124)
-- Dependencies: 6
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_app_error_apperror_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_app_error_apperror_id_seq OWNER TO admin;

--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_app_error_apperror_id_seq', 1, false);


--
-- TOC entry 146 (class 1259 OID 20126)
-- Dependencies: 1925 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id bigint DEFAULT nextval('si_app_error_apperror_id_seq'::regclass) NOT NULL,
    apperror_time date NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 147 (class 1259 OID 20133)
-- Dependencies: 6
-- Name: si_cargo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo (
    id integer NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_cargo_tipo bigint NOT NULL,
    creado timestamp without time zone NOT NULL,
    modificado timestamp without time zone NOT NULL
);


ALTER TABLE public.si_cargo OWNER TO admin;

--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 147
-- Name: TABLE si_cargo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cargo IS 'Tabla de Cargos';


--
-- TOC entry 148 (class 1259 OID 20136)
-- Dependencies: 1926 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE si_cargo_tipo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cargo_tipo IS 'Tablas de Cargo Tipo';


--
-- TOC entry 149 (class 1259 OID 20140)
-- Dependencies: 1927 1928 1929 1930 1931 1932 6
-- Name: si_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_centro_acopio (
    id bigint NOT NULL,
    id_org bigint,
    codigo character varying(5) NOT NULL,
    nombre character varying(255) NOT NULL,
    rif character varying(16) DEFAULT NULL::character varying,
    telefono character varying(32) DEFAULT NULL::character varying,
    fax character varying(32) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    direccion character varying(255) DEFAULT NULL::character varying,
    id_pais smallint,
    id_estado smallint,
    id_municipio smallint,
    id_codigo_postal smallint,
    coordenadas_utm character varying(32) DEFAULT NULL::character varying,
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_centro_acopio OWNER TO admin;

--
-- TOC entry 150 (class 1259 OID 20152)
-- Dependencies: 149 6
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_centro_acopio_id_seq OWNER TO admin;

--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 150
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_centro_acopio_id_seq OWNED BY si_centro_acopio.id;


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 150
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 6, true);


--
-- TOC entry 151 (class 1259 OID 20154)
-- Dependencies: 6
-- Name: si_cliente; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cliente (
    id bigint NOT NULL,
    rif character(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    telefono character varying(32) NOT NULL,
    email character varying(255) NOT NULL,
    ubicacion character varying(255) NOT NULL
);


ALTER TABLE public.si_cliente OWNER TO admin;

--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 151
-- Name: TABLE si_cliente; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cliente IS 'Tabla de Clientes';


--
-- TOC entry 152 (class 1259 OID 20160)
-- Dependencies: 6
-- Name: si_cosecha_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_id_seq OWNER TO admin;

--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 152
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 1, false);


--
-- TOC entry 153 (class 1259 OID 20162)
-- Dependencies: 1934 1935 1936 1937 6
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint DEFAULT nextval('si_cosecha_id_seq'::regclass) NOT NULL,
    id_programa bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    proyectado real DEFAULT 0.0,
    observacion character varying(255) DEFAULT NULL::character varying,
    fecha_inicio date,
    fecha_fin date,
    estado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.si_cosecha OWNER TO admin;

--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 153
-- Name: COLUMN si_cosecha.estado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_cosecha.estado IS 'False = Abierto
True = Cerrado';


--
-- TOC entry 154 (class 1259 OID 20172)
-- Dependencies: 6
-- Name: si_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cultivo_id_seq OWNER TO admin;

--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 154
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 7, true);


--
-- TOC entry 155 (class 1259 OID 20174)
-- Dependencies: 1938 1939 6
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint DEFAULT nextval('si_cultivo_id_seq'::regclass) NOT NULL,
    id_tipo_cultivo bigint DEFAULT 0 NOT NULL,
    nombre character varying(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 156 (class 1259 OID 20179)
-- Dependencies: 6
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 0
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 4, true);


--
-- TOC entry 157 (class 1259 OID 20181)
-- Dependencies: 1940 6
-- Name: si_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo_tipo (
    id bigint DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo_tipo OWNER TO admin;

--
-- TOC entry 158 (class 1259 OID 20185)
-- Dependencies: 1941 6
-- Name: si_ejes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ejes (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    capacidad integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_ejes OWNER TO admin;

--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 158
-- Name: TABLE si_ejes; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_ejes IS 'Tabla para el Control de Ejes en Calculo de Toneladas para despacho';


--
-- TOC entry 159 (class 1259 OID 20189)
-- Dependencies: 6 158
-- Name: si_ejes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ejes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_ejes_id_seq OWNER TO admin;

--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_ejes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ejes_id_seq OWNED BY si_ejes.id;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 160 (class 1259 OID 20191)
-- Dependencies: 6
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_codigos_log_codigo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_log_codigos_log_codigo_id_seq OWNER TO admin;

--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 160
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 161 (class 1259 OID 20193)
-- Dependencies: 1943 6
-- Name: si_log_codigos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_log_codigos (
    log_codigo_id bigint DEFAULT nextval('si_log_codigos_log_codigo_id_seq'::regclass) NOT NULL,
    log_codigo_nombre_es character varying(255) NOT NULL,
    log_codigo_critico smallint NOT NULL,
    log_codigo_tipo character varying(45) NOT NULL
);


ALTER TABLE public.si_log_codigos OWNER TO admin;

--
-- TOC entry 162 (class 1259 OID 20197)
-- Dependencies: 6
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_consultas_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_log_consultas_log_id_seq OWNER TO admin;

--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 225, true);


--
-- TOC entry 163 (class 1259 OID 20199)
-- Dependencies: 1944 6
-- Name: si_log_consultas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_log_consultas (
    log_id bigint DEFAULT nextval('si_log_consultas_log_id_seq'::regclass) NOT NULL,
    en_fecha date,
    log_codigo_id bigint,
    usuario_id bigint,
    usuario_info character varying(255),
    usuario_email character varying(255),
    usuario_compania character varying(255),
    session_id character varying(255),
    direccion_ip character varying(100),
    navegador text,
    en_tablas character varying(255),
    data_vieja text,
    data_nueva text,
    sentencia_sql text,
    comentario character varying(255)
);


ALTER TABLE public.si_log_consultas OWNER TO admin;

--
-- TOC entry 164 (class 1259 OID 20206)
-- Dependencies: 6
-- Name: si_menu; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu (
    id bigint NOT NULL,
    nombre character varying(32) NOT NULL,
    id_padre bigint NOT NULL,
    url character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_menu OWNER TO admin;

--
-- TOC entry 165 (class 1259 OID 20209)
-- Dependencies: 164 6
-- Name: si_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_menu_id_seq OWNER TO admin;

--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 165
-- Name: si_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_id_seq OWNED BY si_menu.id;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 165
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 24, true);


--
-- TOC entry 166 (class 1259 OID 20211)
-- Dependencies: 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 167 (class 1259 OID 20214)
-- Dependencies: 1946 1947 1948 1949 1950 1951 6
-- Name: si_movimiento; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_movimiento (
    silo_id bigint NOT NULL,
    cosecha_id bigint NOT NULL,
    numero integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    cantidad_muestra real DEFAULT 0.0 NOT NULL,
    peso_bruto real DEFAULT 0.0 NOT NULL,
    placa_vehiculo date NOT NULL,
    cedula_conductor character(16) NOT NULL,
    descuento_humedad real DEFAULT 0.0 NOT NULL,
    descuento_impuresas real DEFAULT 0.0 NOT NULL,
    sada_id character(32) NOT NULL,
    observacion character varying(255) NOT NULL,
    sap_id character(32),
    peso_vacio real DEFAULT 0.0 NOT NULL,
    estado_id integer NOT NULL,
    nombre character varying(255),
    id bigint NOT NULL,
    programa_id bigint,
    contrato character(32) NOT NULL,
    tipo_proceso boolean DEFAULT true NOT NULL
);


ALTER TABLE public.si_movimiento OWNER TO admin;

--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE si_movimiento; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_movimiento IS 'Tabla de Movimiento de Recepción y Despacho, el campo tipo_proceso si es valor (true) es recepcion y (false) es despacho
';


--
-- TOC entry 168 (class 1259 OID 20226)
-- Dependencies: 6
-- Name: si_organizacion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_organizacion (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(255),
    rif character varying(16),
    telefono character varying(32),
    email character varying(255),
    direccion character varying(255),
    fax character varying(32),
    id_pais smallint NOT NULL,
    id_estado smallint NOT NULL,
    id_municipio smallint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean
);


ALTER TABLE public.si_organizacion OWNER TO admin;

--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 168
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 169 (class 1259 OID 20232)
-- Dependencies: 168 6
-- Name: si_organizacion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_organizacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_organizacion_id_seq OWNER TO admin;

--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_organizacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_organizacion_id_seq OWNED BY si_organizacion.id;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 170 (class 1259 OID 20234)
-- Dependencies: 6
-- Name: si_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_parametros_id_seq OWNER TO admin;

--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 3, true);


--
-- TOC entry 171 (class 1259 OID 20236)
-- Dependencies: 1953 6
-- Name: si_parametros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_parametros (
    id bigint DEFAULT nextval('si_parametros_id_seq'::regclass) NOT NULL,
    parametro_llave character varying(255) NOT NULL,
    parametro_valor character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    parametro_mostrar smallint NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_parametros OWNER TO admin;

--
-- TOC entry 172 (class 1259 OID 20243)
-- Dependencies: 6
-- Name: si_perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_perfiles_id_seq OWNER TO admin;

--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 173 (class 1259 OID 20245)
-- Dependencies: 1954 6
-- Name: si_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_perfiles (
    id bigint DEFAULT nextval('si_perfiles_id_seq'::regclass) NOT NULL,
    nombre_perfil character varying(255) NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_perfiles OWNER TO admin;

--
-- TOC entry 174 (class 1259 OID 20249)
-- Dependencies: 6
-- Name: si_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_productor (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    rif character varying(16) NOT NULL,
    telefono character varying(32),
    email character varying(255) NOT NULL,
    direccion character varying(255),
    sap_id character(32),
    centro_acopio_id bigint NOT NULL
);


ALTER TABLE public.si_productor OWNER TO admin;

--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE si_productor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_productor IS 'Tabla de Productores';


--
-- TOC entry 175 (class 1259 OID 20255)
-- Dependencies: 6
-- Name: si_programa_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_programa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_programa_id_seq OWNER TO admin;

--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 1, false);


--
-- TOC entry 176 (class 1259 OID 20257)
-- Dependencies: 1955 6
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint DEFAULT nextval('si_programa_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero integer,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 177 (class 1259 OID 20264)
-- Dependencies: 6
-- Name: si_proveedor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_proveedor (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    telefono character varying(32) NOT NULL,
    email character varying(255) NOT NULL,
    ubicacion character varying(255) NOT NULL
);


ALTER TABLE public.si_proveedor OWNER TO admin;

--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 178 (class 1259 OID 20270)
-- Dependencies: 1956 1957 1959 6
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_almacen bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    coordenada character varying(255),
    numero integer DEFAULT 0 NOT NULL,
    capacidad integer DEFAULT 0,
    observacion character varying(255),
    estatus character(1) DEFAULT 1 NOT NULL,
    modulo character(2),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_silos OWNER TO admin;

--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 179 (class 1259 OID 20278)
-- Dependencies: 6 178
-- Name: si_silos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_silos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_silos_id_seq OWNER TO admin;

--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_silos_id_seq OWNED BY si_silos.id;


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 72, true);


--
-- TOC entry 180 (class 1259 OID 20280)
-- Dependencies: 1961 6
-- Name: si_usuarios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL,
    cedula character varying(255) NOT NULL,
    fecha_nacimiento date,
    sexo character varying(2) NOT NULL,
    usuario character(32) NOT NULL,
    contrasena character varying(255) NOT NULL,
    direccion character varying(255),
    telefono character varying(32),
    email character varying(255),
    creado date,
    modificado date,
    estatus boolean DEFAULT true NOT NULL
);


ALTER TABLE public.si_usuarios OWNER TO admin;

--
-- TOC entry 181 (class 1259 OID 20286)
-- Dependencies: 180 6
-- Name: si_usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_usuarios_id_seq OWNER TO admin;

--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 181
-- Name: si_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_id_seq OWNED BY si_usuarios.id;


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 181
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 182 (class 1259 OID 20288)
-- Dependencies: 6
-- Name: si_usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios_perfiles (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_perfil bigint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_usuarios_perfiles OWNER TO admin;

--
-- TOC entry 183 (class 1259 OID 20291)
-- Dependencies: 6 182
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_usuarios_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_usuarios_perfiles_id_seq OWNER TO admin;

--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_perfiles_id_seq OWNED BY si_usuarios_perfiles.id;


--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 1921 (class 2604 OID 20293)
-- Dependencies: 141 140
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_almacenes ALTER COLUMN id SET DEFAULT nextval('si_almacenes_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 20294)
-- Dependencies: 150 149
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_centro_acopio_id_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 20295)
-- Dependencies: 159 158
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_ejes ALTER COLUMN id SET DEFAULT nextval('si_ejes_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 20296)
-- Dependencies: 165 164
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu ALTER COLUMN id SET DEFAULT nextval('si_menu_id_seq'::regclass);


--
-- TOC entry 1952 (class 2604 OID 20297)
-- Dependencies: 169 168
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_organizacion ALTER COLUMN id SET DEFAULT nextval('si_organizacion_id_seq'::regclass);


--
-- TOC entry 1958 (class 2604 OID 20298)
-- Dependencies: 179 178
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_silos ALTER COLUMN id SET DEFAULT nextval('si_silos_id_seq'::regclass);


--
-- TOC entry 1960 (class 2604 OID 20299)
-- Dependencies: 181 180
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios ALTER COLUMN id SET DEFAULT nextval('si_usuarios_id_seq'::regclass);


--
-- TOC entry 1962 (class 2604 OID 20300)
-- Dependencies: 183 182
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios_perfiles ALTER COLUMN id SET DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass);


--
-- TOC entry 2029 (class 0 OID 20104)
-- Dependencies: 140
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen) FROM stdin;
1	1	Todos	\N	1	1	1	\N	\N	\N	t	\N	\N	\N	1
3	3	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:05:32.030751	\N	1
4	4	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:06:27.331621	\N	1
5	5	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:12:33.325252	\N	1
6	6	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:25:07.74788	\N	1
2	2	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:01:40.114191	\N	1
\.


--
-- TOC entry 2030 (class 0 OID 20112)
-- Dependencies: 142
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis (id, descrip, max, min) FROM stdin;
\.


--
-- TOC entry 2031 (class 0 OID 20117)
-- Dependencies: 143
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_centro_acopio (analisis_id, centro_acopio_id, id) FROM stdin;
\.


--
-- TOC entry 2032 (class 0 OID 20120)
-- Dependencies: 144
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_resultado (movimiento_id, analisis_id, observacion, valor, usuario_id, id_analsis_resultado, id) FROM stdin;
\.


--
-- TOC entry 2033 (class 0 OID 20126)
-- Dependencies: 146
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 2034 (class 0 OID 20133)
-- Dependencies: 147
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo (id, id_centro_acopio, id_almacen, id_usuario, id_cargo_tipo, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2035 (class 0 OID 20136)
-- Dependencies: 148
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo_tipo (id, nombre, nivel) FROM stdin;
\.


--
-- TOC entry 2036 (class 0 OID 20140)
-- Dependencies: 149
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) FROM stdin;
1	0	00	Agropatria	\N	\N	\N	\N	\N	1	1	1	\N	\N	t	2012-02-12 00:00:00-04:30	\N
3	1	57	Sabana de Parra	J-123123	\N	\N	\N	Algun Lugar	1	1	1	\N	\N	t	2012-02-13 11:05:32.010896-04:30	\N
4	1	58	Chaguaramas	J-123123	\N	\N	\N	Chaguaramas	1	1	1	\N	\N	t	2012-02-13 11:06:27.30781-04:30	\N
6	1	63	Zaraza	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:25:07.723533-04:30	\N
5	1	60	Sabaneta	J-123123	\N	\N	\N	Zulia	1	2	2	\N	\N	t	2012-02-13 11:12:33.305226-04:30	\N
2	1	56	Araure	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:01:40.092295-04:30	\N
\.


--
-- TOC entry 2037 (class 0 OID 20154)
-- Dependencies: 151
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cliente (id, rif, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2038 (class 0 OID 20162)
-- Dependencies: 153
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, nombre, proyectado, observacion, fecha_inicio, fecha_fin, estado) FROM stdin;
\.


--
-- TOC entry 2039 (class 0 OID 20174)
-- Dependencies: 155
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_tipo_cultivo, nombre, creado, modificado) FROM stdin;
5	1	Arroz	\N	\N
6	1	Trigo	\N	\N
\.


--
-- TOC entry 2040 (class 0 OID 20181)
-- Dependencies: 157
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo_tipo (id, nombre, creado, modificado) FROM stdin;
1	Ninguno	\N	\N
2	Otro	\N	\N
3	Arroz Tipo 1	2012-02-08 10:25:39.047912-04:30	2012-02-08 10:25:39.047912-04:30
4	Arroz Tipo 2	2012-02-08 10:26:04.892642-04:30	2012-02-08 10:26:57.370103-04:30
\.


--
-- TOC entry 2041 (class 0 OID 20185)
-- Dependencies: 158
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ejes (id, nombre, capacidad) FROM stdin;
\.


--
-- TOC entry 2042 (class 0 OID 20193)
-- Dependencies: 161
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) FROM stdin;
101	Inicio de Sesion	0	OK
102	Cierre de Sesion	0	OK
105	Acceso Denegado	0	ERR
201	Data Nueva	0	OK
202	Data Actualizada	0	OK
203	Data Eliminada	0	OK
\.


--
-- TOC entry 2043 (class 0 OID 20199)
-- Dependencies: 163
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) FROM stdin;
1	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
2	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
3	2012-02-07	202	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id='1', nombre='Chaguaramas', rif='J-1234567', telefono='04129876543', email='asd@asd.com', ubicacion='Guaricoooooo', id_sap='', coordenadas='', id_org='0', modificado=now()	UPDATE si_centro_acopio SET  id='1', nombre='Chaguaramas', rif='J-1234567', telefono='04129876543', email='asd@asd.com', ubicacion='Guaricoooooo', id_sap='', coordenadas='', id_org='0', modificado=now() WHERE id=1	
4	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 3	
5	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
6	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Chaguaramas'<br />rif =  'J-1237123'<br />telefono =  '0416-1234567'<br />email =  'asd@asd123.com'<br />ubicacion =  'la que sea'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Chaguaramas', 'J-1237123', '0416-1234567', 'asd@asd123.com', 'la que sea', null, null, null,now(),now())	
7	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
8	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '0416-1234567'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '0416-1234567', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
9	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
21	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 12	
10	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asd'<br />rif =  'asd'<br />telefono =  'asd'<br />email =  'asd'<br />ubicacion =  'asd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asd', 'asd', 'asd', 'asd', 'asd', null, null, null,now(),now())	
11	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '123'<br />rif =  '123'<br />telefono =  '123'<br />email =  '123'<br />ubicacion =  '123'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('123', '123', '123', '123', '123', null, null, null,now(),now())	
12	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asdasd'<br />rif =  'dasdasd'<br />telefono =  'dasdasd'<br />email =  'dasdasd'<br />ubicacion =  'dasdasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asdasd', 'dasdasd', 'dasdasd', 'dasdasd', 'dasdasd', null, null, null,now(),now())	
13	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asdasd'<br />rif =  'dasdasd'<br />telefono =  'dasdasd'<br />email =  'dasdasd'<br />ubicacion =  'dasdasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asdasd', 'dasdasd', 'dasdasd', 'dasdasd', 'dasdasd', null, null, null,now(),now())	
14	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'añlsjdalskd'<br />rif =  'kdjaslkdj'<br />telefono =  'ldkajskldj'<br />email =  'kdajslkdj'<br />ubicacion =  'lkdajskldjad'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('añlsjdalskd', 'kdjaslkdj', 'ldkajskldj', 'kdajslkdj', 'lkdajskldjad', null, null, null,now(),now())	
15	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 21	
16	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 7	
17	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 8	
18	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 9	
19	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 10	
20	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 11	
22	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 14	
23	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 17	
24	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 5	
25	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 18	
26	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 19	
27	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 19	
28	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aksdajksldj'<br />rif =  'kldjaskldjasdkl'<br />telefono =  'djklasjdahlkdj'<br />email =  'lkdjklsdjaksldj'<br />ubicacion =  'djlkasjdaskldj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aksdajksldj', 'kldjaskldjasdkl', 'djklasjdahlkdj', 'lkdjklsdjaksldj', 'djlkasjdaskldj', null, null, null,now(),now())	
29	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'zzz'<br />rif =  'zzzz'<br />telefono =  'zzzz'<br />email =  'zzzz'<br />ubicacion =  'zzzz'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('zzz', 'zzzz', 'zzzz', 'zzzz', 'zzzz', null, null, null,now(),now())	
30	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
31	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
32	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
33	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '18902312n3'<br />rif =  '901273j1203'<br />telefono =  '8h129783h1'<br />email =  '8h127893h17829'<br />ubicacion =  'h78189h23791823'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('18902312n3', '901273j1203', '8h129783h1', '8h127893h17829', 'h78189h23791823', null, null, null,now(),now())	
34	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'alksdjaskl'<br />rif =  'jkldajsdkl'<br />telefono =  'jdaskldjl'<br />email =  'kdjaslkdjlk'<br />ubicacion =  'djlkasjd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('alksdjaskl', 'jkldajsdkl', 'jdaskldjl', 'kdjaslkdjlk', 'djlkasjd', null, null, null,now(),now())	
35	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '12390123'<br />rif =  'hj12kl3j12'<br />telefono =  'klj12kl3j12'<br />email =  'kl3j122l3k1j23lk'<br />ubicacion =  'lk3j12kl31j23'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('12390123', 'hj12kl3j12', 'klj12kl3j12', 'kl3j122l3k1j23lk', 'lk3j12kl31j23', null, null, null,now(),now())	
36	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'alskdjaskldj'<br />rif =  'kldjaskldj'<br />telefono =  'lkdjaskldj'<br />email =  'kldjskldj'<br />ubicacion =  'dklasjdlkasj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('alskdjaskldj', 'kldjaskldj', 'lkdjaskldj', 'kldjskldj', 'dklasjdlkasj', null, null, null,now(),now())	
37	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsdjaskldj'<br />rif =  'kdasjldkasjdkl'<br />telefono =  'djaskldjaskldj'<br />email =  'dklsajdkl'<br />ubicacion =  'jdklasjdklasdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsdjaskldj', 'kdasjldkasjdkl', 'djaskldjaskldj', 'dklsajdkl', 'jdklasjdklasdj', null, null, null,now(),now())	
38	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aksjdakldj'<br />rif =  'dklasjdkl'<br />telefono =  'djaklsdj'<br />email =  'lkdjskladj'<br />ubicacion =  'kldjaskldj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aksjdakldj', 'dklasjdkl', 'djaklsdj', 'lkdjskladj', 'kldjaskldj', null, null, null,now(),now())	
39	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjskldj'<br />rif =  'dklasjdkl'<br />telefono =  'jdklasjdkl'<br />email =  'djaskldj'<br />ubicacion =  'kldjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjskldj', 'dklasjdkl', 'jdklasjdkl', 'djaskldj', 'kldjaklsdj', null, null, null,now(),now())	
40	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsjdaklsdj'<br />rif =  'kdlsjalkd'<br />telefono =  'jdlkasjsdkl'<br />email =  'jdlksdjlkadj'<br />ubicacion =  'kdjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsjdaklsdj', 'kdlsjalkd', 'jdlkasjsdkl', 'jdlksdjlkadj', 'kdjaklsdj', null, null, null,now(),now())	
41	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askljdaskldj'<br />rif =  'dklasjdlk'<br />telefono =  'jdklasjdkl'<br />email =  'djaskldj'<br />ubicacion =  'lkjaksdjasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askljdaskldj', 'dklasjdlk', 'jdklasjdkl', 'djaskldj', 'lkjaksdjasd', null, null, null,now(),now())	
42	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'klasjdklasd'<br />rif =  'klasjdlkasjd'<br />telefono =  'dalksjdlkasdj'<br />email =  'kljadklsdjaslkd'<br />ubicacion =  'kasjdlaksdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('klasjdklasd', 'klasjdlkasjd', 'dalksjdlkasdj', 'kljadklsdjaslkd', 'kasjdlaksdj', null, null, null,now(),now())	
43	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjaskld'<br />rif =  'jdlkasjdklasjd'<br />telefono =  'kldjaskldjaskldj'<br />email =  'kldjaslkdjasdlk'<br />ubicacion =  'jdklasdjalkdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjaskld', 'jdlkasjdklasjd', 'kldjaskldjaskldj', 'kldjaslkdjasdlk', 'jdklasdjalkdj', null, null, null,now(),now())	
44	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsdjakl'<br />rif =  'kasjdaslkd'<br />telefono =  'kjaskldjaskl'<br />email =  'askldjaklsd'<br />ubicacion =  'dklasjdlkaj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsdjakl', 'kasjdaslkd', 'kjaskldjaskl', 'askldjaklsd', 'dklasjdlkaj', null, null, null,now(),now())	
45	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjaksdj'<br />rif =  'kldjasdklasjdkl'<br />telefono =  'djaskldj'<br />email =  'kldjaskldjakldj'<br />ubicacion =  'ldjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjaksdj', 'kldjasdklasjdkl', 'djaskldj', 'kldjaskldjakldj', 'ldjaklsdj', null, null, null,now(),now())	
46	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '1203871237'<br />rif =  '87w9812723'<br />telefono =  'lk12lk3jh'<br />email =  'jh12jk3h'<br />ubicacion =  'kjh123jk1h2'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('1203871237', '87w9812723', 'lk12lk3jh', 'jh12jk3h', 'kjh123jk1h2', null, null, null,now(),now())	
47	2012-02-07	203	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 23	
48	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '38uiojkds'<br />rif =  '892iueowjk'<br />telefono =  '23ujhn'<br />email =  '12783uyjh'<br />ubicacion =  '1728hwjqn'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('38uiojkds', '892iueowjk', '23ujhn', '12783uyjh', '1728hwjqn', null, null, null,now(),now())	
67	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '6', nombre = 'Trigo', id_tipo_cultivo = '1', modificado=now()	UPDATE si_cultivo SET  id = '6', nombre = 'Trigo', id_tipo_cultivo = '1', modificado=now() WHERE id=6	
49	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askldjaskldj'<br />rif =  'kldajsdkl'<br />telefono =  'jkdasjdlk'<br />email =  'jdklasjdkl'<br />ubicacion =  'jdlkasjdklaj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askldjaskldj', 'kldajsdkl', 'jkdasjdlk', 'jdklasjdkl', 'jdlkasjdklaj', null, null, null,now(),now())	
50	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '0416-1234567'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '0416-1234567', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
51	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guaricoooooo', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guaricoooooo', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=2	
52	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = '123321', coordenadas = 'asdaasd', id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = '123321', coordenadas = 'asdaasd', id_org = null, modificado=now() WHERE id=2	
53	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=2	
54	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Chaguaramos'<br />rif =  'J-9876543'<br />telefono =  '0412-7418529'<br />email =  '123@asd.com'<br />ubicacion =  'Mcy'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Chaguaramos', 'J-9876543', '0412-7418529', '123@asd.com', 'Mcy', null, null, null,now(),now())	
55	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'jesus silva'<br />rif =  'j-9668397'<br />telefono =  '0416-4383168'<br />email =  'jexuxal@hotmail.com'<br />ubicacion =  'zolia'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('jesus silva', 'j-9668397', '0416-4383168', 'jexuxal@hotmail.com', 'zolia', null, null, null,now(),now())	
56	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
57	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
58	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
59	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'guarilandia', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'guarilandia', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
60	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'ASD'<br />rif =  'ASD'<br />telefono =  'ASD'<br />email =  'ASD'<br />ubicacion =  'ASD'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('ASD', 'ASD', 'ASD', 'ASD', 'ASD', null, null, null,now(),now())	
61	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Arroz'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Arroz', '1',now(),now())	
62	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Trigo'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Trigo', '1',now(),now())	
63	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Sorgo'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Sorgo', '1',now(),now())	
64	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '7', nombre = 'Sorgo', id_tipo_cultivo = '2', modificado=now()	UPDATE si_cultivo SET  id = '7', nombre = 'Sorgo', id_tipo_cultivo = '2', modificado=now() WHERE id=7	
65	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '5', nombre = 'Arroz', id_tipo_cultivo = '2', modificado=now()	UPDATE si_cultivo SET  id = '5', nombre = 'Arroz', id_tipo_cultivo = '2', modificado=now() WHERE id=5	
66	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '5', nombre = 'Arroz', id_tipo_cultivo = '1', modificado=now()	UPDATE si_cultivo SET  id = '5', nombre = 'Arroz', id_tipo_cultivo = '1', modificado=now() WHERE id=5	
68	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	nombre = 'Arroz Tipo 1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo_tipo  (nombre, creado, modificado) VALUES  ('Arroz Tipo 1',now(),now())	
69	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	nombre = 'Arroz Tipo 2'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo_tipo  (nombre, creado, modificado) VALUES  ('Arroz Tipo 2',now(),now())	
70	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	id = '4', nombre = 'Arroz Tipo 3', modificado=now()	UPDATE si_cultivo_tipo SET  id = '4', nombre = 'Arroz Tipo 3', modificado=now() WHERE id=4	
71	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	id = '4', nombre = 'Arroz Tipo 2', modificado=now()	UPDATE si_cultivo_tipo SET  id = '4', nombre = 'Arroz Tipo 2', modificado=now() WHERE id=4	
72	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Cagua'<br />rif =  'J-182731092'<br />telefono =  '0412-123456789'<br />email =  'ASD@asd.com'<br />ubicacion =  'Cagua'<br />id_sap =  '132465'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Cagua', 'J-182731092', '0412-123456789', 'ASD@asd.com', 'Cagua', '132465', null, null,now(),now())	
73	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_silos	No data	nombre = 'Silo B'<br />coordenada =  'la que sea'<br />numero =  '2'<br />capacidad =  '30000'<br />observacion =  null<br />id_centro_acopio =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (nombre, coordenada, numero, capacidad, observacion, id_centro_acopio, creado, modificado) VALUES  ('Silo B', 'la que sea', '2', '30000', null, '1',now(),now())	
74	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_silos	No data	id = '2', nombre = 'Silo B', coordenada = 'Sur', numero = '2', capacidad = '30000', observacion = 'A', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '2', nombre = 'Silo B', coordenada = 'Sur', numero = '2', capacidad = '30000', observacion = 'A', id_centro_acopio = '1', modificado=now() WHERE id=2	
75	2012-02-08	105	0	N/A	N/A	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '1376934'	Login Incorrect=1376934
76	2012-02-08	105	0	N/A	N/A	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '1376934'	Login Incorrect=1376934
77	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', id_centro_acopio = '1', modificado=now() WHERE id=1	
78	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = 'AAAAA', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = 'AAAAA', id_centro_acopio = '1', modificado=now() WHERE id=1	
79	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = null, id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = null, id_centro_acopio = '1', modificado=now() WHERE id=1	
80	2012-02-08	201	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	nombre = 'Silo B'<br />coordenada =  'Sur'<br />numero =  '2'<br />capacidad =  '350000'<br />observacion =  'Ninguna'<br />id_centro_acopio =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (nombre, coordenada, numero, capacidad, observacion, id_centro_acopio, creado, modificado) VALUES  ('Silo B', 'Sur', '2', '350000', 'Ninguna', '1',now(),now())	
81	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	codigo = '63'<br />nombre =  'Zaraza'<br />rif =  'J-3456789'<br />telefono =  null<br />email =  null<br />ubicacion =  'Otra'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (codigo, nombre, rif, telefono, email, ubicacion, coordenadas, id_org, creado, modificado) VALUES  ('63', 'Zaraza', 'J-3456789', null, null, 'Otra', null, null,now(),now())	
82	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
83	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
84	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '182640'	Login Incorrect=182640
85	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
86	2012-02-12	105	0	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
87	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Juan'<br />apellido =  'Taborda'<br />cedula =  '13741258'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  'Mcy'<br />telefono =  null<br />email =  null<br />usuario =  'jtaborda'<br />contrasena =  '123'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado, modificado) VALUES  ('Juan', 'Taborda', '13741258', null, 'M', 'Mcy', null, null, 'jtaborda', '123',now(),now())	
88	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '2'<br />id_perfil =  '3'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','2', '3', now())	
89	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Mariely'<br />apellido =  'Coronado'<br />cedula =  '17987654'<br />fecha_nacimiento =  null<br />sexo =  'F'<br />direccion =  'La Villa'<br />telefono =  null<br />email =  'marielycoronado@agropatria.co.ve'<br />usuario =  'mcoronado'<br />contrasena =  '123'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Mariely', 'Coronado', '17987654', null, 'F', 'La Villa', null, 'marielycoronado@agropatria.co.ve', 'mcoronado', '123',now())	
90	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '2'<br />id_perfil =  '4'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','2', '4', now())	
91	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
92	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
93	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
94	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
95	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
96	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
97	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
98	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
99	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
100	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
101	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
102	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '57'<br />nombre =  'Sabana de Parra'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Algun Lugar'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '57', 'Sabana de Parra', 'J-123123', null, null, null, 'Algun Lugar', '1', '1', '1', null, null, 't',now())	
103	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '3'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('3', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
104	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
105	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
106	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
107	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
108	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
109	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
110	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
111	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
112	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
113	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
114	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '58'<br />nombre =  'Chaguaramas'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Chaguaramas'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '58', 'Chaguaramas', 'J-123123', null, null, null, 'Chaguaramas', '1', '1', '1', null, null, 't',now())	
115	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '4'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('4', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
116	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
117	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
118	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
119	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
120	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
121	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
122	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
123	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
124	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
204	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
125	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
126	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
127	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
128	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 13'<br />coordenada =  'Norte'<br />numero =  '13'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 13', 'Norte', '13', '1000', 'A',now())	
129	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 14'<br />coordenada =  'Norte'<br />numero =  '14'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 14', 'Norte', '14', '1000', 'A',now())	
130	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 15'<br />coordenada =  'Norte'<br />numero =  '15'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 15', 'Norte', '15', '1000', 'A',now())	
131	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 16'<br />coordenada =  'Norte'<br />numero =  '16'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 16', 'Norte', '16', '1000', 'A',now())	
132	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 17'<br />coordenada =  'Norte'<br />numero =  '17'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 17', 'Norte', '17', '1000', 'A',now())	
133	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 18'<br />coordenada =  'Norte'<br />numero =  '18'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 18', 'Norte', '18', '1000', 'A',now())	
205	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 't'	UPDATE si_almacenes SET estatus = 't' WHERE id_centro_acopio = '2'	
134	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 19'<br />coordenada =  'Norte'<br />numero =  '19'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 19', 'Norte', '19', '1000', 'A',now())	
135	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 20'<br />coordenada =  'Norte'<br />numero =  '20'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 20', 'Norte', '20', '1000', 'A',now())	
136	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 21'<br />coordenada =  'Norte'<br />numero =  '21'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 21', 'Norte', '21', '1000', 'A',now())	
137	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 22'<br />coordenada =  'Norte'<br />numero =  '22'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 22', 'Norte', '22', '1000', 'A',now())	
138	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 23'<br />coordenada =  'Norte'<br />numero =  '23'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 23', 'Norte', '23', '1000', 'A',now())	
139	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 24'<br />coordenada =  'Norte'<br />numero =  '24'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 24', 'Norte', '24', '1000', 'A',now())	
140	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '60'<br />nombre =  'Sabaneta'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Zulia'<br />id_pais =  '1'<br />id_estado =  '2'<br />id_municipio =  '2'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '60', 'Sabaneta', 'J-123123', null, null, null, 'Zulia', '1', '2', '2', null, null, 't',now())	
141	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
142	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
143	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
144	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
145	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
146	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
147	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
148	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
149	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
150	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
151	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
206	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 't'	UPDATE si_silos SET estatus = 't' WHERE id_centro_acopio = '2'	
152	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
153	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
154	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 13'<br />coordenada =  'Norte'<br />numero =  '13'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 13', 'Norte', '13', '1000', 'A',now())	
155	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 14'<br />coordenada =  'Norte'<br />numero =  '14'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 14', 'Norte', '14', '1000', 'A',now())	
156	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 15'<br />coordenada =  'Norte'<br />numero =  '15'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 15', 'Norte', '15', '1000', 'A',now())	
157	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 16'<br />coordenada =  'Norte'<br />numero =  '16'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 16', 'Norte', '16', '1000', 'A',now())	
158	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 17'<br />coordenada =  'Norte'<br />numero =  '17'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 17', 'Norte', '17', '1000', 'A',now())	
159	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 18'<br />coordenada =  'Norte'<br />numero =  '18'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 18', 'Norte', '18', '1000', 'A',now())	
160	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 19'<br />coordenada =  'Norte'<br />numero =  '19'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 19', 'Norte', '19', '1000', 'A',now())	
207	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id IN (2,3)	
161	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 20'<br />coordenada =  'Norte'<br />numero =  '20'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 20', 'Norte', '20', '1000', 'A',now())	
162	2012-02-13	202	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta222', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia - Maracaibo', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now()	UPDATE si_centro_acopio SET  id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta222', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia - Maracaibo', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now() WHERE id=5	
163	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
164	2012-02-13	202	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now()	UPDATE si_centro_acopio SET  id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now() WHERE id=5	
165	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
166	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '63'<br />nombre =  'Zaraza'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Guarico'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '63', 'Zaraza', 'J-123123', null, null, null, 'Guarico', '1', '1', '1', null, null, 't',now())	
167	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '6'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('6', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
168	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
169	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
170	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
171	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
172	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
173	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
174	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
175	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
176	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
177	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
208	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
178	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
179	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
180	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Jesus'<br />apellido =  'Silva'<br />cedula =  '9668397'<br />fecha_nacimiento =  '1970-09-01'<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jsilva'<br />contrasena =  '123'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Jesus', 'Silva', '9668397', '1970-09-01', 'M', null, null, null, 'jsilva', '123',now())	
181	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '6'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','6', '2', now())	
182	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
183	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
184	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
185	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
186	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
187	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
188	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
189	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
190	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
191	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Juan'<br />apellido =  'Taborda'<br />cedula =  '13769341'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jtaborda'<br />contrasena =  '40bd001563085fc35165329ea1ff5c5ecbdbbeef'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Juan', 'Taborda', '13769341', null, 'M', null, null, null, 'jtaborda', '40bd001563085fc35165329ea1ff5c5ecbdbbeef',now())	
192	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '3'<br />id_almacen = '3'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('3','3', '2', now())	
193	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
194	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
195	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
196	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
197	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
198	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
199	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
200	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
201	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
202	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
203	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
209	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
210	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '0'	UPDATE si_silos SET estatus = '0' WHERE id_centro_acopio = '2'	
211	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
212	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
213	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 't'	UPDATE si_almacenes SET estatus = 't' WHERE id_centro_acopio = '2'	
214	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '1'	UPDATE si_silos SET estatus = '1' WHERE id_centro_acopio = '2'	
215	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id IN (2,3)	
216	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Jesus'<br />apellido =  'Rodriguez'<br />cedula =  '18264065'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jrodriguez'<br />contrasena =  '40bd001563085fc35165329ea1ff5c5ecbdbbeef'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Jesus', 'Rodriguez', '18264065', null, 'M', null, null, null, 'jrodriguez', '40bd001563085fc35165329ea1ff5c5ecbdbbeef',now())	
217	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '4'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','4', '2', now())	
218	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '4', nombre = 'Jesus', apellido = 'Rodriguez', cedula = '18264065', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'jesusrodriguez@agropatria.co.ve', usuario = 'jrodriguez                      ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '4', nombre = 'Jesus', apellido = 'Rodriguez', cedula = '18264065', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'jesusrodriguez@agropatria.co.ve', usuario = 'jrodriguez                      ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=4	
219	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '4'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','4', '2', now())	
220	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '2'	
221	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '2'	
222	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '2'	
223	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '2'	
224	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '2', nombre = 'Jesus', apellido = 'Silva', cedula = '9668397', fecha_nacimiento = '1970-09-01', sexo = 'M', direccion = null, telefono = null, email = 'jesussilva@agropatria.co.ve', usuario = 'jsilva                          ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '2', nombre = 'Jesus', apellido = 'Silva', cedula = '9668397', fecha_nacimiento = '1970-09-01', sexo = 'M', direccion = null, telefono = null, email = 'jesussilva@agropatria.co.ve', usuario = 'jsilva                          ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=2	
225	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '2'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','2', '2', now())	
\.


--
-- TOC entry 2044 (class 0 OID 20206)
-- Dependencies: 164
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu (id, nombre, id_padre, url, creado, modificado) FROM stdin;
1	Maestros	0	\N	\N	\N
2	Procesos	0	\N	\N	\N
3	Reportes	0	\N	\N	\N
4	Panel de Control	0	\N	\N	\N
5	Cuenta	0	\N	\N	\N
6	Centros de Acopio	1	admin/centros_acopio_listado.php	\N	\N
7	Cultivo	1	admin/cultivo_listado.php	\N	\N
8	Programa	1	admin/programa_listado.php	\N	\N
9	Silos	1	admin/silos_listado.php	\N	\N
10	Productor	1	admin/productor_listado.php	\N	\N
11	Recepci&oacute;n	2	\N	\N	\N
12	Despacho	2	\N	\N	\N
13	Programas	3	\N	\N	\N
14	Cosecha	3	\N	\N	\N
15	Cultivos	3	\N	\N	\N
16	Productores	3	\N	\N	\N
17	Recepciones	3	\N	\N	\N
18	Despacho	3	\N	\N	\N
19	Silos	4	\N	\N	\N
21	Formulas	4	\N	\N	\N
22	Configuracion	4	\N	\N	\N
23	Config. Cuenta	5	\N	\N	\N
20	Usuarios	4	admin/usuarios_listado.php	\N	\N
24	Organizaciones	1	admin/organizacion_listado.php	\N	\N
\.


--
-- TOC entry 2045 (class 0 OID 20211)
-- Dependencies: 166
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu_usuario (id_menu, id_usuario) FROM stdin;
1	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	1
24	1
\.


--
-- TOC entry 2046 (class 0 OID 20214)
-- Dependencies: 167
-- Data for Name: si_movimiento; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_movimiento (silo_id, cosecha_id, numero, fecha_inicio, fecha_fin, cantidad_muestra, peso_bruto, placa_vehiculo, cedula_conductor, descuento_humedad, descuento_impuresas, sada_id, observacion, sap_id, peso_vacio, estado_id, nombre, id, programa_id, contrato, tipo_proceso) FROM stdin;
\.


--
-- TOC entry 2047 (class 0 OID 20226)
-- Dependencies: 168
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus) FROM stdin;
1	Agropatria	\N	\N	\N	\N	\N	\N	1	1	1	2012-02-12 00:00:00-04:30	\N	t
\.


--
-- TOC entry 2048 (class 0 OID 20236)
-- Dependencies: 171
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
1	SYSTEM_NAME	SIGESI	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
2	MAX_RESULTS_PAG	20	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
\.


--
-- TOC entry 2049 (class 0 OID 20245)
-- Dependencies: 173
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_perfiles (id, nombre_perfil, creado, modificado) FROM stdin;
2	Gerente	2012-02-07	\N
1	Gerente General	2012-02-07	\N
7	Despacho	2012-02-07	\N
6	Recepcion	2012-02-07	\N
5	Romanero	2012-02-07	\N
4	Calidad	2012-02-07	\N
3	Administrador	2012-02-07	\N
\.


--
-- TOC entry 2050 (class 0 OID 20249)
-- Dependencies: 174
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_productor (id, nombre, rif, telefono, email, direccion, sap_id, centro_acopio_id) FROM stdin;
\.


--
-- TOC entry 2051 (class 0 OID 20257)
-- Dependencies: 176
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, numero, nombre, observacion, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2052 (class 0 OID 20264)
-- Dependencies: 177
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_proveedor (id, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2053 (class 0 OID 20270)
-- Dependencies: 178
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, observacion, estatus, modulo, creado, modificado) FROM stdin;
7	3	3	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:05:32.047308-04:30	\N
8	3	3	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:05:32.064005-04:30	\N
9	3	3	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:05:32.080546-04:30	\N
10	3	3	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:05:32.097424-04:30	\N
11	3	3	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:05:32.114005-04:30	\N
12	3	3	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:05:32.130658-04:30	\N
13	3	3	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:05:32.147097-04:30	\N
14	3	3	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:05:32.164022-04:30	\N
15	3	3	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:05:32.180592-04:30	\N
16	3	3	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:05:32.197159-04:30	\N
17	4	4	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:06:27.348165-04:30	\N
18	4	4	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:06:27.365003-04:30	\N
19	4	4	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:06:27.381487-04:30	\N
20	4	4	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:06:27.39829-04:30	\N
21	4	4	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:06:27.414956-04:30	\N
22	4	4	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:06:27.431423-04:30	\N
23	4	4	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:06:27.448256-04:30	\N
24	4	4	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:06:27.464898-04:30	\N
25	4	4	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:06:27.481472-04:30	\N
26	4	4	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:06:27.498121-04:30	\N
27	4	4	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:06:27.514982-04:30	\N
28	4	4	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:06:27.531417-04:30	\N
29	4	4	Silo 13	Norte	13	1000	\N	1	A 	2012-02-13 11:06:27.548043-04:30	\N
30	4	4	Silo 14	Norte	14	1000	\N	1	A 	2012-02-13 11:06:27.565593-04:30	\N
31	4	4	Silo 15	Norte	15	1000	\N	1	A 	2012-02-13 11:06:27.585406-04:30	\N
32	4	4	Silo 16	Norte	16	1000	\N	1	A 	2012-02-13 11:06:27.598079-04:30	\N
33	4	4	Silo 17	Norte	17	1000	\N	1	A 	2012-02-13 11:06:27.614882-04:30	\N
34	4	4	Silo 18	Norte	18	1000	\N	1	A 	2012-02-13 11:06:27.631368-04:30	\N
35	4	4	Silo 19	Norte	19	1000	\N	1	A 	2012-02-13 11:06:27.64816-04:30	\N
36	4	4	Silo 20	Norte	20	1000	\N	1	A 	2012-02-13 11:06:27.664683-04:30	\N
37	4	4	Silo 21	Norte	21	1000	\N	1	A 	2012-02-13 11:06:27.681424-04:30	\N
38	4	4	Silo 22	Norte	22	1000	\N	1	A 	2012-02-13 11:06:27.698087-04:30	\N
39	4	4	Silo 23	Norte	23	1000	\N	1	A 	2012-02-13 11:06:27.714699-04:30	\N
40	4	4	Silo 24	Norte	24	1000	\N	1	A 	2012-02-13 11:06:27.731507-04:30	\N
41	5	5	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:12:33.341886-04:30	\N
42	5	5	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:12:33.358622-04:30	\N
43	5	5	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:12:33.375377-04:30	\N
44	5	5	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:12:33.39185-04:30	\N
45	5	5	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:12:33.408492-04:30	\N
46	5	5	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:12:33.425069-04:30	\N
47	5	5	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:12:33.442001-04:30	\N
48	5	5	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:12:33.458509-04:30	\N
49	5	5	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:12:33.475215-04:30	\N
50	5	5	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:12:33.491855-04:30	\N
51	5	5	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:12:33.508602-04:30	\N
52	5	5	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:12:33.525128-04:30	\N
53	5	5	Silo 13	Norte	13	1000	\N	1	A 	2012-02-13 11:12:33.541914-04:30	\N
54	5	5	Silo 14	Norte	14	1000	\N	1	A 	2012-02-13 11:12:33.561376-04:30	\N
55	5	5	Silo 15	Norte	15	1000	\N	1	A 	2012-02-13 11:12:33.575171-04:30	\N
56	5	5	Silo 16	Norte	16	1000	\N	1	A 	2012-02-13 11:12:33.59178-04:30	\N
57	5	5	Silo 17	Norte	17	1000	\N	1	A 	2012-02-13 11:12:33.60849-04:30	\N
58	5	5	Silo 18	Norte	18	1000	\N	1	A 	2012-02-13 11:12:33.625125-04:30	\N
59	5	5	Silo 19	Norte	19	1000	\N	1	A 	2012-02-13 11:12:33.64196-04:30	\N
60	5	5	Silo 20	Norte	20	1000	\N	1	A 	2012-02-13 11:12:33.658508-04:30	\N
61	6	6	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:25:07.764398-04:30	\N
62	6	6	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:25:07.781128-04:30	\N
63	6	6	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:25:07.797725-04:30	\N
64	6	6	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:25:07.814551-04:30	\N
65	6	6	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:25:07.831087-04:30	\N
66	6	6	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:25:07.847859-04:30	\N
67	6	6	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:25:07.864434-04:30	\N
68	6	6	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:25:07.880988-04:30	\N
69	6	6	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:25:07.897561-04:30	\N
70	6	6	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:25:07.914479-04:30	\N
71	6	6	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:25:07.931073-04:30	\N
72	6	6	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:25:07.947754-04:30	\N
2	2	2	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:01:40.130888-04:30	\N
3	2	2	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:01:40.147421-04:30	\N
4	2	2	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:01:40.164032-04:30	\N
5	2	2	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:01:40.180896-04:30	\N
6	2	2	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:01:40.197353-04:30	\N
\.


--
-- TOC entry 2054 (class 0 OID 20280)
-- Dependencies: 180
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus) FROM stdin;
1	Jose	Peluzzo	1234567	2012-02-12	M	jpeluzzo                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	Maracay	\N	josepeluzzo@agropatria.co.ve	2012-02-12	\N	t
3	Juan	Taborda	13769341	\N	M	jtaborda                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	\N	2012-02-13	\N	t
4	Jesus	Rodriguez	18264065	\N	M	jrodriguez                      	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesusrodriguez@agropatria.co.ve	2012-02-13	2012-02-13	t
2	Jesus	Silva	9668397	1970-09-01	M	jsilva                          	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesussilva@agropatria.co.ve	2012-02-13	2012-02-13	t
\.


--
-- TOC entry 2055 (class 0 OID 20288)
-- Dependencies: 182
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) FROM stdin;
1	1	1	1	2012-02-13 00:00:00-04:30	\N
2	2	2	2	2012-02-13 11:34:56.142546-04:30	\N
3	3	2	3	2012-02-13 15:00:02.192211-04:30	\N
4	4	4	2	2012-02-13 16:15:23.105604-04:30	\N
\.


--
-- TOC entry 1972 (class 2606 OID 20302)
-- Dependencies: 146 146
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 1990 (class 2606 OID 20304)
-- Dependencies: 161 161
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 1964 (class 2606 OID 20306)
-- Dependencies: 140 140
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 1968 (class 2606 OID 20308)
-- Dependencies: 143 143
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 1966 (class 2606 OID 20310)
-- Dependencies: 142 142
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 1970 (class 2606 OID 20312)
-- Dependencies: 144 144
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 1974 (class 2606 OID 20314)
-- Dependencies: 147 147
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 1976 (class 2606 OID 20316)
-- Dependencies: 148 148
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 1978 (class 2606 OID 20318)
-- Dependencies: 149 149
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 1980 (class 2606 OID 20320)
-- Dependencies: 151 151
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 1982 (class 2606 OID 20322)
-- Dependencies: 153 153
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 1984 (class 2606 OID 20324)
-- Dependencies: 155 155
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 1986 (class 2606 OID 20326)
-- Dependencies: 157 157
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 20328)
-- Dependencies: 158 158
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 1992 (class 2606 OID 20330)
-- Dependencies: 163 163
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 1994 (class 2606 OID 20332)
-- Dependencies: 164 164
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 1998 (class 2606 OID 20334)
-- Dependencies: 168 168
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2000 (class 2606 OID 20336)
-- Dependencies: 171 171
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 20338)
-- Dependencies: 173 173
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2004 (class 2606 OID 20340)
-- Dependencies: 174 174
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 20342)
-- Dependencies: 176 176
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2008 (class 2606 OID 20344)
-- Dependencies: 177 177
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 20346)
-- Dependencies: 167 167
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_movimiento
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2010 (class 2606 OID 20348)
-- Dependencies: 178 178
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2016 (class 2606 OID 20350)
-- Dependencies: 182 182
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 20352)
-- Dependencies: 180 180
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2014 (class 2606 OID 20354)
-- Dependencies: 180 180
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2017 (class 2606 OID 20355)
-- Dependencies: 149 140 1977
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2018 (class 2606 OID 20360)
-- Dependencies: 176 2005 153
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2019 (class 2606 OID 20365)
-- Dependencies: 155 1985 157
-- Name: si_cultivo_id_tipo_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_tipo_cultivo_fkey FOREIGN KEY (id_tipo_cultivo) REFERENCES si_cultivo_tipo(id);


--
-- TOC entry 2020 (class 2606 OID 20370)
-- Dependencies: 1989 161 163
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2021 (class 2606 OID 20375)
-- Dependencies: 166 164 1993
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2022 (class 2606 OID 20380)
-- Dependencies: 180 2011 166
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2023 (class 2606 OID 20385)
-- Dependencies: 149 1977 176
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2024 (class 2606 OID 20390)
-- Dependencies: 140 1963 178
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2025 (class 2606 OID 20395)
-- Dependencies: 149 178 1977
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2026 (class 2606 OID 20400)
-- Dependencies: 1963 140 182
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2027 (class 2606 OID 20405)
-- Dependencies: 2001 182 173
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2028 (class 2606 OID 20410)
-- Dependencies: 182 180 2011
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-13 16:35:04 VET

--
-- PostgreSQL database dump complete
--

