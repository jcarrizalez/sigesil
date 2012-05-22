--
-- PostgreSQL database dump
--

-- Started on 2012-05-22 14:51:26 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 261 (class 1255 OID 26531)
-- Dependencies: 6
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
-- TOC entry 140 (class 1259 OID 26532)
-- Dependencies: 6
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
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 140
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 141 (class 1259 OID 26534)
-- Dependencies: 2119 6
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
-- TOC entry 142 (class 1259 OID 26541)
-- Dependencies: 6
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
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 142
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 143 (class 1259 OID 26543)
-- Dependencies: 2120 2121 2122 6
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
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 143
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 144 (class 1259 OID 26549)
-- Dependencies: 6
-- Name: si_analisis_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_centro_acopio (
    id bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_centro_acopio bigint NOT NULL
);


ALTER TABLE public.si_analisis_centro_acopio OWNER TO admin;

--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 145 (class 1259 OID 26552)
-- Dependencies: 6 144
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
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 146 (class 1259 OID 26554)
-- Dependencies: 2124 2125 2126 2127 2128 2129 6
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
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 147 (class 1259 OID 26563)
-- Dependencies: 6 146
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
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 728, true);


--
-- TOC entry 148 (class 1259 OID 26565)
-- Dependencies: 2131 6
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
-- TOC entry 149 (class 1259 OID 26569)
-- Dependencies: 6 148
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
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 150 (class 1259 OID 26571)
-- Dependencies: 6
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
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 151 (class 1259 OID 26574)
-- Dependencies: 150 6
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 750, true);


--
-- TOC entry 152 (class 1259 OID 26576)
-- Dependencies: 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id character varying(255) NOT NULL,
    apperror_time timestamp with time zone NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 153 (class 1259 OID 26582)
-- Dependencies: 6
-- Name: si_asociacion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_asociacion (
    id bigint NOT NULL,
    id_pais smallint,
    id_estado smallint,
    id_municipio smallint,
    codigo character varying(16) NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(255),
    rif character varying(16),
    telefono character varying(32),
    email character varying(255),
    direccion character varying(255),
    fax character varying(32),
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_asociacion OWNER TO admin;

--
-- TOC entry 154 (class 1259 OID 26588)
-- Dependencies: 153 6
-- Name: si_asociacion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_asociacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_asociacion_id_seq OWNER TO admin;

--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 154
-- Name: si_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_asociacion_id_seq OWNED BY si_asociacion.id;


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 154
-- Name: si_asociacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociacion_id_seq', 1, false);


--
-- TOC entry 155 (class 1259 OID 26590)
-- Dependencies: 6
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
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 155
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 156 (class 1259 OID 26592)
-- Dependencies: 2135 6
-- Name: si_asociado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_asociado (
    id bigint DEFAULT nextval('si_asociado_id_seq'::regclass) NOT NULL,
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
    modificado timestamp with time zone,
    id_asociacion bigint NOT NULL
);


ALTER TABLE public.si_asociado OWNER TO admin;

--
-- TOC entry 157 (class 1259 OID 26599)
-- Dependencies: 6
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
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 157
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 158 (class 1259 OID 26601)
-- Dependencies: 2136 6
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
-- TOC entry 159 (class 1259 OID 26605)
-- Dependencies: 6
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
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 160 (class 1259 OID 26607)
-- Dependencies: 2137 2138 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 161 (class 1259 OID 26612)
-- Dependencies: 6
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
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 162 (class 1259 OID 26614)
-- Dependencies: 2139 2140 2141 2142 2143 2144 2145 6
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
-- TOC entry 163 (class 1259 OID 26627)
-- Dependencies: 6
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
-- TOC entry 164 (class 1259 OID 26630)
-- Dependencies: 163 6
-- Name: si_choferes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_choferes_id_seq OWNER TO admin;

--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 164
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 164
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 35, true);


--
-- TOC entry 165 (class 1259 OID 26632)
-- Dependencies: 6
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
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 165
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 14, true);


--
-- TOC entry 166 (class 1259 OID 26634)
-- Dependencies: 2147 6
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
-- TOC entry 167 (class 1259 OID 26641)
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
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 167
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 5, true);


--
-- TOC entry 168 (class 1259 OID 26643)
-- Dependencies: 2148 2149 2150 2151 2152 6
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
-- TOC entry 169 (class 1259 OID 26654)
-- Dependencies: 6
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
-- TOC entry 170 (class 1259 OID 26657)
-- Dependencies: 6
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
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 171 (class 1259 OID 26660)
-- Dependencies: 6 170
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_silo_id_seq OWNER TO admin;

--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 172 (class 1259 OID 26662)
-- Dependencies: 6
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
    observa_admon character varying,
    observa_lab character varying(255)
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 172
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
-- TOC entry 173 (class 1259 OID 26668)
-- Dependencies: 6 172
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
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 3, true);


--
-- TOC entry 174 (class 1259 OID 26670)
-- Dependencies: 2155 6
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
-- TOC entry 175 (class 1259 OID 26674)
-- Dependencies: 6 174
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_plaga_id_seq OWNER TO admin;

--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 3, true);


--
-- TOC entry 176 (class 1259 OID 26676)
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
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 177 (class 1259 OID 26678)
-- Dependencies: 2157 2158 2159 6
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint DEFAULT nextval('si_cultivo_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    codigo character varying(16) NOT NULL,
    nombre character varying(255) NOT NULL,
    tipificado boolean DEFAULT false,
    ciclo integer DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 178 (class 1259 OID 26684)
-- Dependencies: 2160 2161 6
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
-- TOC entry 179 (class 1259 OID 26689)
-- Dependencies: 6 178
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 10, true);


--
-- TOC entry 180 (class 1259 OID 26691)
-- Dependencies: 6
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
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 26693)
-- Dependencies: 2163 6
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
-- TOC entry 182 (class 1259 OID 26697)
-- Dependencies: 2164 6
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
    estatus character(1),
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
    peso_acon_liq2 double precision
);


ALTER TABLE public.si_despacho OWNER TO admin;

--
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 182
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
-- TOC entry 183 (class 1259 OID 26701)
-- Dependencies: 6 182
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 22, true);


--
-- TOC entry 184 (class 1259 OID 26703)
-- Dependencies: 6
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
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 185 (class 1259 OID 26705)
-- Dependencies: 2166 2167 6
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
-- TOC entry 186 (class 1259 OID 26710)
-- Dependencies: 6
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
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 187 (class 1259 OID 26712)
-- Dependencies: 2168 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 188 (class 1259 OID 26716)
-- Dependencies: 2169 6
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
-- TOC entry 189 (class 1259 OID 26723)
-- Dependencies: 6 188
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
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 190 (class 1259 OID 26725)
-- Dependencies: 6
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
-- TOC entry 191 (class 1259 OID 26731)
-- Dependencies: 190 6
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
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 191
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 191
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 48, true);


--
-- TOC entry 192 (class 1259 OID 26733)
-- Dependencies: 2172 2173 6
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
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 193 (class 1259 OID 26738)
-- Dependencies: 6
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
-- TOC entry 194 (class 1259 OID 26741)
-- Dependencies: 6 193
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
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 7, true);


--
-- TOC entry 195 (class 1259 OID 26743)
-- Dependencies: 192 6
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 28, true);


--
-- TOC entry 196 (class 1259 OID 26745)
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
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 197 (class 1259 OID 26747)
-- Dependencies: 2176 6
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
-- TOC entry 198 (class 1259 OID 26751)
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
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 1898, true);


--
-- TOC entry 199 (class 1259 OID 26753)
-- Dependencies: 2177 6
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
-- TOC entry 200 (class 1259 OID 26760)
-- Dependencies: 6
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 42, true);


--
-- TOC entry 201 (class 1259 OID 26762)
-- Dependencies: 2178 2179 6
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
-- TOC entry 202 (class 1259 OID 26767)
-- Dependencies: 2180 2181 2182 2183 6
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
-- TOC entry 203 (class 1259 OID 26774)
-- Dependencies: 6
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
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 204 (class 1259 OID 26776)
-- Dependencies: 2184 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 205 (class 1259 OID 26780)
-- Dependencies: 6
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
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 20, true);


--
-- TOC entry 206 (class 1259 OID 26782)
-- Dependencies: 2185 2186 6
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
-- TOC entry 207 (class 1259 OID 26790)
-- Dependencies: 6
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
-- TOC entry 208 (class 1259 OID 26793)
-- Dependencies: 6 207
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_det_id_seq OWNER TO admin;

--
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 1, true);


--
-- TOC entry 209 (class 1259 OID 26795)
-- Dependencies: 6
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
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 209
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 210 (class 1259 OID 26797)
-- Dependencies: 2188 6
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
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 211 (class 1259 OID 26804)
-- Dependencies: 6
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 211
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 212 (class 1259 OID 26806)
-- Dependencies: 2189 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 26810)
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
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 12, true);


--
-- TOC entry 214 (class 1259 OID 26812)
-- Dependencies: 2190 6
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
-- TOC entry 215 (class 1259 OID 26819)
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
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 9, true);


--
-- TOC entry 216 (class 1259 OID 26821)
-- Dependencies: 2191 6
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
-- TOC entry 217 (class 1259 OID 26825)
-- Dependencies: 6
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
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 218 (class 1259 OID 26828)
-- Dependencies: 6 217
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
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 219 (class 1259 OID 26830)
-- Dependencies: 6
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
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 220 (class 1259 OID 26833)
-- Dependencies: 6 219
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
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 221 (class 1259 OID 26835)
-- Dependencies: 6
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
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 13, true);


--
-- TOC entry 222 (class 1259 OID 26837)
-- Dependencies: 2194 6
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
-- TOC entry 223 (class 1259 OID 26844)
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
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 223
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 6, true);


--
-- TOC entry 224 (class 1259 OID 26846)
-- Dependencies: 2195 6
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
-- TOC entry 225 (class 1259 OID 26853)
-- Dependencies: 6
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
-- TOC entry 226 (class 1259 OID 26859)
-- Dependencies: 6 225
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
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 227 (class 1259 OID 26861)
-- Dependencies: 6
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
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 228 (class 1259 OID 26867)
-- Dependencies: 6 227
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
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 4, true);


--
-- TOC entry 229 (class 1259 OID 26869)
-- Dependencies: 2198 2199 2200 2201 6
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
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 229
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
-- TOC entry 230 (class 1259 OID 26876)
-- Dependencies: 6
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
-- TOC entry 231 (class 1259 OID 26879)
-- Dependencies: 230 6
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, true);


--
-- TOC entry 232 (class 1259 OID 26881)
-- Dependencies: 6 229
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
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 28, true);


--
-- TOC entry 233 (class 1259 OID 26883)
-- Dependencies: 2204 6
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
-- TOC entry 234 (class 1259 OID 26890)
-- Dependencies: 2206 6
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
-- TOC entry 235 (class 1259 OID 26897)
-- Dependencies: 234 6
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
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 55, true);


--
-- TOC entry 236 (class 1259 OID 26899)
-- Dependencies: 233 6
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
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 60, true);


--
-- TOC entry 237 (class 1259 OID 26901)
-- Dependencies: 6
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
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 238 (class 1259 OID 26903)
-- Dependencies: 2208 2209 6
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
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 239 (class 1259 OID 26911)
-- Dependencies: 6
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
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 240 (class 1259 OID 26913)
-- Dependencies: 2210 2211 2212 6
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
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 241 (class 1259 OID 26919)
-- Dependencies: 6
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
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 242 (class 1259 OID 26925)
-- Dependencies: 241 6
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
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 2, true);


--
-- TOC entry 243 (class 1259 OID 26927)
-- Dependencies: 6
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
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 10, true);


--
-- TOC entry 244 (class 1259 OID 26929)
-- Dependencies: 2214 2215 2216 6
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
    ultimo_acceso timestamp with time zone
);


ALTER TABLE public.si_usuarios OWNER TO admin;

--
-- TOC entry 245 (class 1259 OID 26938)
-- Dependencies: 6
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
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 10, true);


--
-- TOC entry 246 (class 1259 OID 26940)
-- Dependencies: 2217 6
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
-- TOC entry 247 (class 1259 OID 26944)
-- Dependencies: 6
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
-- TOC entry 248 (class 1259 OID 26947)
-- Dependencies: 6 247
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
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 248
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 248
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 48, true);


--
-- TOC entry 2123 (class 2604 OID 26949)
-- Dependencies: 145 144
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2130 (class 2604 OID 26950)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2132 (class 2604 OID 26951)
-- Dependencies: 149 148
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2133 (class 2604 OID 26952)
-- Dependencies: 151 150
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2134 (class 2604 OID 26953)
-- Dependencies: 154 153
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociacion ALTER COLUMN id SET DEFAULT nextval('si_asociacion_id_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 26954)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2153 (class 2604 OID 26955)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2154 (class 2604 OID 26956)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2156 (class 2604 OID 26957)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2162 (class 2604 OID 26958)
-- Dependencies: 179 178
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 26959)
-- Dependencies: 183 182
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 26960)
-- Dependencies: 189 188
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 26961)
-- Dependencies: 191 190
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2174 (class 2604 OID 26962)
-- Dependencies: 195 192
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2175 (class 2604 OID 26963)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 26964)
-- Dependencies: 208 207
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 26965)
-- Dependencies: 218 217
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 26966)
-- Dependencies: 220 219
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2196 (class 2604 OID 26967)
-- Dependencies: 226 225
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 26968)
-- Dependencies: 228 227
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 26969)
-- Dependencies: 232 229
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2203 (class 2604 OID 26970)
-- Dependencies: 231 230
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 26971)
-- Dependencies: 236 233
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 26972)
-- Dependencies: 235 234
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 26973)
-- Dependencies: 242 241
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 26974)
-- Dependencies: 248 247
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2444 (class 0 OID 26534)
-- Dependencies: 141
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
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '1');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (11, 2, 'PRODUCTOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-20 11:06:41.92', '2012-05-03 14:34:27.011983', 2, '3');


--
-- TOC entry 2445 (class 0 OID 26543)
-- Dependencies: 143
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
-- TOC entry 2446 (class 0 OID 26549)
-- Dependencies: 144
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2447 (class 0 OID 26554)
-- Dependencies: 146
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 247, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 255, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 277, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 288, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 310, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 333, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 345, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 364, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 399, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 407, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 408, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 425, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 430, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 447, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 468, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 496, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 504, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 526, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 537, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 559, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 582, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 594, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 613, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 648, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 656, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 657, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 674, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 679, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 696, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 717, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 231, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 232, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 233, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 234, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 235, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 236, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 237, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 238, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 239, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 240, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 241, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 242, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 243, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 244, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 245, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 246, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 248, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 249, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 250, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 251, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 252, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 253, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 254, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 256, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 257, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 258, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 259, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 260, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 261, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 262, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 263, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 264, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 265, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 266, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 267, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 268, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 269, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 270, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 271, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 272, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 273, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 274, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 275, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 276, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 278, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 279, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 280, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 281, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 282, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 283, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 284, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 285, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 286, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 287, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 289, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 290, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 291, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 292, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 293, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 294, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 295, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 296, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 297, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 298, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 299, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 300, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 301, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 302, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 303, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 304, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 305, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 306, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 307, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 308, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 309, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 311, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 312, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 313, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 314, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 315, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 316, 10.000, 26.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 317, 0.000, 7.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 318, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 319, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 320, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 321, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 322, 0.000, 17.000, 0.000, 17.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 323, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 324, 0.000, 30.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 325, 0.000, 20.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 326, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 327, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 328, 715.000, 0.790, 715.000, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 329, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 330, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 331, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 332, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 334, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 335, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 336, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 337, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 338, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 339, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 340, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 341, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 342, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 343, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 344, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 346, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 347, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 348, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 349, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 350, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 351, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 352, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 353, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 354, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 355, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 356, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 357, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 358, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 359, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 360, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 361, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 362, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 363, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 365, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 366, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 367, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 368, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 369, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 370, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 371, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 372, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 373, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 374, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 375, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 376, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 377, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 378, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 379, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 380, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 381, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 382, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 383, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 384, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 385, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 386, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 387, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 388, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 389, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 390, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 391, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 392, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 393, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 394, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 395, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 396, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 397, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 398, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 400, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 401, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 402, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 403, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 404, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 405, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 406, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 409, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 410, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 411, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 412, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 413, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 414, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 415, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 416, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 417, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 418, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 419, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 420, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 421, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 422, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 423, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 424, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 426, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 427, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 428, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 429, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 431, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 432, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 433, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 434, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 435, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 436, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 437, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 438, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 439, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 440, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 441, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 442, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 443, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 444, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 445, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 446, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 448, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 449, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 450, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 451, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 452, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 453, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 454, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 455, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 456, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 457, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 458, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 459, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 460, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 461, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 462, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 463, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 464, 715.000, 0.790, 715.000, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 465, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 466, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 467, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 469, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 470, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 471, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 472, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 473, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 474, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 475, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 476, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 477, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 478, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 479, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 480, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 481, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 482, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 483, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 484, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 485, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 486, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 487, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 488, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 489, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 490, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 491, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 492, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 493, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 494, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 495, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 497, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 498, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 499, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 500, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 501, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 502, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 503, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 505, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 506, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 507, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 508, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 509, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 510, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 511, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 512, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 513, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 514, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 515, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 516, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 517, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 518, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 519, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 520, 12.000, 24.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 521, 0.000, 10.000, 0.000, 5.100, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 522, 0.000, 2.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 523, 0.000, 1.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 524, 0.600, 0.760, 0.600, 0.760, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 525, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 527, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 528, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 529, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 530, 11.000, 22.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 531, 0.000, 11.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 532, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 533, 0.000, 8.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 534, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 535, 0.680, 0.730, 0.680, 0.730, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 536, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 538, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 539, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 540, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 541, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 542, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 543, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 544, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 545, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 546, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 547, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 548, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 549, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 550, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 551, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 552, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 553, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 554, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 555, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 556, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 557, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 558, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 560, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 561, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 562, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 563, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 564, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 565, 10.000, 26.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 566, 0.000, 7.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 567, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 568, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 569, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 570, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 571, 0.000, 17.000, 0.000, 17.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 572, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 573, 0.000, 30.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 574, 0.000, 20.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 575, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 576, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 577, 715.000, 0.790, 715.000, 0.760, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 578, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 579, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 580, 12.500, 15.000, 12.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 581, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 583, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 584, 0.000, 4.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 585, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 586, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 587, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 588, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 589, 0.000, 26.000, 0.000, 26.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 590, 0.000, 3.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 591, 12.000, 24.000, 12.000, 24.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 592, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 593, 0.000, 40.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 595, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 596, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 597, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 598, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 599, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 600, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 601, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 602, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 603, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 604, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 605, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 606, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 607, 40.000, 60.000, 45.000, 60.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 608, 65.000, 70.000, 65.000, 70.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 609, 25.000, 39.000, 30.000, 39.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 610, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 611, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 612, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 614, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 615, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 616, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 617, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 618, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 619, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 620, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 621, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 622, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 623, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 624, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 625, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 626, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 627, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 628, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 629, 8.000, 19.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 630, 0.000, 8.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 631, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 632, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 633, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 634, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 635, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 636, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 637, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 638, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 639, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 640, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 641, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 642, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 643, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 644, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 645, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 646, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 647, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 649, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 650, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 651, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 652, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 653, 8.000, 19.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 654, 0.000, 8.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 655, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 658, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 659, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 660, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 661, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 662, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 663, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 664, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 665, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 666, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 667, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 668, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 669, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 670, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 671, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 672, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 673, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 675, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 676, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 677, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 678, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 680, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 681, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 682, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 683, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 684, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 685, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 686, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 687, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 688, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 689, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 690, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 691, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 692, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 693, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 694, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 695, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 697, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 698, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 699, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 700, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 701, 12.000, 30.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 702, 0.000, 5.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 703, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 704, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 705, 0.000, 3.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 706, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 707, 0.000, 11.000, 0.000, 60.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 708, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 709, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 710, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 711, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 712, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 713, 715.000, 0.790, 715.000, 0.790, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 714, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 715, 0.000, 20.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 716, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 718, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 719, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 720, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 721, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 722, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 723, 0.000, 0.000, 0.000, 0.500, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 724, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 725, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 726, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 727, 1.000, 2.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 728, 0.000, 1.000, 0.000, 1.000, 4);


--
-- TOC entry 2448 (class 0 OID 26565)
-- Dependencies: 148
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2449 (class 0 OID 26571)
-- Dependencies: 150
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (413, 11, NULL, 1, 5, '13.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (414, 11, NULL, 2, 5, '4.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (415, 11, NULL, 3, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (416, 11, NULL, 4, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (417, 11, NULL, 5, 5, '8.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (418, 11, NULL, 6, 5, '6.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (419, 11, NULL, 7, 5, '6.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (420, 11, NULL, 8, 5, '5.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (421, 11, NULL, 9, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (422, 11, NULL, 10, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (423, 11, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (424, 11, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (425, 11, NULL, 13, 5, '0.714', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (426, 11, NULL, 14, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (427, 11, NULL, 15, 5, '15.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (428, 11, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (429, 11, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (430, 11, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (431, 11, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (432, 11, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (433, 11, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (434, 10, NULL, 1, 5, '12.000', '20.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (435, 10, NULL, 2, 5, '0.000', '4.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (436, 10, NULL, 3, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (437, 10, NULL, 4, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (438, 10, NULL, 5, 5, '0.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (439, 10, NULL, 6, 5, '0.000', '9.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (440, 10, NULL, 7, 5, '0.000', '8.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (441, 10, NULL, 8, 5, '0.000', '5.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (442, 10, NULL, 9, 5, '0.000', '14.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (443, 10, NULL, 10, 5, '0.000', '0.100', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (444, 10, NULL, 11, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (445, 10, NULL, 12, 5, '0.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (446, 10, NULL, 13, 5, '0.710', '0.790', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (447, 10, NULL, 14, 5, '0.000', '0.100', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (448, 10, NULL, 15, 5, '0.000', '19.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (449, 10, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (450, 10, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (451, 10, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (452, 10, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (453, 10, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (454, 10, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (455, 13, NULL, 1, 5, '15.000', '13.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (456, 13, NULL, 2, 5, '9.000', '8.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (457, 13, NULL, 7, 5, '1.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (458, 13, NULL, 8, 5, '1.000', '1.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (459, 13, NULL, 13, 5, '0.600', '0.700', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (460, 13, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (461, 13, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (462, 13, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (463, 13, NULL, 24, 5, 'B', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (464, 13, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (465, 12, NULL, 1, 5, '13.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (466, 12, NULL, 2, 5, '8.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (467, 12, NULL, 7, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (468, 12, NULL, 8, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (469, 12, NULL, 13, 5, '0.700', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (470, 12, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (471, 12, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (472, 12, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (473, 12, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (474, 12, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (475, 14, NULL, 1, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (476, 14, NULL, 2, 5, '0.500', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (477, 14, NULL, 13, 5, '0.340', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (478, 14, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (479, 14, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (480, 14, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (481, 14, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (482, 15, NULL, 1, 5, '10.000', '11.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (483, 15, NULL, 2, 5, '5.000', '6.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (484, 15, NULL, 13, 5, '0.400', '0.400', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (485, 15, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (486, 15, NULL, 22, 5, 'B', 'B', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (487, 15, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (488, 15, NULL, 38, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (489, 10, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (490, 10, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (491, 10, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (492, 10, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (493, 10, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (494, 10, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (495, 11, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (496, 11, NULL, 21, 5, 'C', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (497, 11, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (498, 11, NULL, 23, 5, 'D', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (499, 11, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (500, 11, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (501, 12, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (502, 12, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (503, 12, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (504, 12, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (505, 13, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (506, 13, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (507, 13, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (508, 13, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (509, 15, NULL, 1, 5, '10.000', '12.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (510, 15, NULL, 2, 5, '5.000', '7.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (511, 15, NULL, 13, 5, '0.400', '0.350', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (512, 15, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (513, 15, NULL, 22, 5, 'B', 'C', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (514, 15, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (515, 15, NULL, 38, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (516, 14, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (517, 14, NULL, 2, 5, '0.500', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (518, 14, NULL, 13, 5, '0.400', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (519, 14, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (520, 14, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (521, 14, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (522, 14, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (523, 16, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (524, 16, NULL, 2, 5, '4.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (525, 16, NULL, 3, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (526, 16, NULL, 4, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (527, 16, NULL, 5, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (528, 16, NULL, 6, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (529, 16, NULL, 7, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (530, 16, NULL, 8, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (531, 16, NULL, 9, 5, '14.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (532, 16, NULL, 10, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (533, 16, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (534, 16, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (535, 16, NULL, 13, 5, '0.730', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (536, 16, NULL, 14, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (537, 16, NULL, 15, 5, '19.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (538, 16, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (539, 16, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (540, 16, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (541, 16, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (542, 16, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (543, 16, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (544, 17, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (545, 17, NULL, 2, 5, '5.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (546, 17, NULL, 3, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (547, 17, NULL, 4, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (548, 17, NULL, 5, 5, '3.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (549, 17, NULL, 6, 5, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (550, 17, NULL, 7, 5, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (551, 17, NULL, 8, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (552, 17, NULL, 9, 5, '15.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (553, 17, NULL, 10, 5, '0.200', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (554, 17, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (555, 17, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (556, 17, NULL, 13, 5, '0.710', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (557, 17, NULL, 14, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (558, 17, NULL, 15, 5, '19.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (559, 17, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (560, 17, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (561, 17, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (562, 17, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (563, 17, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (564, 17, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (565, 18, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (566, 18, NULL, 2, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (567, 18, NULL, 7, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (568, 18, NULL, 8, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (569, 18, NULL, 13, 5, '0.600', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (570, 18, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (571, 18, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (572, 18, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (573, 18, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (574, 18, NULL, 20, 5, 'SI', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (575, 20, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (576, 20, NULL, 2, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (577, 20, NULL, 13, 5, '0.335', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (578, 20, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (579, 20, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (580, 20, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (581, 20, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (582, 20, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (583, 20, NULL, 2, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (584, 20, NULL, 13, 5, '0.335', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (585, 20, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (586, 20, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (587, 20, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (588, 20, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (589, 21, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (590, 21, NULL, 2, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (591, 21, NULL, 3, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (592, 21, NULL, 4, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (593, 21, NULL, 5, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (594, 21, NULL, 6, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (595, 21, NULL, 7, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (596, 21, NULL, 8, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (597, 21, NULL, 9, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (598, 21, NULL, 10, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (599, 21, NULL, 11, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (600, 21, NULL, 12, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (601, 21, NULL, 13, 5, '0.710', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (602, 21, NULL, 14, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (603, 21, NULL, 15, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (604, 21, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (605, 21, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (606, 21, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (607, 21, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (608, 21, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (609, 21, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (610, 21, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (611, 21, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (612, 21, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (613, 21, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (614, 21, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (615, 21, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (616, 22, NULL, 1, 5, '12.000', '13.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (617, 22, NULL, 2, 5, '2.000', '3.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (618, 22, NULL, 3, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (619, 22, NULL, 4, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (620, 22, NULL, 5, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (621, 22, NULL, 6, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (622, 22, NULL, 7, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (623, 22, NULL, 8, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (624, 22, NULL, 9, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (625, 22, NULL, 10, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (626, 22, NULL, 11, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (627, 22, NULL, 12, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (628, 22, NULL, 13, 5, '0.710', '0.710', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (629, 22, NULL, 14, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (630, 22, NULL, 15, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (631, 22, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (632, 22, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (633, 22, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (634, 22, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (635, 22, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (636, 22, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (637, 22, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (638, 22, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (639, 22, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (640, 22, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (641, 22, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (642, 22, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (643, NULL, 8, 1, 5, '7.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (644, NULL, 8, 2, 5, '6.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (645, NULL, 8, 13, 5, '0.335', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (646, 25, NULL, 1, 2, '12.000', '13.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (647, 25, NULL, 2, 2, '2.000', '3.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (648, 25, NULL, 3, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (649, 25, NULL, 4, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (650, 25, NULL, 5, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (651, 25, NULL, 6, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (652, 25, NULL, 7, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (653, 25, NULL, 8, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (654, 25, NULL, 9, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (655, 25, NULL, 10, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (656, 25, NULL, 11, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (657, 25, NULL, 12, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (658, 25, NULL, 13, 2, '0.710', '0.710', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (659, 25, NULL, 14, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (660, 25, NULL, 15, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (661, 25, NULL, 19, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (662, 25, NULL, 21, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (663, 25, NULL, 22, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (664, 25, NULL, 23, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (665, 25, NULL, 24, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (666, 25, NULL, 20, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (667, 25, NULL, 19, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (668, 25, NULL, 21, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (669, 25, NULL, 22, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (670, 25, NULL, 23, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (671, 25, NULL, 24, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (672, 25, NULL, 20, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (673, 26, NULL, 1, 3, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (674, 26, NULL, 2, 3, '5.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (675, 26, NULL, 3, 3, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (676, 26, NULL, 4, 3, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (677, 26, NULL, 5, 3, '3.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (678, 26, NULL, 6, 3, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (679, 26, NULL, 7, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (680, 26, NULL, 8, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (681, 26, NULL, 9, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (682, 26, NULL, 10, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (683, 26, NULL, 11, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (684, 26, NULL, 12, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (685, 26, NULL, 13, 3, '0.710', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (686, 26, NULL, 14, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (687, 26, NULL, 15, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (688, 26, NULL, 19, 3, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (689, 26, NULL, 21, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (690, 26, NULL, 22, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (691, 26, NULL, 23, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (692, 26, NULL, 24, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (693, 26, NULL, 20, 3, 'SI', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (694, 28, NULL, 1, 3, '16.000', '16.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (695, 28, NULL, 2, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (696, 28, NULL, 14, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (697, 28, NULL, 21, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (698, 28, NULL, 22, 3, 'A', 'B', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (699, 28, NULL, 24, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (700, 28, NULL, 20, 3, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (701, 28, NULL, 25, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (702, 28, NULL, 26, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (703, 28, NULL, 27, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (704, 28, NULL, 28, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (705, 28, NULL, 29, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (706, 28, NULL, 30, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (707, 28, NULL, 31, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (708, 28, NULL, 32, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (709, 28, NULL, 33, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (710, 28, NULL, 36, 3, '40.000', '40.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (711, 28, NULL, 37, 3, '59.000', '59.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (712, 28, NULL, 38, 3, '22.000', '22.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (713, NULL, 21, 1, 3, '13.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (714, NULL, 21, 2, 3, '8.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (715, NULL, 21, 14, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (716, NULL, 21, 21, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (717, NULL, 21, 22, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (718, NULL, 21, 24, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (719, NULL, 21, 20, 3, 'SI', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (720, NULL, 21, 25, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (721, NULL, 21, 26, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (722, NULL, 21, 27, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (723, NULL, 21, 28, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (724, NULL, 21, 29, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (725, NULL, 21, 30, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (726, NULL, 21, 31, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (727, NULL, 21, 32, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (728, NULL, 21, 33, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (729, NULL, 21, 36, 3, '46.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (730, NULL, 21, 37, 3, '50.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (731, NULL, 21, 38, 3, '20.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (732, NULL, 22, 1, 3, '12.000', '12.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (733, NULL, 22, 2, 3, '8.000', '8.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (734, NULL, 22, 14, 3, '40.000', '40.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (735, NULL, 22, 21, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (736, NULL, 22, 22, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (737, NULL, 22, 24, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (738, NULL, 22, 20, 3, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (739, NULL, 22, 25, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (740, NULL, 22, 26, 3, '8.000', '8.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (741, NULL, 22, 27, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (742, NULL, 22, 28, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (743, NULL, 22, 29, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (744, NULL, 22, 30, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (745, NULL, 22, 31, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (746, NULL, 22, 32, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (747, NULL, 22, 33, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (748, NULL, 22, 36, 3, '46.000', '46.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (749, NULL, 22, 37, 3, '50.000', '50.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (750, NULL, 22, 38, 3, '20.000', '20.000', '', 2, 'D');


--
-- TOC entry 2450 (class 0 OID 26576)
-- Dependencies: 152
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('cc61218b4bd82fac5c', '2012-05-22 14:11:35.58862-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:187:"ERROR:  error de sintaxis en o cerca de «DES»
LINE 27: ...rec IN ("1","10","11") ORDER BY r.fecha_recepcion DES, r.num...
                                                              ^";s:5:"query";s:2165:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') ORDER BY r.fecha_recepcion DES, r.numero";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:11:35";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('c97813a7f7349a5c2c', '2012-05-22 14:12:21.312956-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:212:"ERROR:  no se puede convertir el tipo timestamp with time zone a integer
LINE 27: ..._rec IN ("1","10","11") ORDER BY r.fecha_recepcion::int ASC,...
                                                              ^";s:5:"query";s:2170:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') ORDER BY r.fecha_recepcion::int ASC, r.numero";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:12:21";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('806602f7993984bc81', '2012-05-22 14:13:34.02399-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:187:"ERROR:  error de sintaxis en o cerca de «DES»
LINE 27: ...ND r.estatus_rec IN ("1","10","11") ORDER BY r.id DES, r.num...
                                                              ^";s:5:"query";s:2152:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') ORDER BY r.id DES, r.numero";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:13:34";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('1441a341d66b7d3d7e', '2012-05-22 14:16:59.877746-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:185:"ERROR:  error de sintaxis en o cerca de «r»
LINE 27: ...acopio = "2" AND r.estatus_rec IN ("1","10","11") r.fecha_re...
                                                              ^";s:5:"query";s:2166:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') r.fecha_recepcion DESC, ORDER BY r.id ASC";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:17:00";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('07f7e933abde911cce', '2012-05-22 14:17:18.457692-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:189:"ERROR:  error de sintaxis en o cerca de «DESCr»
LINE 27: ...rec IN ("1","10","11") ORDER BY r.fecha_recepcion DESCr.id A...
                                                              ^";s:5:"query";s:2164:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') ORDER BY r.fecha_recepcion DESCr.id ASC";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:17:18";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('76aa0fdc047bcb65ac', '2012-05-22 14:17:27.306055-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:73:"/home/jtaborda/proyectos/sigesil/admin/analisis_resultado_listado.php<br>";s:4:"line";i:30;s:5:"class";s:9:"Recepcion";s:8:"function";s:16:"listadoRecepcion";s:11:"mysql_error";s:210:"ERROR:  falta una entrada para la tabla «descr» en la cláusula FROM
LINE 27: ...ec IN ("1","10","11") ORDER BY r.fecha_recepcion, DESCr.id A...
                                                              ^";s:5:"query";s:2165:"SELECT r.*, <br />
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, <br />
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, <br />
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, <br />
                    pr.id AS id_programa, pr.nombre AS programa, <br />
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, <br />
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,<br />
                    g.numero_guia, g.contrato, <br />
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/<br />
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,<br />
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,<br />
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,<br />
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,<br />
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques<br />
                    FROM si_recepcion r<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio<br />
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha<br />
                    INNER JOIN si_programa pr ON pr.id = co.id_programa<br />
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo<br />
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/<br />
                    INNER JOIN si_productor p ON p.id = r.id_productor<br />
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado<br />
                    INNER JOIN si_guiarec g ON g.id = r.id_guia<br />
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer<br />
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo<br />
                    WHERE ''1'' AND r.id_centro_acopio = ''2'' AND r.estatus_rec IN (''1'',''10'',''11'') ORDER BY r.fecha_recepcion, DESCr.id ASC";s:9:"user_name";s:8:"JTABORDA";s:4:"date";s:19:"2012-05-22 02:17:27";}i:1;a:4:{s:4:"file";s:66:"/home/jtaborda/proyectos/sigesil/lib/class/recepcion.class.php<br>";s:4:"line";i:148;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('62642a75f742a7048f', '2012-05-22 14:40:50.874513-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"/var/www/sigesil/reportes/gerente_despacho.php<br>";s:4:"line";i:13;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:144:"ERROR:  no existe la columna «list»
LINE 1: SELECT id,codigo, nombre,list,codigo FROM si_cultivo Cultivo...
                                 ^";s:5:"query";s:70:"SELECT id,codigo, nombre,list,codigo FROM si_cultivo Cultivo where ''1''";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-22 02:40:50";}i:1;a:4:{s:4:"file";s:46:"/var/www/sigesil/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- TOC entry 2451 (class 0 OID 26582)
-- Dependencies: 153
-- Data for Name: si_asociacion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2452 (class 0 OID 26592)
-- Dependencies: 156
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2453 (class 0 OID 26601)
-- Dependencies: 158
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2454 (class 0 OID 26607)
-- Dependencies: 160
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2455 (class 0 OID 26614)
-- Dependencies: 162
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
-- TOC entry 2456 (class 0 OID 26627)
-- Dependencies: 163
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (26, 1, NULL, NULL, NULL, 'V10852147', 'ASD ASD', NULL, NULL, NULL, true, '2012-05-15 16:34:05.29467-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (27, 1, 1, 2, 2, 'V23123123', 'NUEVO CHOFER', NULL, NULL, NULL, true, '2012-05-15 16:36:16.531554-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (13, 1, NULL, NULL, NULL, 'V16538158', 'JOSE TORRES', NULL, NULL, NULL, true, '2012-05-11 10:53:44.289468-04:30', '2012-05-22 13:53:04.938937-04:30');
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (14, 1, NULL, NULL, NULL, 'V9668397', 'JESUS SILVA', NULL, NULL, NULL, true, '2012-05-11 10:54:45.201067-04:30', '2012-05-22 14:04:03.968722-04:30');


--
-- TOC entry 2457 (class 0 OID 26634)
-- Dependencies: 166
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (4, 1, NULL, 'V16538158', NULL, 'JOSE FUENTES', NULL, NULL, NULL, '2  ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 6, 64, NULL, true, '2012-05-14 16:19:58.764204-04:30', NULL);
INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (14, 1, NULL, 'V18264065', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, '1  ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, '2012-05-22 14:21:46.641544-04:30', NULL);


--
-- TOC entry 2458 (class 0 OID 26643)
-- Dependencies: 168
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (1, 2, 1, 'INVIERNO 2012', 220000, NULL, 45000, '2012-09-03', '2013-02-04', true, '2012-04-18 15:25:47.739787-04:30', NULL, '2012011');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 3, 3, 'COSECHA 1 SORGO', NULL, NULL, NULL, '2012-04-29', '2012-07-29', true, '2012-04-29 22:43:28.902-04:30', NULL, '2012031');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (3, 4, 12, 'COSECHA 1 GIR', NULL, NULL, NULL, NULL, NULL, true, '2012-05-07 00:19:27.451-04:30', NULL, '2012121');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (4, 5, 1, 'C-MAIZ SABANA', NULL, NULL, NULL, NULL, NULL, true, '2012-05-17 15:08:09.679749-04:30', NULL, '2012011');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (5, 6, 2, 'COSECHA ARROZ', NULL, NULL, NULL, NULL, NULL, true, '2012-05-22 14:01:51.803232-04:30', NULL, '2012021');


--
-- TOC entry 2459 (class 0 OID 26654)
-- Dependencies: 169
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 4, 7, '2012-05-11 10:19:08.669778-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 4, 6, '2012-05-11 10:19:08.686443-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 5, 8, '2012-05-11 10:19:23.312938-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 3, 0, 10, '2012-05-11 10:19:33.635405-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 3, 0, 9, '2012-05-11 10:19:33.652063-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 11, 0, 0, '2012-05-11 10:19:40.19555-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 2, 2, 12, 11, '2012-05-11 10:19:52.365962-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 2, 2, 12, 10, '2012-05-11 10:19:52.382516-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 2, 3, 4, 6, '2012-05-11 10:20:02.430589-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 2, 7, 0, 0, '2012-05-11 10:20:12.012387-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 10, 0, 0, '2012-05-11 10:20:19.879273-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 2, 13, 9, '2012-05-11 10:20:40.249582-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 2, 13, 7, '2012-05-11 10:20:40.26608-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 8, 0, 11, '2012-05-11 10:21:23.146523-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 8, 0, 6, '2012-05-11 10:21:23.163078-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (4, 3, 2, 4, 7, '2012-05-17 15:28:01.669213-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (4, 3, 2, 4, 6, '2012-05-17 15:28:01.685993-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (5, 2, 2, 4, 7, '2012-05-22 14:02:26.310301-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (5, 2, 2, 4, 6, '2012-05-22 14:02:26.327051-04:30', NULL);


--
-- TOC entry 2460 (class 0 OID 26657)
-- Dependencies: 170
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2461 (class 0 OID 26662)
-- Dependencies: 172
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cuarentena (id, id_centro_acopio, id_analisis, id_cultivo, id_recepcion, id_usuario, tipo_mov, fecha_mov, fecha_cultivo, grado_infestacion, laboratorio, id_producto, toneladas, cant_producto, id_plaga, hora_trab, fecha_lib, hora_lib, estatus, creado, modificado, observa_admon, observa_lab) VALUES (1, 2, 20, 3, 18, 5, 'R ', '2012-05-11 00:00:00-04:30', '2012-05-11 00:00:00-04:30', NULL, 'C ', 1, 2, 8, NULL, '08:05 AM  ', '2012-05-13 00:00:00-04:30', '12:05 AM  ', '2', '2012-05-11 15:46:40.652736-04:30', '2012-05-14 08:05:27.437234-04:30', 'APROBADO POR MARIELY ', 'SE PROCEDE A CUARENTENA');
INSERT INTO si_cuarentena (id, id_centro_acopio, id_analisis, id_cultivo, id_recepcion, id_usuario, tipo_mov, fecha_mov, fecha_cultivo, grado_infestacion, laboratorio, id_producto, toneladas, cant_producto, id_plaga, hora_trab, fecha_lib, hora_lib, estatus, creado, modificado, observa_admon, observa_lab) VALUES (2, 2, 20, 1, 26, 3, 'R ', '2012-05-22 00:00:00-04:30', '2012-05-22 00:00:00-04:30', NULL, 'C ', 1, 15, 60, NULL, '01:58 PM  ', '2012-05-24 00:00:00-04:30', '05:58 AM  ', '2', '2012-05-22 13:57:11.570214-04:30', '2012-05-22 13:58:30.262228-04:30', 'CUARENTENA PRUEBA DE SISTEMAS', 'PRUEBAS DE SISTEMAS LABORATORIO');
INSERT INTO si_cuarentena (id, id_centro_acopio, id_analisis, id_cultivo, id_recepcion, id_usuario, tipo_mov, fecha_mov, fecha_cultivo, grado_infestacion, laboratorio, id_producto, toneladas, cant_producto, id_plaga, hora_trab, fecha_lib, hora_lib, estatus, creado, modificado, observa_admon, observa_lab) VALUES (3, 2, 20, 2, 21, 3, 'D ', '2012-05-22 14:36:06.388011-04:30', '2012-05-22 14:36:06.388011-04:30', NULL, 'C ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-22 14:36:06.388011-04:30', NULL, NULL, NULL);


--
-- TOC entry 2462 (class 0 OID 26670)
-- Dependencies: 174
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cuarentena_plaga (id, id_cuarentena, id_plaga, cantidad) VALUES (1, 1, 1, 5);
INSERT INTO si_cuarentena_plaga (id, id_cuarentena, id_plaga, cantidad) VALUES (2, 1, 8, 40);
INSERT INTO si_cuarentena_plaga (id, id_cuarentena, id_plaga, cantidad) VALUES (3, 2, 1, 100);


--
-- TOC entry 2463 (class 0 OID 26678)
-- Dependencies: 177
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (10, 1, '10', 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (12, 1, '12', 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (13, 1, '13', 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (14, 1, '14', 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (16, 1, '16', 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (19, 1, '92', 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (20, 1, '93', 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (21, 1, '94', 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (2, 1, '02', 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (3, 1, '03', 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (4, 1, '04', 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (5, 1, '05', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (6, 1, '06', 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (7, 1, '07', 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (8, 1, '08', 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (9, 1, '09', 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (22, 1, '95', 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (23, 1, '96', 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (11, 1, '11', 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (15, 1, '15', 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (17, 1, '17', 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (24, 1, '97', 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (25, 1, '98', 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (18, 1, '68', 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (26, 1, '99', 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', '2012-05-03 15:13:02.029691-04:30', true);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado, estatus) VALUES (1, 1, '01', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', '2012-05-10 13:37:19.05023-04:30', true);


--
-- TOC entry 2464 (class 0 OID 26684)
-- Dependencies: 178
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (1, 2, 2, 26, 'A ', 0.00, 4.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (2, 2, 2, 26, 'B ', 4.10, 11.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (3, 2, 2, 30, 'A ', 0.00, 17.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (4, 2, 2, 30, 'B ', 17.10, 30.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (5, 2, 2, 31, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (6, 2, 2, 31, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (7, 2, 2, 32, 'A ', 0.00, 8.50);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (8, 2, 2, 32, 'B ', 8.51, 14.00);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (9, 2, 2, 33, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo (id, id_centro_acopio, id_cultivo, id_analisis, tipo, min, max) VALUES (10, 2, 2, 33, 'B ', 1.51, 3.00);


--
-- TOC entry 2465 (class 0 OID 26693)
-- Dependencies: 181
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2466 (class 0 OID 26697)
-- Dependencies: 182
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (9, 2, 10, 8, 4, 26, 19, 5, 2, 4, 2, '2012-05-15 16:35:35.488808-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, NULL, NULL, NULL, '2012-05-15 16:35:35.488808-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (10, 2, 10, 8, 4, 27, 42, 5, 2, 4, 2, '2012-05-15 16:36:32.504747-04:30', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 2, NULL, NULL, NULL, '2012-05-15 16:36:32.504747-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (8, 2, 10, 8, 4, 13, 38, 5, 2, 4, 2, '2012-05-14 16:31:42.218487-04:30', 1, '2012-05-14 16:34:45.869718-04:30', 12997, NULL, '2012-05-15 17:00:00.611296-04:30', 17940, NULL, 7, 6, NULL, NULL, NULL, '5', 1, NULL, 5, 5, '2012-05-14 16:31:42.218487-04:30', '2012-05-15 17:00:00.611296-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (21, 2, 2, 8, 4, 14, 42, 5, 2, 4, 2, '2012-05-22 14:23:08.997287-04:30', 1, '2012-05-22 14:33:54.028102-04:30', 48705, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', 1, NULL, 5, NULL, '2012-05-22 14:23:08.997287-04:30', '2012-05-22 14:36:06.388011-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (22, 2, 2, 8, 4, 14, 42, 5, 2, 4, 2, '2012-05-22 14:23:27.661076-04:30', 2, '2012-05-22 14:34:05.622568-04:30', 27523, 24704, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', 2, NULL, 6, NULL, '2012-05-22 14:23:27.661076-04:30', '2012-05-22 14:44:31.814731-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2467 (class 0 OID 26705)
-- Dependencies: 185
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2468 (class 0 OID 26712)
-- Dependencies: 187
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
-- TOC entry 2469 (class 0 OID 26716)
-- Dependencies: 188
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2470 (class 0 OID 26725)
-- Dependencies: 190
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
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (31, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I01', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (32, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (33, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I05', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (34, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (35, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I06', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (36, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (37, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (38, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (39, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I015', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (40, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (41, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I017', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (42, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (43, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I03', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (44, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (45, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I04', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (46, 1, 2, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (47, 1, 2, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (48, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);


--
-- TOC entry 2471 (class 0 OID 26733)
-- Dependencies: 192
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (21, NULL, NULL, 5, 761312123, 15000, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 11:33:44.415664-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (22, NULL, NULL, 5, 723897289, 123123, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 13:38:04.836066-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (23, NULL, NULL, 5, 123412312, 123123, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 16:31:57.351332-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (24, NULL, NULL, 5, 231231212, 12312, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 16:34:05.29467-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (25, NULL, NULL, 2, 341234123, 15000, NULL, NULL, '2012-05-17 00:00:00-04:30', 'P', NULL, NULL, '2012-05-17 15:29:42.034425-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (10, NULL, NULL, 5, 1, 2000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '1', '2012-05-11 10:53:44.289468-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (11, NULL, NULL, 5, 2, 100, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, NULL, '2012-05-11 10:54:45.201067-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (12, NULL, NULL, 5, 3, 1000, NULL, NULL, '2012-05-09 00:00:00-04:30', 'P', NULL, '2', '2012-05-11 10:58:07.51559-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (13, NULL, NULL, 5, 4, 150, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '155', '2012-05-11 10:58:29.375606-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (14, NULL, NULL, 5, 5, 130, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '156', '2012-05-11 11:01:04.877065-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (15, NULL, NULL, 5, 6, 2000, NULL, NULL, '2012-05-16 00:00:00-04:30', 'P', NULL, '4578496', '2012-05-11 11:01:25.253897-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (16, NULL, NULL, 5, 7, 2000, NULL, NULL, '2012-05-08 00:00:00-04:30', 'P', NULL, '25487', '2012-05-11 14:44:04.70865-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (17, NULL, NULL, 5, 8, 1000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '123659', '2012-05-11 15:10:48.737671-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (18, NULL, NULL, 5, 9, 2000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '65450', '2012-05-11 15:43:25.121714-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (19, NULL, NULL, 5, 10, 2000, NULL, NULL, '2012-05-02 00:00:00-04:30', 'P', NULL, '15478', '2012-05-11 16:07:00.187586-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (20, NULL, NULL, 5, 11, 2000, NULL, NULL, '2012-05-14 00:00:00-04:30', 'P', NULL, '489023', '2012-05-14 14:31:58.405515-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (26, NULL, NULL, 5, 348923798, 15000, NULL, NULL, '2012-05-22 00:00:00-04:30', 'P', NULL, NULL, '2012-05-22 13:53:04.938937-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (27, NULL, NULL, 5, 237894237, 15000, NULL, NULL, '2012-05-22 00:00:00-04:30', 'P', NULL, NULL, '2012-05-22 14:03:19.559676-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (28, NULL, NULL, 5, 773456455, 10000, NULL, NULL, '2012-05-22 00:00:00-04:30', 'P', NULL, NULL, '2012-05-22 14:04:03.968722-04:30', NULL);


--
-- TOC entry 2472 (class 0 OID 26738)
-- Dependencies: 193
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (4, 12, '48759           ', '2012-05-10 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (5, 12, '1245            ', '2012-05-11 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (6, 20, '254672          ', '2012-05-14 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (7, 26, '54564564654     ', '2012-05-15 00:00:00-04:30', '');


--
-- TOC entry 2473 (class 0 OID 26747)
-- Dependencies: 197
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2474 (class 0 OID 26753)
-- Dependencies: 199
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1667, '2012-05-20', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '613uodp69a891obtup37f5ni15', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 613uodp69a891obtup37f5ni15<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''613uodp69a891obtup37f5ni15''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1668, '2012-05-20', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '613uodp69a891obtup37f5ni15', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''613uodp69a891obtup37f5ni15'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1669, '2012-05-22', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-18 15:57:41.5049-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1670, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'No data', 'nombre = ''RAFAEL''<br />apellido =  ''ADAMES''<br />cedula =  ''123456''<br />fecha_nacimiento =  null<br />sexo =  ''M''<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  ''RADAMES''<br />contrasena =  ''E7B47259793917A0BECEDA2C5E00D3CB08B69F57''<br />creado = now()<br />', 'INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  (''RAFAEL'', ''ADAMES'', ''123456'', null, ''M'', null, null, null, ''RADAMES'', ''E7B47259793917A0BECEDA2C5E00D3CB08B69F57'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1671, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios_perfiles', 'No data', 'id_usuario = ''9''<br />id_almacen =  ''2''<br />id_perfil =  ''4''<br />creado = now()<br />', 'INSERT INTO si_usuarios_perfiles  (id_usuario, id_almacen, id_perfil, creado) VALUES  (''9'', ''2'', ''4'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1672, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'No data', 'nombre = ''LUIS''<br />apellido =  ''ESTRADA''<br />cedula =  ''123456''<br />fecha_nacimiento =  null<br />sexo =  ''M''<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  ''LESTRADA''<br />contrasena =  ''311E0C5E77F8A19D144E3AFED36912889EBAAE1C''<br />creado = now()<br />', 'INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  (''LUIS'', ''ESTRADA'', ''123456'', null, ''M'', null, null, null, ''LESTRADA'', ''311E0C5E77F8A19D144E3AFED36912889EBAAE1C'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1673, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios_perfiles', 'No data', 'id_usuario = ''10''<br />id_almacen =  ''2''<br />id_perfil =  ''4''<br />creado = now()<br />', 'INSERT INTO si_usuarios_perfiles  (id_usuario, id_almacen, id_perfil, creado) VALUES  (''10'', ''2'', ''4'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1674, '2012-05-22', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''10''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1675, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1676, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1677, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1678, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1679, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1680, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1681, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1682, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1683, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1684, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1685, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1686, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1687, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1688, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''39''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''39'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1689, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1690, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''34''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''34'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1691, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1692, '2012-05-22', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''9''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1693, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1694, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1695, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1696, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1697, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1698, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1699, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1700, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1701, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1702, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1703, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1704, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1705, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1706, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''39''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''39'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1707, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1708, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''34''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''34'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1709, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1710, '2012-05-22', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''10''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1711, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1712, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1713, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1714, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1715, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''10''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''10'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1716, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1717, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1770, '2012-05-22', 202, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''8'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1718, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1719, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1720, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1721, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1722, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1723, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1724, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''17''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''17'', ''10'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1725, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''39''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''39'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1726, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''10''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''10'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1727, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''34''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''34'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1728, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''10''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''10'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1729, '2012-05-22', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''9''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1730, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1731, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1732, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1733, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1734, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''9''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''9'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1735, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1736, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1737, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1738, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1739, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1740, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1741, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1742, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1743, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''17''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''17'', ''9'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1744, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''39''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''39'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1745, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''9''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''9'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1746, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''34''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''34'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1747, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''9''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''9'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1748, '2012-05-22', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''8''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1749, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''8''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''8'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1750, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''8''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''8'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1751, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''8''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''8'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1752, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''8''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''8'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1753, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''8''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''8'', ''1'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1754, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''8''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''8'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1755, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1756, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1757, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1758, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1759, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1760, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1761, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''8''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''8'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1762, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''17''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''17'', ''8'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1763, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''39''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''39'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1764, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''8''<br />nuevo =  ''4''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''8'', ''4'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1765, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''34''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''34'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1766, '2012-05-22', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''8''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''8'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1767, '2012-05-22', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1768, '2012-05-22', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1769, '2012-05-22', 101, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-18 15:58:12.225277-04:30<br />conectado = 1<br />sesion = cvnlol2bupjj73drgeo34hc4r5<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''8''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1771, '2012-05-22', 102, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''8'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1772, '2012-05-22', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-22 11:32:30.630779-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1773, '2012-05-22', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1774, '2012-05-22', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1775, '2012-05-22', 101, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-22 11:37:18.93082-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''8''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1776, '2012-05-22', 202, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''8'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1777, '2012-05-22', 102, 8, 'LEIDY SIFONTES', 'N/A', 'CHAGUARAMAS', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''8'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1778, '2012-05-22', 101, 9, 'RAFAEL ADAMES', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = <br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''9''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1779, '2012-05-22', 202, 9, 'RAFAEL ADAMES', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''9'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1780, '2012-05-22', 102, 9, 'RAFAEL ADAMES', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''9'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1781, '2012-05-22', 101, 10, 'LUIS ESTRADA', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = <br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''10''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1782, '2012-05-22', 202, 10, 'LUIS ESTRADA', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = m969b5r3osm7lrkkka3tbkg6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''10'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1783, '2012-05-22', 102, 10, 'LUIS ESTRADA', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''10'' AND sesion = ''m969b5r3osm7lrkkka3tbkg6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1784, '2012-05-22', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-20 23:05:11.882-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''m969b5r3osm7lrkkka3tbkg6s7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1785, '2012-05-22', 101, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-16 16:25:17.241602-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8nvtu4h2ht6hgmd7ld9uto8e85''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8nvtu4h2ht6hgmd7ld9uto8e85'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1786, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 8nvtu4h2ht6hgmd7ld9uto8e85<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''8nvtu4h2ht6hgmd7ld9uto8e85''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1787, '2012-05-22', 102, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''8nvtu4h2ht6hgmd7ld9uto8e85'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1788, '2012-05-22', 101, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-22 13:52:31.229683-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8nvtu4h2ht6hgmd7ld9uto8e85''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8nvtu4h2ht6hgmd7ld9uto8e85'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1789, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''348923798''<br />fecha_emision =  ''22-05-2012''<br />contrato =  null<br />kilogramos =  ''15000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''348923798'', ''22-05-2012'', null, ''15000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1790, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec_det', 'No data', 'id_guiarec = ''26''<br />subguia =  ''54564564654''<br />fecha =  ''15-05-2012''<br />descripcion =  ''''<br />', 'INSERT INTO si_guiarec_det (id_guiarec, subguia, fecha, descripcion)                     VALUES (''26'', ''54564564654'', ''15-05-2012'', '''')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1791, '2012-05-22', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_choferes', 'Register No.0<br />ced_rif = V16538158<br />nombre = JOSE TORRES<br />id = 13<br />id_org = 1<br />estatus = t<br />modificado = 2012-05-17 15:29:42.034425-04:30<br />', 'ced_rif = ''V16538158'', nombre = ''JOSE TORRES'', id = ''13'', id_org = ''1'', estatus = ''T'', modificado=now()', 'UPDATE si_choferes SET  ced_rif = ''V16538158'', nombre = ''JOSE TORRES'', id = ''13'', id_org = ''1'', estatus = ''T'', modificado=now() WHERE id=13', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1792, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'No data', 'id_cosecha = ''1''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />numero =  ''1''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''7''<br />id_guia =  ''26''<br />id_vehiculo =  ''42''<br />id_chofer =  ''13''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, numero, id_productor, id_asociacion, id_asociado, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''1'', ''NOW()'', ''1'', ''1'', ''5'', ''1'', ''2'', ''1'', ''2'', ''4'', ''7'', ''26'', ''42'', ''13'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1793, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''12.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''1'', ''3'', ''12.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1794, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''2'', ''3'', ''5.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1795, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''11.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''3'', ''3'', ''11.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1796, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''11.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''4'', ''3'', ''11.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1797, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''3.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''5'', ''3'', ''3.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1798, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''11.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''6'', ''3'', ''11.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1799, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''7'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1800, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''8'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1801, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''9'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1802, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''10'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1803, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''11'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1804, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''12'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1805, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.710''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''13'', ''3'', ''0.710'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1806, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''14'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1807, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''15'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1808, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''19'', ''3'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1809, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''21'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1810, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''22'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1811, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''23''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''23'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1812, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''24'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1813, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''26''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''SI''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''26'', ''20'', ''3'', ''SI'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1814, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cuarentena', 'No data', 'id_centro_acopio = ''2''<br />id_recepcion =  ''26''<br />id_cultivo =  ''1''<br />id_usuario =  ''3''<br />id_analisis =  ''20''<br />tipo_mov =  ''R''<br />fecha_mov =  ''NOW()''<br />fecha_cultivo =  ''NOW()''<br />laboratorio =  ''C''<br />creado = now()<br />', 'INSERT INTO si_cuarentena  (id_centro_acopio, id_recepcion, id_cultivo, id_usuario, id_analisis, tipo_mov, fecha_mov, fecha_cultivo, laboratorio, creado) VALUES  (''2'', ''26'', ''1'', ''3'', ''20'', ''R'', ''NOW()'', ''NOW()'', ''C'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1815, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 26<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''26'', estatus_rec = ''2'', muestra = ''1'', modificado=now()', 'UPDATE si_recepcion SET  id = ''26'', estatus_rec = ''2'', muestra = ''1'', modificado=now() WHERE id=26', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1816, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cuarentena', 'Register No.0<br />fecha_mov = 2012-05-22 13:57:11.570214-04:30<br />observa_admon = <br />id = 2<br />modificado = <br />', 'fecha_mov = ''22-05-2012'', observa_admon = ''CUARENTENA PRUEBA DE SISTEMAS'', id = ''2'', modificado=now()', 'UPDATE si_cuarentena SET  fecha_mov = ''22-05-2012'', observa_admon = ''CUARENTENA PRUEBA DE SISTEMAS'', id = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1817, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />numero = 1<br />id = 26<br />estatus_rec = 2<br />modificado = 2012-05-22 13:57:11.570214<br />', 'numero = ''1'', id = ''26'', estatus_rec = ''11'', modificado=now()', 'UPDATE si_recepcion SET  numero = ''1'', id = ''26'', estatus_rec = ''11'', modificado=now() WHERE id=26', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1818, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cuarentena', 'Register No.0<br />fecha_mov = 2012-05-22 00:00:00-04:30<br />observa_admon = CUARENTENA PRUEBA DE SISTEMAS<br />id_producto = <br />toneladas = <br />cant_producto = <br />fecha_cultivo = 2012-05-22 13:57:11.570214-04:30<br />hora_trab = <br />fecha_lib = <br />hora_lib = <br />observa_lab = <br />id = 2<br />estatus = <br />modificado = 2012-05-22 13:57:43.289405-04:30<br />', 'fecha_mov = ''2012-05-22'', observa_admon = ''CUARENTENA PRUEBA DE SISTEMAS'', id_producto = ''1'', toneladas = ''15'', cant_producto = ''60'', fecha_cultivo = ''2012-05-22'', hora_trab = ''01:58 PM'', fecha_lib = ''2012-05-24'', hora_lib = ''05:58 AM'', observa_lab = ''PRUEBAS DE SISTEMAS LABORATORIO'', id = ''2'', estatus = ''2'', modificado=now()', 'UPDATE si_cuarentena SET  fecha_mov = ''2012-05-22'', observa_admon = ''CUARENTENA PRUEBA DE SISTEMAS'', id_producto = ''1'', toneladas = ''15'', cant_producto = ''60'', fecha_cultivo = ''2012-05-22'', hora_trab = ''01:58 PM'', fecha_lib = ''2012-05-24'', hora_lib = ''05:58 AM'', observa_lab = ''PRUEBAS DE SISTEMAS LABORATORIO'', id = ''2'', estatus = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1819, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cuarentena_plaga', 'No data', 'id_cuarentena = ''2''<br />id_plaga =  ''1''<br />cantidad =  ''100''<br />', 'INSERT INTO si_cuarentena_plaga (id_cuarentena, id_plaga, cantidad) VALUES (''2'', ''1'', ''100'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1820, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''201202''<br />id_cultivo =  ''2''<br />nombre =  ''PROG ARROZ''<br />estatus =  ''T''<br />observacion =  null<br />fecha_inicio =  ''22-05-2012''<br />fecha_fin =  ''22-05-2013''<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, id_cultivo, nombre, estatus, observacion, fecha_inicio, fecha_fin, id_centro_acopio, creado) VALUES  (''201202'', ''2'', ''PROG ARROZ'', ''T'', null, ''22-05-2012'', ''22-05-2013'', ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1821, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha', 'No data', 'id_programa = ''6''<br />id_cultivo =  ''2''<br />codigo =  ''2012021''<br />nombre =  ''COSECHA ARROZ''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (id_programa, id_cultivo, codigo, nombre, proyectado, area_siembra, fecha_inicio, fecha_fin, estatus, creado) VALUES  (''6'', ''2'', ''2012021'', ''COSECHA ARROZ'', null, null, null, null, ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1822, '2012-05-22', 203, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'No data', 'DELETE FROM si_cosecha_productor                       WHERE id_cosecha = ''5'' AND id_centro_acopio = ''2''                       AND id_productor = ''2'' AND id_asociacion = ''4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1823, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''5''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''7''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''5'', ''2'', ''2'', ''4'', ''7'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1824, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''5''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''6''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''5'', ''2'', ''2'', ''4'', ''6'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1825, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''237894237''<br />fecha_emision =  ''22-05-2012''<br />contrato =  null<br />kilogramos =  ''15000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''237894237'', ''22-05-2012'', null, ''15000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1826, '2012-05-22', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_choferes', 'Register No.0<br />ced_rif = V9668397<br />nombre = JESUS SILVA<br />id = 14<br />id_org = 1<br />estatus = t<br />modificado = <br />', 'ced_rif = ''V9668397'', nombre = ''JESUS SILVA'', id = ''14'', id_org = ''1'', estatus = ''T'', modificado=now()', 'UPDATE si_choferes SET  ced_rif = ''V9668397'', nombre = ''JESUS SILVA'', id = ''14'', id_org = ''1'', estatus = ''T'', modificado=now() WHERE id=14', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1827, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'No data', 'id_cosecha = ''5''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />numero =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''6''<br />id_guia =  ''27''<br />id_vehiculo =  ''42''<br />id_chofer =  ''14''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, numero, id_productor, id_asociacion, id_asociado, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''5'', ''NOW()'', ''1'', ''1'', ''5'', ''1'', ''2'', ''2'', ''2'', ''4'', ''6'', ''27'', ''42'', ''14'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1828, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''773456455''<br />fecha_emision =  ''22-05-2012''<br />contrato =  null<br />kilogramos =  ''10000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''773456455'', ''22-05-2012'', null, ''10000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1829, '2012-05-22', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_choferes', 'Register No.0<br />ced_rif = V9668397<br />nombre = JESUS SILVA<br />id = 14<br />id_org = 1<br />estatus = t<br />modificado = 2012-05-22 14:03:19.559676-04:30<br />', 'ced_rif = ''V9668397'', nombre = ''JESUS SILVA'', id = ''14'', id_org = ''1'', estatus = ''T'', modificado=now()', 'UPDATE si_choferes SET  ced_rif = ''V9668397'', nombre = ''JESUS SILVA'', id = ''14'', id_org = ''1'', estatus = ''T'', modificado=now() WHERE id=14', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1830, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'No data', 'id_cosecha = ''5''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''2''<br />cant_muestras =  ''2''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />numero =  ''3''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''6''<br />id_guia =  ''28''<br />id_vehiculo =  ''42''<br />id_chofer =  ''14''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, numero, id_productor, id_asociacion, id_asociado, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''5'', ''NOW()'', ''2'', ''2'', ''5'', ''1'', ''2'', ''3'', ''2'', ''4'', ''6'', ''28'', ''42'', ''14'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1831, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''16.000''<br />muestra2 =  ''16.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''1'', ''3'', ''16.000'', ''16.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1832, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''2'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1833, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''14'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1834, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1835, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''B''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''22'', ''3'', ''A'', ''B'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1836, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''24'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1837, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1838, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''25''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''25'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1839, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''26''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''26'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1840, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''27''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''27'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1841, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''28''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''28'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1842, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''29''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''29'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1843, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''30''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''30'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1844, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''31''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''31'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1845, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''32''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''32'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1846, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''33''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''33'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1847, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''36''<br />id_usuario =  ''3''<br />muestra1 =  ''40.000''<br />muestra2 =  ''40.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''36'', ''3'', ''40.000'', ''40.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1848, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''37''<br />id_usuario =  ''3''<br />muestra1 =  ''59.000''<br />muestra2 =  ''59.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''37'', ''3'', ''59.000'', ''59.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1849, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''28''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''22.000''<br />muestra2 =  ''22.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''28'', ''38'', ''3'', ''22.000'', ''22.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1850, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 28<br />estatus_rec = 1<br />modificado = <br />', 'id = ''28'', estatus_rec = ''3'', modificado=now()', 'UPDATE si_recepcion SET  id = ''28'', estatus_rec = ''3'', modificado=now() WHERE id=28', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1851, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion_cultivo_tipo', 'No data', 'id_centro_acopio = ''2''<br />id_recepcion =  ''28''<br />id_cultivo =  ''2''<br />laboratorio =  ''C''<br />tipo =  ''A''<br />creado = now()<br />', 'INSERT INTO si_recepcion_cultivo_tipo  (id_centro_acopio, id_recepcion, id_cultivo, laboratorio, tipo, creado) VALUES  (''2'', ''28'', ''2'', ''C'', ''A'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1852, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cliente', 'No data', 'ced_rif = ''V18264065''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />id_sap =  null<br />ref =  null<br />telefono =  null<br />fax =  null<br />email_org =  null<br />edo_civil =  ''1''<br />direccion =  null<br />id_pais =  ''1''<br />contacto1_nombre =  null<br />contacto1_telefono =  null<br />contacto1_email =  null<br />contacto2_nombre =  null<br />contacto2_telefono =  null<br />contacto2_email =  null<br />contacto3_nombre =  null<br />contacto3_telefono =  null<br />contacto3_email =  null<br />id_estado =  ''5''<br />id_municipio =  ''51''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cliente  (ced_rif, nombre, id_org, id_sap, ref, telefono, fax, email_org, edo_civil, direccion, id_pais, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_estado, id_municipio, estatus, creado) VALUES  (''V18264065'', ''JESUS RODRIGUEZ'', ''1'', null, null, null, null, null, ''1'', null, ''1'', null, null, null, null, null, null, null, null, null, ''5'', ''51'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1853, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_ordenes', 'No data', 'numero_orden = ''56021214''<br />id_cliente =  ''14''<br />fecha_emision =  ''08-05-2012''<br />toneladas =  ''200''<br />descuento =  ''F''<br />cod_verificacion =  ''56021897''<br />id_centro_acopio =  ''2''<br />id_cultivo =  ''2''<br />estatus =  ''N''<br />creado = now()<br />', 'INSERT INTO si_ordenes  (numero_orden, id_cliente, fecha_emision, toneladas, descuento, cod_verificacion, id_centro_acopio, id_cultivo, estatus, creado) VALUES  (''56021214'', ''14'', ''08-05-2012'', ''200'', ''F'', ''56021897'', ''2'', ''2'', ''N'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1854, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'No data', 'id_orden = ''8''<br />id_cultivo =  ''10''<br />id_cliente =  ''4''<br />id_chofer =  ''14''<br />cant_muestras =  ''1''<br />id_centro_acopio =  ''2''<br />numero =  ''1''<br />id_vehiculo =  ''42''<br />id_usuario =  ''5''<br />id_transporte =  ''2''<br />id_punto_entrega =  ''4''<br />fecha_des =  ''NOW()''<br />id_silo =  ''2''<br />estatus =  ''1''<br />creado = now()<br />', 'INSERT INTO si_despacho  (id_orden, id_cultivo, id_cliente, id_chofer, cant_muestras, id_centro_acopio, numero, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, fecha_des, id_silo, estatus, creado) VALUES  (''8'', ''10'', ''4'', ''14'', ''1'', ''2'', ''1'', ''42'', ''5'', ''2'', ''4'', ''NOW()'', ''2'', ''1'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1855, '2012-05-22', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'No data', 'id_orden = ''8''<br />id_cultivo =  ''10''<br />id_cliente =  ''4''<br />id_chofer =  ''14''<br />cant_muestras =  ''2''<br />id_centro_acopio =  ''2''<br />numero =  ''2''<br />id_vehiculo =  ''42''<br />id_usuario =  ''5''<br />id_transporte =  ''2''<br />id_punto_entrega =  ''4''<br />fecha_des =  ''NOW()''<br />id_silo =  ''2''<br />estatus =  ''1''<br />creado = now()<br />', 'INSERT INTO si_despacho  (id_orden, id_cultivo, id_cliente, id_chofer, cant_muestras, id_centro_acopio, numero, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, fecha_des, id_silo, estatus, creado) VALUES  (''8'', ''10'', ''4'', ''14'', ''2'', ''2'', ''2'', ''42'', ''5'', ''2'', ''4'', ''NOW()'', ''2'', ''1'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1856, '2012-05-22', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />id = 21<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''5'', peso_01v = ''48705'', id = ''21'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''48705'', id = ''21'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=21', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1857, '2012-05-22', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'm969b5r3osm7lrkkka3tbkg6s7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />peso_02v = <br />id = 22<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''6'', peso_01v = ''27523'', peso_02v = ''24704'', id = ''22'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''6'', peso_01v = ''27523'', peso_02v = ''24704'', id = ''22'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=22', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1858, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''13.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''1'', ''3'', ''13.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1859, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''8.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''2'', ''3'', ''8.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1860, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''14'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1861, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''21'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1862, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''22'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1863, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''24'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1864, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''SI''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''20'', ''3'', ''SI'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1865, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''25''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''25'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1866, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''26''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''26'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1867, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''27''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''27'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1868, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''28''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''28'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1869, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''29''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''29'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1870, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''30''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''30'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1871, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''31''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''31'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1872, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''32''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''32'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1873, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''33''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''33'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1874, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''36''<br />id_usuario =  ''3''<br />muestra1 =  ''46.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''36'', ''3'', ''46.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1875, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''37''<br />id_usuario =  ''3''<br />muestra1 =  ''50.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''37'', ''3'', ''50.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1876, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''21''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''20.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''21'', ''38'', ''3'', ''20.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1877, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cuarentena', 'No data', 'id_centro_acopio = ''2''<br />id_recepcion =  ''21''<br />id_cultivo =  ''2''<br />id_usuario =  ''3''<br />id_analisis =  ''20''<br />tipo_mov =  ''D''<br />fecha_mov =  ''NOW()''<br />fecha_cultivo =  ''NOW()''<br />laboratorio =  ''C''<br />creado = now()<br />', 'INSERT INTO si_cuarentena  (id_centro_acopio, id_recepcion, id_cultivo, id_usuario, id_analisis, tipo_mov, fecha_mov, fecha_cultivo, laboratorio, creado) VALUES  (''2'', ''21'', ''2'', ''3'', ''20'', ''D'', ''NOW()'', ''NOW()'', ''C'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1878, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 21<br />estatus = 2<br />modificado = 2012-05-22 14:33:54.028102-04:30<br />', 'id = ''21'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''21'', estatus = ''3'', modificado=now() WHERE id=21', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1879, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''12.000''<br />muestra2 =  ''12.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''1'', ''3'', ''12.000'', ''12.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1880, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''8.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''2'', ''3'', ''8.000'', ''8.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1881, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''40.000''<br />muestra2 =  ''40.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''14'', ''3'', ''40.000'', ''40.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1882, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1883, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1884, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''24'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1885, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1886, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''25''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''25'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1887, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''26''<br />id_usuario =  ''3''<br />muestra1 =  ''8.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''26'', ''3'', ''8.000'', ''8.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1888, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''27''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''27'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1889, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''28''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''28'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1890, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''29''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''29'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1891, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''30''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''30'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1892, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''31''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''31'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1893, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''32''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''32'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1894, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''33''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''33'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1895, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''36''<br />id_usuario =  ''3''<br />muestra1 =  ''46.000''<br />muestra2 =  ''46.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''36'', ''3'', ''46.000'', ''46.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1896, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''37''<br />id_usuario =  ''3''<br />muestra1 =  ''50.000''<br />muestra2 =  ''50.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''37'', ''3'', ''50.000'', ''50.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1897, '2012-05-22', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''22''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''20.000''<br />muestra2 =  ''20.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''22'', ''38'', ''3'', ''20.000'', ''20.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (1898, '2012-05-22', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '8nvtu4h2ht6hgmd7ld9uto8e85', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 22<br />estatus = 2<br />modificado = 2012-05-22 14:34:05.622568-04:30<br />', 'id = ''22'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''22'', estatus = ''3'', modificado=now() WHERE id=22', '');


--
-- TOC entry 2475 (class 0 OID 26762)
-- Dependencies: 201
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (14, 'M_Cosecha', 3, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (15, 'M_Cultivo', 3, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (13, 'M_Programas', 3, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (19, 'M_Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (23, 'M_ConfigCta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (24, 'M_Organizacion', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (25, 'M_Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (21, 'M_Formulas', 4, 'admin/formulacion_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (16, 'M_Productores', 3, NULL, true, 4, NULL, NULL);
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
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (5, 'M_Cuenta', 0, NULL, true, 5, NULL, NULL);
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


--
-- TOC entry 2476 (class 0 OID 26767)
-- Dependencies: 202
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 4, 7, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (40, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (42, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (5, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (23, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (24, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (6, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (7, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (39, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (40, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (21, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (5, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (23, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (42, 3, 0, 1, 0, 0);
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


--
-- TOC entry 2477 (class 0 OID 26776)
-- Dependencies: 204
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
-- TOC entry 2478 (class 0 OID 26782)
-- Dependencies: 206
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (8, 2, 4, 10, 56101201, '2012-05-11 00:00:00-04:30', NULL, 125000, NULL, 'N', NULL, '2012-05-14 16:26:49.478641-04:30', NULL, '56226695');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (20, 2, 14, 2, 56021214, '2012-05-08 00:00:00-04:30', NULL, 200, false, 'N', NULL, '2012-05-22 14:22:11.020151-04:30', NULL, '56021897');


--
-- TOC entry 2479 (class 0 OID 26790)
-- Dependencies: 207
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2480 (class 0 OID 26797)
-- Dependencies: 210
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2481 (class 0 OID 26806)
-- Dependencies: 212
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'VENEZUELA');


--
-- TOC entry 2482 (class 0 OID 26812)
-- Dependencies: 214
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
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (12, 'REFGUIA', 'MAT - SADA - INSAE', 'Referencias de Subguia', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);


--
-- TOC entry 2483 (class 0 OID 26821)
-- Dependencies: 216
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (1, 'GERENTE GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (9, 'DESPACHO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (3, 'ADMINISTRADOR GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (8, 'RECEPCION', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (7, 'ROMANERO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (5, 'CALIDAD GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (2, 'GERENTE DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (4, 'ADMINISTRADOR DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (6, 'CALIDAD DE SILO', '2012-02-07 00:00:00-04:30', NULL);


--
-- TOC entry 2484 (class 0 OID 26825)
-- Dependencies: 217
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
-- TOC entry 2485 (class 0 OID 26830)
-- Dependencies: 219
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2486 (class 0 OID 26837)
-- Dependencies: 222
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (7, 1, NULL, 'V16269763', NULL, 'PRODUCTOR 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:16.897952-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (8, 1, NULL, 'V15610226', NULL, 'PRODUCTOR 3', NULL, NULL, NULL, NULL, NULL, 1, 14, 160, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 16:12:42.012754-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (6, 1, NULL, 'V17247200', NULL, 'PRODUCTOR 1', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:00.31368-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (10, 1, NULL, 'V12789456', NULL, 'PRODUCTOR 5', NULL, NULL, NULL, NULL, NULL, 1, 16, 203, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 11:06:26.497-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (11, 1, NULL, 'V10123456', NULL, 'PRODUCTOR 6', NULL, NULL, NULL, NULL, NULL, 1, 5, 43, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 14:24:04.48-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (9, 1, NULL, 'V14785236', NULL, 'PRODUCTOR 4', NULL, NULL, NULL, NULL, NULL, 1, 24, 319, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 10:24:44.811-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (2, 1, NULL, 'G00000000', NULL, 'BANCO AGRICOLA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:25.998447-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (3, 1, NULL, 'G00000001', NULL, 'FONDAS', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:56.023047-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (4, 1, NULL, 'G00123456', NULL, 'CONSEJO COMUNAL 1', NULL, NULL, NULL, NULL, NULL, 1, 8, 91, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:22.105165-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (5, 1, NULL, 'G00456789', NULL, 'CONSEJO COMUNAL 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:41.603699-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (12, 1, NULL, 'G00789456', NULL, 'CONSEJO COMUNAL 3', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 22:58:46.545-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (13, 1, NULL, 'G00123456', NULL, 'CONSEJO COMUNAL 4', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 08:34:16.836892-04:30', '2012-05-03 15:20:51.557328-04:30');


--
-- TOC entry 2487 (class 0 OID 26846)
-- Dependencies: 224
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (2, 2, 'INVIERNO 2012', 'INVIERNO 2012', '2012-04-18 15:25:47.739787-04:30', NULL, true, '201201', '2012-09-03', '2013-09-03', 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (3, 2, 'PROGRAMA SORGO', NULL, '2012-04-29 22:43:28.902-04:30', '2012-05-03 15:03:26.829691-04:30', true, '201203', '2012-04-29', '2013-04-29', 3);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (4, 2, 'PROGRAMA GIRASOL', NULL, '2012-05-07 00:19:27.451-04:30', NULL, true, '201212', '2012-05-07', '2013-05-07', 12);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (5, 3, 'MAIZ SABANA DE P', NULL, '2012-05-17 15:08:09.679749-04:30', NULL, true, '201201', '2012-05-17', '2013-05-17', 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (6, 2, 'PROG ARROZ', NULL, '2012-05-22 14:01:51.803232-04:30', NULL, true, '201202', '2012-05-22', '2013-05-22', 2);


--
-- TOC entry 2488 (class 0 OID 26853)
-- Dependencies: 225
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2489 (class 0 OID 26861)
-- Dependencies: 227
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (4, 4, NULL, NULL, NULL, NULL, 'CHAGUARAMAS', NULL, NULL, NULL, '2012-05-14 16:31:42.218487', NULL, NULL);


--
-- TOC entry 2490 (class 0 OID 26869)
-- Dependencies: 229
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (10, 2, 1, NULL, 2, 10, 5, 1, '2012-05-11 10:53:44.289468-04:30', 1, '2012-05-11 13:44:49.351478-04:30', 30509, 34221, NULL, '2012-05-11 14:45:43.175191-04:30', 20475, 20146, 12, 0, 1096, 460, '2012-05-11 10:53:44.289468-04:30', '2012-05-11 14:45:43.175191', 2, 18, 13, 5, 5, NULL, 22553, 0, 9, 4, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (17, 2, 1, NULL, 3, 17, 5, 8, '2012-05-11 15:10:48.737671-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:10:48.737671-04:30', '2012-05-11 15:31:05.736435', 1, 28, 13, NULL, NULL, NULL, NULL, 0, 3, NULL, 10);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (18, 2, 2, NULL, 2, 18, 5, 9, '2012-05-11 15:43:25.121714-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:43:25.121714-04:30', '2012-05-11 16:00:33.746091', 1, 30, 13, NULL, NULL, NULL, NULL, 1, 11, 12, 10);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (19, 2, 3, NULL, 10, 19, 5, 10, '2012-05-11 16:07:00.187586-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 16:07:00.187586-04:30', NULL, 1, 32, 13, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (21, 2, 1, NULL, 2, 21, 5, 1, '2012-05-15 11:33:44.415664-04:30', 1, '2012-05-15 11:34:28.810589-04:30', 41822, NULL, NULL, '2012-05-15 11:34:55.810439-04:30', 19292, NULL, 12, 0, NULL, NULL, '2012-05-15 11:33:44.415664-04:30', '2012-05-15 11:34:55.810439', 1, 26, 13, 5, 5, NULL, 22530, 0, 9, 5, 8);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (23, 2, 1, NULL, 2, 23, 5, 3, '2012-05-15 16:31:57.351332-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-15 16:31:57.351332-04:30', NULL, 2, 17, 13, NULL, NULL, NULL, NULL, 0, 1, 4, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (24, 2, 2, NULL, 2, 24, 5, 4, '2012-05-15 16:34:05.29467-04:30', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-15 16:34:05.29467-04:30', NULL, 1, 41, 26, NULL, NULL, NULL, NULL, 0, 1, 12, 11);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (22, 2, 1, NULL, 2, 22, 5, 2, '2012-05-15 13:38:04.836066-04:30', 1, '2012-05-15 13:38:51.100021-04:30', 22717, 25973, NULL, '2012-05-15 13:39:25.011505-04:30', 10411, 12000, 12, 2, 149, 653, '2012-05-15 13:38:04.836066-04:30', '2012-05-15 13:39:25.011505', 2, 17, 13, 5, 5, NULL, 25476, 0, 9, 4, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (11, 2, 1, NULL, 2, 11, 5, 2, '2012-05-11 10:54:45.201067-04:30', 1, '2012-05-11 13:45:01.60294-04:30', 40755, NULL, NULL, '2012-05-11 14:46:07.66782-04:30', 33856, NULL, 13, 4, 78, 273, '2012-05-11 10:54:45.201067-04:30', '2012-05-11 14:46:07.66782', 1, 19, 14, 6, 6, NULL, 6548, 0, 9, 4, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (25, 3, 4, NULL, 2, 25, 2, 1, '2012-05-17 15:29:42.034425-04:30', 1, '2012-05-17 15:36:13.724105-04:30', 32930, 24871, NULL, '2012-05-17 15:37:48.697534-04:30', 22609, 13402, 12, 2, 124, 542, '2012-05-17 15:29:42.034425-04:30', '2012-05-17 15:37:48.697534', 2, 18, 13, 11, 11, NULL, 21125, 0, 9, 4, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (12, 2, 2, NULL, 3, 12, 5, 3, '2012-05-11 10:58:07.51559-04:30', 2, '2012-05-11 13:45:09.151378-04:30', 20687, NULL, NULL, '2012-05-11 14:47:00.024669-04:30', 9694, NULL, 13, 8, 125, 869, '2012-05-11 10:58:07.51559-04:30', '2012-05-11 14:47:00.024669', 1, 21, 13, 5, 6, NULL, 9999, 0, 9, 4, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (13, 2, 2, NULL, 7, 13, 5, 4, '2012-05-11 10:58:29.375606-04:30', 1, '2012-05-11 13:45:15.221446-04:30', 43136, 35716, NULL, '2012-05-11 14:47:55.727065-04:30', 19682, 7820, 15, 9, 1167, 4266, '2012-05-11 10:58:29.375606-04:30', '2012-05-11 14:47:55.727065', 2, 19, 14, 5, 5, NULL, 45917, 0, 9, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (14, 2, 3, NULL, 8, 14, 5, 5, '2012-05-11 11:01:04.877065-04:30', 2, '2012-05-11 13:45:20.226478-04:30', 33083, NULL, NULL, '2012-05-11 14:48:15.588618-04:30', 23826, NULL, 9, 0.5, NULL, NULL, '2012-05-11 11:01:04.877065-04:30', '2012-05-11 14:48:15.588618', 1, 19, 14, 6, 6, 9257, 9257, 0, 9, NULL, 11);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (16, 2, 1, NULL, 2, 16, 5, 7, '2012-05-11 14:44:04.70865-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 14:44:04.70865-04:30', '2012-05-11 15:01:33.393072', 1, 26, 13, NULL, NULL, NULL, NULL, 0, 3, 4, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (20, 2, 3, NULL, 10, 20, 5, 1, '2012-05-14 14:31:58.405515-04:30', 1, '2012-05-14 14:46:58.250043-04:30', 49026, NULL, NULL, '2012-05-20 23:19:51.987-04:30', 33820, NULL, 9, 7, NULL, NULL, '2012-05-14 14:31:58.405515-04:30', '2012-05-20 23:19:51.987', 1, 34, 13, 5, 5, 14273, 14902, 0, 9, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (15, 2, 3, NULL, 10, 15, 5, 6, '2012-05-11 11:01:25.253897-04:30', 1, '2012-05-20 23:33:06.356-04:30', 30366, 31307, NULL, '2012-05-20 23:41:32.098-04:30', 25804, 13572, 10, 5, NULL, NULL, '2012-05-11 11:01:25.253897-04:30', '2012-05-20 23:41:32.098', 2, 21, 13, 5, 5, 20690, 21628, 0, 9, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (26, 2, 1, NULL, 2, 26, 5, 1, '2012-05-22 13:53:04.938937-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-22 13:53:04.938937-04:30', '2012-05-22 13:57:43.289405', 1, 42, 13, NULL, NULL, NULL, NULL, 1, 11, 4, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (27, 2, 5, NULL, 2, 27, 5, 2, '2012-05-22 14:03:19.559676-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-22 14:03:19.559676-04:30', NULL, 1, 42, 14, NULL, NULL, NULL, NULL, 0, 1, 4, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec, id_asociacion, id_asociado) VALUES (28, 2, 5, NULL, 2, 28, 5, 3, '2012-05-22 14:04:03.968722-04:30', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-22 14:04:03.968722-04:30', '2012-05-22 14:19:10.616995', 2, 42, 14, NULL, NULL, NULL, NULL, 0, 3, 4, 6);


--
-- TOC entry 2491 (class 0 OID 26876)
-- Dependencies: 230
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion_cultivo_tipo (id, id_recepcion, id_centro_acopio, id_cultivo, laboratorio, tipo, creado, modificado) VALUES (1, 28, 2, 2, 'C ', 'A ', '2012-05-22 14:19:10.616995-04:30', NULL);


--
-- TOC entry 2492 (class 0 OID 26883)
-- Dependencies: 233
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


--
-- TOC entry 2493 (class 0 OID 26890)
-- Dependencies: 234
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
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (18, 1, 'M_Cultivo', 'Cultivo', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (19, 1, 'M_Programas', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (20, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (21, 1, 'M_Productor', 'Productor', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (22, 1, 'M_Recepcion', 'Recepci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (23, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (24, 1, 'M_Programa', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (25, 1, 'M_Cosecha', 'Cosechas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (26, 1, 'M_Cultivo', 'Cultivos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (27, 1, 'M_Productores', 'Productores', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (28, 1, 'M_Recepciones', 'Recepciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (29, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (30, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (31, 1, 'M_Usuarios', 'Usuarios', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (33, 1, 'M_Configuracion', 'Configuraci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (34, 1, 'M_ConfigCta', 'Config. Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (35, 1, 'M_Organizacion', 'Organizaciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (36, 1, 'M_Almacenes', 'Almacenes', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (32, 1, 'M_Formulas', 'F&oacute;rmulas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (40, 3, 'E_FueraNorma', 'El valor indicado está fuera de norma.!!!', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (39, 1, 'M_Romana', 'Romana', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (38, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (37, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (41, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (42, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (53, 1, 'M_GerenteRecepcion', 'Gerente Recepci&oacute;n', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (43, 1, 'M_Chofer', 'Chofer', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (54, 1, 'M_GerenteDespacho', 'Gerente Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (52, 1, 'M_CuarentenaPendiente', 'Cuarentenas Pendientes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (50, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (49, 1, 'M_Auditoria', 'Auditoria del Sistema', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (48, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (44, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (45, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (46, 1, 'M_Ordenes', 'Ordenes de Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (47, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (55, 1, 'M_UtilitarioRecepciones', 'Utilitario Recepciones', 1, '2012-05-11 00:00:00-04:30', NULL);


--
-- TOC entry 2494 (class 0 OID 26903)
-- Dependencies: 238
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
-- TOC entry 2495 (class 0 OID 26913)
-- Dependencies: 240
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
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.255:9600');
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.255:9601');


--
-- TOC entry 2496 (class 0 OID 26919)
-- Dependencies: 241
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_transporte (id, id_centro_acopio, rif, nombre, contacto, direccion, telefono1, telefono2, fax, email, id_pais, id_estado, id_municipio, creado, modificado) VALUES (2, 2, NULL, 'ASOTRAMACHA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:31:42.218487-04:30', NULL);


--
-- TOC entry 2497 (class 0 OID 26929)
-- Dependencies: 244
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, 'JUANCARRIZALEZ@AGROPATRIA.CO.VE', '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-05-17 15:28:30.825707-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'JESUSRODRIGUEZ@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-05-15 15:47:23.514447-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'JOSEPELUZZO@AGROPATRIA.CO.VE', '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, '2012-05-22 11:37:47.959291-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (8, 'LEIDY', 'SIFONTES', '123456', NULL, 'F', 'LSIFONTES', 'E34A43F70CD2570DC01BAAF1667C2FC91BBAACE6', NULL, NULL, NULL, '2012-05-18 15:54:34.262069-04:30', NULL, true, 0, NULL, '2012-05-22 11:38:59.961109-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (9, 'RAFAEL', 'ADAMES', '123456', NULL, 'M', 'RADAMES', 'E7B47259793917A0BECEDA2C5E00D3CB08B69F57', NULL, NULL, NULL, '2012-05-22 11:33:31.825155-04:30', NULL, true, 0, NULL, '2012-05-22 11:39:29.221623-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (10, 'LUIS', 'ESTRADA', '123456', NULL, 'M', 'LESTRADA', '311E0C5E77F8A19D144E3AFED36912889EBAAE1C', NULL, NULL, NULL, '2012-05-22 11:34:14.980207-04:30', NULL, true, 0, NULL, '2012-05-22 11:39:51.95883-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (5, 'MARIELY', 'CORONADO', '16538158', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 1, 'm969b5r3osm7lrkkka3tbkg6s7', '2012-05-22 13:32:26.849422-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JUANTABORDA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 1, '8nvtu4h2ht6hgmd7ld9uto8e85', '2012-05-22 13:52:45.373114-04:30');


--
-- TOC entry 2498 (class 0 OID 26940)
-- Dependencies: 246
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (6, 6, 2, 8, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (5, 5, 2, 2, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 3, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (8, 8, 4, 4, '2012-05-18 15:54:34.286197-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (9, 9, 2, 4, '2012-05-22 11:33:31.853499-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (10, 10, 2, 4, '2012-05-22 11:34:15.008645-04:30', NULL);


--
-- TOC entry 2499 (class 0 OID 26944)
-- Dependencies: 247
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (17, '125MNJU', 'FORD', 'GRIS', 5000, NULL, NULL, NULL, '2012-05-11 10:52:24.547132-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (19, 'DAW06R', 'FIAT', 'ROJO', 120, NULL, NULL, NULL, '2012-05-11 10:54:26.103604-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (21, '147ÑLOJ', 'CHEVROLET', 'NEGRO', 3000, NULL, NULL, NULL, '2012-05-11 10:57:50.343025-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (26, '125MJH', 'FORD', 'AZUL', 2000, NULL, NULL, NULL, '2012-05-11 14:42:53.356585-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (28, '1453689', 'TOYOTA', NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:10:27.540816-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (30, 'HGYTJUY', 'VOLVO', 'BLANCO', NULL, NULL, NULL, NULL, '2012-05-11 15:43:16.293216-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (32, '1458796', 'VOLVO', NULL, NULL, NULL, NULL, NULL, '2012-05-11 16:06:53.14973-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (18, '125MNJ', 'FORD', NULL, NULL, NULL, NULL, '147LKJU', '2012-05-11 10:53:44.289468-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (34, '2458KJU', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 14:31:31.07605-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (36, '254ñLK', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:15:53.890513-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (37, '123BNM', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:27:57.722339-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (38, '123MNB', 'VOVLO', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:29:29.815347-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (41, '123123', 'NUEVA', 'NUEVO', NULL, NULL, NULL, NULL, '2012-05-15 16:33:58.872515-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (42, 'QWEQWE', 'QWEQWE', 'QWE', NULL, NULL, NULL, NULL, '2012-05-15 16:36:26.862256-04:30', NULL);


--
-- TOC entry 2232 (class 2606 OID 26976)
-- Dependencies: 152 152
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2278 (class 2606 OID 26978)
-- Dependencies: 197 197
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2220 (class 2606 OID 26980)
-- Dependencies: 141 141
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2606 OID 26982)
-- Dependencies: 144 144
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 26984)
-- Dependencies: 146 146
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 26986)
-- Dependencies: 143 143 143
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2224 (class 2606 OID 26988)
-- Dependencies: 143 143
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 26990)
-- Dependencies: 150 150
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 26992)
-- Dependencies: 153 153
-- Name: si_asociacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociacion
    ADD CONSTRAINT si_asociacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 26994)
-- Dependencies: 156 156
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 26996)
-- Dependencies: 158 158
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 26998)
-- Dependencies: 160 160
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 27000)
-- Dependencies: 162 162
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 27002)
-- Dependencies: 163 163
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 27004)
-- Dependencies: 166 166
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 27006)
-- Dependencies: 168 168
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 27008)
-- Dependencies: 170 170 170 170
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2252 (class 2606 OID 27010)
-- Dependencies: 170 170
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 27012)
-- Dependencies: 172 172
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 27014)
-- Dependencies: 174 174
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 27016)
-- Dependencies: 177 177
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 27018)
-- Dependencies: 178 178
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 27020)
-- Dependencies: 181 181
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2264 (class 2606 OID 27022)
-- Dependencies: 182 182
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 27024)
-- Dependencies: 185 185
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2268 (class 2606 OID 27026)
-- Dependencies: 187 187
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 27028)
-- Dependencies: 188 188
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2272 (class 2606 OID 27030)
-- Dependencies: 190 190
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 27032)
-- Dependencies: 192 192
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2276 (class 2606 OID 27034)
-- Dependencies: 193 193
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 27036)
-- Dependencies: 199 199
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2282 (class 2606 OID 27038)
-- Dependencies: 201 201
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2284 (class 2606 OID 27040)
-- Dependencies: 202 202 202
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2286 (class 2606 OID 27042)
-- Dependencies: 204 204
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 27044)
-- Dependencies: 207 207
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 27046)
-- Dependencies: 206 206
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2292 (class 2606 OID 27048)
-- Dependencies: 210 210
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 27050)
-- Dependencies: 212 212
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 27052)
-- Dependencies: 214 214
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 27054)
-- Dependencies: 216 216
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2300 (class 2606 OID 27056)
-- Dependencies: 217 217
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 27058)
-- Dependencies: 219 219
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2304 (class 2606 OID 27060)
-- Dependencies: 222 222
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2306 (class 2606 OID 27062)
-- Dependencies: 224 224
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2308 (class 2606 OID 27064)
-- Dependencies: 225 225
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 27066)
-- Dependencies: 227 227
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2314 (class 2606 OID 27068)
-- Dependencies: 230 230
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2312 (class 2606 OID 27070)
-- Dependencies: 229 229
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2318 (class 2606 OID 27072)
-- Dependencies: 234 234
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 27074)
-- Dependencies: 233 233
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2320 (class 2606 OID 27076)
-- Dependencies: 238 238
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2322 (class 2606 OID 27078)
-- Dependencies: 240 240
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2324 (class 2606 OID 27080)
-- Dependencies: 241 241
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2330 (class 2606 OID 27082)
-- Dependencies: 246 246
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2326 (class 2606 OID 27084)
-- Dependencies: 244 244
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2328 (class 2606 OID 27086)
-- Dependencies: 244 244
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2332 (class 2606 OID 27088)
-- Dependencies: 247 247
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2333 (class 2606 OID 27089)
-- Dependencies: 141 2241 162
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2334 (class 2606 OID 27094)
-- Dependencies: 187 2267 141
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2335 (class 2606 OID 27099)
-- Dependencies: 141 204 2285
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2336 (class 2606 OID 27104)
-- Dependencies: 2293 212 141
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2338 (class 2606 OID 27109)
-- Dependencies: 2223 144 143
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2339 (class 2606 OID 27114)
-- Dependencies: 144 2241 162
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2340 (class 2606 OID 27119)
-- Dependencies: 2223 143 146
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2341 (class 2606 OID 27124)
-- Dependencies: 146 2291 210
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2342 (class 2606 OID 27129)
-- Dependencies: 143 2223 148
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2343 (class 2606 OID 27134)
-- Dependencies: 2291 210 148
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2337 (class 2606 OID 27139)
-- Dependencies: 2291 210 143
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2344 (class 2606 OID 27144)
-- Dependencies: 150 143 2223
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2345 (class 2606 OID 27149)
-- Dependencies: 2263 182 150
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2346 (class 2606 OID 27154)
-- Dependencies: 2311 229 150
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2347 (class 2606 OID 27159)
-- Dependencies: 150 244 2325
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2348 (class 2606 OID 27164)
-- Dependencies: 2219 158 141
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2349 (class 2606 OID 27169)
-- Dependencies: 158 2239 160
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2350 (class 2606 OID 27174)
-- Dependencies: 244 2325 158
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2351 (class 2606 OID 27179)
-- Dependencies: 187 2267 162
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2352 (class 2606 OID 27184)
-- Dependencies: 2285 204 162
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2353 (class 2606 OID 27189)
-- Dependencies: 2291 162 210
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2354 (class 2606 OID 27194)
-- Dependencies: 162 2293 212
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2355 (class 2606 OID 27199)
-- Dependencies: 163 2291 210
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2356 (class 2606 OID 27204)
-- Dependencies: 2291 210 166
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2357 (class 2606 OID 27209)
-- Dependencies: 177 2257 168
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2358 (class 2606 OID 27214)
-- Dependencies: 168 224 2305
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2359 (class 2606 OID 27219)
-- Dependencies: 169 2241 162
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2360 (class 2606 OID 27224)
-- Dependencies: 169 2247 168
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2361 (class 2606 OID 27229)
-- Dependencies: 2303 222 169
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2362 (class 2606 OID 27234)
-- Dependencies: 170 2247 168
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2363 (class 2606 OID 27239)
-- Dependencies: 2257 177 170
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2364 (class 2606 OID 27244)
-- Dependencies: 170 2319 238
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2365 (class 2606 OID 27249)
-- Dependencies: 143 2223 172
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2366 (class 2606 OID 27254)
-- Dependencies: 2241 172 162
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2367 (class 2606 OID 27259)
-- Dependencies: 177 172 2257
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2368 (class 2606 OID 27264)
-- Dependencies: 172 2311 229
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2369 (class 2606 OID 27269)
-- Dependencies: 244 172 2325
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2370 (class 2606 OID 27274)
-- Dependencies: 2253 172 174
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2371 (class 2606 OID 27279)
-- Dependencies: 177 210 2291
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2372 (class 2606 OID 27284)
-- Dependencies: 2223 143 178
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2373 (class 2606 OID 27289)
-- Dependencies: 178 162 2241
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2374 (class 2606 OID 27294)
-- Dependencies: 2257 177 178
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2375 (class 2606 OID 27299)
-- Dependencies: 2257 177 181
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2376 (class 2606 OID 27304)
-- Dependencies: 210 181 2291
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2377 (class 2606 OID 27309)
-- Dependencies: 162 182 2241
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2378 (class 2606 OID 27314)
-- Dependencies: 182 166 2245
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2379 (class 2606 OID 27319)
-- Dependencies: 182 177 2257
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2380 (class 2606 OID 27324)
-- Dependencies: 2287 182 206
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2381 (class 2606 OID 27329)
-- Dependencies: 182 2309 227
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2382 (class 2606 OID 27334)
-- Dependencies: 182 238 2319
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2383 (class 2606 OID 27339)
-- Dependencies: 2323 182 241
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2384 (class 2606 OID 27344)
-- Dependencies: 182 244 2325
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2385 (class 2606 OID 27349)
-- Dependencies: 247 2331 182
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2386 (class 2606 OID 27354)
-- Dependencies: 2291 185 210
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2387 (class 2606 OID 27359)
-- Dependencies: 212 187 2293
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2388 (class 2606 OID 27364)
-- Dependencies: 188 187 2267
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2389 (class 2606 OID 27369)
-- Dependencies: 188 204 2285
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2390 (class 2606 OID 27374)
-- Dependencies: 2291 188 210
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2391 (class 2606 OID 27379)
-- Dependencies: 188 212 2293
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2392 (class 2606 OID 27384)
-- Dependencies: 188 222 2303
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2393 (class 2606 OID 27389)
-- Dependencies: 2241 190 162
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2394 (class 2606 OID 27394)
-- Dependencies: 177 190 2257
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2395 (class 2606 OID 27399)
-- Dependencies: 210 190 2291
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2396 (class 2606 OID 27404)
-- Dependencies: 192 2325 244
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2397 (class 2606 OID 27409)
-- Dependencies: 193 192 2273
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2398 (class 2606 OID 27414)
-- Dependencies: 199 2277 197
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2399 (class 2606 OID 27419)
-- Dependencies: 2281 202 201
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2400 (class 2606 OID 27424)
-- Dependencies: 2325 202 244
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2401 (class 2606 OID 27429)
-- Dependencies: 204 2267 187
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2406 (class 2606 OID 27434)
-- Dependencies: 207 206 2287
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2402 (class 2606 OID 27439)
-- Dependencies: 206 2241 162
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2403 (class 2606 OID 27444)
-- Dependencies: 166 206 2245
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2404 (class 2606 OID 27449)
-- Dependencies: 206 2257 177
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2405 (class 2606 OID 27454)
-- Dependencies: 2309 206 227
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2407 (class 2606 OID 27459)
-- Dependencies: 210 2267 187
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2408 (class 2606 OID 27464)
-- Dependencies: 210 204 2285
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2409 (class 2606 OID 27469)
-- Dependencies: 210 212 2293
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2410 (class 2606 OID 27474)
-- Dependencies: 217 2291 210
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2411 (class 2606 OID 27479)
-- Dependencies: 2291 210 219
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2412 (class 2606 OID 27484)
-- Dependencies: 2267 187 222
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2413 (class 2606 OID 27489)
-- Dependencies: 204 222 2285
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2414 (class 2606 OID 27494)
-- Dependencies: 222 210 2291
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2415 (class 2606 OID 27499)
-- Dependencies: 212 2293 222
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2416 (class 2606 OID 27504)
-- Dependencies: 162 224 2241
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2417 (class 2606 OID 27509)
-- Dependencies: 225 2267 187
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2418 (class 2606 OID 27514)
-- Dependencies: 225 204 2285
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2419 (class 2606 OID 27519)
-- Dependencies: 210 225 2291
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2420 (class 2606 OID 27524)
-- Dependencies: 225 2293 212
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2421 (class 2606 OID 27529)
-- Dependencies: 227 162 2241
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2422 (class 2606 OID 27534)
-- Dependencies: 227 2245 166
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2423 (class 2606 OID 27539)
-- Dependencies: 2267 227 187
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2424 (class 2606 OID 27544)
-- Dependencies: 227 204 2285
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2425 (class 2606 OID 27549)
-- Dependencies: 212 227 2293
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2433 (class 2606 OID 27554)
-- Dependencies: 2241 162 230
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2434 (class 2606 OID 27559)
-- Dependencies: 2257 177 230
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2435 (class 2606 OID 27564)
-- Dependencies: 230 2311 229
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2426 (class 2606 OID 27569)
-- Dependencies: 229 162 2241
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2427 (class 2606 OID 27574)
-- Dependencies: 229 163 2243
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2428 (class 2606 OID 27579)
-- Dependencies: 229 2247 168
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2429 (class 2606 OID 27584)
-- Dependencies: 229 192 2273
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2430 (class 2606 OID 27589)
-- Dependencies: 229 222 2303
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2431 (class 2606 OID 27594)
-- Dependencies: 229 238 2319
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2432 (class 2606 OID 27599)
-- Dependencies: 229 244 2325
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2436 (class 2606 OID 27604)
-- Dependencies: 234 233 2315
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2437 (class 2606 OID 27609)
-- Dependencies: 238 141 2219
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2438 (class 2606 OID 27614)
-- Dependencies: 238 162 2241
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2439 (class 2606 OID 27619)
-- Dependencies: 240 162 2241
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2440 (class 2606 OID 27624)
-- Dependencies: 241 162 2241
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2441 (class 2606 OID 27629)
-- Dependencies: 2219 246 141
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2442 (class 2606 OID 27634)
-- Dependencies: 246 2297 216
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2443 (class 2606 OID 27639)
-- Dependencies: 246 2325 244
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-22 14:51:27 VET

--
-- PostgreSQL database dump complete
--

