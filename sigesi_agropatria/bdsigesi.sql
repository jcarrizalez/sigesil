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
    id bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_centro_acopio bigint NOT NULL
);


ALTER TABLE public.si_analisis_centro_acopio OWNER TO admin;

--
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_centro_acopio_id_seq OWNER TO admin;

--
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


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
    estatus boolean,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_cultivo_id_seq OWNER TO admin;

--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 2, true);


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
    estatus boolean DEFAULT true,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_des OWNER TO admin;

--
-- Name: si_analisis_des_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_des_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_des_id_seq OWNER TO admin;

--
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- Name: si_analisis_resultado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_resultado (
    id bigint NOT NULL,
    id_recepcion bigint,
    id_despacho bigint,
    id_analisis bigint NOT NULL,
    id_usuario bigint NOT NULL,
    observacion character varying(255),
    muestra1 character(16),
    muestra2 character(16),
    muestra3 character(16)
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_resultado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_resultado_id_seq OWNER TO admin;

--
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 18, true);


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

SELECT pg_catalog.setval('si_asociado_id_seq', 6, true);


--
-- Name: si_asociado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_asociado (
    id bigint DEFAULT nextval('si_asociado_id_seq'::regclass) NOT NULL,
    id_productor bigint NOT NULL,
    ced_rif character(16) NOT NULL,
    nombre character varying(255) NOT NULL,
    direccion character varying(255),
    telefono character varying(255),
    celular character varying(255),
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    estatus boolean,
    direccion_finca character varying(255),
    area_finca integer,
    ton_cosecha real,
    creado timestamp with time zone,
    modificado timestamp with time zone
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

SELECT pg_catalog.setval('si_cosecha_id_seq', 4, true);


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
    modificado timestamp with time zone,
    id bigint NOT NULL
);


ALTER TABLE public.si_cosecha_productor OWNER TO admin;

--
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_productor_id_seq OWNER TO admin;

--
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;


--
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 4, true);


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

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción';


--
-- Name: si_despacho_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_despacho_id_seq OWNER TO admin;

--
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);


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
-- Name: si_guiarec; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiarec (
    id bigint NOT NULL,
    id_agencia bigint,
    id_cultivo bigint,
    id_usuario bigint NOT NULL,
    numero_guia integer NOT NULL,
    kilogramos real DEFAULT 0.0 NOT NULL,
    placa_remolque character(16),
    placa_vehiculo character(16),
    cedula_chofer character(16) NOT NULL,
    fecha_emision timestamp with time zone NOT NULL,
    estatus character(2) DEFAULT 1,
    cedula_asociado character(16),
    contrato character varying(16),
    nombre_chofer character(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- Name: si_guiarec_det; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiarec_det (
    id bigint NOT NULL,
    id_guiarec bigint NOT NULL,
    id_rec bigint NOT NULL,
    subguia character(16),
    fecha timestamp with time zone,
    descripcion character varying(255)
);


ALTER TABLE public.si_guiarec_det OWNER TO admin;

--
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_det_id_seq OWNER TO admin;

--
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 1, false);


--
-- Name: si_guiarec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_id_seq OWNER TO admin;

--
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 16, true);


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

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 419, true);


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
    id_usuario bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_menu_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_menu_usuario_id_seq OWNER TO admin;

--
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;


--
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_usuario_id_seq', 32, true);


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

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


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

SELECT pg_catalog.setval('si_productor_id_seq', 14, true);


--
-- Name: si_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_productor (
    id bigint DEFAULT nextval('si_productor_id_seq'::regclass) NOT NULL,
    id_org bigint,
    id_sap character(16),
    ced_rif character(16) NOT NULL,
    cod_ref character(16),
    nombre character varying(255) NOT NULL,
    telefono character varying(32),
    fax character varying(32),
    email character varying(255),
    edo_civil character(3),
    nacionalidad character(3),
    direccion character varying(255),
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
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

SELECT pg_catalog.setval('si_programa_id_seq', 3, true);


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
-- Name: si_proveedor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_proveedor_id_seq OWNER TO admin;

--
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


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
    id_asociado bigint,
    id_guia bigint NOT NULL,
    id_usuario bigint NOT NULL,
    numero integer NOT NULL,
    fecha_recepcion timestamp with time zone,
    carril integer,
    estatus_rec character(1),
    romana_llena integer,
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
    impureza real,
    humedad_des real,
    impureza_des real,
    creado timestamp with time zone,
    modificado timestamp without time zone,
    cant_muestras smallint DEFAULT 1 NOT NULL,
    id_vehiculo bigint NOT NULL
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo
Estatus=''T''=>Transito
Estatus=''A''=>Activo
Estatus=''C''=>Curentena';


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

SELECT pg_catalog.setval('si_recepcion_id_seq', 8, true);


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
    chuto boolean,
    placa_remolques character(16),
    creado timestamp with time zone,
    modificado timestamp with time zone
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

SELECT pg_catalog.setval('si_vehiculos_id_seq', 8, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);


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

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


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

INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, min_rec, max_rec, min_des, max_des, reduccion_rec, reduccion_des, estatus, id) VALUES (1, 1, 1, 'C', 0, 0, 0, 0, 0, 0, true, 1);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, min_rec, max_rec, min_des, max_des, reduccion_rec, reduccion_des, estatus, id) VALUES (1, 2, 1, 'C', 0, 0, 0, 0, 0, 0, true, 2);


--
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, observacion, muestra1, muestra2, muestra3) VALUES (13, 4, NULL, 1, 3, NULL, '77              ', '0               ', '0               ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, observacion, muestra1, muestra2, muestra3) VALUES (14, 4, NULL, 2, 3, NULL, '99              ', '0               ', '0               ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, observacion, muestra1, muestra2, muestra3) VALUES (17, 6, NULL, 1, 3, NULL, '4               ', '6               ', '7               ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, observacion, muestra1, muestra2, muestra3) VALUES (18, 6, NULL, 2, 3, NULL, '5               ', '0               ', '1               ');


--
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('b9cb062f1d095df587', '2012-02-27 07:56:45.310681-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 07:56:45";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('bec43c27e79396ee31', '2012-02-27 07:59:27.12415-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 07:59:27";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('95c10ff495f5b72ff3', '2012-02-27 08:03:33.629411-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:03:33";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('00a73d024ef9e70af1', '2012-02-27 08:05:17.158226-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:77;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:05:17";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('d908f9d28967c42b58', '2012-02-27 08:06:30.726666-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:06:30";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('467549abcebeaa30d5', '2012-02-27 08:07:57.347577-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:07:57";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('361053801bba911f24', '2012-02-27 08:15:08.368579-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:11;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:179:"ERROR:  no existe la columna a.id_cultivo
LINE 8: ...                 WHERE "1" AND a.id_org = "1" AND a.id_culti...
                                                             ^";s:5:"query";s:397:"select <br />
                    a.id,<br />
                    ac.id_cultivo, <br />
                    a.codigo,<br />
                    a.nombre <br />
                    from si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND a.id_cultivo = ''1'' ORDER BY a.id";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-27 08:15:08";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:18;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('b56bb9d72575f2d56c', '2012-02-27 08:23:24.227169-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:15;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"listadoAnalisis";s:11:"mysql_error";s:185:"ERROR:  no existe la columna rec.estatus_guia
LINE 24: ... o.id = "1" AND cul.id = "1" AND rec.id = "1" AND rec.estatu...
                                                              ^";s:5:"query";s:1224:"select  o.id as id_org,<br />
                    o.nombre as nombre_org,<br />
                    ca.id as id_ca,<br />
                    ca.codigo as codigo_ca, <br />
                    ca.nombre as nombre_ca,<br />
                    cul.id as id_cultivo,<br />
                    cul.codigo as codigo_cul,<br />
                    cul.nombre as nombre_cul,  <br />
                    rec.id as id_rec,<br />
                    rec.numero,<br />
                    rec.estatus_rec,<br />
                    rec.fecha_recepcion,<br />
                    rec.cant_muestras,<br />
                    rec.carril <br />
                    from si_recepcion rec <br />
                    inner join si_centro_acopio ca<br />
                    on rec.id_centro_acopio=ca.id <br />
                    inner join si_cosecha cos<br />
                    on cos.id=rec.id_cosecha	<br />
                    inner join si_cultivo cul<br />
                    on cul.id=cos.id_cultivo <br />
                    inner join si_organizacion o<br />
                    on o.id=ca.id_org <br />
                    WHERE ''1'' AND o.id = ''1'' AND cul.id = ''1'' AND rec.id = ''1'' AND rec.estatus_guia = ''A'' ORDER BY rec.id";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-27 08:23:24";}i:1;a:4:{s:4:"file";s:76:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:47;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('ef54a32d1849e20c94', '2012-02-27 10:36:33.820202-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:33;s:5:"class";s:8:"Analisis";s:8:"function";s:17:"guardarResultados";s:11:"mysql_error";s:207:"ERROR:  la sintaxis de entrada no es válida para tipo real: «»
LINE 1: ...a1, muestra2, muestra3) VALUES ("2", "1", "3", "2", "4", "")
                                                                    ^";s:5:"query";s:140:"INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''2'', ''4'', '''')";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-27 10:36:35";}i:1;a:4:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis.class.php<br>";s:4:"line";i:16;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('e8c6b3ebf481ed020d', '2012-02-27 13:28:21.172024-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:58:"/var/www/sigesi_agropatria/admin/productor_listado.php<br>";s:4:"line";i:9;s:5:"class";s:9:"Productor";s:8:"function";s:18:"listadoProductores";s:11:"mysql_error";s:185:"ERROR:  no existe la columna p.id_centro_acopio
LINE 4: ...        INNER JOIN si_centro_acopio ca ON ca.id = p.id_centr...
                                                             ^";s:5:"query";s:275:"SELECT p.id,p.*,<br />
                    ca.nombre AS nombre_ca<br />
                    FROM si_productor p<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = p.id_centro_acopio<br />
                    WHERE ''1'' AND p.id_centro_acopio = 2 ORDER BY p.id";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-27 01:28:22";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/productor.class.php<br>";s:4:"line";i:15;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('c9f8693865ce9e0e6e', '2012-02-27 14:09:21.138266-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:180:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_cosecha = "" AND id_centro_acopio =...
                                           ^";s:5:"query";s:205:"SELECT *<br />
                FROM si_cosecha_productor<br />
                WHERE id_cosecha = '''' AND id_centro_acopio = ''2'' AND id_productor = ''V963852'' AND asociado = ''t''<br />
                LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:09:21";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:80;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('0e3bacf7f0a97e7990', '2012-02-27 14:11:53.031781-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE cp.id_cosecha = "" AND cp.id_centr...
                                                  ^";s:5:"query";s:310:"SELECT cp.*<br />
                    FROM si_cosecha_productor cp<br />
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor<br />
                    WHERE cp.id_cosecha = '''' AND cp.id_centro_acopio = ''2'' AND pr.ced_rif = ''V963852'' AND cp.asociado = ''t''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:11:53";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:81;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('169b05d1d04f83da98', '2012-02-27 14:21:15.326769-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE cp.id_cosecha = "" AND cp.id_centr...
                                                  ^";s:5:"query";s:310:"SELECT cp.*<br />
                    FROM si_cosecha_productor cp<br />
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor<br />
                    WHERE cp.id_cosecha = '''' AND cp.id_centro_acopio = ''2'' AND pr.ced_rif = ''V963852'' AND cp.asociado = ''t''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:21:15";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:81;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) VALUES (1, 1, 'V013769341      ', 'JUAN TABORDA', 'MARACAY', '0243-271-55-30', '0426-933-38-66', 1, 1, 1, true, 'MARACAY', 100, 0, NULL, NULL);
INSERT INTO si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) VALUES (3, 6, 'V17247200       ', 'HIGUERA ENDER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-26 23:38:13.54-04:30', NULL);
INSERT INTO si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) VALUES (6, 11, 'V147258         ', 'AJSDHASJD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 13:45:32.972295-04:30', NULL);


--
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (2, 1, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-02-19 15:03:36.599-04:30');
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (3, 1, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (4, 1, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (5, 1, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (6, 1, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (7, 1, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (8, 1, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (9, 1, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', NULL);


--
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201201');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (3, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201202');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (4, 3, 3, 'SEGUNDA COSECHA', NULL, NULL, NULL, '2012-02-27', '2012-09-28', true, '2012-02-27 13:32:56.323501-04:30', NULL, '201203');


--
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 11, true, NULL, NULL, 1);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 12, false, NULL, NULL, 2);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (4, 2, 13, false, NULL, NULL, 3);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 14, false, NULL, NULL, 4);


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

INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (1, NULL, NULL, 4, 123, 123123, NULL, NULL, 'V3213123        ', '2012-02-26 00:00:00-04:30', 'A ', NULL, NULL, 'SDASDA                                                                                                                                                                                                                                                         ', '2012-02-26 22:43:45.108-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (5, NULL, NULL, 4, 123123123, 12312312, NULL, NULL, 'V3213123        ', '2012-02-26 00:00:00-04:30', 'A ', NULL, NULL, 'AQSDASD                                                                                                                                                                                                                                                        ', '2012-02-26 22:53:46.518-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (8, NULL, NULL, 4, 7292, 180000, NULL, NULL, 'V12345678       ', '2012-02-24 00:00:00-04:30', 'A ', NULL, NULL, 'CARLOS PEREZ                                                                                                                                                                                                                                                   ', '2012-02-26 23:38:13.54-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (9, NULL, NULL, 4, 7985, 180000, NULL, NULL, 'V18654321       ', '2012-02-27 00:00:00-04:30', 'A ', NULL, NULL, 'CARLOS GUZMAN                                                                                                                                                                                                                                                  ', '2012-02-27 07:52:25.579036-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (10, NULL, NULL, 4, 1, 15000, NULL, NULL, 'V10112322       ', '2012-02-20 00:00:00-04:30', 'A ', NULL, NULL, 'EVARISTO CAMPOS                                                                                                                                                                                                                                                ', '2012-02-27 10:16:55.886293-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (13, NULL, NULL, 4, 741852, 185000, NULL, NULL, 'V8975632        ', '2012-02-27 00:00:00-04:30', 'A ', NULL, NULL, 'KASJDASKLDJ                                                                                                                                                                                                                                                    ', '2012-02-27 13:45:32.972295-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (14, NULL, NULL, 4, 96513210, 123123, NULL, NULL, 'V56324123       ', '2012-02-27 00:00:00-04:30', 'A ', NULL, NULL, 'ASDASD                                                                                                                                                                                                                                                         ', '2012-02-27 13:47:09.336061-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (15, NULL, NULL, 4, 67, 100000, NULL, NULL, 'V9668397        ', '2012-02-27 00:00:00-04:30', 'A ', NULL, NULL, 'JESUS SILVA                                                                                                                                                                                                                                                    ', '2012-02-27 15:21:33.411056-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (16, NULL, NULL, 4, 3123123, 1854564, NULL, NULL, 'V54987652       ', '2012-02-27 00:00:00-04:30', 'A ', NULL, NULL, 'ASDASD                                                                                                                                                                                                                                                         ', '2012-02-27 15:43:41.034812-04:30', NULL);


--
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
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

INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (320, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (321, '2012-02-27', 202, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (322, '2012-02-27', 102, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (323, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (324, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''g25p34affrq63onj9negruph33''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (325, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''g25p34affrq63onj9negruph33'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (326, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', 'cilek7efdfsef4digtg68futj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''cilek7efdfsef4digtg68futj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''cilek7efdfsef4digtg68futj6'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (327, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (328, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''7985''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''180000''<br />cedula_chofer =  ''V18654321''<br />nombre_chofer =  ''CARLOS GUZMAN''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''7985'', ''27-02-2012'', null, ''180000'', ''V18654321'', ''CARLOS GUZMAN'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (329, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''12456789''<br />nombre =  ''PEDRO PEREZ''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''12456789'', ''PEDRO PEREZ'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (330, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  null<br />placa_remolques =  ''123-ASD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', null, ''123-ASD'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (331, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''7''<br />id_guia =  ''9''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, creado) VALUES  (''1'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''7'', ''9'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (332, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (333, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (334, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (335, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (336, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (337, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (338, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (339, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (340, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (341, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (342, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (343, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''1''<br />fecha_emision =  ''20-02-2012''<br />contrato =  null<br />kilogramos =  ''15000''<br />cedula_chofer =  ''V10112322''<br />nombre_chofer =  ''EVARISTO CAMPOS''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''1'', ''20-02-2012'', null, ''15000'', ''V10112322'', ''EVARISTO CAMPOS'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (344, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V11980123''<br />nombre =  ''JOSE PELUZZO''<br />telefono =  ''0414''<br />email =  ''JOSEPELUZZO@AGROPATRIA.O.VE''<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V11980123'', ''JOSE PELUZZO'', ''0414'', ''JOSEPELUZZO@AGROPATRIA.O.VE'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (345, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''AA22DD3''<br />marca =  ''MACK''<br />placa_remolques =  ''AA11DD44''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''AA22DD3'', ''MACK'', ''AA11DD44'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (346, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''8''<br />id_guia =  ''10''<br />id_vehiculo =  ''4''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''2'', ''2'', ''27-02-2012'', ''1'', ''1'', ''4'', ''A'', ''2'', ''2'', ''8'', ''10'', ''4'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (347, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (348, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (349, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (350, '2012-02-27', 202, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (351, '2012-02-27', 102, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (352, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (353, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (354, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (355, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (356, '2012-02-27', 202, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''908j1ud3vfdfi1a8om140steg7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (357, '2012-02-27', 102, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''908j1ud3vfdfi1a8om140steg7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (358, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (359, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (360, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (361, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (362, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''908j1ud3vfdfi1a8om140steg7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (363, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''908j1ud3vfdfi1a8om140steg7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (364, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (371, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (372, '2012-02-27', 101, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''v0k2k4udo8khrtnn2bu6usn525''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''v0k2k4udo8khrtnn2bu6usn525'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (373, '2012-02-27', 201, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PR2''<br />nombre =  ''SEGUNDO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PR2'', ''SEGUNDO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (374, '2012-02-27', 201, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''201201''<br />nombre =  ''SEGUNDA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''27-02-2012''<br />fecha_fin =  ''28-09-2012''<br />id_programa =  ''3''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''201201'', ''SEGUNDA COSECHA'', ''1'', null, null, ''27-02-2012'', ''28-09-2012'', ''3'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (375, '2012-02-27', 202, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''v0k2k4udo8khrtnn2bu6usn525''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (376, '2012-02-27', 102, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''v0k2k4udo8khrtnn2bu6usn525'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (377, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (378, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''741852''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''185000''<br />cedula_chofer =  ''V8975632''<br />nombre_chofer =  ''KASJDASKLDJ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''741852'', ''27-02-2012'', null, ''185000'', ''V8975632'', ''KASJDASKLDJ'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (379, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V963852''<br />nombre =  ''KALSJDKALSD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V963852'', ''KALSJDKALSD'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (380, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_asociado', 'No data', 'ced_rif = ''V147258''<br />nombre =  ''AJSDHASJD''<br />telefono =  null<br />id_productor =  ''11''<br />creado = now()<br />', 'INSERT INTO si_asociado  (ced_rif, nombre, telefono, id_productor, creado) VALUES  (''V147258'', ''AJSDHASJD'', null, ''11'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (381, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''11''<br />asociado =  ''t''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''11'', ''t'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (382, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''DLSDAHD''<br />marca =  null<br />placa_remolques =  ''ASDHASKJD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''DLSDAHD'', null, ''ASDHASKJD'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (383, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''3''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''11''<br />id_guia =  ''13''<br />id_vehiculo =  ''5''<br />id_asociado =  ''6''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, id_asociado, creado) VALUES  (''3'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''11'', ''13'', ''5'', ''6'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (384, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''96513210''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''123123''<br />cedula_chofer =  ''V56324123''<br />nombre_chofer =  ''ASDASD''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''96513210'', ''27-02-2012'', null, ''123123'', ''V56324123'', ''ASDASD'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (385, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V89724165''<br />nombre =  ''ASDASD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V89724165'', ''ASDASD'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (386, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''12''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''12'', ''f'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (387, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASDASD''<br />marca =  null<br />placa_remolques =  ''ASDASD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASDASD'', null, ''ASDASD'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (388, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''4''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''3''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''12''<br />id_guia =  ''14''<br />id_vehiculo =  ''6''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''4'', ''2'', ''27-02-2012'', ''1'', ''3'', ''4'', ''A'', ''2'', ''2'', ''12'', ''14'', ''6'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (389, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (390, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (391, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (392, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''66''<br />muestra2 =  ''66''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''66'', ''66'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (393, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''66''<br />muestra2 =  ''66''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''66'', ''66'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (394, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''33''<br />muestra2 =  ''22''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''33'', ''22'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (395, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''99''<br />muestra2 =  ''11''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''2'', ''3'', ''99'', ''11'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (398, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''1''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''2'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (399, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''7''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''2'', ''3'', ''5'', ''7'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (402, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''77''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''77'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (403, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''99''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''2'', ''3'', ''99'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (406, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''4''<br />muestra2 =  ''6''<br />muestra3 =  ''7''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''1'', ''3'', ''4'', ''6'', ''7'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (407, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''0''<br />muestra3 =  ''1''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''2'', ''3'', ''5'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (408, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (409, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (410, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''67''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''100000''<br />cedula_chofer =  ''V9668397''<br />nombre_chofer =  ''JESUS SILVA''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''67'', ''27-02-2012'', null, ''100000'', ''V9668397'', ''JESUS SILVA'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (411, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V9668397''<br />nombre =  ''JESUS SILVA''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V9668397'', ''JESUS SILVA'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (412, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''4''<br />id_centro_acopio =  ''2''<br />id_productor =  ''13''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''4'', ''2'', ''13'', ''f'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (413, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''MCX 452''<br />marca =  ''CHEVROLET''<br />placa_remolques =  ''DAB 828''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''MCX 452'', ''CHEVROLET'', ''DAB 828'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (414, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''4''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''13''<br />id_guia =  ''15''<br />id_vehiculo =  ''7''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''1'', ''4'', ''27-02-2012'', ''1'', ''2'', ''4'', ''1'', ''2'', ''2'', ''13'', ''15'', ''7'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (415, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''3123123''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''1854564''<br />cedula_chofer =  ''V54987652''<br />nombre_chofer =  ''ASDASD''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''3123123'', ''27-02-2012'', null, ''1854564'', ''V54987652'', ''ASDASD'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (416, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V213123123''<br />nombre =  ''ASDASDASD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V213123123'', ''ASDASDASD'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (417, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''14''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''14'', ''f'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (418, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASDASDAS''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASDASDAS'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (419, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''5''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''14''<br />id_guia =  ''16''<br />id_vehiculo =  ''8''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''5'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''14'', ''16'', ''8'',now())', '');


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
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (27, 'Analisis Recepci&oacute;n', 2, 'admin/analisis_recepcion_listado.php?estatus=1', true, 3, NULL, NULL);


--
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (1, 1, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (3, 1, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (4, 1, 3);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (5, 1, 4);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (24, 1, 5);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (6, 1, 6);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (7, 1, 7);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (8, 1, 8);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (9, 1, 9);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (13, 1, 10);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (14, 1, 11);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (15, 1, 12);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (16, 1, 13);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (17, 1, 14);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (18, 1, 15);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (19, 1, 16);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (20, 1, 17);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (21, 1, 18);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (22, 1, 19);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (23, 1, 20);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (1, 2, 21);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (7, 2, 22);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (8, 2, 23);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (9, 2, 24);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (10, 2, 25);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (25, 1, 26);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (25, 2, 27);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (26, 1, 28);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (2, 3, 29);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (27, 3, 30);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (2, 4, 31);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (11, 4, 32);


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

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-02-19 14:45:27.722-04:30', true, 'AGR');


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

INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (1, 1, '01              ', 'V123            ', 'V123            ', 'JUAN TABORDA', '04269333866', 'N/A', 'tabordajuan@gmail.com', 'C  ', 'V  ', 'MARACAY', 1, 2, 1, 'NORTE', true, '                ', 'N/A', 'MARACAY         ', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '2011-02-22 00:00:00-04:30', '2011-02-22 00:00:00-04:30');
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (3, NULL, NULL, 'V2312312        ', NULL, 'ASDASD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-26 22:53:46.518-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (6, NULL, NULL, 'V18264065       ', NULL, 'JESUS RODRIGUEZ', '04162440414', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-26 23:38:13.54-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (7, NULL, NULL, 'V12456789       ', NULL, 'PEDRO PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 07:52:25.579036-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (8, NULL, NULL, 'V11980123       ', NULL, 'JOSE PELUZZO', '0414', NULL, 'JOSEPELUZZO@AGROPATRIA.O.VE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 10:16:55.886293-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (11, NULL, NULL, 'V963852         ', NULL, 'KALSJDKALSD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 13:45:32.972295-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (12, NULL, NULL, 'V89724165       ', NULL, 'ASDASD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 13:47:09.336061-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (13, NULL, NULL, 'V9668397        ', NULL, 'JESUS SILVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 15:21:33.411056-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (14, NULL, NULL, 'V213123123      ', NULL, 'ASDASDASD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 15:43:41.034812-04:30', NULL);


--
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo) VALUES (2, 2, 'PRIMER PROGRAMA', NULL, '2012-02-23 13:13:17.94223-04:30', NULL, true, 'PR1');
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo) VALUES (3, 2, 'SEGUNDO PROGRAMA', NULL, '2012-02-27 13:32:56.323501-04:30', NULL, true, 'PR2');


--
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (1, 2, 2, 2, 3, NULL, 5, 4, 1, '2012-02-26 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-26 22:53:46.518-04:30', NULL, 2, 1);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (2, 2, 2, 2, 6, 3, 8, 4, 2, '2012-02-26 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-26 23:38:13.54-04:30', NULL, 2, 2);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (3, 2, 2, 2, 7, NULL, 9, 4, 1, '2012-02-27 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 07:52:25.579036-04:30', NULL, 2, 3);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (4, 2, 2, 2, 8, NULL, 10, 4, 2, '2012-02-27 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 10:16:55.886293-04:30', NULL, 1, 4);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (5, 2, 2, 2, 11, 6, 13, 4, 3, '2012-02-27 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 13:45:32.972295-04:30', NULL, 2, 5);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (6, 2, 2, 2, 12, NULL, 14, 4, 4, '2012-02-27 00:00:00-04:30', 1, '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 13:47:09.336061-04:30', NULL, 3, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (7, 2, 4, 2, 13, NULL, 15, 4, 1, '2012-02-27 00:00:00-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 15:21:33.411056-04:30', NULL, 2, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (8, 2, 2, 2, 14, NULL, 16, 4, 5, '2012-02-27 00:00:00-04:30', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 15:43:41.034812-04:30', NULL, 2, 8);


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

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12', NULL, true, 0, NULL, '2012-02-27 11:28:48.717992-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA                          ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesussilva@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 0, NULL, '2012-02-27 13:28:15.147699-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'juantaborda@agropatria.co.ve', '2012-02-13', '2012-02-17', true, 1, '95apbrbn2fk35jqd3ag09eo363', '2012-02-27 14:06:11.488087-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ                      ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 1, 'g25p34affrq63onj9negruph33', '2012-02-27 15:17:48.230523-04:30');


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

INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (1, 'DASDASD         ', NULL, NULL, NULL, NULL, NULL, 'ASDASD          ', '2012-02-26 22:53:46.518-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (2, 'XKZ-158         ', NULL, NULL, NULL, NULL, NULL, '123-456         ', '2012-02-26 23:38:13.54-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (3, 'ASD-ASD         ', NULL, NULL, NULL, NULL, NULL, '123-ASD         ', '2012-02-27 07:52:25.579036-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (4, 'AA22DD3         ', 'MACK', NULL, NULL, NULL, NULL, 'AA11DD44        ', '2012-02-27 10:16:55.886293-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (5, 'DLSDAHD         ', NULL, NULL, NULL, NULL, NULL, 'ASDHASKJD       ', '2012-02-27 13:45:32.972295-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (6, 'ASDASD          ', NULL, NULL, NULL, NULL, NULL, 'ASDASD          ', '2012-02-27 13:47:09.336061-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (7, 'MCX 452         ', 'CHEVROLET', NULL, NULL, NULL, NULL, 'DAB 828         ', '2012-02-27 15:21:33.411056-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (8, 'ASDASDAS        ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-27 15:43:41.034812-04:30', NULL);


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
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


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
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


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
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


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
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


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
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


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
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


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
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_asociado_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_asociado_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_asociado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_asociado_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


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
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


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
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- Name: si_despacho_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


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
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


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
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


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
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_recepcion_id_asociado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);


--
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


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
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


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

