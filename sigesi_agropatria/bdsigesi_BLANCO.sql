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
-- Name: sp_ascii(character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION sp_ascii(character varying) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT TRANSLATE
($1,
'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ',
'aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC');
$_$;


ALTER FUNCTION public.sp_ascii(character varying) OWNER TO admin;

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

SELECT pg_catalog.setval('si_almacenes_id_seq', 9, true);


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

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


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
    codigo character varying(16) NOT NULL,
    formula boolean DEFAULT false
);


ALTER TABLE public.si_analisis OWNER TO admin;

--
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


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
    reduccion_rec numeric(10,3) DEFAULT 0,
    reduccion_des numeric(10,3) DEFAULT 0,
    estatus character(1),
    id bigint NOT NULL,
    min_rec numeric(16,3) DEFAULT 0.0,
    max_rec numeric(16,3) DEFAULT 0.0,
    min_des numeric(16,3) DEFAULT 0.0,
    max_des numeric(16,3) DEFAULT 0.0,
    id_centro_acopio bigint NOT NULL
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_analisis_cultivo_id_seq OWNER TO admin;

--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 0, true);


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
    muestra1 character varying(16),
    muestra2 character varying(16),
    muestra3 character varying(16),
    id_centro_acopio bigint NOT NULL,
    tipo_mov character varying(2) NOT NULL
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_analisis_resultado_id_seq OWNER TO admin;

--
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 0, true);


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
-- Name: si_choferes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_choferes (
    id bigint NOT NULL,
    id_org bigint,
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    ced_rif character varying(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    celular character varying(32),
    telefono character varying(32),
    direccion character varying(255),
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_choferes OWNER TO admin;

--
-- Name: si_choferes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_choferes_id_seq OWNER TO admin;

--
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 0, true);


--
-- Name: si_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cliente_id_seq OWNER TO admin;

--
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 0, true);


--
-- Name: si_cliente; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cliente (
    id bigint DEFAULT nextval('si_cliente_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_sap character(16),
    ced_rif character varying(16) NOT NULL,
    ref character(16),
    nombre character varying(32) NOT NULL,
    telefono character varying(32),
    fax character varying(32),
    email_org character varying(255),
    edo_civil character(3),
    contacto1_nombre character varying(32),
    contacto1_telefono character varying(32),
    contacto1_email character varying(255),
    contacto2_nombre character varying(32),
    contacto2_telefono character varying(32),
    contacto2_email character varying(255),
    contacto3_nombre character varying(32),
    contacto3_telefono character varying(32),
    contacto3_email character varying(255),
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    direccion character varying(255),
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cosecha_id_seq OWNER TO admin;

--
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 0, true);


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
    id_asociacion bigint,
    id_asociado bigint,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cosecha_productor OWNER TO admin;

--
-- Name: si_cosecha_silo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha_silo (
    id bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_silo bigint NOT NULL,
    id_cultivo bigint NOT NULL
);


ALTER TABLE public.si_cosecha_silo OWNER TO admin;

--
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cosecha_silo_id_seq OWNER TO admin;

--
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 0, true);


--
-- Name: si_cuarentena; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cuarentena (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_recepcion bigint,
    id_usuario bigint NOT NULL,
    tipo_mov character(2) NOT NULL,
    fecha_mov timestamp with time zone,
    fecha_cultivo timestamp with time zone,
    grado_infestacion integer,
    laboratorio character(2),
    id_producto bigint,
    toneladas real,
    cant_producto integer,
    id_plaga bigint,
    hora_trab character(10),
    fecha_lib timestamp with time zone,
    hora_lib character(10),
    estatus character(1),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    observa_admon character varying(100),
    observa_lab character varying(100)
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- Name: TABLE si_cuarentena; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cuarentena IS 'Tabla de Control de Cuarentenas
Estatus
1.- LabCentral
2.- Ctna
3.- Romana Lleno
4.- Tolvas
5.- Ctna Tolva
6.- Romana Vacio
7.- Rechazo Central
8.- Rechazo Planta
9.- Acondicionado';


--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cuarentena_id_seq OWNER TO admin;

--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 0, true);


--
-- Name: si_cuarentena_plaga; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cuarentena_plaga (
    id bigint NOT NULL,
    id_cuarentena bigint NOT NULL,
    id_plaga bigint NOT NULL,
    cantidad integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cuarentena_plaga OWNER TO admin;

--
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cuarentena_plaga_id_seq OWNER TO admin;

--
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 0, true);


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

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint DEFAULT nextval('si_cultivo_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    tipificado boolean DEFAULT false,
    ciclo integer DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean,
    codigo bigint
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- Name: si_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo_tipo (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_analisis bigint NOT NULL,
    tipo character(2) NOT NULL,
    min numeric(10,2) DEFAULT 0.0 NOT NULL,
    max numeric(10,2) DEFAULT 0.0 NOT NULL
);


ALTER TABLE public.si_cultivo_tipo OWNER TO admin;

--
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 0, true);


--
-- Name: si_denom_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_denom_tip_id_seq OWNER TO admin;

--
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 0, true);


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
    id_cliente bigint NOT NULL,
    id_chofer bigint NOT NULL,
    id_vehiculo bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_transporte bigint NOT NULL,
    id_punto_entrega bigint NOT NULL,
    id_silo bigint NOT NULL,
    fecha_des timestamp with time zone,
    numero integer NOT NULL,
    fecha_v timestamp with time zone,
    peso_01v real,
    peso_02v real,
    fecha_pel timestamp with time zone,
    peso_01l real,
    peso_02l real,
    humedad real,
    impureza real,
    humedad_des double precision,
    impureza_des double precision,
    kac_des real,
    cant_muestras smallint DEFAULT 0,
    carril integer,
    romana_ent integer,
    romana_sal integer,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    peso_acon double precision,
    peso_acon_liq double precision,
    muestra smallint,
    humedad2 real,
    impureza2 real,
    humedad_des2 double precision,
    impureza_des2 double precision,
    peso_acon2 double precision,
    peso_acon_liq2 double precision,
    estatus smallint
);


ALTER TABLE public.si_despacho OWNER TO admin;

--
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Despacho

Estatus:
1.- Romana Vacio
2.- Laboratorio
3.- Romana Lleno
4.- Rechazado
5.- Despachado

Muestra:
0.- Todas las muestras estan aceptadas
1.- Solo la muestra (1) Motriz esta aceptada
2.- Solo la muestra (2) Remolque esta aceptada
3.- Todas las muestras estan rechazadas';


--
-- Name: si_despacho_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_despacho_id_seq OWNER TO admin;

--
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 0, true);


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

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_finca_id_seq OWNER TO admin;

--
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 0, true);


--
-- Name: si_formulas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_formulas (
    id bigint NOT NULL,
    id_org bigint,
    id_centro_acopio bigint,
    id_cultivo bigint,
    formula character varying(255) NOT NULL,
    codigo character varying(11) NOT NULL,
    id_mov bigint NOT NULL,
    tipo_for bigint NOT NULL,
    condicion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    id_analisis bigint
);


ALTER TABLE public.si_formulas OWNER TO admin;

--
-- Name: si_formulas_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_formulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_formulas_id_seq OWNER TO admin;

--
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 48, true);


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
    fecha_emision timestamp with time zone NOT NULL,
    estatus character(1) DEFAULT 1,
    cedula_asociado character(16),
    contrato character varying(16),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- Name: si_guiarec_det; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiarec_det (
    id bigint NOT NULL,
    id_guiarec bigint NOT NULL,
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_guiarec_det_id_seq OWNER TO admin;

--
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 0, true);


--
-- Name: si_guiarec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_guiarec_id_seq OWNER TO admin;

--
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 0, true);


--
-- Name: si_impresora; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_impresora (
    id bigint NOT NULL,
    id_centro_acopio bigint,
    estatus smallint,
    nombre character varying(64),
    parametros character varying(255)
);


ALTER TABLE public.si_impresora OWNER TO admin;

--
-- Name: si_impresora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_impresora_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_impresora_id_seq OWNER TO admin;

--
-- Name: si_impresora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_impresora_id_seq OWNED BY si_impresora.id;


--
-- Name: si_impresora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_impresora_id_seq', 2, true);


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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_log_consultas_log_id_seq OWNER TO admin;

--
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 0, true);


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
    centro_acopio character varying(255),
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

SELECT pg_catalog.setval('si_menu_id_seq', 45, true);


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
    nuevo smallint DEFAULT 0,
    modificar smallint DEFAULT 0,
    eliminar smallint DEFAULT 0,
    imprimir smallint DEFAULT 0
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_ordenes_id_seq OWNER TO admin;

--
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 0, true);


--
-- Name: si_ordenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ordenes (
    id bigint DEFAULT nextval('si_ordenes_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    numero_orden bigint NOT NULL,
    fecha_emision timestamp with time zone,
    numero_contrato character varying(32),
    toneladas real DEFAULT 0.0,
    descuento boolean,
    estatus character varying(1),
    id_punto_entrega bigint,
    creado timestamp with time zone,
    modificado timestamp without time zone,
    cod_verificacion character varying
);


ALTER TABLE public.si_ordenes OWNER TO admin;

--
-- Name: si_ordenes_det; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ordenes_det (
    id bigint NOT NULL,
    id_orden bigint NOT NULL,
    numero_orden character varying(16),
    fecha timestamp with time zone,
    descripcion character varying(255),
    kilogramos real
);


ALTER TABLE public.si_ordenes_det OWNER TO admin;

--
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_ordenes_det_id_seq OWNER TO admin;

--
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 0, true);


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

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- Name: si_parametros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_parametros (
    id bigint DEFAULT nextval('si_parametros_id_seq'::regclass) NOT NULL,
    parametro_llave character varying(255) NOT NULL,
    parametro_valor character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    parametro_mostrar smallint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone
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
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_perfiles OWNER TO admin;

--
-- Name: si_perfiles_menu; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_perfiles_menu (
    id bigint NOT NULL,
    id_perfil bigint,
    id_menu bigint,
    nuevo smallint DEFAULT 0 NOT NULL,
    modificar smallint DEFAULT 0 NOT NULL,
    eliminar smallint DEFAULT 0 NOT NULL,
    imprimir smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_perfiles_menu OWNER TO admin;

--
-- Name: si_perfiles_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_perfiles_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_perfiles_menu_id_seq OWNER TO admin;

--
-- Name: si_perfiles_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_perfiles_menu_id_seq OWNED BY si_perfiles_menu.id;


--
-- Name: si_perfiles_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_menu_id_seq', 52, true);


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

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- Name: si_producto; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_producto (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    codigo character(16) NOT NULL,
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

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- Name: si_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_productor_id_seq OWNER TO admin;

--
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 0, true);


--
-- Name: si_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_productor (
    id bigint DEFAULT nextval('si_productor_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_sap character varying(16),
    ced_rif character varying(16) NOT NULL,
    cod_ref character varying(16),
    nombre character varying(255) NOT NULL,
    telefono character varying(32),
    fax character varying(32),
    email character varying(255),
    edo_civil character varying(1),
    direccion character varying(255),
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    coordenadas_utm character varying(32),
    estatus boolean,
    ced_legal character varying(16),
    legal_nombre character varying(255),
    cod_ag_dir_fis character varying(16),
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_programa_id_seq OWNER TO admin;

--
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 0, true);


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
    codigo character varying(16) NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    id_cultivo bigint NOT NULL
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- Name: si_proveedor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_proveedor (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    rif character(16) NOT NULL,
    cedula character(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    telefono character varying(32) NOT NULL,
    fax character varying(32) NOT NULL,
    email_org character varying(255) NOT NULL,
    contacto_nombre character varying(32) NOT NULL,
    contacto_telefono character varying(32) NOT NULL,
    contacto_email character varying(255) NOT NULL,
    id_pais bigint NOT NULL,
    id_estado bigint NOT NULL,
    id_municipio bigint NOT NULL,
    direccion character varying(255) NOT NULL,
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_proveedor OWNER TO admin;

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
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    numero integer,
    nombre character varying(255) NOT NULL,
    telefono character(16),
    direccion character varying(255),
    estatus boolean,
    creado timestamp without time zone,
    modificado timestamp without time zone,
    id_centro_acopio bigint
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_punto_entrega_id_seq OWNER TO admin;

--
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 0, true);


--
-- Name: si_recepcion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recepcion (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_silo bigint,
    id_productor bigint NOT NULL,
    id_guia bigint NOT NULL,
    id_usuario bigint NOT NULL,
    numero integer NOT NULL,
    fecha_recepcion timestamp with time zone,
    carril integer,
    fecha_pel timestamp with time zone,
    peso_01l real,
    peso_02l real,
    tolva integer,
    fecha_v timestamp with time zone,
    peso_01v real,
    peso_02v real,
    humedad real,
    impureza real,
    humedad_des double precision,
    impureza_des double precision,
    creado timestamp with time zone,
    modificado timestamp without time zone,
    cant_muestras smallint DEFAULT 1 NOT NULL,
    id_vehiculo bigint NOT NULL,
    id_chofer bigint,
    romana_ent integer,
    romana_sal integer,
    peso_acon double precision,
    peso_acon_liq double precision,
    muestra smallint DEFAULT 0,
    estatus_rec smallint,
    id_asociacion bigint DEFAULT 0,
    id_asociado bigint DEFAULT 0
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo

Estatus:
1.- LabCentral
2.- Ctna
3.- Romana Lleno
4.- Tolvas
5.- Ctna Tolva
6.- Romana Vacio
7.- Rechazo Central
8.- Rechazo Planta
9.- Liquidado

Muestra
0.- Todas las muestras estan aceptadas
1.- Solo la muestra (1) Motriz esta rechazada
2.- Solo la muestra (2) Remolque esta rechazada
3.- Todas las muestras estan rechazadas';


--
-- Name: si_recepcion_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recepcion_cultivo_tipo (
    id bigint NOT NULL,
    id_recepcion bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    laboratorio character(2) NOT NULL,
    tipo character(2) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_recepcion_cultivo_tipo OWNER TO admin;

--
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_recepcion_cultivo_tipo_id_seq OWNER TO admin;

--
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 0, true);


--
-- Name: si_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_recepcion_id_seq OWNER TO admin;

--
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 0, true);


--
-- Name: si_recursos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recursos (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    localizacion character varying(255),
    nombre_archivo character varying(255),
    autentificacion smallint DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_recursos OWNER TO admin;

--
-- Name: si_recursos_etiquetas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recursos_etiquetas (
    id bigint NOT NULL,
    id_recurso bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    valor character varying(255) NOT NULL,
    global smallint DEFAULT 0 NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_recursos_etiquetas OWNER TO admin;

--
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recursos_etiquetas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_recursos_etiquetas_id_seq OWNER TO admin;

--
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 55, true);


--
-- Name: si_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_recursos_id_seq OWNER TO admin;

--
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 61, true);


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
    modulo character(2),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean
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

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


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
    modificiado timestamp with time zone,
    parametros character varying(30)
);


ALTER TABLE public.si_tolcarom OWNER TO admin;

--
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- Name: si_transporte; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_transporte (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    rif character(16),
    nombre character varying(255) NOT NULL,
    contacto character varying(255),
    direccion character varying(255),
    telefono1 character(16),
    telefono2 character(16),
    fax character(16),
    email character varying(255),
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    creado timestamp with time zone,
    modificado timestamp with time zone
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_transporte_id_seq OWNER TO admin;

--
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 0, true);


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

SELECT pg_catalog.setval('si_usuarios_id_seq', 10, true);


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
    usuario character varying(32) NOT NULL,
    contrasena character varying(255) NOT NULL,
    direccion character varying(255),
    telefono character varying(32),
    email character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean DEFAULT true NOT NULL,
    conectado smallint DEFAULT 0 NOT NULL,
    sesion character varying(255),
    ultimo_acceso timestamp with time zone,
    fecha_contrasena timestamp with time zone
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

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 10, true);


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
    placa character varying(16) NOT NULL,
    marca character varying(32),
    color character varying(16),
    capacidad real,
    tara_aprox real,
    chuto boolean,
    placa_remolques character varying(16),
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
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_vehiculos_id_seq OWNER TO admin;

--
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 0, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_impresora ALTER COLUMN id SET DEFAULT nextval('si_impresora_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_perfiles_menu ALTER COLUMN id SET DEFAULT nextval('si_perfiles_menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


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
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '1');


--
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (4, 1, 'GRANOS DAÑADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (5, 1, 'GRANOS DAÑADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (6, 1, 'GRANOS DAÑADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (7, 1, 'GRANOS DAÑADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (15, 1, 'GRANO PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (3, 1, 'GRANOS CON GERMEN DAÑADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2', true);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (23, 1, 'COLOR', 2, true, '2012-02-22 00:00:00-04:30', NULL, '22', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (16, 1, 'MAIZ ENTERO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '16', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (17, 1, 'MAIZ PARTIDO GRANDE', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '17', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (18, 1, 'MAIZ PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '18', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (24, 1, 'LIMPIEZA', 2, true, '2012-02-22 00:00:00-04:30', NULL, '23', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (27, 1, 'GRANOS PUNTA NEGRA', 2, true, '2012-02-22 00:00:00-04:30', NULL, '27', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (25, 1, 'GRANOS MANCHADOS', 2, true, '2012-02-22 00:00:00-04:30', NULL, '25', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (28, 1, 'GRANOS YESOSOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '28', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (29, 1, 'GRANOS PANZA BLANCA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '29', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (30, 1, 'YESOSOS + PANZA BLANCA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '30', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (32, 1, 'GRANOS VERDES', 1, true, '2012-02-22 00:00:00-04:30', NULL, '32', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (31, 1, 'GRANOS ROJOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '31', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (33, 1, 'GRANOS SIN CASCARA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '33', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (34, 1, 'ARROZ PADDY', 1, true, '2012-02-22 00:00:00-04:30', NULL, '34', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (36, 1, 'RENDIMIENTO GRANO ENTERO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '38', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (35, 1, 'SORGO ENTERO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '37', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (37, 1, 'BLANCO TOTAL', 1, true, '2012-02-22 00:00:00-04:30', NULL, '39', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (38, 1, 'TEMPERATURA DEL GRANO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '40', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (39, 1, 'MEZCLA DE COLOR EN AMARILLO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '41', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1', true);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (19, 1, 'AFLATOXINA', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (21, 1, 'ASPECTO', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (20, 1, 'INSECTOS VIVOS', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (22, 1, 'OLOR', 2, true, '2012-02-22 00:00:00-04:30', NULL, '21', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (26, 1, 'GRANOS DAÑADOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '26', false);


--
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 2, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 3, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 4, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 5, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 6, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 7, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 8, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 9, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 10, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 11, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 12, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 13, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 14, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 15, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 16, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 21, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 22, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 23, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 24, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 28, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 29, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 30, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 31, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 32, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 33, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 34, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 35, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 36, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 37, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 38, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 39, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 40, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 41, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 42, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 43, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 44, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 45, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 50, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 51, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 52, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 53, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 54, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 55, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 56, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 57, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 62, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 63, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 64, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 65, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 66, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 67, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 68, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 69, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 70, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 71, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 72, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 73, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 74, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 75, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 76, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 77, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 78, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 79, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 81, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 82, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 83, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 84, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 85, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 86, 10.000, 26.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 87, 0.000, 7.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 88, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 89, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 90, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 91, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 92, 0.000, 17.000, 0.000, 17.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 93, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 94, 0.000, 30.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 95, 0.000, 20.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 96, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 97, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 98, 715.000, 0.790, 715.000, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 99, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 100, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 101, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 102, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 104, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 105, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 106, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 107, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 108, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 109, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 110, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 111, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 112, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 113, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 114, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 116, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 117, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 118, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 119, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 120, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 121, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 122, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 123, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 124, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 125, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 126, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 127, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 128, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 129, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 130, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 131, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 132, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 133, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 135, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 136, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 137, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 138, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 139, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 140, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 141, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 142, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 143, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 144, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 145, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 146, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 147, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 148, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 149, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 150, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 151, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 152, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 153, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 154, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 155, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 156, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 157, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 158, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 159, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 160, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 161, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 162, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 163, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 164, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 165, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 166, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 167, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 168, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 170, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 171, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 172, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 173, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 174, 6.000, 24.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 175, 0.000, 20.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 176, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 178, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 179, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 180, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 181, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 184, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 185, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 186, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 187, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 188, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 189, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 190, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 191, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 192, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 193, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 194, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 195, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 196, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 197, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 198, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 199, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 201, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 202, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 203, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 204, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 206, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 207, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 208, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 209, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 210, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 211, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 212, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 213, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 214, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 215, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 216, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 217, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 218, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 219, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 220, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 221, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 223, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 224, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 225, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 226, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 227, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 228, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 229, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 230, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 231, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 232, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 233, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 234, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 235, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 236, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 237, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 238, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 239, 715.000, 0.790, 715.000, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 240, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 241, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 242, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 244, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 245, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 246, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 247, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 248, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 249, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 250, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 251, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 252, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 253, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 254, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 17, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 25, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 47, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 58, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 80, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 103, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 115, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 134, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 169, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 177, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 182, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 183, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 200, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 205, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 222, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 243, 0.000, 0.000, 0.000, 0.000, 2);


--
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
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

INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (3, 1, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (4, 1, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (5, 1, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (6, 1, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (7, 1, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (8, 1, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (2, 1, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-03-16 10:40:45.916545-04:30');
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (9, 1, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', '2012-05-03 14:24:41.877195-04:30');


--
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (2, 1, 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 2);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (3, 1, 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 3);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (4, 1, 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 4);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (5, 1, 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 5);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (6, 1, 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 6);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (7, 1, 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 7);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (8, 1, 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 8);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (9, 1, 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 9);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (10, 1, 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 10);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (11, 1, 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 11);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (12, 1, 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 12);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (13, 1, 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 13);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (14, 1, 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 14);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (15, 1, 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 15);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (16, 1, 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 16);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (17, 1, 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 17);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (18, 1, 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 68);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (19, 1, 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 92);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (20, 1, 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 93);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (21, 1, 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 94);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (22, 1, 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true, 95);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (23, 1, 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true, 96);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (24, 1, 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true, 97);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (25, 1, 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true, 98);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (26, 1, 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true, 99);
INSERT INTO si_cultivo (id, id_org, nombre, tipificado, ciclo, creado, modificado, estatus, codigo) VALUES (1, 1, 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 1);


--
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (5, 1, '6 Ejes', 48000);


--
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_estado (id, id_pais, nombre) VALUES (2, 1, 'AMAZONAS');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (3, 1, 'ANZOATEGUI');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (4, 1, 'APURE');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (5, 1, 'ARAGUA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (6, 1, 'BARINAS');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (7, 1, 'BOLIVAR');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (8, 1, 'CARABOBO');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (9, 1, 'COJEDES');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (10, 1, 'DELTA AMACURO');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (11, 1, 'FALCON');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (12, 1, 'GUARICO');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (13, 1, 'LARA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (14, 1, 'MERIDA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (15, 1, 'MIRANDA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (16, 1, 'MONAGAS');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (17, 1, 'NUEVA ESPARTA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (18, 1, 'PORTUGUESA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (19, 1, 'SUCRE');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (20, 1, 'TACHIRA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (21, 1, 'TRUJILLO');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (22, 1, 'VARGAS');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (23, 1, 'YARACUY');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (24, 1, 'ZULIA');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (1, 1, 'DISTRITO CAPITAL');


--
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (12, 1, 1, 12, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (4, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (5, 1, 1, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (1, 1, 1, NULL, '(PL1+PL2)', 'PL12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (7, 1, 1, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (8, 1, 1, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (9, 1, 1, 2, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H02', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (10, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I02', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (11, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I02', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (3, 1, 1, NULL, '((PL1+PL2)-(PV1+PV2))', 'PN', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (2, 1, 1, NULL, '(PV1+PV2)', 'PV12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (6, 1, 1, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (13, 1, 1, 12, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (14, 1, 1, 7, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (15, 1, 1, 7, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (16, 1, 1, 7, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (17, 1, 1, 7, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (18, 1, 1, 7, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (19, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I07', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (20, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I07', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (21, 1, 1, 7, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H07', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (22, 1, 1, 8, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (23, 1, 1, 8, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (24, 1, 1, 8, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (25, 1, 1, 8, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (26, 1, 1, 8, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (27, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I08', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (28, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I08', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (29, 1, 1, 8, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H08', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (30, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (32, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (34, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (36, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (38, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (40, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (42, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (44, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (31, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I01', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (35, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I06', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (39, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I015', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (37, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (41, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I017', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (43, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I03', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (45, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I04', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (33, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I05', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (46, 1, 1, 10, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (47, 1, 1, 10, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (48, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-22 00:00:00-04:30', NULL, NULL);


--
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_impresora; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_impresora (id, id_centro_acopio, estatus, nombre, parametros) VALUES (2, 2, 9, 'impresoraB', NULL);
INSERT INTO si_impresora (id, id_centro_acopio, estatus, nombre, parametros) VALUES (1, 2, 1, 'FX-890', NULL);


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



--
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (19, 'M_Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (23, 'M_ConfigCta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (24, 'M_Organizacion', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (25, 'M_Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (21, 'M_Formulas', 4, 'admin/formulacion_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (27, 'M_LabCentral', 2, 'admin/analisis_labcentral.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (28, 'M_Romana', 2, 'admin/romana_movimiento.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (31, 'M_labPlanta', 2, 'admin/analisis_labplanta.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (12, 'M_Despacho', 2, 'admin/despacho.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (18, 'M_Despacho', 3, 'reportes/reporte_despacho.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (29, 'M_Chofer', 1, 'admin/chofer_listado.php', true, 10, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (32, 'M_Ordenes', 1, 'admin/ordenes_listado.php', true, 11, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (26, 'M_MenuUsuario', 4, 'admin/menu_usuario_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (17, 'M_Recepciones', 3, 'reportes/reporte_recepcion.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (1, 'M_Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (6, 'M_CentrosA', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (34, 'M_CosechaProductor', 4, 'admin/cosecha_productor.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (35, 'M_Auditoria', 3, 'reportes/reporte_actividad.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (22, 'M_Configuracion', 4, 'admin/parametros.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (36, 'M_BoletaVirtual', 4, 'admin/boleta_virtual.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (38, 'M_CuarentenaPendiente', 2, 'admin/cuarentena_pendiente_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (39, 'M_GerenteRecepcion', 3, 'reportes/gerente_recepcion.php', true, 8, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (40, 'M_GerenteDespacho', 3, 'reportes/gerente_despacho.php', true, 9, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (42, 'M_UtilitarioRecepciones', 4, 'admin/utilitario_recepcion_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (13, 'M_Programas', 3, 'reportes/reporte_programas.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (14, 'M_Cosecha', 3, 'reportes/reporte_cosechas.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (15, 'M_Cultivo', 3, 'reportes/reporte_cultivos.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (16, 'M_Productores', 3, 'reportes/reporte_productores.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (44, 'M_UtilitarioDespachos', 4, 'admin/utilitario_despacho_listado.php', true, 8, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (5, 'M_Cuenta', 0, NULL, false, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (45, 'M_GranosVerdes', 3, 'reportes/granos_verdes.php', true, 10, NULL, NULL);


--
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 4, 7, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (40, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (42, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (5, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (23, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 10, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 10, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 10, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 10, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 10, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 10, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 10, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 10, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 10, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 9, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 9, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 9, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 9, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 9, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 8, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (42, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (44, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (24, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (6, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (40, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (45, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (40, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (45, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (21, 5, 1, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (42, 5, 0, 0, 0, 0);


--
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_municipio (id, id_estado, nombre) VALUES (1, 1, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (2, 2, 'ALTO ORINOCO         ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (3, 2, 'ATABAPO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (4, 2, 'ATURES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (5, 2, 'AUTANA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (6, 2, 'MANAPIARE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (7, 2, 'MAROA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (8, 2, 'RIO NEGRO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (9, 3, 'ANACO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (10, 3, 'ARAGUA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (11, 3, 'BOLIVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (12, 3, 'BRUZUAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (13, 3, 'CAJIGAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (14, 3, 'CARVAJAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (15, 3, 'DIEGO BAUTISTA URBANEJA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (16, 3, 'FREITES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (17, 3, 'GUANIPA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (18, 3, 'GUANTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (19, 3, 'INDEPENDENCIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (20, 3, 'LIBERTAD');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (21, 3, 'MCGREGOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (22, 3, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (23, 3, 'MONAGAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (24, 3, 'PENALVER');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (25, 3, 'PIRITU');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (26, 3, 'SAN JUAN DE CAPISTRANO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (27, 3, 'SANTA ANA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (28, 3, 'SIMON RODRIGUEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (29, 3, 'SOTILLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (30, 4, 'ACHAGUAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (31, 4, 'BIRUACA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (32, 4, 'MUNOZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (33, 4, 'PAEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (34, 4, 'PEDRO CAMEJO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (35, 4, 'ROMULO GALLEGOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (36, 4, 'SAN FERNANDO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (37, 5, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (38, 5, 'CAMATAGUA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (39, 5, 'FRANCISCO LINARES ALCÁNTARA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (40, 5, 'GIRARDOT');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (41, 5, 'JOSÉ ANGEL LAMAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (42, 5, 'JOSÉ FÉLIX RIBAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (43, 5, 'JOSÉ RAFAEL REVENGA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (44, 5, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (45, 5, 'MARIO BRICEÑO IRAGORRY');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (46, 5, 'OCUMARE DE LA COSTA DE ORO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (47, 5, 'SAN CASIMIRO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (48, 5, 'SAN SEBASTIÁN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (49, 5, 'SANTIAGO MARIÑO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (50, 5, 'SANTOS MICHELENA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (51, 5, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (52, 5, 'TOVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (53, 5, 'URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (54, 5, 'ZAMORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (55, 6, 'ALBERTO ARVELO TORREALBA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (56, 6, 'ANDRÉS ELOY BLANCO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (57, 6, 'ANTONIO JOSÉ DE SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (58, 6, 'ARISMENDI');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (59, 6, 'BARINAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (60, 6, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (61, 6, 'CRUZ PAREDES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (62, 6, 'EZEQUIEL ZAMORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (63, 6, 'OBISPOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (64, 6, 'PEDRAZA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (65, 6, 'ROJAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (66, 6, 'SOSA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (67, 7, 'CARONÍ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (68, 7, 'CEDEÑO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (69, 7, 'EL CALLAO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (70, 7, 'GRAN SABANA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (71, 7, 'HERES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (72, 7, 'PIAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (73, 7, 'RAÚL LEONI');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (74, 7, 'ROSCIO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (75, 7, 'SIFONTES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (76, 7, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (77, 7, 'PADRE PEDRO CHIEN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (78, 8, 'BEJUMA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (79, 8, 'CARLOS ARVELO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (80, 8, 'DIEGO IBARRA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (81, 8, 'GUACARA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (82, 8, 'JUAN JOSÉ MORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (83, 8, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (84, 8, 'LOS GUAYOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (85, 8, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (86, 8, 'MONTALBÁN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (87, 8, 'NAGUANAGUA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (88, 8, 'PUERTO CABELLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (89, 8, 'SAN DIEGO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (90, 8, 'SAN JOAQUÍN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (91, 8, 'VALENCIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (92, 9, 'ANZOÁTEGUI');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (93, 9, 'FALCÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (94, 9, 'GIRARDOT');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (95, 9, 'LIMA BLANCO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (96, 9, 'PAO DE SAN JUAN BAUTISTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (97, 9, 'RICAURTE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (98, 9, 'RÓMULO GALLEGOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (99, 9, 'SAN CARLOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (100, 9, 'TINACO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (101, 10, 'ANTONIO DÍAZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (102, 10, 'CASACOIMA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (103, 10, 'PEDERNALES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (104, 10, 'TUCUPITA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (105, 10, 'ANTONIO DIAZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (106, 10, 'CASACOIMA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (107, 10, 'PEDERNALES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (108, 10, 'TUCUPITA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (109, 11, 'ACOSTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (110, 11, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (111, 11, 'BUCHIVACOA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (112, 11, 'CACIQUE MANAURE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (113, 11, 'CARIRUBANA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (114, 11, 'COLINA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (115, 11, 'DABAJURO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (116, 11, 'DEMOCRACIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (117, 11, 'FALCÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (118, 11, 'FEDERACIÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (119, 11, 'JACURA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (120, 11, 'LOS TAQUES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (121, 11, 'MAUROA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (122, 11, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (123, 11, 'MONSEÑOR ITURRIZA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (124, 11, 'PALMASOLA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (125, 11, 'PETIT');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (126, 11, 'PÍRITU');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (127, 11, 'SAN FRANCISCO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (128, 11, 'SILVA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (129, 11, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (130, 11, 'TOCÓPERO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (131, 11, 'UNIÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (132, 11, 'URUMACO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (133, 11, 'ZAMORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (134, 12, 'CAMAGUÁN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (135, 12, 'CHAGUARAMAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (136, 12, 'EL SOCORRO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (137, 12, 'SEBASTIAN FRANCISCO DE MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (138, 12, 'JOSÉ FÉLIX RIBAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (139, 12, 'JOSÉ TADEO MONAGAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (140, 12, 'JUAN GERMÁN ROSCIO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (141, 12, 'JULIÁN MELLADO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (142, 12, 'LAS MERCEDES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (143, 12, 'LEONARDO INFANTE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (144, 12, 'PEDRO ZARAZA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (145, 12, 'ORTIZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (146, 12, 'SAN GERÓNIMO DE GUAYABAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (147, 12, 'SAN JOSÉ DE GUARIBE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (148, 12, 'SANTA MARÍA DE IPIRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (149, 13, 'ANDRÉS ELOY BLANCO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (150, 13, 'CRESPO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (151, 13, 'IRIBARREN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (152, 13, 'JIMÉNEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (153, 13, 'MORÁN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (154, 13, 'PALAVECINO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (213, 16, 'SOTILLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (214, 16, 'URACOA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (215, 17, 'ANTOLÍN DEL CAMPO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (216, 17, 'ARISMENDI ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (217, 17, 'DÍAZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (218, 17, 'GARCÍA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (219, 17, 'GÓMEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (220, 17, 'MANEIRO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (221, 17, 'MARCANO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (222, 17, 'MARIÑO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (223, 17, 'PENÍNSULA DE MACANAO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (224, 17, 'TUBORES ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (225, 17, 'VILLALBA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (226, 18, 'AGUA BLANCA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (227, 18, 'ARAURE ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (228, 18, 'ESTELLER ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (229, 18, 'GUANARE ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (230, 18, 'GUANARITO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (231, 18, 'MONSEÑOR JOSÉ VICENTE DE UNDA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (232, 18, 'OSPINO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (233, 18, 'PÁEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (234, 18, 'PAPELÓN ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (235, 18, 'SAN GENARO DE BOCONOÍTO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (236, 18, 'SAN RAFAEL DE ONOTO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (237, 18, 'SANTA ROSALÍA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (238, 18, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (239, 18, 'TURÉN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (240, 19, 'ANDRÉS ELOY BLANCO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (241, 19, 'ANDRÉS MATA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (242, 19, 'ARISMENDI ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (243, 19, 'BENÍTEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (244, 19, 'BERMÚDEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (245, 19, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (246, 19, 'CAJIGAL ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (247, 19, 'CRUZ SALMERÓN ACOSTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (248, 19, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (249, 19, 'MARIÑO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (250, 19, 'MEJÍA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (251, 19, 'MONTES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (252, 19, 'RIBERO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (253, 19, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (254, 19, 'VALDEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (255, 20, 'ANDRÉS BELLO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (256, 20, 'ANTONIO RÓMULO COSTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (257, 20, 'AYACUCHO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (258, 20, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (259, 20, 'CÁRDENAS ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (260, 20, 'CÓRDOBA (SANTA ANA DE TÁCHIRA)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (261, 20, 'FERNÁNDEZ FEO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (262, 20, 'FRANCISCO DE MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (156, 13, 'TORRES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (157, 13, 'URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (158, 14, 'ALBERTO ADRIANI');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (159, 14, 'ANDRÉS BELLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (160, 14, 'ANTONIO PINTO SALINAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (161, 14, 'ARICAGUA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (162, 14, 'ARZOBISPO CHACÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (163, 14, 'CAMPO ELÍAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (164, 14, 'CARACCIOLO PARRA OLMEDO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (165, 14, 'CARDENAL QUINTERO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (166, 14, 'GUARAQUE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (167, 14, 'JULIO CÉSAR SALAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (168, 14, 'JUSTO BRICEÑO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (169, 14, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (170, 14, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (171, 14, 'OBISPO RAMOS DE LORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (172, 14, 'PADRE NOGUERA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (173, 14, 'PUEBLO LLANO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (174, 14, 'RANGEL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (175, 14, 'RIVAS DÁVILA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (176, 14, 'SANTOS MARQUINA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (177, 14, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (178, 14, 'TOVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (179, 14, 'TULIO FEBRES CORDERO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (180, 14, 'ZEA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (181, 15, 'ACEVEDO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (182, 15, 'ANDRÉS BELLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (183, 15, 'BARUTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (184, 15, 'BRIÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (185, 15, 'BUROZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (186, 15, 'CARRIZAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (187, 15, 'CHACAO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (188, 15, 'CRISTÓBAL ROJAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (189, 15, 'EL HATILLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (190, 15, 'GUAICAIPURO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (191, 15, 'INDEPENDENCIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (192, 15, 'LANDER');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (193, 15, 'LOS SALIAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (194, 15, 'PÁEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (195, 15, 'PAZ CASTILLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (196, 15, 'PEDRO GUAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (197, 15, 'PLAZA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (198, 15, 'SIMÓN BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (199, 15, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (200, 15, 'URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (201, 15, 'ZAMORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (202, 16, 'ACOSTA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (203, 16, 'AGUASAY');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (204, 16, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (205, 16, 'CARIPE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (206, 16, 'CEDEÑO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (207, 16, 'EZEQUIEL ZAMORA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (208, 16, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (209, 16, 'MATURÍN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (210, 16, 'PIAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (211, 16, 'PUNCERES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (212, 16, 'SANTA BÁRBARA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (263, 20, 'GARCÍA DE HEVIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (264, 20, 'GUÁSIMOS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (265, 20, 'INDEPENDENCIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (266, 20, 'JÁUREGUI ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (267, 20, 'JOSÉ MARÍA VARGAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (268, 20, 'JUNÍN ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (269, 20, 'LIBERTAD (CAPACHO VIEJO)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (270, 20, 'LIBERTADOR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (271, 20, 'LOBATERA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (272, 20, 'MICHELENA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (273, 20, 'PANAMERICANO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (274, 20, 'PEDRO MARÍA UREÑA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (275, 20, 'RAFAEL URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (276, 20, 'SAMUEL DARÍO MALDONADO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (277, 20, 'SAN CRISTÓBAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (278, 20, 'SEBORUCO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (279, 20, 'SIMÓN RODRÍGUEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (280, 20, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (281, 20, 'TORBES ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (282, 20, 'URIBANTE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (283, 20, 'SAN JUDAS TADEO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (284, 21, 'ANDRÉS BELLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (285, 21, 'BOCONÓ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (286, 21, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (287, 21, 'CANDELARIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (288, 21, 'CARACHE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (289, 21, 'ESCUQUE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (290, 21, 'JOSÉ FELIPE MÁRQUEZ CAÑIZALEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (291, 21, 'JUAN VICENTE CAMPOS ELÍAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (292, 21, 'LA CEIBA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (293, 21, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (294, 21, 'MONTE CARMELO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (295, 21, 'MOTATÁN ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (296, 21, 'PAMPÁN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (297, 21, 'PAMPANITO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (298, 21, 'RAFAEL RANGEL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (299, 21, 'SAN RAFAEL DE CARVAJAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (300, 21, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (301, 21, 'TRUJILLO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (302, 21, 'URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (303, 21, 'VALERA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (304, 22, 'VARGAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (305, 23, 'ARÍSTIDES BASTIDAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (306, 23, 'BOLÍVAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (307, 23, 'BRUZUAL');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (308, 23, 'COCOROTE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (309, 23, 'INDEPENDENCIA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (310, 23, 'JOSÉ ANTONIO PÁEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (311, 23, 'LA TRINIDAD');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (312, 23, 'MANUEL MONGE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (313, 23, 'NIRGUA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (314, 23, 'PEÑA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (315, 23, 'SAN FELIPE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (316, 23, 'SUCRE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (317, 23, 'URACHICHE');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (318, 23, 'VEROES');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (319, 24, 'ALMIRANTE PADILLA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (320, 24, 'BARALT');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (321, 24, 'CABIMAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (322, 24, 'CATATUMBO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (323, 24, 'COLÓN');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (324, 24, 'FRANCISCO JAVIER PULGAR');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (325, 24, 'JESÚS ENRIQUE LOSADA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (326, 24, 'JESÚS MARÍA SEMPRÚN ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (327, 24, 'CAÑADA DE URDANETA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (328, 24, 'LAGUNILLAS');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (329, 24, 'MACHIQUES DE PERIJÁ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (330, 24, 'MARA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (331, 24, 'MARACAIBO');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (332, 24, 'MIRANDA');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (333, 24, 'PÁEZ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (334, 24, 'ROSARIO DE PERIJÁ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (335, 24, 'SAN FRANCISCO ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (336, 24, 'SANTA RITA ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (337, 24, 'SIMÓN BOLÍVAR ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (338, 24, 'SUCRE ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (339, 24, 'VALMORE RODRÍGUEZ ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (155, 13, 'SIMÓN PLANAS');


--
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'VENEZUELA');


--
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (6, 'PL1', 'Peso Lleno 1', 'Peso de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (7, 'PL2', 'Peso Lleno 2', 'Peso de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (8, 'PV1', 'Peso Vacio 1', 'Peso Vac&iacute;o de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (9, 'PV2', 'Peso Vacio 2', 'Peso Vac&iacute;o de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (10, 'IMPL', 'Impurezas de Laboratorio', 'Impurezas de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (11, 'HUML', 'Humedad de Laboratorio', 'Humedad de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);


--
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (1, 'GERENTE GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (3, 'ADMINISTRADOR GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (5, 'CALIDAD GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (2, 'GERENTE DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (4, 'ADMINISTRADOR DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (6, 'CALIDAD DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (7, 'USUARIO', '2012-02-07 00:00:00-04:30', NULL);


--
-- Data for Name: si_perfiles_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (1, 1, 1, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (4, 1, 3, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (5, 1, 13, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (6, 1, 14, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (7, 1, 15, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (8, 1, 16, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (11, 1, 35, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (12, 1, 39, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (13, 1, 40, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (15, 1, 4, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (19, 1, 36, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (2, 1, 24, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (3, 1, 6, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (9, 1, 17, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (10, 1, 18, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (14, 1, 45, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (16, 1, 20, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (17, 1, 22, 0, 1, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (18, 1, 26, 0, 1, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (20, 2, 1, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (21, 2, 25, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (22, 2, 9, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (23, 2, 8, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (25, 2, 10, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (24, 2, 7, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (26, 2, 29, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (27, 2, 32, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (28, 2, 2, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (29, 2, 11, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (30, 2, 12, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (31, 2, 27, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (32, 2, 38, 0, 1, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (33, 2, 31, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (34, 2, 28, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (35, 2, 3, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (36, 2, 13, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (37, 2, 14, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (38, 2, 15, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (39, 2, 16, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (40, 2, 17, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (41, 2, 18, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (42, 2, 35, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (43, 2, 39, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (44, 2, 40, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (45, 2, 45, 0, 0, 0, 1);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (46, 2, 4, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (47, 2, 20, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (48, 2, 21, 1, 1, 1, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (49, 2, 26, 0, 1, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (50, 2, 34, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (51, 2, 36, 0, 0, 0, 0);
INSERT INTO si_perfiles_menu (id, id_perfil, id_menu, nuevo, modificar, eliminar, imprimir) VALUES (52, 2, 42, 0, 0, 0, 0);


--
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (1, 1, 'SITOPHILUS ORYZAE-GRANARIUS', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (3, 1, 'TRIBOLIUM CASTANEUN', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (4, 1, 'CRYPTOLETES FERRUGINEUS', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (5, 1, 'ALPHITOBUS SURINAMESIS', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (6, 1, 'RHIZOPERTA DOMINICANA', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (7, 1, 'ORYZAPHILUS SURNAMESIS', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (8, 1, 'SITOTROGA CEREALELLA', NULL, NULL, NULL);
INSERT INTO si_plaga (id, id_org, nombre, estatus, creado, modificado) VALUES (9, 1, 'OTROS', NULL, NULL, NULL);


--
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_recursos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (1, 'Global', NULL, NULL, 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (2, 'Index', 'pages', 'index.php', 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (3, 'Analisis de Resultados', 'admin', 'analisis_resultado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (4, 'Principal', 'pages', 'principal.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (5, 'Recepcion', 'admin', 'recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (6, 'Almacen', 'admin', 'almacen.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (7, 'Listado Almacen', 'admin', 'almacen_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (8, 'Analisis Lab C', 'admin', 'analisis_labcentral.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (9, 'Analisis Lab P', 'admin', 'analisis_labplanta.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (10, 'Analisis Recepcion', 'admin', 'analisis_recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (11, 'Listado Analisis Resultado', 'admin', 'analisis_resultado_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (12, 'Listado Cargo', 'admin', 'cargo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (13, 'Cargo', 'admin', 'cargos.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (14, 'Centros de Acopio', 'admin', 'centros_acopio.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (15, 'Listado de Centros de Acopio', 'admin', 'centros_acopio_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (16, 'Chofer', 'admin', 'chofer.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (17, 'Listado de Choferes', 'admin', 'chofer_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (18, 'Popup de Clientes', 'admin', 'cliente_popup.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (19, 'Config de Parametros', 'admin', 'conf_parametros.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (20, 'Config de Usuario', 'admin', 'conf_usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (21, 'Cosecha', 'admin', 'cosecha.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (22, 'Cuarentena', 'admin', 'cuarentena.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (23, 'Cultivo', 'admin', 'cultivo.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (24, 'Listado de Cultivos', 'admin', 'cultivo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (25, 'Despacho', 'admin', 'despacho.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (26, 'Formulacion', 'admin', 'formulacion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (27, 'Listado Formulacion', 'admin', 'formulacion_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (28, 'Menu Usuario', 'admin', 'menu_usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (29, 'Menu', 'lib/common', 'menu.php', 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (30, 'Ordenes', 'admin', 'ordenes.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (31, 'Listado de Ordenes', 'admin', 'ordenes_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (32, 'Organizacion', 'admin', 'organizacion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (33, 'Listado de Organizaciones', 'admin', 'organizacion_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (34, 'Productor', 'admin', 'productor.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (35, 'Listado de Productores', 'admin', 'productor_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (36, 'Programa', 'admin', 'programa.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (37, 'Listado de Programas', 'admin', 'programa_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (38, 'Recepcion', 'admin', 'recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (39, 'Romana', 'admin', 'romana.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (40, 'Listado de Romana', 'admin', 'romana_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (41, 'Romana Movimiento', 'admin', 'romana_movimiento.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (42, 'Silos', 'admin', 'silos.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (43, 'Listado de Silos', 'admin', 'silos_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (44, 'Tipo Cultivo', 'admin', 'tipo_cultivo.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (45, 'Listado Tipo Cultivo', 'admin', 'tipo_cultivo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (46, 'Usuario', 'admin', 'usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (47, 'Listado de Usuarios', 'admin', 'usuarios_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (49, 'Imprimir', 'reportes', 'imprimir.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (48, 'Boleta Recepcion', 'reportes', 'imprimir_recepcion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (50, 'Boleta Liquidacion', 'reportes', 'imprimir_boleta_liquidacion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (51, 'Boleta Rechazo', 'reportes', 'imprimir_boleta_rechazo.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (52, 'Boleta Tipificacion', 'reportes', 'imprimir_boleta_tipificacion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (53, 'Reporte Despacho', 'reportes', 'reporte_despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (54, 'Reporte Recepcion', 'reportes', 'reporte_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (55, 'Boleta Virtual', 'admin', 'boleta_virtual.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (56, 'Cuarentenas Pendientes', 'admin', 'cuarentena_pendiente_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (58, 'Consulta Gerente Despachos', 'reportes', 'gerente_despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (57, 'Consulta Gerente Recepcion', 'reportes', 'gerente_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (59, 'Reporte de Actividad', 'reportes', 'reporte_actividad.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (60, 'Utilitario Recepciones', 'admin', 'utilitario_recepcion_listado.php', 1, '2012-05-11 00:00:00-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (61, 'Utilitario Despachos', 'admin', 'utilitario_despacho_listado.php', 1, '2012-05-29 00:00:00-04:30', NULL);


--
-- Data for Name: si_recursos_etiquetas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (1, 1, 'txtUsuario', 'Usuario', 1, '2012-03-06 09:37:56.586579-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (2, 1, 'txtContrasena', 'Contrase&ntilde;a', 1, '2012-03-06 09:37:56.586579-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (3, 1, 'txtEntrar', 'Entrar', 1, '2012-03-06 09:42:42.170218-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (4, 1, 'txtCancelar', 'Cancelar', 1, '2012-03-06 09:42:42.170218-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (5, 1, 'txtPiePagina', 'Sistema de Gesti&oacute;n de Silos - SIGESIL<br/>&copy; 2012 Todos los Derechos Reservados.<br/><br/>', 1, '2012-03-06 09:52:09.440852-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (6, 2, 'loginerror', 'Usuario y/o Contrase&ntilde;a Inv&aacute;lidos', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (7, 2, 'auth_requerida', 'Debe Iniciar Sesi&oacute;n', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (8, 2, 'usuario_inactivo', 'Usuario y/o Centro de Acopio Inactivo', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (9, 2, 'captcha_invalido', 'Captcha Inv&aacute;lido', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (10, 2, 'captcha_vacio', 'Debe introducir el Captcha', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (11, 1, 'E_NO40TNA', 'Existen analisis fuera de norma la muestra sera rechazada , NO SE ENVIARA A CUARENTENA', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (12, 1, 'M_Maestros', 'Maestros', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (13, 1, 'M_Procesos', 'Procesos', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (14, 1, 'M_Reportes', 'Reportes', 1, '2012-03-06 10:24:33.951075-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (16, 1, 'M_Cuenta', 'Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (17, 1, 'M_CentrosA', 'Centros de Acopio', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (19, 1, 'M_Programas', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (20, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (21, 1, 'M_Productor', 'Productor', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (22, 1, 'M_Recepcion', 'Recepci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (23, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (24, 1, 'M_Programa', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (25, 1, 'M_Cosecha', 'Cosechas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (18, 1, 'M_Cultivo', 'Cultivos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (50, 1, 'M_CuarentenaPendiente', 'Cuarentenas Pendientes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (26, 1, 'M_Productores', 'Productores', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (27, 1, 'M_Recepciones', 'Recepciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (28, 1, 'M_Despacho', 'Despachos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (29, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (30, 1, 'M_Usuarios', 'Usuarios', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (31, 1, 'M_Formulas', 'F&oacute;rmulas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (32, 1, 'M_Configuracion', 'Configuraci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (33, 1, 'M_ConfigCta', 'Config. Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (34, 1, 'M_Organizacion', 'Organizaciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (35, 1, 'M_Almacenes', 'Almacenes', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (36, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (37, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (38, 1, 'M_Romana', 'Romana', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (39, 3, 'E_FueraNorma', 'El valor indicado está fuera de norma.!!!', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (40, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (41, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (42, 1, 'M_Chofer', 'Chofer', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (43, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (44, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (45, 1, 'M_Ordenes', 'Ordenes de Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (46, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (47, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (48, 1, 'M_Auditoria', 'Auditoria del Sistema', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (49, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (51, 1, 'M_GerenteRecepcion', 'Gerente Recepci&oacute;n', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (52, 1, 'M_GerenteDespacho', 'Gerente Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (55, 1, 'M_GranosVerdes', 'Granos Verdes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (53, 1, 'M_UtilitarioRecepciones', 'Utilitario Recepciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (54, 1, 'M_UtilitarioDespachos', 'Utilitario Despachos', 1, '2012-03-06 00:00:00-04:30', NULL);


--
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (7, 3, 3, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:05:32.047308-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (8, 3, 3, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:05:32.064005-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (29, 4, 4, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:06:27.548043-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (53, 5, 5, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:12:33.541914-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (17, 4, 4, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:06:27.348165-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (41, 5, 5, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:12:33.341886-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (18, 4, 4, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:06:27.365003-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (42, 5, 5, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:12:33.358622-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (62, 6, 6, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:25:07.781128-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (3, 2, 2, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:01:40.147421-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (74, 7, 7, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:27:55-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (9, 3, 3, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:05:32.080546-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (19, 4, 4, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:06:27.381487-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (43, 5, 5, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:12:33.375377-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (63, 6, 6, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:25:07.797725-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (10, 3, 3, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:05:32.097424-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (20, 4, 4, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:06:27.39829-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (44, 5, 5, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:12:33.39185-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (64, 6, 6, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:25:07.814551-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (11, 3, 3, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:05:32.114005-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (21, 4, 4, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:06:27.414956-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (45, 5, 5, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:12:33.408492-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (65, 6, 6, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:25:07.831087-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (12, 3, 3, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:05:32.130658-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (22, 4, 4, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:06:27.431423-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (46, 5, 5, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:12:33.425069-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (66, 6, 6, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:25:07.847859-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (13, 3, 3, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:05:32.147097-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (23, 4, 4, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:06:27.448256-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (47, 5, 5, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:12:33.442001-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (67, 6, 6, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:25:07.864434-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (14, 3, 3, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:05:32.164022-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (24, 4, 4, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:06:27.464898-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (48, 5, 5, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:12:33.458509-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (68, 6, 6, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:25:07.880988-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (15, 3, 3, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:05:32.180592-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (25, 4, 4, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:06:27.481472-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (49, 5, 5, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:12:33.475215-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (69, 6, 6, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:25:07.897561-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (16, 3, 3, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:05:32.197159-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (26, 4, 4, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:06:27.498121-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (50, 5, 5, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:12:33.491855-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (70, 6, 6, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:25:07.914479-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (27, 4, 4, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:06:27.514982-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (51, 5, 5, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:12:33.508602-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (71, 6, 6, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:25:07.931073-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (28, 4, 4, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:06:27.531417-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (52, 5, 5, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:12:33.525128-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (72, 6, 6, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:25:07.947754-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (31, 4, 4, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:06:27.585406-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (55, 5, 5, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:12:33.575171-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (32, 4, 4, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:06:27.598079-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (56, 5, 5, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:12:33.59178-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (33, 4, 4, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:06:27.614882-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (57, 5, 5, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:12:33.60849-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (34, 4, 4, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:06:27.631368-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (58, 5, 5, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:12:33.625125-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (35, 4, 4, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:06:27.64816-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (59, 5, 5, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:12:33.64196-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (36, 4, 4, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:06:27.664683-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (60, 5, 5, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:12:33.658508-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (37, 4, 4, 'SILO 21', 'MODULO A', 21, 1000, NULL, 'A ', '2012-02-13 11:06:27.681424-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (38, 4, 4, 'SILO 22', 'MODULO A', 22, 1000, NULL, 'A ', '2012-02-13 11:06:27.698087-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (39, 4, 4, 'SILO 23', 'MODULO A', 23, 1000, NULL, 'A ', '2012-02-13 11:06:27.714699-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (40, 4, 4, 'SILO 24', 'MODULO A', 24, 1000, NULL, 'A ', '2012-02-13 11:06:27.731507-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (61, 6, 6, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:25:07.764398-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (73, 7, 7, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:27:38-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (4, 2, 2, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:01:40.164032-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (2, 2, 2, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:01:40.130888-04:30', '2012-02-19 19:46:46.671-04:30', true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (5, 2, 2, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:01:40.180896-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (6, 2, 2, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:01:40.197353-04:30', '2012-05-03 14:47:10.601082-04:30', true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (30, 4, 4, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:06:27.565593-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (54, 5, 5, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:12:33.561376-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (77, 8, 8, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:35:00.481-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (76, 8, 8, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:35:00.478-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (75, 8, 8, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:35:00.46-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (83, 9, 9, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:39:25.175-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (84, 9, 9, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:39:25.182-04:30', NULL, true);
INSERT INTO si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, modulo, creado, modificado, estatus) VALUES (85, 9, 9, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:39:25.185-04:30', NULL, true);


--
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (1, 2, 'Tolva 1', 1, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (2, 2, 'Tolva 2', 2, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (3, 2, 'Carril 1', 1, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (4, 2, 'Carril 2', 2, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (7, 3, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (8, 3, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (9, 3, 'Carril 1', 1, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (10, 3, 'Carril 2', 2, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (11, 3, 'Romana 1', 1, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (12, 3, 'Romana 2', 2, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (13, 4, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (14, 4, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (15, 4, 'Carril 1', 1, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (16, 4, 'Carril 2', 2, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (19, 5, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (20, 5, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (21, 5, 'Carril 1', 1, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (22, 5, 'Carril 2', 2, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (23, 5, 'Romana 1', 1, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (24, 5, 'Romana 2', 2, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (25, 6, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (26, 6, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (27, 6, 'Carril 1', 1, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (28, 6, 'Carril 2', 2, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (29, 6, 'Romana 1', 1, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (30, 6, 'Romana 2', 2, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (31, 7, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (32, 7, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (33, 7, 'Carril 1', 1, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (34, 7, 'Carril 2', 2, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (35, 7, 'Romana 1', 1, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (36, 7, 'Romana 2', 2, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (37, 8, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (38, 8, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (39, 8, 'Carril 1', 1, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (40, 8, 'Carril 2', 2, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (41, 8, 'Romana 1', 1, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (42, 8, 'Romana 2', 2, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (43, 9, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (44, 9, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (45, 9, 'Carril 1', 1, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (46, 9, 'Carril 2', 2, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (47, 9, 'Romana 1', 1, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (48, 9, 'Romana 2', 2, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (6, 2, 'Romana 2', 2, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'http://192.168.56.89:9600');
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (5, 2, 'Romana 1', 1, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'http://192.168.56.89:9601');
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.74:9600');
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.74:9600');


--
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, 'JUANCARRIZALEZ@AGROPATRIA.CO.VE', '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-05-17 15:28:30.825707-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (9, 'RAFAEL', 'ADAMES', '123456', NULL, 'M', 'RADAMES', 'E7B47259793917A0BECEDA2C5E00D3CB08B69F57', NULL, NULL, NULL, '2012-05-22 11:33:31.825155-04:30', NULL, true, 0, NULL, '2012-05-22 11:39:29.221623-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (10, 'LUIS', 'ESTRADA', '123456', NULL, 'M', 'LESTRADA', '311E0C5E77F8A19D144E3AFED36912889EBAAE1C', NULL, NULL, NULL, '2012-05-22 11:34:14.980207-04:30', NULL, true, 1, 'ohbp0km4qrq53u9cnpeu2fcgv7', '2012-05-23 15:15:45.209464-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (8, 'LEIDY', 'SIFONTES', '123456', NULL, 'F', 'LSIFONTES', 'E34A43F70CD2570DC01BAAF1667C2FC91BBAACE6', NULL, NULL, NULL, '2012-05-18 15:54:34.262069-04:30', NULL, true, 0, NULL, '2012-05-24 08:20:26.876511-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (5, 'MARIELY', 'CORONADO', '16538158', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 0, NULL, '2012-06-06 08:17:33.243452-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'JOSEPELUZZO@AGROPATRIA.CO.VE', '2012-02-12 00:00:00-04:30', NULL, true, 1, 'pig0o65ntfclqatvdhivfh4eu3', '2012-06-06 08:24:47.043891-04:30', '2012-02-12 00:00:00-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JUANTABORDA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 0, NULL, '2012-05-30 15:48:17.656958-04:30', NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso, fecha_contrasena) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'JESUSRODRIGUEZ@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-06-04 15:46:20.292134-04:30', NULL);


--
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (5, 5, 2, 2, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 3, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (8, 8, 4, 4, '2012-05-18 15:54:34.286197-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (9, 9, 2, 4, '2012-05-22 11:33:31.853499-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (10, 10, 2, 4, '2012-05-22 11:34:15.008645-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (6, 6, 2, 7, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');


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
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


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
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


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
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


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
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


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
-- Name: si_impresora_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_pkey PRIMARY KEY (id);


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
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


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
-- Name: si_perfiles_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles_menu
    ADD CONSTRAINT si_perfiles_menu_pkey PRIMARY KEY (id);


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
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


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
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


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
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


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
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


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
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


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
-- Name: si_impresora_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


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
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


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
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


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
-- Name: si_perfiles_menu_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_perfiles_menu
    ADD CONSTRAINT si_perfiles_menu_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- Name: si_perfiles_menu_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_perfiles_menu
    ADD CONSTRAINT si_perfiles_menu_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


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
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


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
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


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
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


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

