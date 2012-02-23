--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
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
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: si_almacenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_almacenes (
    id bigint DEFAULT nextval('si_almacenes_id_seq'::regclass) NOT NULL,
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
    id_tipo_almacen bigint NOT NULL,
    codigo character varying(16) NOT NULL
);


ALTER TABLE public.si_almacenes OWNER TO admin;

--
-- Name: si_analisis_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_id_seq OWNER TO admin;

--
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- Name: si_analisis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis (
    id bigint DEFAULT nextval('si_analisis_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo_analisis smallint DEFAULT 1,
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    codigo character varying(16) NOT NULL
);


ALTER TABLE public.si_analisis OWNER TO admin;

--
-- Name: si_analisis_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_centro_acopio (
    analisis_id bigint NOT NULL,
    centro_acopio_id bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_centro_acopio OWNER TO admin;

--
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla Vehiculos';


--
-- Name: si_analisis_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_cultivo (
    id_org bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    laboratorio character(1) NOT NULL,
    min_rec real,
    max_rec real,
    min_des real,
    max_des real,
    reduccion_rec real,
    reduccion_des real,
    estatus boolean
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- Name: si_analisis_des; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_des (
    id_org bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    min_rec real,
    max_rec real,
    min_des real,
    max_des real,
    descuento_rec real,
    descuento_des real,
    estatus boolean DEFAULT true
);


ALTER TABLE public.si_analisis_des OWNER TO admin;

--
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
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id character varying(255) NOT NULL,
    apperror_time timestamp with time zone NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- Name: si_asociado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_asociado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_asociado_id_seq OWNER TO admin;

--
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- Name: si_asociado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_asociado (
    id bigint DEFAULT nextval('si_asociado_id_seq'::regclass) NOT NULL,
    id_cosecha bigint NOT NULL,
    id_productor bigint NOT NULL,
    cedula character(16),
    nombre character varying(255) NOT NULL,
    direccion character varying(255) NOT NULL,
    telefono character varying(255) NOT NULL,
    celular character varying(255) NOT NULL,
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    estatus boolean,
    direccion_finca character varying(255) NOT NULL,
    area_finca integer,
    ton_cosecha real
);


ALTER TABLE public.si_asociado OWNER TO admin;

--
-- Name: si_cargo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_id_seq OWNER TO admin;

--
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- Name: si_cargo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo (
    id bigint DEFAULT nextval('si_cargo_id_seq'::regclass) NOT NULL,
    id_almacen bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_cargo_tipo bigint NOT NULL,
    creado timestamp without time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_cargo OWNER TO admin;

--
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_tipo_id_seq OWNER TO admin;

--
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
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
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- Name: si_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_centro_acopio (
    id bigint DEFAULT nextval('si_centro_acopio_id_seq'::regclass) NOT NULL,
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
-- Name: si_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cliente_id_seq OWNER TO admin;

--
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- Name: si_cliente; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cliente (
    id bigint DEFAULT nextval('si_cliente_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_sap character(16) NOT NULL,
    rif character(16) NOT NULL,
    ref character(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    telefono character varying(32) NOT NULL,
    fax character varying(32) NOT NULL,
    email_org character varying(255) NOT NULL,
    edo_civil character(3),
    nacionalidad character(3),
    contacto1_nombre character varying(32) NOT NULL,
    contacto1_telefono character varying(32) NOT NULL,
    contacto1_email character varying(255) NOT NULL,
    contacto2_nombre character varying(32) NOT NULL,
    contacto2_telefono character varying(32) NOT NULL,
    contacto2_email character varying(255) NOT NULL,
    contacto3_nombre character varying(32) NOT NULL,
    contacto3_telefono character varying(32) NOT NULL,
    contacto3_email character varying(255) NOT NULL,
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    direccion character varying(255) NOT NULL,
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cliente OWNER TO admin;

--
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
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 3, true);


--
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint DEFAULT nextval('si_cosecha_id_seq'::regclass) NOT NULL,
    id_programa bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    nombre character varying(255),
    proyectado real DEFAULT 0.0,
    observacion character varying(255) DEFAULT NULL::character varying,
    area_siembra real DEFAULT 0.0,
    fecha_inicio date,
    fecha_fin date,
    estatus boolean DEFAULT false NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    codigo character varying(16) NOT NULL
);


ALTER TABLE public.si_cosecha OWNER TO admin;

--
-- Name: si_cosecha_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha_productor (
    id_cosecha bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_productor bigint NOT NULL,
    asociado boolean NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cosecha_productor OWNER TO admin;

--
-- Name: si_cuarentena; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cuarentena (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero_mov integer NOT NULL,
    tipo_mov character(1) NOT NULL,
    codigo_cultivo character(16),
    fecha_mov timestamp with time zone,
    fecha_cultivo timestamp with time zone,
    grado_infestacion integer,
    laboratorio character(2),
    id_producto bigint,
    toneladas real,
    cant_producto integer,
    id_plaga bigint,
    hora_trab real,
    fecha_lib timestamp with time zone,
    hora_lib timestamp with time zone,
    id_analisis bigint,
    estatus boolean
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- Name: TABLE si_cuarentena; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cuarentena IS 'Tabla de Cuarentena para Fumigacion de Cultivos';


--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_id_seq OWNER TO admin;

--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
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
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 9, true);


--
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint DEFAULT nextval('si_cultivo_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    codigo character(16) NOT NULL,
    nombre character varying(255) NOT NULL,
    tipificado boolean DEFAULT false,
    ciclo integer DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- Name: si_denom_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_denom_tip_id_seq OWNER TO admin;

--
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- Name: si_denom_tip; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_denom_tip (
    id bigint DEFAULT nextval('si_denom_tip_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    nombre_tipo_clase character varying(255) NOT NULL,
    valor integer NOT NULL,
    estatus boolean
);


ALTER TABLE public.si_denom_tip OWNER TO admin;

--
-- Name: si_despacho; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_despacho (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_orden bigint NOT NULL,
    id_productor bigint NOT NULL,
    id_chofer bigint NOT NULL,
    id_vehiculo bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_transporte bigint NOT NULL,
    id_punto_entrega bigint NOT NULL,
    id_silo bigint NOT NULL,
    fecha_des timestamp with time zone,
    numero integer NOT NULL,
    num_oca character(16),
    kgr_oca real,
    nu1_oca character(16),
    kg1_oca real,
    romana_vacia boolean,
    fecha_vacia timestamp with time zone,
    peso01_vacio real,
    peso02_vacio real,
    romana_llena real,
    fecha_liq timestamp with time zone,
    peso01_liq real,
    peso02_liq real,
    hum01_des real,
    hum02_des real,
    imp01_des real,
    imp02_des real,
    khu_01d real,
    khu_02d real,
    kim_01d real,
    kim_02d real,
    kac_des real,
    estatus character(1)
);


ALTER TABLE public.si_despacho OWNER TO admin;

--
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción de Cultivo';


--
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
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- Name: si_ejes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ejes (
    id bigint DEFAULT nextval('si_ejes_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    capacidad integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_ejes OWNER TO admin;

--
-- Name: si_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_estado_id_seq OWNER TO admin;

--
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- Name: si_finca; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_finca (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    id_productor bigint NOT NULL,
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    id_agencia bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion character varying(255) NOT NULL,
    area_siembra real DEFAULT 0.0,
    creado timestamp without time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_finca OWNER TO admin;

--
-- Name: si_finca_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_finca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_finca_id_seq OWNER TO admin;

--
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- Name: si_guia_rec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guia_rec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_guia_rec_id_seq OWNER TO admin;

--
-- Name: si_guia_rec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guia_rec_id_seq', 1, false);


--
-- Name: si_guiarec; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiarec (
    id bigint DEFAULT nextval('si_guia_rec_id_seq'::regclass) NOT NULL,
    id_agencia bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_productor bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_usuario bigint NOT NULL,
    numero_guia integer NOT NULL,
    kilogramos real DEFAULT 0.0,
    placa_remolque character(16),
    placa_vehiculo character(16),
    cedula_chofer character(16),
    fecha_emision timestamp with time zone,
    hora_emision timestamp with time zone,
    estatus character(2),
    cedula_asociado character(16),
    fecha_rec timestamp with time zone
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- Name: si_guiasrec_det; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiasrec_det (
    id_guiarec bigint NOT NULL,
    id_rec bigint NOT NULL,
    subguia character(16),
    fecha timestamp with time zone,
    descripcion character varying(255)
);


ALTER TABLE public.si_guiasrec_det OWNER TO admin;

--
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
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
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
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 254, true);


--
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
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 26, true);


--
-- Name: si_menu; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu (
    id bigint DEFAULT nextval('si_menu_id_seq'::regclass) NOT NULL,
    nombre character varying(32) NOT NULL,
    id_padre bigint NOT NULL,
    url character varying(255),
    estatus boolean DEFAULT true,
    orden integer,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_menu OWNER TO admin;

--
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- Name: si_municipio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_municipio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_municipio_id_seq OWNER TO admin;

--
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- Name: si_ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_id_seq OWNER TO admin;

--
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- Name: si_ordenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ordenes (
    id bigint DEFAULT nextval('si_ordenes_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    numero_orden bigint NOT NULL,
    tipo character(2) NOT NULL,
    fecha_emision timestamp with time zone NOT NULL,
    numero_contrato character(32),
    toneladas real DEFAULT 0.0,
    descuento boolean,
    estatus boolean
);


ALTER TABLE public.si_ordenes OWNER TO admin;

--
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
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 2, true);


--
-- Name: si_organizacion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_organizacion (
    id bigint DEFAULT nextval('si_organizacion_id_seq'::regclass) NOT NULL,
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
    estatus boolean,
    codigo character varying(16)
);


ALTER TABLE public.si_organizacion OWNER TO admin;

--
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- Name: si_pais_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_pais_id_seq OWNER TO admin;

--
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
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
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 5, true);


--
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
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
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
-- Name: si_plaga; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_plaga (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    estatus boolean,
    creado timestamp without time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_plaga OWNER TO admin;

--
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- Name: si_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_plaga_id_seq OWNER TO admin;

--
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 1, false);


--
-- Name: si_producto; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_producto (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    numero integer NOT NULL,
    nombre character varying(255) NOT NULL,
    presentacion character(16) NOT NULL,
    dosis real,
    estatus boolean,
    creado timestamp without time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_producto OWNER TO admin;

--
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- Name: si_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_producto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_producto_id_seq OWNER TO admin;

--
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 1, false);


--
-- Name: si_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_productor_id_seq OWNER TO admin;

--
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 1, true);


--
-- Name: si_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_productor (
    id bigint DEFAULT nextval('si_productor_id_seq'::regclass) NOT NULL,
    id_org bigint,
    id_sap character(16),
    cod_rif character(16),
    cod_ref character(16),
    nombre character varying(255),
    telefono character varying(32),
    fax character varying(32),
    email character varying(255),
    edo_civil character(3),
    nacionalidad character(3),
    direccion character varying(255),
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    coordenadas_utm character varying(32),
    estatus boolean,
    ced_legal character(16),
    legal_nombre character varying(255),
    cod_ag_dir_fis character(16),
    contacto1_nombre character varying(255),
    contacto1_telefono character varying(255),
    contacto1_email character varying(255),
    contacto2_nombre character varying(255),
    contacto2_telefono character varying(255),
    contacto2_email character varying(255),
    contacto3_nombre character varying(255),
    contacto3_telefono character varying(255),
    contacto3_email character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_productor OWNER TO admin;

--
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
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 2, true);


--
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint DEFAULT nextval('si_programa_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean NOT NULL,
    codigo character varying(16) NOT NULL
);


ALTER TABLE public.si_programa OWNER TO admin;

--
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
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- Name: si_punto_entrega; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_punto_entrega (
    id bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    numero integer NOT NULL,
    nombre character varying(255) NOT NULL,
    telefono character(16),
    direccion character varying(255) NOT NULL,
    estatus boolean,
    creado timestamp without time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_punto_entrega OWNER TO admin;

--
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_punto_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_punto_entrega_id_seq OWNER TO admin;

--
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- Name: si_recepcion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recepcion (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_silo bigint NOT NULL,
    id_productor bigint NOT NULL,
    id_asociado bigint NOT NULL,
    id_guia bigint NOT NULL,
    id_chofer bigint NOT NULL,
    id_usuario bigint NOT NULL,
    numero integer NOT NULL,
    contrato character(16),
    fecha_emision timestamp with time zone,
    fecha_recepcion date,
    carril integer,
    estatus_rec character(1),
    estatus_guia character(1),
    romana_llena character(1),
    fecha_pel timestamp with time zone,
    peso01_liq real,
    peso02_liq real,
    tolva integer,
    fecha_des timestamp with time zone,
    romana_vac integer,
    fecha_venta timestamp with time zone,
    peso01_ven real,
    peso02_ven real,
    humedad real,
    impuresa real,
    humedad_des real,
    impuresa_des real,
    creado timestamp with time zone,
    modificado timestamp without time zone
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo';


--
-- Name: si_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_id_seq OWNER TO admin;

--
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 1, true);


--
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
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint DEFAULT nextval('si_silos_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_almacen bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    coordenada character varying(255),
    codigo integer NOT NULL,
    capacidad integer DEFAULT 0,
    observacion character varying(255),
    estatus character(1) DEFAULT 1 NOT NULL,
    modulo character(2),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_silos OWNER TO admin;

--
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- Name: si_tolcarom_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_tolcarom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_tolcarom_id_seq OWNER TO admin;

--
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- Name: si_tolcarom; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_tolcarom (
    id bigint DEFAULT nextval('si_tolcarom_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    numero integer DEFAULT 0 NOT NULL,
    tipo character(1),
    estatus boolean DEFAULT true,
    creado timestamp with time zone,
    modificiado timestamp with time zone
);


ALTER TABLE public.si_tolcarom OWNER TO admin;

--
-- Name: si_transporte; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_transporte (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    rif character(16),
    nombre character varying(255),
    contacto character varying(255),
    direccion character varying(255),
    telefono1 character(16),
    telefono2 character(16),
    fax character(16),
    email character varying(255),
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL
);


ALTER TABLE public.si_transporte OWNER TO admin;

--
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- Name: si_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_transporte_id_seq OWNER TO admin;

--
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
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
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- Name: si_usuarios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios (
    id bigint DEFAULT nextval('si_usuarios_id_seq'::regclass) NOT NULL,
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
    estatus boolean DEFAULT true NOT NULL,
    conectado smallint DEFAULT 0 NOT NULL,
    sesion character varying(255),
    ultimo_acceso timestamp with time zone
);


ALTER TABLE public.si_usuarios OWNER TO admin;

--
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
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- Name: si_usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios_perfiles (
    id bigint DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass) NOT NULL,
    id_usuario bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_perfil bigint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_usuarios_perfiles OWNER TO admin;

--
-- Name: si_vehiculos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_vehiculos (
    id bigint NOT NULL,
    placa character(16) NOT NULL,
    marca character varying(32),
    color character varying(16),
    capacidad real,
    tara_aprox real,
    chuto boolean
);


ALTER TABLE public.si_vehiculos OWNER TO admin;

--
-- Name: si_vehiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_vehiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_vehiculos_id_seq OWNER TO admin;

--
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (8, 8, 'ALMACEN - SILOS', NULL, 1, 12, 137, NULL, NULL, NULL, true, NULL, '2012-02-19 15:35:00.454', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (9, 9, 'ALMACEN - SILOS', NULL, 1, 18, 229, NULL, NULL, NULL, true, NULL, '2012-02-19 15:39:25.17', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (7, 7, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-19 15:26:29', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (6, 6, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:25:07.74788', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (5, 5, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:12:33.325252', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (4, 4, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:06:27.331621', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (3, 3, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:05:32.030751', NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (1, 1, 'TODOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, NULL, NULL, 1, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (10, 2, 'HERRAMIENTAS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-19 20:29:24.769', NULL, 2, '2');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (11, 2, 'PRODUCTOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-20 11:06:41.92', NULL, 2, '3');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '2');


--
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (3, 1, 'GRANOS CON GERMEN DANADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (4, 1, 'GRANOS DANADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (5, 1, 'GRANOS DANADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (6, 1, 'GRANOS DANADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (7, 1, 'GRANOS DANADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (15, 1, 'GRANO PARTIDO PEQUENO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (16, 1, 'AFLATOXINA', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (17, 1, 'ASPECTO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (18, 1, 'OLOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '21');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (19, 1, 'COLOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '22');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (20, 1, 'LIMPIEZA', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '23');
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo) VALUES (21, 1, 'INSECTOS VIVOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24');


--
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, min_rec, max_rec, min_des, max_des, reduccion_rec, reduccion_des, estatus) VALUES (1, 1, 1, 'C', 0, 0, 0, 0, 0, 0, true);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, min_rec, max_rec, min_des, max_des, reduccion_rec, reduccion_des, estatus) VALUES (1, 2, 1, 'C', 0, 0, 0, 0, 0, 0, true);


--
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('fd14117a0fa30c38c7', '2012-02-22 11:27:43.735437-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:26;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:84:"ERROR:  el valor null para la columna «id_programa» viola la restricción not null";s:5:"query";s:209:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''COS6'', ''COSECHA 6'', ''1'', null, null, null, null, null, ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-22 11:27:43";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('c297d7a186dad9c8bd', '2012-02-22 11:36:20.305538-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:26;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:84:"ERROR:  el valor null para la columna «id_programa» viola la restricción not null";s:5:"query";s:225:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''AKLSD'', ''AKLSDJAS'', ''1'', null, null, ''22-02-2012'', ''24-05-2012'', null, ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-22 11:36:20";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('cd5ace240347c35c50', '2012-02-23 13:12:14.414756-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:24;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «nombre» viola la restricción not null";s:5:"query";s:203:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''012012'', null, ''1'', null, null, null, null, ''2'', ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-23 01:12:14";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('7d72db40107670511e', '2012-02-23 16:32:26.285782-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:56:"/var/www/sigesi_agropatria/ajax/cosecha_programa.php<br>";s:4:"line";i:21;s:5:"class";s:9:"Recepcion";s:8:"function";s:14:"recepcionesDia";s:11:"mysql_error";s:186:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_centro_acopio = "" AND id_cosecha =...
                                                 ^";s:5:"query";s:163:"SELECT COUNT(*) AS total<br />
                FROM si_recepcion<br />
                WHERE id_centro_acopio = '''' AND id_cosecha = ''2'' AND fecha_recepcion = now()";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-23 04:32:26";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:11;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('4b06905c18ac3475cd', '2012-02-23 16:34:50.860537-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:56:"/var/www/sigesi_agropatria/ajax/cosecha_programa.php<br>";s:4:"line";i:21;s:5:"class";s:9:"Recepcion";s:8:"function";s:14:"recepcionesDia";s:11:"mysql_error";s:186:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_centro_acopio = "" AND id_cosecha =...
                                                 ^";s:5:"query";s:168:"SELECT COUNT(*) AS total<br />
                FROM si_recepcion<br />
                WHERE id_centro_acopio = '''' AND id_cosecha = ''2idCA='' AND fecha_recepcion = now()";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-23 04:34:50";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:11;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (7, 2, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (9, 2, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (8, 2, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (3, 2, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (4, 2, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (5, 2, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (6, 2, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (2, 2, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-02-19 15:03:36.599-04:30');


--
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201201');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (3, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201202');


--
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (2, 1, '2               ', 'ARROZ BLANCO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:30.631661-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (3, 1, '3               ', 'SORGO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:49.981169-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (4, 1, '4               ', 'SOYA HÚMEDA NACIONAL', false, NULL, '2012-02-18 15:23:05.361573-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (7, 1, '7               ', 'ARROZ BLANCO TOTAL', false, NULL, '2012-02-18 15:26:43.873325-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (5, 1, '5               ', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:23:20.129438-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (6, 1, '6               ', 'MAÍZ BLANCO SECO NACIONAL', false, NULL, '2012-02-18 15:23:55.551313-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (8, 1, '8               ', 'ARROZ PADDY ACONDICIONADO', false, NULL, '2012-02-18 15:27:07.455848-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (9, 1, '9               ', 'TOMATE NACIONAL', false, NULL, '2012-02-18 15:28:36.609786-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (1, 1, '1               ', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:10.224543-04:30', '2012-02-22 09:02:31.725667-04:30');


--
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_estado (id, id_pais, nombre) VALUES (1, 1, 'Distrito Capital');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (2, 1, 'Amazonas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (3, 1, 'Anzoategui');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (4, 1, 'Apure');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (5, 1, 'Aragua');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (6, 1, 'Barinas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (7, 1, 'Bolivar');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (8, 1, 'Carabobo');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (9, 1, 'Cojedes');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (10, 1, 'Delta Amacuro');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (11, 1, 'Falcon');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (12, 1, 'Guarico');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (13, 1, 'Lara');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (14, 1, 'Merida');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (15, 1, 'Miranda');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (16, 1, 'Monagas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (17, 1, 'Nueva Esparta');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (18, 1, 'Portuguesa');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (19, 1, 'Sucre');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (20, 1, 'Tachira');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (21, 1, 'Trujillo');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (22, 1, 'Vargas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (23, 1, 'Yaracuy');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (24, 1, 'Zulia');


--
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_guiasrec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (38, '2012-02-21', 202, 1, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''5f0dg3t1f4vma97eirjpggh0m5''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (39, '2012-02-21', 102, 1, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''5f0dg3t1f4vma97eirjpggh0m5'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (40, '2012-02-21', 101, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5f0dg3t1f4vma97eirjpggh0m5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5f0dg3t1f4vma97eirjpggh0m5'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (41, '2012-02-21', 201, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_programa', 'No data', 'numero = ''1''<br />nombre =  ''PRIMER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (numero, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''1'', ''PRIMER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (42, '2012-02-21', 201, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_cosecha', 'No data', 'nombre = ''1ERA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''1ERA COSECHA'', ''1'', null, null, null, null, ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (43, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (44, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (45, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (46, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (47, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (48, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (49, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (50, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (51, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (52, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (53, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (54, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (55, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (56, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''dicn64qmp89t4g5l8gjhfss6f3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''dicn64qmp89t4g5l8gjhfss6f3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (57, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''dicn64qmp89t4g5l8gjhfss6f3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (58, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''dicn64qmp89t4g5l8gjhfss6f3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (59, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (60, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (61, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (62, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (63, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (64, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (65, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (66, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cultivo', 'No data', 'id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now()', 'UPDATE si_cultivo SET  id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (67, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cultivo', 'No data', 'id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍZ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now()', 'UPDATE si_cultivo SET  id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍZ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (68, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''n9lo312ik4dc25a8bi9ea9anu2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (69, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''n9lo312ik4dc25a8bi9ea9anu2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (70, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (71, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (73, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (74, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (75, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (76, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (77, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (78, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (79, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (80, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (81, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (82, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (83, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (84, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (85, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (86, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (87, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (88, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (89, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (90, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (91, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (92, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (93, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (94, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (95, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (96, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (97, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (98, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (99, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (102, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (103, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (104, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (105, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (106, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (107, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jsilvA''', 'Login Incorrect=jsilvA');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (108, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jSilvA''', 'Login Incorrect=jSilvA');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (109, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (110, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (111, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (112, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jpeluzzo''', 'Login Incorrect=jpeluzzo');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (113, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (114, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (115, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (116, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (117, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (118, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (119, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (120, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'numero = ''2''<br />nombre =  ''SEGUNDO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (numero, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''2'', ''SEGUNDO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (121, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''1''<br />nombre =  ''COSECHA N1''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''4''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''1'', ''COSECHA N1'', ''1'', null, null, null, null, ''4'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (122, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PRO3''<br />nombre =  ''TERCER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PRO3'', ''TERCER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (123, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''3''<br />nombre =  ''TERCERA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''5''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''3'', ''TERCERA COSECHA'', ''1'', null, null, null, null, ''5'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (124, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''4TO''<br />nombre =  ''CUARTO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''4TO'', ''CUARTO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (125, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''C1''<br />nombre =  ''COS1''<br />id_cultivo =  ''2''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''6''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''C1'', ''COS1'', ''2'', null, null, null, null, ''6'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (126, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''C2''<br />nombre =  ''COS2''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''6''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''C2'', ''COS2'', ''3'', null, null, null, null, ''6'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (127, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''5TO''<br />nombre =  ''QUINTO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''5TO'', ''QUINTO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (128, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO1''<br />nombre =  ''COS1''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO1'', ''COS1'', ''3'', null, null, null, null, ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (129, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO2''<br />nombre =  ''COS2''<br />id_cultivo =  ''5''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO2'', ''COS2'', ''5'', null, null, null, null, ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (130, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO3''<br />nombre =  ''COS3''<br />id_cultivo =  ''9''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''22-02-2012''<br />fecha_fin =  ''31-05-2012''<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO3'', ''COS3'', ''9'', null, null, ''22-02-2012'', ''31-05-2012'', ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (132, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (133, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (134, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (135, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (136, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (137, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (138, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (139, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (140, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (141, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (143, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''AKLSJDAS''<br />nombre =  ''ASKDJASLKD''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''AKLSJDAS'', ''ASKDJASLKD'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (144, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''ASDASD''<br />nombre =  ''ASDASD''<br />id_cultivo =  ''4''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''22-02-2012''<br />fecha_fin =  ''22-04-2012''<br />id_programa =  ''10''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''ASDASD'', ''ASDASD'', ''4'', null, null, ''22-02-2012'', ''22-04-2012'', ''10'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (145, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''ASLKDJASD''<br />nombre =  ''ASDASD''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''10''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''ASLKDJASD'', ''ASDASD'', ''3'', null, null, null, null, ''10'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (146, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (147, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (148, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (149, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (150, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (151, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (152, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (153, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (154, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (155, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (156, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (157, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (158, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (159, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (160, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (161, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (162, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (163, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (164, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (165, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (166, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (167, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (168, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (169, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '911igj8tj63pl5r18ghah9lqj2', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (170, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (171, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (172, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (173, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '911igj8tj63pl5r18ghah9lqj2', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (174, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (175, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (176, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (177, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (178, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (179, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (180, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (181, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (182, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (183, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''1bh788d9itn4emslv6qhiebnq5''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (184, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''1bh788d9itn4emslv6qhiebnq5'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (185, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (186, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (187, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''9rpgatihnkm0c9ud670jevtlf1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''9rpgatihnkm0c9ud670jevtlf1'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (188, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''9rpgatihnkm0c9ud670jevtlf1''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (189, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''9rpgatihnkm0c9ud670jevtlf1'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (190, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (191, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (192, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (193, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (194, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (195, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (196, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (197, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (198, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (199, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (200, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (222, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (201, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (202, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (203, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (204, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (205, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (206, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (207, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (208, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (209, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (210, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (211, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (223, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (212, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_almacenes', 'No data', 'id = ''2'', codigo = ''2'', nombre = ''ALMACEN - SILOS'', direccion = null, id_pais = ''1'', telefono = null, fax = null, email = null, estatus = ''T'', coordenadas_utm = null, id_centro_acopio = ''2'', id_estado = ''18'', id_municipio = ''227'', id_tipo_almacen = ''2'', modificado=now()', 'UPDATE si_almacenes SET  id = ''2'', codigo = ''2'', nombre = ''ALMACEN - SILOS'', direccion = null, id_pais = ''1'', telefono = null, fax = null, email = null, estatus = ''T'', coordenadas_utm = null, id_centro_acopio = ''2'', id_estado = ''18'', id_municipio = ''227'', id_tipo_almacen = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (213, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (214, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (215, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (216, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (218, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PR1''<br />nombre =  ''PRIMER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PR1'', ''PRIMER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (219, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''012012''<br />nombre =  null<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''2''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''012012'', null, ''1'', null, null, null, null, ''2'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (220, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''022012''<br />nombre =  null<br />id_cultivo =  ''2''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''2''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''022012'', null, ''2'', null, null, null, null, ''2'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (221, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (224, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (225, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (226, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (227, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '2rm0ac1q4vn6lqvo290m1ish65', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 18.0.996.0<br />Engine: AppleWebKit v: 535.15</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''2rm0ac1q4vn6lqvo290m1ish65''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''2rm0ac1q4vn6lqvo290m1ish65'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (228, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (229, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (230, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '8h1ur4m9775blsrhfgoe3gimb5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8h1ur4m9775blsrhfgoe3gimb5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8h1ur4m9775blsrhfgoe3gimb5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (231, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (232, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (233, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (234, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (235, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (236, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (237, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (238, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (239, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (240, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (241, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (242, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (243, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (244, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (245, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (246, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_centro_acopio', 'No data', 'estatus = ''f''', 'UPDATE si_centro_acopio SET estatus = ''f'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (247, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_centro_acopio', 'No data', 'estatus = ''t''', 'UPDATE si_centro_acopio SET estatus = ''t'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (248, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (249, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (250, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (251, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (252, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (253, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (254, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');


--
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (3, 'Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (5, 'Cuenta', 0, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (6, 'Centros de Acopio', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (12, 'Despacho', 2, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (13, 'Programas', 3, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (14, 'Cosecha', 3, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (15, 'Cultivos', 3, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (16, 'Productores', 3, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (17, 'Recepciones', 3, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (18, 'Despacho', 3, NULL, true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (19, 'Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (20, 'Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (21, 'Formulas', 4, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (22, 'Configuracion', 4, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (23, 'Config. Cuenta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (24, 'Organizaciones', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (4, 'Ctrol de Procesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (1, 'Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (2, 'Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (25, 'Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (9, 'Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (7, 'Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (10, 'Productor', 1, 'admin/productor_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (26, 'Menu - Usuario', 4, 'admin/menu_usuario.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (11, 'Recepci&oacute;n', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (8, 'Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (27, 'Analisis Recepci&oacute;n', 2, 'admin/analisis_recepcion.php', true, 3, NULL, NULL);


--
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (1, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (3, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (4, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (5, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (24, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (6, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (7, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (8, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (9, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (13, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (14, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (15, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (16, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (17, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (18, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (19, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (20, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (21, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (22, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (23, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (1, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (7, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (8, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (9, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (10, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (25, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (25, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (26, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (2, 3);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (27, 3);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (2, 4);
INSERT INTO si_menu_usuario (id_menu, id_usuario) VALUES (11, 4);


--
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_municipio (id, id_estado, nombre) VALUES (1, 1, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (2, 2, 'Alto Orinoco         ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (3, 2, 'Atabapo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (4, 2, 'Atures');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (5, 2, 'Autana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (6, 2, 'Manapiare');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (7, 2, 'Maroa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (8, 2, 'Rio Negro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (9, 3, 'Anaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (10, 3, 'Aragua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (11, 3, 'Bolivar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (12, 3, 'Bruzual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (13, 3, 'Cajigal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (14, 3, 'Carvajal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (15, 3, 'Diego Bautista Urbaneja');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (16, 3, 'Freites');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (17, 3, 'Guanipa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (18, 3, 'Guanta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (19, 3, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (20, 3, 'Libertad');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (21, 3, 'McGregor');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (22, 3, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (23, 3, 'Monagas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (24, 3, 'Penalver');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (25, 3, 'Piritu');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (26, 3, 'San Juan de Capistrano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (27, 3, 'Santa Ana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (28, 3, 'Simon Rodriguez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (29, 3, 'Sotillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (30, 4, 'Achaguas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (31, 4, 'Biruaca');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (32, 4, 'Munoz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (33, 4, 'Paez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (34, 4, 'Pedro Camejo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (35, 4, 'Romulo Gallegos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (36, 4, 'San Fernando');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (37, 5, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (38, 5, 'Camatagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (39, 5, 'Francisco Linares Alcántara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (40, 5, 'Girardot');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (41, 5, 'José Angel Lamas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (42, 5, 'José Félix Ribas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (43, 5, 'José Rafael Revenga');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (44, 5, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (45, 5, 'Mario Briceño Iragorry');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (46, 5, 'Ocumare de la Costa de Oro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (47, 5, 'San Casimiro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (48, 5, 'San Sebastián');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (49, 5, 'Santiago Mariño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (50, 5, 'Santos Michelena');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (51, 5, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (52, 5, 'Tovar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (53, 5, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (54, 5, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (55, 6, 'Alberto Arvelo Torrealba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (56, 6, 'Andrés Eloy Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (57, 6, 'Antonio José de Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (58, 6, 'Arismendi');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (59, 6, 'Barinas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (60, 6, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (61, 6, 'Cruz Paredes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (62, 6, 'Ezequiel Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (63, 6, 'Obispos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (64, 6, 'Pedraza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (65, 6, 'Rojas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (66, 6, 'Sosa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (67, 7, 'Caroní');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (68, 7, 'Cedeño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (69, 7, 'El Callao');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (70, 7, 'Gran Sabana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (71, 7, 'Heres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (72, 7, 'Piar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (73, 7, 'Raúl Leoni');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (74, 7, 'Roscio');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (75, 7, 'Sifontes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (76, 7, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (77, 7, 'Padre Pedro Chien');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (78, 8, 'Bejuma');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (79, 8, 'Carlos Arvelo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (80, 8, 'Diego Ibarra');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (81, 8, 'Guacara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (82, 8, 'Juan José Mora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (83, 8, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (84, 8, 'Los Guayos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (85, 8, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (86, 8, 'Montalbán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (87, 8, 'Naguanagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (88, 8, 'Puerto Cabello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (89, 8, 'San Diego');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (90, 8, 'San Joaquín');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (91, 8, 'Valencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (92, 9, 'Anzoátegui');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (93, 9, 'Falcón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (94, 9, 'Girardot');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (95, 9, 'Lima Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (96, 9, 'Pao de San Juan Bautista');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (97, 9, 'Ricaurte');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (98, 9, 'Rómulo Gallegos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (99, 9, 'San Carlos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (100, 9, 'Tinaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (101, 10, 'Antonio Díaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (102, 10, 'Casacoima');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (103, 10, 'Pedernales');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (104, 10, 'Tucupita');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (105, 10, 'Antonio Diaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (106, 10, 'Casacoima');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (107, 10, 'Pedernales');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (108, 10, 'Tucupita');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (109, 11, 'Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (110, 11, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (111, 11, 'Buchivacoa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (112, 11, 'Cacique Manaure');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (113, 11, 'Carirubana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (114, 11, 'Colina');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (115, 11, 'Dabajuro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (116, 11, 'Democracia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (117, 11, 'Falcón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (118, 11, 'Federación');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (119, 11, 'Jacura');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (120, 11, 'Los Taques');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (121, 11, 'Mauroa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (122, 11, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (123, 11, 'Monseñor Iturriza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (124, 11, 'Palmasola');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (125, 11, 'Petit');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (126, 11, 'Píritu');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (127, 11, 'San Francisco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (128, 11, 'Silva');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (129, 11, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (130, 11, 'Tocópero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (131, 11, 'Unión');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (132, 11, 'Urumaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (133, 11, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (134, 12, 'Camaguán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (135, 12, 'Chaguaramas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (136, 12, 'El Socorro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (137, 12, 'Sebastian Francisco de Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (138, 12, 'José Félix Ribas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (139, 12, 'José Tadeo Monagas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (140, 12, 'Juan Germán Roscio');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (141, 12, 'Julián Mellado');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (142, 12, 'Las Mercedes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (143, 12, 'Leonardo Infante');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (144, 12, 'Pedro Zaraza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (145, 12, 'Ortiz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (146, 12, 'San Gerónimo de Guayabal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (147, 12, 'San José de Guaribe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (148, 12, 'Santa María de Ipire');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (149, 13, 'Andrés Eloy Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (150, 13, 'Crespo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (151, 13, 'Iribarren');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (152, 13, 'Jiménez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (153, 13, 'Morán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (154, 13, 'Palavecino');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (213, 16, 'Sotillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (214, 16, 'Uracoa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (215, 17, 'Antolín del Campo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (216, 17, 'Arismendi ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (217, 17, 'Díaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (218, 17, 'García');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (219, 17, 'Gómez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (220, 17, 'Maneiro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (221, 17, 'Marcano ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (222, 17, 'Mariño ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (223, 17, 'Península de Macanao ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (224, 17, 'Tubores ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (225, 17, 'Villalba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (226, 18, 'Agua Blanca');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (227, 18, 'Araure ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (228, 18, 'Esteller ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (229, 18, 'Guanare ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (230, 18, 'Guanarito');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (231, 18, 'Monseñor José Vicente de Unda ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (232, 18, 'Ospino ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (233, 18, 'Páez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (234, 18, 'Papelón ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (235, 18, 'San Genaro de Boconoíto');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (236, 18, 'San Rafael de Onoto');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (237, 18, 'Santa Rosalía ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (238, 18, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (239, 18, 'Turén');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (240, 19, 'Andrés Eloy Blanco ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (241, 19, 'Andrés Mata');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (242, 19, 'Arismendi ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (243, 19, 'Benítez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (244, 19, 'Bermúdez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (245, 19, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (246, 19, 'Cajigal ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (247, 19, 'Cruz Salmerón Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (248, 19, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (249, 19, 'Mariño ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (250, 19, 'Mejía ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (251, 19, 'Montes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (252, 19, 'Ribero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (253, 19, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (254, 19, 'Valdez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (255, 20, 'Andrés Bello ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (256, 20, 'Antonio Rómulo Costa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (257, 20, 'Ayacucho ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (258, 20, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (259, 20, 'Cárdenas ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (260, 20, 'Córdoba (Santa Ana de Táchira)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (261, 20, 'Fernández Feo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (262, 20, 'Francisco de Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (156, 13, 'Torres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (157, 13, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (158, 14, 'Alberto Adriani');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (159, 14, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (160, 14, 'Antonio Pinto Salinas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (161, 14, 'Aricagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (162, 14, 'Arzobispo Chacón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (163, 14, 'Campo Elías');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (164, 14, 'Caracciolo Parra Olmedo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (165, 14, 'Cardenal Quintero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (166, 14, 'Guaraque');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (167, 14, 'Julio César Salas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (168, 14, 'Justo Briceño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (169, 14, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (170, 14, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (171, 14, 'Obispo Ramos de Lora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (172, 14, 'Padre Noguera');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (173, 14, 'Pueblo Llano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (174, 14, 'Rangel');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (175, 14, 'Rivas Dávila');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (176, 14, 'Santos Marquina');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (177, 14, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (178, 14, 'Tovar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (179, 14, 'Tulio Febres Cordero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (180, 14, 'Zea');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (181, 15, 'Acevedo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (182, 15, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (183, 15, 'Baruta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (184, 15, 'Brión');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (185, 15, 'Buroz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (186, 15, 'Carrizal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (187, 15, 'Chacao');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (188, 15, 'Cristóbal Rojas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (189, 15, 'El Hatillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (190, 15, 'Guaicaipuro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (191, 15, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (192, 15, 'Lander');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (193, 15, 'Los Salias');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (194, 15, 'Páez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (195, 15, 'Paz Castillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (196, 15, 'Pedro Gual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (197, 15, 'Plaza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (198, 15, 'Simón Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (199, 15, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (200, 15, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (201, 15, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (202, 16, 'Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (203, 16, 'Aguasay');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (204, 16, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (205, 16, 'Caripe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (206, 16, 'Cedeño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (207, 16, 'Ezequiel Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (208, 16, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (209, 16, 'Maturín');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (210, 16, 'Piar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (211, 16, 'Punceres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (212, 16, 'Santa Bárbara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (263, 20, 'García de Hevia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (264, 20, 'Guásimos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (265, 20, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (266, 20, 'Jáuregui ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (267, 20, 'José María Vargas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (268, 20, 'Junín ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (269, 20, 'Libertad (Capacho Viejo)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (270, 20, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (271, 20, 'Lobatera ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (272, 20, 'Michelena');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (273, 20, 'Panamericano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (274, 20, 'Pedro María Ureña');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (275, 20, 'Rafael Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (276, 20, 'Samuel Darío Maldonado');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (277, 20, 'San Cristóbal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (278, 20, 'Seboruco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (279, 20, 'Simón Rodríguez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (280, 20, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (281, 20, 'Torbes ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (282, 20, 'Uribante');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (283, 20, 'San Judas Tadeo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (284, 21, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (285, 21, 'Boconó');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (286, 21, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (287, 21, 'Candelaria');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (288, 21, 'Carache');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (289, 21, 'Escuque');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (290, 21, 'José Felipe Márquez Cañizalez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (291, 21, 'Juan Vicente Campos Elías');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (292, 21, 'La Ceiba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (293, 21, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (294, 21, 'Monte Carmelo ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (295, 21, 'Motatán ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (296, 21, 'Pampán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (297, 21, 'Pampanito ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (298, 21, 'Rafael Rangel');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (299, 21, 'San Rafael de Carvajal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (300, 21, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (301, 21, 'Trujillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (302, 21, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (303, 21, 'Valera');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (304, 22, 'Vargas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (305, 23, 'Arístides Bastidas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (306, 23, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (307, 23, 'Bruzual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (308, 23, 'Cocorote');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (309, 23, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (310, 23, 'José Antonio Páez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (311, 23, 'La Trinidad');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (312, 23, 'Manuel Monge');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (313, 23, 'Nirgua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (314, 23, 'Peña');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (315, 23, 'San Felipe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (316, 23, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (317, 23, 'Urachiche');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (318, 23, 'Veroes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (319, 24, 'Almirante Padilla');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (320, 24, 'Baralt');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (321, 24, 'Cabimas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (322, 24, 'Catatumbo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (323, 24, 'Colón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (324, 24, 'Francisco Javier Pulgar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (325, 24, 'Jesús Enrique Losada ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (326, 24, 'Jesús María Semprún ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (327, 24, 'Cañada de Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (328, 24, 'Lagunillas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (329, 24, 'Machiques de Perijá');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (330, 24, 'Mara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (331, 24, 'Maracaibo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (332, 24, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (333, 24, 'Páez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (334, 24, 'Rosario de Perijá');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (335, 24, 'San Francisco ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (336, 24, 'Santa Rita ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (337, 24, 'Simón Bolívar ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (338, 24, 'Sucre ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (339, 24, 'Valmore Rodríguez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (155, 13, 'Simón Planas');


--
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (2, 'AGROPATRIA', NULL, 'J13769431', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-02-19 14:51:33.417-04:30', true, 'AGR');
INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'TODOS', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 1, 1, '2012-02-12 00:00:00-04:30', '2012-02-19 14:45:27.722-04:30', true, 'TOD');


--
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'Venezuela');


--
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17', NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17', NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20', NULL);


--
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (1, 'GERENTE GENERAL', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (2, 'GERENTE', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (3, 'ADMINISTRADOR', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (4, 'CALIDAD', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (5, 'ROMANERO', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (6, 'RECEPCION', '2012-02-07', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (7, 'DESPACHO', '2012-02-07', NULL);


--
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor (id, id_org, id_sap, cod_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (1, 1, '01              ', 'V013769341      ', 'V0137693417     ', 'JUAN TABORDA', '04269333866', 'N/A', 'tabordajuan@gmail.com', 'C  ', 'V  ', 'MARACAY', 1, 2, 1, 'NORTE', true, '                ', 'N/A', 'MARACAY         ', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '2011-02-22 00:00:00-04:30', '2011-02-22 00:00:00-04:30');


--
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo) VALUES (2, 2, 'PRIMER PROGRAMA', NULL, '2012-02-23 13:13:17.94223-04:30', NULL, true, 'PR1');


--
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_chofer, id_usuario, numero, contrato, fecha_emision, fecha_recepcion, carril, estatus_rec, estatus_guia, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impuresa, humedad_des, impuresa_des, creado, modificado) VALUES (1, 2, 2, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, '2012-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (7, 3, 3, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.047308-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (8, 3, 3, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.064005-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (29, 4, 4, 'SILO 13', 'MODULO A', 13, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.548043-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (53, 5, 5, 'SILO 13', 'MODULO A', 13, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.541914-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (30, 4, 4, 'SILO 14', 'MODULO A', 14, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.565593-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (54, 5, 5, 'SILO 14', 'MODULO A', 14, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.561376-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (77, 8, 8, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.481-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (76, 8, 8, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.478-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (75, 8, 8, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.46-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (83, 9, 9, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.175-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (84, 9, 9, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.182-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (85, 9, 9, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.185-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (17, 4, 4, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.348165-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (41, 5, 5, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.341886-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (18, 4, 4, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.365003-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (42, 5, 5, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.358622-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (62, 6, 6, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.781128-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (3, 2, 2, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.147421-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (74, 7, 7, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:27:55-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (9, 3, 3, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.080546-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (19, 4, 4, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.381487-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (43, 5, 5, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.375377-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (63, 6, 6, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.797725-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (10, 3, 3, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.097424-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (20, 4, 4, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.39829-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (44, 5, 5, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.39185-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (64, 6, 6, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.814551-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (5, 2, 2, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.180896-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (11, 3, 3, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.114005-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (21, 4, 4, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.414956-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (45, 5, 5, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.408492-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (65, 6, 6, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.831087-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (6, 2, 2, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.197353-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (12, 3, 3, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.130658-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (22, 4, 4, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.431423-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (46, 5, 5, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.425069-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (66, 6, 6, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.847859-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (13, 3, 3, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.147097-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (23, 4, 4, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.448256-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (47, 5, 5, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.442001-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (67, 6, 6, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.864434-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (14, 3, 3, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.164022-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (24, 4, 4, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.464898-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (48, 5, 5, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.458509-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (68, 6, 6, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.880988-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (15, 3, 3, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.180592-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (25, 4, 4, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.481472-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (49, 5, 5, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.475215-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (69, 6, 6, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.897561-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (16, 3, 3, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.197159-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (26, 4, 4, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.498121-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (50, 5, 5, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.491855-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (70, 6, 6, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.914479-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (27, 4, 4, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.514982-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (51, 5, 5, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.508602-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (71, 6, 6, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.931073-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (28, 4, 4, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.531417-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (52, 5, 5, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.525128-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (72, 6, 6, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.947754-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (31, 4, 4, 'SILO 15', 'MODULO A', 15, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.585406-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (55, 5, 5, 'SILO 15', 'MODULO A', 15, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.575171-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (32, 4, 4, 'SILO 16', 'MODULO A', 16, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.598079-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (56, 5, 5, 'SILO 16', 'MODULO A', 16, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.59178-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (33, 4, 4, 'SILO 17', 'MODULO A', 17, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.614882-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (57, 5, 5, 'SILO 17', 'MODULO A', 17, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.60849-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (34, 4, 4, 'SILO 18', 'MODULO A', 18, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.631368-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (58, 5, 5, 'SILO 18', 'MODULO A', 18, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.625125-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (35, 4, 4, 'SILO 19', 'MODULO A', 19, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.64816-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (59, 5, 5, 'SILO 19', 'MODULO A', 19, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.64196-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (36, 4, 4, 'SILO 20', 'MODULO A', 20, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.664683-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (60, 5, 5, 'SILO 20', 'MODULO A', 20, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.658508-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (37, 4, 4, 'SILO 21', 'MODULO A', 21, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.681424-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (38, 4, 4, 'SILO 22', 'MODULO A', 22, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.698087-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (39, 4, 4, 'SILO 23', 'MODULO A', 23, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.714699-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (40, 4, 4, 'SILO 24', 'MODULO A', 24, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.731507-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (61, 6, 6, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.764398-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (73, 7, 7, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:27:38-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (4, 2, 2, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.164032-04:30', NULL);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) VALUES (2, 2, 2, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.130888-04:30', '2012-02-19 19:46:46.671-04:30');


--
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12', NULL, true, 1, 'kli5vtsln4vne4gk0j11ok3kr7', '2012-02-23 13:56:20.722241-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ                      ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 1, '4fvkt2dqh61g5vbcvohspinqk3', '2012-02-23 16:35:06.43074-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA                          ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesussilva@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 0, NULL, '2012-02-23 16:13:22.630331-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'juantaborda@agropatria.co.ve', '2012-02-13', '2012-02-17', true, 1, '8h1ur4m9775blsrhfgoe3gimb5', '2012-02-23 13:51:36.837066-04:30');


--
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 4, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 6, '2012-02-13 16:15:23.105604-04:30', NULL);


--
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- Name: si_recepcion_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey1 PRIMARY KEY (id);


--
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_guia_rec_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_guia_rec_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- Name: si_guia_rec_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

