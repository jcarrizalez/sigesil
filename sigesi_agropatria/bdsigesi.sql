--
-- PostgreSQL database dump
--

-- Started on 2012-05-10 16:30:26 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 263 (class 1255 OID 35888)
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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 35889)
-- Dependencies: 2125 6
-- Name: romana; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE romana (
    id bigint NOT NULL,
    datos character varying(255),
    ca bigint,
    estatus character varying DEFAULT 1,
    romana bigint
);


ALTER TABLE public.romana OWNER TO admin;

--
-- TOC entry 141 (class 1259 OID 35896)
-- Dependencies: 140 6
-- Name: romana_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE romana_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.romana_id_seq OWNER TO admin;

--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 141
-- Name: romana_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE romana_id_seq OWNED BY romana.id;


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 141
-- Name: romana_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('romana_id_seq', 1, false);


--
-- TOC entry 142 (class 1259 OID 35898)
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
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 142
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


--
-- TOC entry 143 (class 1259 OID 35900)
-- Dependencies: 2127 6
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
-- TOC entry 144 (class 1259 OID 35907)
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
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 144
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 145 (class 1259 OID 35909)
-- Dependencies: 2128 2129 2130 6
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
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 146 (class 1259 OID 35915)
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
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 147 (class 1259 OID 35918)
-- Dependencies: 6 146
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 148 (class 1259 OID 35920)
-- Dependencies: 2132 2133 2134 2135 2136 2137 6
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
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 149 (class 1259 OID 35929)
-- Dependencies: 6 148
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
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 230, true);


--
-- TOC entry 150 (class 1259 OID 35931)
-- Dependencies: 2139 6
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
-- TOC entry 151 (class 1259 OID 35935)
-- Dependencies: 6 150
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
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 152 (class 1259 OID 35937)
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
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 153 (class 1259 OID 35940)
-- Dependencies: 152 6
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
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 153
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 153
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 412, true);


--
-- TOC entry 154 (class 1259 OID 35942)
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
-- TOC entry 155 (class 1259 OID 35948)
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
-- TOC entry 156 (class 1259 OID 35954)
-- Dependencies: 6 155
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
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_asociacion_id_seq OWNED BY si_asociacion.id;


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_asociacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociacion_id_seq', 1, false);


--
-- TOC entry 157 (class 1259 OID 35956)
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
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 157
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 158 (class 1259 OID 35958)
-- Dependencies: 2143 6
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
-- TOC entry 159 (class 1259 OID 35965)
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
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 160 (class 1259 OID 35967)
-- Dependencies: 2144 6
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
-- TOC entry 161 (class 1259 OID 35971)
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
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 162 (class 1259 OID 35973)
-- Dependencies: 2145 2146 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 163 (class 1259 OID 35978)
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
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 164 (class 1259 OID 35980)
-- Dependencies: 2147 2148 2149 2150 2151 2152 2153 6
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
-- TOC entry 165 (class 1259 OID 35993)
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
-- TOC entry 166 (class 1259 OID 35996)
-- Dependencies: 165 6
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
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 12, true);


--
-- TOC entry 167 (class 1259 OID 35998)
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
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 167
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 3, true);


--
-- TOC entry 168 (class 1259 OID 36000)
-- Dependencies: 2155 6
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
-- TOC entry 169 (class 1259 OID 36007)
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
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 3, true);


--
-- TOC entry 170 (class 1259 OID 36009)
-- Dependencies: 2156 2157 2158 2159 2160 6
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
-- TOC entry 171 (class 1259 OID 36020)
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
-- TOC entry 172 (class 1259 OID 36023)
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
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 173 (class 1259 OID 36026)
-- Dependencies: 6 172
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
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 174 (class 1259 OID 36028)
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
    modificado timestamp with time zone
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 174
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
-- TOC entry 175 (class 1259 OID 36031)
-- Dependencies: 174 6
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 176 (class 1259 OID 36033)
-- Dependencies: 2163 6
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
-- TOC entry 177 (class 1259 OID 36037)
-- Dependencies: 6 176
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
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 177
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 177
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 1, false);


--
-- TOC entry 178 (class 1259 OID 36039)
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
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 179 (class 1259 OID 36041)
-- Dependencies: 2165 2166 2167 6
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
-- TOC entry 180 (class 1259 OID 36047)
-- Dependencies: 2168 2169 6
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
-- TOC entry 181 (class 1259 OID 36052)
-- Dependencies: 180 6
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
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 181
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 181
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 10, true);


--
-- TOC entry 182 (class 1259 OID 36054)
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
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 36056)
-- Dependencies: 2171 6
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
-- TOC entry 184 (class 1259 OID 36060)
-- Dependencies: 2172 6
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
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 184
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
-- TOC entry 185 (class 1259 OID 36064)
-- Dependencies: 6 184
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
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 7, true);


--
-- TOC entry 186 (class 1259 OID 36066)
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 187 (class 1259 OID 36068)
-- Dependencies: 2174 2175 6
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
-- TOC entry 188 (class 1259 OID 36073)
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
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 188
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 189 (class 1259 OID 36075)
-- Dependencies: 2176 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 190 (class 1259 OID 36079)
-- Dependencies: 2177 6
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
-- TOC entry 191 (class 1259 OID 36086)
-- Dependencies: 6 190
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
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 191
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 191
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 192 (class 1259 OID 36088)
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
-- TOC entry 193 (class 1259 OID 36094)
-- Dependencies: 6 192
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 48, true);


--
-- TOC entry 194 (class 1259 OID 36096)
-- Dependencies: 2180 2181 6
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
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 195 (class 1259 OID 36101)
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
-- TOC entry 196 (class 1259 OID 36104)
-- Dependencies: 195 6
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
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 3, true);


--
-- TOC entry 197 (class 1259 OID 36106)
-- Dependencies: 194 6
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
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 9, true);


--
-- TOC entry 198 (class 1259 OID 36108)
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 199 (class 1259 OID 36110)
-- Dependencies: 2184 6
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
-- TOC entry 200 (class 1259 OID 36114)
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
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 363, true);


--
-- TOC entry 201 (class 1259 OID 36116)
-- Dependencies: 2185 6
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
-- TOC entry 202 (class 1259 OID 36123)
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
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 38, true);


--
-- TOC entry 203 (class 1259 OID 36125)
-- Dependencies: 2186 2187 6
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
-- TOC entry 204 (class 1259 OID 36130)
-- Dependencies: 2188 2189 2190 2191 6
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
-- TOC entry 205 (class 1259 OID 36137)
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
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 206 (class 1259 OID 36139)
-- Dependencies: 2192 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 207 (class 1259 OID 36143)
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
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 7, true);


--
-- TOC entry 208 (class 1259 OID 36145)
-- Dependencies: 2193 2194 6
-- Name: si_ordenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ordenes (
    id bigint DEFAULT nextval('si_ordenes_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    numero_orden bigint NOT NULL,
    fecha_emision timestamp with time zone,
    numero_contrato character(32),
    toneladas real DEFAULT 0.0,
    descuento boolean,
    estatus character(1),
    id_punto_entrega bigint,
    creado timestamp with time zone,
    modificado timestamp without time zone,
    cod_verificacion character varying
);


ALTER TABLE public.si_ordenes OWNER TO admin;

--
-- TOC entry 209 (class 1259 OID 36153)
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
-- TOC entry 210 (class 1259 OID 36156)
-- Dependencies: 6 209
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
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 1, true);


--
-- TOC entry 211 (class 1259 OID 36158)
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
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 211
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 212 (class 1259 OID 36160)
-- Dependencies: 2196 6
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
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 213 (class 1259 OID 36167)
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
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 214 (class 1259 OID 36169)
-- Dependencies: 2197 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 215 (class 1259 OID 36173)
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
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 216 (class 1259 OID 36175)
-- Dependencies: 2198 6
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
-- TOC entry 217 (class 1259 OID 36182)
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
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 9, true);


--
-- TOC entry 218 (class 1259 OID 36184)
-- Dependencies: 2199 6
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
-- TOC entry 219 (class 1259 OID 36188)
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
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 220 (class 1259 OID 36191)
-- Dependencies: 6 219
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
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 221 (class 1259 OID 36193)
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
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 222 (class 1259 OID 36196)
-- Dependencies: 221 6
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
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 223 (class 1259 OID 36198)
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
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 223
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 13, true);


--
-- TOC entry 224 (class 1259 OID 36200)
-- Dependencies: 2202 6
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
-- TOC entry 225 (class 1259 OID 36207)
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
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 225
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 4, true);


--
-- TOC entry 226 (class 1259 OID 36209)
-- Dependencies: 2203 6
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
-- TOC entry 227 (class 1259 OID 36216)
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
-- TOC entry 228 (class 1259 OID 36222)
-- Dependencies: 227 6
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
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 229 (class 1259 OID 36224)
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
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 230 (class 1259 OID 36230)
-- Dependencies: 229 6
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
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 3, true);


--
-- TOC entry 231 (class 1259 OID 36232)
-- Dependencies: 2206 2207 6
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
    estatus_rec smallint
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 231
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
9.- Recibido

Muestra
0.- Todas las muestras estan aceptadas
1.- Solo la muestra (1) Motriz esta rechazada
2.- Solo la muestra (2) Remolque esta rechazada
3.- Todas las muestras estan rechazadas';


--
-- TOC entry 232 (class 1259 OID 36237)
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
-- TOC entry 233 (class 1259 OID 36240)
-- Dependencies: 6 232
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
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 234 (class 1259 OID 36242)
-- Dependencies: 231 6
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
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 9, true);


--
-- TOC entry 235 (class 1259 OID 36244)
-- Dependencies: 2210 6
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
-- TOC entry 236 (class 1259 OID 36251)
-- Dependencies: 2212 6
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
-- TOC entry 237 (class 1259 OID 36258)
-- Dependencies: 6 236
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
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 52, true);


--
-- TOC entry 238 (class 1259 OID 36260)
-- Dependencies: 6 235
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
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 56, true);


--
-- TOC entry 239 (class 1259 OID 36262)
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
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 240 (class 1259 OID 36264)
-- Dependencies: 2214 2215 6
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
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 241 (class 1259 OID 36272)
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
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 242 (class 1259 OID 36274)
-- Dependencies: 2216 2217 2218 6
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
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 243 (class 1259 OID 36280)
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
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 244 (class 1259 OID 36286)
-- Dependencies: 243 6
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
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 244
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 244
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, true);


--
-- TOC entry 245 (class 1259 OID 36288)
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
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 7, true);


--
-- TOC entry 246 (class 1259 OID 36290)
-- Dependencies: 2220 2221 2222 6
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
-- TOC entry 247 (class 1259 OID 36299)
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
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 7, true);


--
-- TOC entry 248 (class 1259 OID 36301)
-- Dependencies: 2223 6
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
-- TOC entry 249 (class 1259 OID 36305)
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
-- TOC entry 250 (class 1259 OID 36308)
-- Dependencies: 249 6
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
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 250
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 250
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 16, true);


--
-- TOC entry 2126 (class 2604 OID 36310)
-- Dependencies: 141 140
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY romana ALTER COLUMN id SET DEFAULT nextval('romana_id_seq'::regclass);


--
-- TOC entry 2131 (class 2604 OID 36311)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2138 (class 2604 OID 36312)
-- Dependencies: 149 148
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2140 (class 2604 OID 36313)
-- Dependencies: 151 150
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2141 (class 2604 OID 36314)
-- Dependencies: 153 152
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2142 (class 2604 OID 36315)
-- Dependencies: 156 155
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociacion ALTER COLUMN id SET DEFAULT nextval('si_asociacion_id_seq'::regclass);


--
-- TOC entry 2154 (class 2604 OID 36316)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2161 (class 2604 OID 36317)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2162 (class 2604 OID 36318)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 36319)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 36320)
-- Dependencies: 181 180
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 36321)
-- Dependencies: 185 184
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 36322)
-- Dependencies: 191 190
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 36323)
-- Dependencies: 193 192
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 36324)
-- Dependencies: 197 194
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 36325)
-- Dependencies: 196 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2195 (class 2604 OID 36326)
-- Dependencies: 210 209
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 36327)
-- Dependencies: 220 219
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 36328)
-- Dependencies: 222 221
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2204 (class 2604 OID 36329)
-- Dependencies: 228 227
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 36330)
-- Dependencies: 230 229
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2208 (class 2604 OID 36331)
-- Dependencies: 234 231
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 36332)
-- Dependencies: 233 232
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 36333)
-- Dependencies: 238 235
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 36334)
-- Dependencies: 237 236
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 36335)
-- Dependencies: 244 243
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2224 (class 2604 OID 36336)
-- Dependencies: 250 249
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2450 (class 0 OID 35889)
-- Dependencies: 140
-- Data for Name: romana; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2451 (class 0 OID 35900)
-- Dependencies: 143
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
-- TOC entry 2452 (class 0 OID 35909)
-- Dependencies: 145
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
-- TOC entry 2453 (class 0 OID 35915)
-- Dependencies: 146
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2454 (class 0 OID 35920)
-- Dependencies: 148
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
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 22, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 23, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 24, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 39, 2, 'C', 0.000, 0.000, 'R', 39, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 40, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 41, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 42, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 43, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 44, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 45, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 51, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 52, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 53, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 54, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 55, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 56, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 57, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 58, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 3, 'A', 0.000, 0.000, 'C', 47, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 21, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 25, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 28, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 50, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 62, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 73, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 74, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 75, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 76, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 77, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 78, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 79, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 80, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 81, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 82, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 83, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 98, 0.720, 0.790, 0.720, 0.760, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 99, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 100, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 101, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 102, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 104, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 105, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 106, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 107, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 108, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 109, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 110, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 111, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 112, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 113, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 114, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 115, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 116, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 118, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 119, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 120, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 121, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 122, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 123, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 124, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 125, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 126, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 127, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 128, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 129, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 130, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 131, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 132, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 133, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 134, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 135, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 136, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 137, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 138, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 139, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 140, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 141, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 142, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 84, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 117, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 143, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 13, 'A', 0.000, 0.000, 'R', 147, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 149, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 150, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 151, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 152, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 153, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 12, 'A', 1.000, 1.000, 'R', 145, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 12, 'A', 0.000, 0.000, 'R', 146, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 154, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 155, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 156, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 157, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 158, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 159, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 160, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 161, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 162, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 163, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 164, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 165, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 166, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 167, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 168, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 16, 'A', 0.000, 0.000, 'R', 170, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 171, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 172, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 173, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 174, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 175, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 176, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 177, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 178, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 179, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 180, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 181, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 182, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 183, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 184, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 185, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 186, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 187, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 188, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 189, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 190, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 192, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 193, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 194, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 195, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 196, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 197, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 198, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 199, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 200, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 201, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 202, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 203, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 204, 0.720, 0.790, 0.720, 0.790, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 205, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 206, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 207, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 208, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 209, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 210, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 211, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 213, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 214, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 215, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 216, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 217, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 169, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 191, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 212, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 218, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 219, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 220, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 221, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 222, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 223, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 224, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 225, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 226, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 17, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 103, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 148, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 12, 'A', 7.000, 7.000, 'R', 144, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 227, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 228, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 229, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 230, 0.000, 0.000, 0.000, 0.000, 2);


--
-- TOC entry 2455 (class 0 OID 35931)
-- Dependencies: 150
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2456 (class 0 OID 35937)
-- Dependencies: 152
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (368, 8, NULL, 1, 3, '8.000', '19.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (369, 8, NULL, 2, 3, '0.000', '8.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (370, 8, NULL, 13, 3, '0.330', '0.480', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (371, 8, NULL, 21, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (372, 8, NULL, 22, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (373, 8, NULL, 20, 3, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (374, 8, NULL, 38, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (406, 9, NULL, 1, 3, '8.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (407, 9, NULL, 2, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (408, 9, NULL, 13, 3, '0.333', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (409, 9, NULL, 21, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (410, 9, NULL, 22, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (411, 9, NULL, 20, 3, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (412, 9, NULL, 38, 3, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (375, 2, NULL, 1, 3, '12.000', '12.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (376, 2, NULL, 2, 3, '0.000', '5.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (377, 2, NULL, 3, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (378, 2, NULL, 4, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (379, 2, NULL, 5, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (380, 2, NULL, 6, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (381, 2, NULL, 7, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (382, 2, NULL, 8, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (383, 2, NULL, 9, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (384, 2, NULL, 10, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (385, 2, NULL, 11, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (386, 2, NULL, 12, 3, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (387, 2, NULL, 13, 3, '0.710', '0.790', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (388, 2, NULL, 14, 3, '0.000', '1.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (389, 2, NULL, 15, 3, '20.000', '20.000', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (390, 2, NULL, 19, 3, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (391, 2, NULL, 21, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (392, 2, NULL, 22, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (393, 2, NULL, 23, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (394, 2, NULL, 24, 3, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (395, 2, NULL, 20, 3, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (314, NULL, 1, 1, 3, '19.600', '19.600', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (315, NULL, 1, 2, 3, '3.400', '3.400', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (301, NULL, 6, 2, 5, '2.200', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (302, NULL, 6, 13, 5, '0.330', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (303, NULL, 6, 21, 5, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (304, NULL, 6, 22, 5, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (305, NULL, 6, 20, 5, 'NO', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (306, NULL, 6, 38, 5, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (300, NULL, 6, 1, 5, '7.600', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (309, NULL, 7, 13, 5, '0.330', '0.330', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (310, NULL, 7, 21, 5, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (311, NULL, 7, 22, 5, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (312, NULL, 7, 20, 5, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (313, NULL, 7, 38, 5, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (307, NULL, 7, 1, 5, '7.6', '8.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (308, NULL, 7, 2, 5, '12.200', '10.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (316, NULL, 1, 3, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (317, NULL, 1, 4, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (318, NULL, 1, 5, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (319, NULL, 1, 6, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (320, NULL, 1, 7, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (321, NULL, 1, 8, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (322, NULL, 1, 9, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (323, NULL, 1, 10, 3, '0.000', '0.200', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (324, NULL, 1, 11, 3, '0.000', '11.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (325, NULL, 1, 12, 3, '3.000', '3.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (326, NULL, 1, 13, 3, '0.790', '0.790', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (327, NULL, 1, 14, 3, '1.000', '1.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (328, NULL, 1, 15, 3, '20.000', '20.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (329, NULL, 1, 19, 3, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (330, NULL, 1, 21, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (331, NULL, 1, 22, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (332, NULL, 1, 23, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (333, NULL, 1, 24, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (334, NULL, 1, 20, 3, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (335, NULL, 6, 1, 3, '6.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (336, NULL, 6, 2, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (337, NULL, 6, 13, 3, '0.330', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (338, NULL, 6, 21, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (339, NULL, 6, 22, 3, 'A', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (340, NULL, 6, 20, 3, 'NO', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (341, NULL, 6, 38, 3, '0.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (342, NULL, 7, 1, 3, '6.000', '6.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (343, NULL, 7, 2, 3, '6.000', '6.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (344, NULL, 7, 13, 3, '0.333', '0.333', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (345, NULL, 7, 21, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (346, NULL, 7, 22, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (347, NULL, 7, 20, 3, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (348, NULL, 7, 38, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (349, NULL, 4, 1, 3, '12.000', '12.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (350, NULL, 4, 2, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (351, NULL, 4, 14, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (352, NULL, 4, 21, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (353, NULL, 4, 22, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (354, NULL, 4, 24, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (355, NULL, 4, 20, 3, 'NO', 'NO', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (356, NULL, 4, 25, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (357, NULL, 4, 26, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (358, NULL, 4, 27, 3, 'A', 'A', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (359, NULL, 4, 28, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (360, NULL, 4, 29, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (361, NULL, 4, 30, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (362, NULL, 4, 31, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (363, NULL, 4, 32, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (364, NULL, 4, 33, 3, '0.000', '0.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (365, NULL, 4, 36, 3, '46.000', '46.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (366, NULL, 4, 38, 3, '20.000', '20.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (367, NULL, 4, 39, 3, '50.000', '50.000', '', 2, 'D');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (396, 7, NULL, 1, 3, '24.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (397, 7, NULL, 2, 3, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (398, 7, NULL, 7, 3, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (399, 7, NULL, 8, 3, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (400, 7, NULL, 13, 3, '0.760', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (401, 7, NULL, 19, 3, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (402, 7, NULL, 21, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (403, 7, NULL, 22, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (404, 7, NULL, 24, 3, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (405, 7, NULL, 20, 3, 'NO', '', '', 2, 'R');


--
-- TOC entry 2457 (class 0 OID 35942)
-- Dependencies: 154
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('c6344b8b0fc8f949fe', '2012-05-06 09:24:17.617-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:266:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''12'', ''2'', ''1'', ''1'', ''GIRPAL'', ''(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)'', ''HUML+IMPL = 14 < 999999'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:24:17";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('4ae66491ad5f5366e8', '2012-05-06 09:31:29.095-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:190:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''ALGO = 13 < 14'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:31:29";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('de886ea108e5814ef2', '2012-05-06 09:32:26.634-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:189:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+2'', ''ASD = 13 < 15'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:32:26";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('915b5515e3ab90c1f9', '2012-05-06 09:34:06.058-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:40;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:187:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''123'', ''1+1'', ''ASD = 1 < 4'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:34:06";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('aca32892f9e1f60a39', '2012-05-06 09:35:58.368-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:40;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:187:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''123 = 1 < 2'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:35:58";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('4ba071dd6fb1cb8183', '2012-05-06 09:38:54.562-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:190:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''123 = 1 < 2432'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:38:54";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('65ecfe24d8fc3eaf5b', '2012-05-06 12:00:54.831-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:56:"http://localhost/sigesil/admin/cosecha_productor.php<br>";s:4:"line";i:31;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 12:00:54";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('215064596f84b88770', '2012-05-06 12:01:01.161-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:56:"http://localhost/sigesil/admin/cosecha_productor.php<br>";s:4:"line";i:31;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 12:01:01";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('5df3bffbda93c0889f', '2012-05-06 12:01:47.411-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:54:"http://localhost/sigesil/ajax/cosecha_programa.php<br>";s:4:"line";i:58;s:5:"class";s:7:"Cosecha";s:8:"function";s:23:"asignarCosechaProductor";s:11:"mysql_error";s:208:"ERROR:  la sintaxis de entrada no es válida para integer: «[object»
LINE 8: ...ND cp.id_cosecha = "1" AND p.id = "2" AND p2.id = "[object" ...
                                                             ^";s:5:"query";s:918:"SELECT cp.id_cosecha, p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, <br />
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, <br />
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado<br />
                    FROM si_productor p<br />
                    LEFT JOIN si_cosecha_productor cp ON cp.id_productor = p.id<br />
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado<br />
                    WHERE ''1'' AND cp.id_cosecha = ''1'' AND p.id = ''2'' AND p2.id = ''[object'' OR NOT EXISTS (SELECT cp2.id_asociacion FROM si_cosecha_productor cp2 WHERE cp2.id_cosecha = ''1'' AND (cp2.id_productor = p.id OR cp2.id_asociacion = p.id OR cp2.id_asociado = p.id)) ORDER BY p.ced_rif, p2.ced_rif, p3.ced_rif";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-06 12:01:47";}i:1;a:4:{s:4:"file";s:56:"http://localhost/sigesil/lib/class/cosecha.class.php<br>";s:4:"line";i:71;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('767cf1259883906162', '2012-05-06 12:03:57.313-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:54:"http://localhost/sigesil/ajax/cosecha_programa.php<br>";s:4:"line";i:58;s:5:"class";s:7:"Cosecha";s:8:"function";s:23:"asignarCosechaProductor";s:11:"mysql_error";s:208:"ERROR:  la sintaxis de entrada no es válida para integer: «[object»
LINE 8: ...ND cp.id_cosecha = "1" AND p.id = "2" AND p2.id = "[object" ...
                                                             ^";s:5:"query";s:918:"SELECT cp.id_cosecha, p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, <br />
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, <br />
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado<br />
                    FROM si_productor p<br />
                    LEFT JOIN si_cosecha_productor cp ON cp.id_productor = p.id<br />
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado<br />
                    WHERE ''1'' AND cp.id_cosecha = ''1'' AND p.id = ''2'' AND p2.id = ''[object'' OR NOT EXISTS (SELECT cp2.id_asociacion FROM si_cosecha_productor cp2 WHERE cp2.id_cosecha = ''1'' AND (cp2.id_productor = p.id OR cp2.id_asociacion = p.id OR cp2.id_asociado = p.id)) ORDER BY p.ced_rif, p2.ced_rif, p3.ced_rif";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-06 12:03:57";}i:1;a:4:{s:4:"file";s:56:"http://localhost/sigesil/lib/class/cosecha.class.php<br>";s:4:"line";i:71;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('67526792ec9f2803da', '2012-05-06 22:39:00.576-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:53:"http://localhost/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 10:39:00";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('95bf9c590c5421bd90', '2012-05-07 09:22:28.043857-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-07 09:22:28";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('0f05312f169c91ecc1', '2012-05-07 09:23:16.104705-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-07 09:23:16";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:3;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('7bbc4dab3d1ec3be94', '2012-05-07 10:42:47.60215-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-07 10:42:47";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('744f9114f7543078c2', '2012-05-07 13:44:31.42401-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-07 01:44:31";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('288c5b24b6b0d63da6', '2012-05-08 09:11:11.310859-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-08 09:11:11";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('76f0880ffeacdeda3c', '2012-05-08 11:09:31.191223-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-08 11:09:31";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('8efaf1e473474a926f', '2012-05-08 15:01:02.430658-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:47:"/var/www/sigesil/admin/capturar_ejemplo.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-08 03:01:02";}i:1;a:4:{s:4:"file";s:42:"/var/www/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:40:"/var/www/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:45:"/var/www/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('0dc7455158f72b5f9b', '2012-05-09 11:01:23.563125-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/ajax/detalle_formula.php<br>";s:4:"line";i:124;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:210:"ERROR:  la sintaxis de entrada no es válida para integer: «undefined»
LINE 1: ...OM si_tolcarom Tolcarom where "1" AND Tolcarom.id="undefined...
                                                             ^";s:5:"query";s:81:"SELECT parametros FROM si_tolcarom Tolcarom where ''1'' AND Tolcarom.id=''undefined''";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-09 11:01:23";}i:1;a:4:{s:4:"file";s:46:"/var/www/sigesil/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('00ad287010df5cd716', '2012-05-09 11:03:17.363861-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/ajax/detalle_formula.php<br>";s:4:"line";i:124;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:210:"ERROR:  la sintaxis de entrada no es válida para integer: «undefined»
LINE 1: ...OM si_tolcarom Tolcarom where "1" AND Tolcarom.id="undefined...
                                                             ^";s:5:"query";s:81:"SELECT parametros FROM si_tolcarom Tolcarom where ''1'' AND Tolcarom.id=''undefined''";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-09 11:03:17";}i:1;a:4:{s:4:"file";s:46:"/var/www/sigesil/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES ('15e28d92de73b8556d', '2012-05-09 11:38:33.025197-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:45:"/var/www/sigesil/ajax/detalle_formula.php<br>";s:4:"line";i:124;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:210:"ERROR:  la sintaxis de entrada no es válida para integer: «undefined»
LINE 1: ...OM si_tolcarom Tolcarom where "1" AND Tolcarom.id="undefined...
                                                             ^";s:5:"query";s:81:"SELECT parametros FROM si_tolcarom Tolcarom where ''1'' AND Tolcarom.id=''undefined''";s:9:"user_name";s:10:"JRODRIGUEZ";s:4:"date";s:19:"2012-05-09 11:38:33";}i:1;a:4:{s:4:"file";s:46:"/var/www/sigesil/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- TOC entry 2458 (class 0 OID 35948)
-- Dependencies: 155
-- Data for Name: si_asociacion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2459 (class 0 OID 35958)
-- Dependencies: 158
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2460 (class 0 OID 35967)
-- Dependencies: 160
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2461 (class 0 OID 35973)
-- Dependencies: 162
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2462 (class 0 OID 35980)
-- Dependencies: 164
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
-- TOC entry 2463 (class 0 OID 35993)
-- Dependencies: 165
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (3, 1, 1, 5, 54, 'V16538158', 'MARIELY CORONADO', NULL, NULL, NULL, true, '2012-04-23 14:20:23.712675-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (2, 1, 1, 5, 51, 'V14894566', 'LEIDY SIFONTES', NULL, NULL, NULL, true, '2012-04-18 15:56:47.128604-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (5, 1, 1, 5, 51, 'V18264063', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (6, 1, 1, 5, 51, 'V18264062', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (7, 1, 1, 5, 51, 'V18264061', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (8, 1, 1, 5, 51, 'V18264068', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (9, 1, 1, 5, 51, 'V18264069', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (4, 1, 1, 3, 11, 'V16321654', 'OTRO CHOFER', NULL, NULL, NULL, true, '2012-04-23 14:21:37.597326-04:30', '2012-05-03 15:27:51.959201-04:30');
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (10, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (11, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (12, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-07 00:28:45.32-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (1, 1, 1, 5, 51, 'V18264067', 'JESUS EDUARDO RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-18 14:52:10.222967-04:30', NULL);


--
-- TOC entry 2464 (class 0 OID 36000)
-- Dependencies: 168
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (1, 1, NULL, 'V18264066', NULL, 'JESUS SILVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, '2012-04-18 14:50:40.359184-04:30', NULL);
INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (2, 1, NULL, 'V18264065', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, '2012-04-23 14:15:09.561428-04:30', NULL);
INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (3, 1, NULL, 'V17247200', NULL, 'JOSE PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 6, 56, NULL, true, '2012-04-23 14:18:33.708177-04:30', NULL);


--
-- TOC entry 2465 (class 0 OID 36009)
-- Dependencies: 170
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (1, 2, 1, 'INVIERNO 2012', 220000, NULL, 45000, '2012-09-03', '2013-02-04', true, '2012-04-18 15:25:47.739787-04:30', NULL, '2012011');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 3, 3, 'COSECHA 1 SORGO', NULL, NULL, NULL, '2012-04-29', '2012-07-29', true, '2012-04-29 22:43:28.902-04:30', NULL, '2012031');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (3, 4, 12, 'COSECHA 1 GIR', NULL, NULL, NULL, NULL, NULL, true, '2012-05-07 00:19:27.451-04:30', NULL, '2012121');


--
-- TOC entry 2466 (class 0 OID 36020)
-- Dependencies: 171
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 5, 7, '2012-04-29 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 3, 12, 11, NULL, NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 2, 10, 0, 0, '2012-05-04 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 6, 0, 0, '2012-05-06 19:40:19.328-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 2, 0, 7, '2012-05-07 00:20:00.868-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 2, 2, 0, 6, '2012-05-07 00:20:00.879-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 4, 9, '2012-05-07 07:47:37.794317-04:30', NULL);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 2, 2, 4, 8, '2012-05-07 07:47:37.810916-04:30', NULL);


--
-- TOC entry 2467 (class 0 OID 36023)
-- Dependencies: 172
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2468 (class 0 OID 36028)
-- Dependencies: 174
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2469 (class 0 OID 36033)
-- Dependencies: 176
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2470 (class 0 OID 36041)
-- Dependencies: 179
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
-- TOC entry 2471 (class 0 OID 36047)
-- Dependencies: 180
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
-- TOC entry 2472 (class 0 OID 36056)
-- Dependencies: 183
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2473 (class 0 OID 36060)
-- Dependencies: 184
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (3, 2, 1, 2, 2, 3, 7, 5, 1, 2, 2, '2012-04-23 14:20:55.493459-04:30', 2, '2012-04-23 14:52:02.630034-04:30', 12300, 14850, '2012-04-23 14:55:30.370692-04:30', 18570, 25610, 17.5, 4.5, 1064.375, 718.45299999999997, NULL, '5', 2, NULL, 5, 5, '2012-04-23 14:20:55.493459-04:30', '2012-04-23 14:55:30.370692-04:30', 15247.172, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (2, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-23 14:19:42.192099-04:30', 1, '2012-04-23 14:51:53.059302-04:30', 20000, 0, '2012-04-23 14:55:14.106328-04:30', 35000, NULL, 12, NULL, NULL, NULL, NULL, '5', 1, NULL, 5, 6, '2012-04-23 14:19:42.192099-04:30', '2012-04-23 14:55:14.106328-04:30', 15000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (5, 2, 1, 1, 1, 1, 1, 4, 1, 1, 2, '2012-04-25 08:41:22.287997-04:30', 1, '2012-04-27 07:58:49.121647-04:30', 18550, NULL, '2012-04-27 07:59:40.632098-04:30', 32618, NULL, 15, 3, 479.59100000000001, 407.65199999999999, NULL, '5', 1, NULL, 5, 5, '2012-04-25 08:41:22.287997-04:30', '2012-04-27 07:59:40.632098-04:30', 13180.757, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (6, 2, 12, 5, 2, 10, 1, 5, 1, 2, 2, '2012-05-10 08:39:52.707355-04:30', 1, '2012-05-10 15:22:07.370723-04:30', 20720, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', 1, NULL, 6, NULL, '2012-05-10 08:39:52.707355-04:30', '2012-05-10 15:29:01.42415-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (7, 2, 12, 7, 3, 10, 4, 5, 1, 3, 2, '2012-05-10 08:40:47.6827-04:30', 2, '2012-05-10 15:22:31.969196-04:30', 20720, 21700, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', 2, NULL, 5, NULL, '2012-05-10 08:40:47.6827-04:30', '2012-05-10 15:29:20.824631-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (4, 2, 2, 4, 3, 4, 8, 5, 1, 3, 2, '2012-04-23 14:22:02.577104-04:30', 3, '2012-05-10 15:23:09.614967-04:30', 20300, 19800, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', 2, NULL, 5, NULL, '2012-04-23 14:22:02.577104-04:30', '2012-05-10 15:30:03.821029-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra, humedad2, impureza2, humedad_des2, impureza_des2, peso_acon2, peso_acon_liq2) VALUES (1, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-18 14:56:38.350798-04:30', 1, '2012-05-10 15:21:16.489998-04:30', 3000, 3860, '2012-05-10 16:29:31.647396-04:30', 13000, 13500, 19.6, 3.4000001, 864, 311, NULL, '5', 2, NULL, 5, 5, '2012-04-18 14:56:38.350798-04:30', '2012-05-10 16:29:31.647396-04:30', NULL, 8826, NULL, 19.6, 3.4000001, 833, 299, NULL, 8508);


--
-- TOC entry 2474 (class 0 OID 36068)
-- Dependencies: 187
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes (id, id_org, nombre, capacidad) VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2475 (class 0 OID 36075)
-- Dependencies: 189
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
-- TOC entry 2476 (class 0 OID 36079)
-- Dependencies: 190
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2477 (class 0 OID 36088)
-- Dependencies: 192
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
-- TOC entry 2478 (class 0 OID 36096)
-- Dependencies: 194
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (2, NULL, NULL, 5, 178923612, 15000, NULL, NULL, '2012-04-29 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (3, NULL, NULL, 5, 234234123, 10000, NULL, NULL, '2012-04-28 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (4, NULL, NULL, 5, 92374392, 16000, NULL, NULL, '2012-04-03 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (5, NULL, NULL, 5, 12312312, 30000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (6, NULL, NULL, 5, 238947289, 32000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (7, NULL, NULL, 4, 234213412, 15000, NULL, NULL, '2012-05-04 00:00:00-04:30', 'P', NULL, NULL, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (8, NULL, NULL, 5, 565645234, 30000, NULL, NULL, '2012-05-07 00:00:00-04:30', 'P', NULL, NULL, '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (9, NULL, NULL, 5, 980566523, 35000, NULL, NULL, '2012-05-08 00:00:00-04:30', 'P', NULL, NULL, '2012-05-07 00:28:45.32-04:30', NULL);


--
-- TOC entry 2479 (class 0 OID 36101)
-- Dependencies: 195
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (3, 3, '23124343234     ', '2012-04-12 00:00:00-04:30', '');


--
-- TOC entry 2480 (class 0 OID 36110)
-- Dependencies: 199
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2481 (class 0 OID 36116)
-- Dependencies: 201
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (2, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''201212''<br />id_cultivo =  ''12''<br />nombre =  ''PROGRAMA GIRASOL''<br />estatus =  ''T''<br />observacion =  null<br />fecha_inicio =  ''07-05-2012''<br />fecha_fin =  ''07-05-2013''<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, id_cultivo, nombre, estatus, observacion, fecha_inicio, fecha_fin, id_centro_acopio, creado) VALUES  (''201212'', ''12'', ''PROGRAMA GIRASOL'', ''T'', null, ''07-05-2012'', ''07-05-2013'', ''2'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (3, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha', 'No data', 'id_programa = ''4''<br />id_cultivo =  ''12''<br />codigo =  ''2012121''<br />nombre =  ''COSECHA 1 GIR''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (id_programa, id_cultivo, codigo, nombre, proyectado, area_siembra, fecha_inicio, fecha_fin, estatus, creado) VALUES  (''4'', ''12'', ''2012121'', ''COSECHA 1 GIR'', null, null, null, null, ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (4, '2012-05-07', 203, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'No data', 'DELETE FROM si_cosecha_productor                       WHERE id_cosecha = ''3'' AND id_centro_acopio = ''2''                       AND id_productor = ''2'' AND id_asociacion = ''0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (5, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''3''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''0''<br />id_asociado =  ''7''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''3'', ''2'', ''2'', ''0'', ''7'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (6, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''3''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''0''<br />id_asociado =  ''6''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''3'', ''2'', ''2'', ''0'', ''6'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (7, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''565645234''<br />fecha_emision =  ''07-05-2012''<br />contrato =  null<br />kilogramos =  ''30000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''565645234'', ''07-05-2012'', null, ''30000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (8, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (9, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  ''FORD''<br />placa_remolques =  ''123-123''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', ''FORD'', ''123-123'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (10, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''3''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''6''<br />id_guia =  ''8''<br />id_vehiculo =  ''15''<br />id_chofer =  ''11''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''1'', ''3'', ''NOW()'', ''1'', ''2'', ''5'', ''1'', ''2'', ''6'', ''8'', ''15'', ''11'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (11, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''980566523''<br />fecha_emision =  ''08-05-2012''<br />contrato =  null<br />kilogramos =  ''35000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''980566523'', ''08-05-2012'', null, ''35000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (12, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (13, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASE''<br />marca =  ''MACK''<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASE'', ''MACK'', null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (14, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''3''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''7''<br />id_guia =  ''9''<br />id_vehiculo =  ''16''<br />id_chofer =  ''12''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''2'', ''3'', ''NOW()'', ''1'', ''1'', ''5'', ''1'', ''2'', ''7'', ''9'', ''16'', ''12'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (15, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''15.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''1'', ''5'', ''8.000'', ''15.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (16, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''7.000''<br />muestra2 =  ''1.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''2'', ''5'', ''7.000'', ''1.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (17, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.330''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''13'', ''5'', ''0.330'', ''0.330'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (18, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''21'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (19, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''22'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (20, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''20'', ''5'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (21, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''38'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (22, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 8<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (23, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''10.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''1'', ''5'', ''10.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (24, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''2.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''2'', ''5'', ''2.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (25, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''13'', ''5'', ''0.330'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (26, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (27, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (28, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (29, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''38'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (30, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 9<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (31, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />peso_02l = <br />id = 8<br />estatus_rec = 3<br />fecha_pel = <br />modificado = 2012-05-07 00:29:52.168<br />', 'romana_ent = ''5'', peso_01l = ''47350'', peso_02l = ''49000'', id = ''8'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''47350'', peso_02l = ''49000'', id = ''8'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (32, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 9<br />estatus_rec = 3<br />fecha_pel = <br />modificado = 2012-05-07 00:30:10.949<br />', 'romana_ent = ''5'', peso_01l = ''47350'', id = ''9'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''47350'', id = ''9'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (33, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''1'', ''5'', ''8.000'', ''8.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (34, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''2'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (35, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.330''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''13'', ''5'', ''0.330'', ''0.330'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (36, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''21'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (37, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''22'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (38, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''20'', ''5'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (39, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''38'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (40, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 8<br />estatus_rec = 4<br />muestra = <br />modificado = 2012-05-07 00:33:25.61<br />', 'id = ''8'', estatus_rec = ''6'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''8'', estatus_rec = ''6'', muestra = null, modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (41, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''1'', ''5'', ''8.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (42, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''2'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (43, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''13'', ''5'', ''0.330'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (44, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (45, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (46, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (47, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''38'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (48, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 9<br />estatus_rec = 4<br />muestra = <br />modificado = 2012-05-07 00:33:37.086<br />', 'id = ''9'', estatus_rec = ''6'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''9'', estatus_rec = ''6'', muestra = null, modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (49, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />peso_02v = <br />id = 8<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />peso_acon = <br />modificado = 2012-05-07 00:35:21.295<br />', 'romana_sal = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''8'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.8'', impureza = ''11.1'', peso_acon = ''51287.43'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''8'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.8'', impureza = ''11.1'', peso_acon = ''51287.43'', modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (50, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />id = 9<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />peso_02v = <br />peso_acon = <br />modificado = 2012-05-07 00:35:30.076<br />', 'romana_sal = ''5'', peso_01v = ''20720'', id = ''9'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.6'', impureza = ''2.2'', peso_02v = null, peso_acon = ''26630'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''20720'', id = ''9'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.6'', impureza = ''2.2'', peso_02v = null, peso_acon = ''26630'', modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (51, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = rc9r74n57ere9mobmcrpicete2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''rc9r74n57ere9mobmcrpicete2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (52, '2012-05-07', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''rc9r74n57ere9mobmcrpicete2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (53, '2012-05-07', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-06 22:39:11.292-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (54, '2012-05-07', 203, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'R', 'No data', 'DELETE FROM si_cosecha_productor                       WHERE id_cosecha = ''1'' AND id_centro_acopio = ''2''                       AND id_productor = ''2'' AND id_asociacion = ''4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (55, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''9''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''1'', ''2'', ''2'', ''4'', ''9'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (67, '2012-05-07', 202, 0, 'N/A', 'N/A', 'N/A', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 8negg83b3fnjhe5qo1lr5rq5s2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''8negg83b3fnjhe5qo1lr5rq5s2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (56, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''8''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''1'', ''2'', ''2'', ''4'', ''8'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (57, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''10''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''1'', ''2'', ''2'', ''4'', ''10'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (58, '2012-05-07', 203, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'R', 'No data', 'DELETE FROM si_cosecha_productor                       WHERE id_cosecha = ''1'' AND id_centro_acopio = ''2''                       AND id_productor = ''2'' AND id_asociacion = ''4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (59, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''9''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''1'', ''2'', ''2'', ''4'', ''9'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (60, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''4''<br />id_asociado =  ''8''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''1'', ''2'', ''2'', ''4'', ''8'', now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (61, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 8negg83b3fnjhe5qo1lr5rq5s2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''8negg83b3fnjhe5qo1lr5rq5s2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (62, '2012-05-07', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''8negg83b3fnjhe5qo1lr5rq5s2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (63, '2012-05-07', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 07:34:18.499567-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (64, '2012-05-07', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '1u5n9nhmmo0devbg8rgl66e3b4', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.83<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-06 23:20:39.624-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1u5n9nhmmo0devbg8rgl66e3b4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1u5n9nhmmo0devbg8rgl66e3b4'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (65, '2012-05-07', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '1u5n9nhmmo0devbg8rgl66e3b4', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.83<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 1u5n9nhmmo0devbg8rgl66e3b4<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''1u5n9nhmmo0devbg8rgl66e3b4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (66, '2012-05-07', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '1u5n9nhmmo0devbg8rgl66e3b4', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.83<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''1u5n9nhmmo0devbg8rgl66e3b4'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (68, '2012-05-07', 102, 0, 'N/A', 'N/A', 'N/A', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''8negg83b3fnjhe5qo1lr5rq5s2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (69, '2012-05-07', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 08:42:54.226807-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (70, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_formulas', 'No data', 'id_mov = ''3''<br />id_cultivo =  ''12''<br />tipo_for =  ''2''<br />id_org =  ''1''<br />id_centro_acopio =  ''1''<br />codigo =  ''GIRPA''<br />formula =  ''((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))''<br />condicion =  ''HUML+IMPL = 14 < 9999999''<br />creado = now()<br />', 'INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (''3'', ''12'', ''2'', ''1'', ''1'', ''GIRPA'', ''((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))'', ''HUML+IMPL = 14 < 9999999'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (71, '2012-05-07', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 8negg83b3fnjhe5qo1lr5rq5s2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''8negg83b3fnjhe5qo1lr5rq5s2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (72, '2012-05-07', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''8negg83b3fnjhe5qo1lr5rq5s2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (73, '2012-05-07', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '8negg83b3fnjhe5qo1lr5rq5s2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 08:39:11.245613-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8negg83b3fnjhe5qo1lr5rq5s2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (74, '2012-05-07', 202, 0, 'N/A', 'N/A', 'N/A', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', '', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''7etrog6ls8ko6ka2m4uf2m40a6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (75, '2012-05-07', 102, 0, 'N/A', 'N/A', 'N/A', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''7etrog6ls8ko6ka2m4uf2m40a6'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (76, '2012-05-07', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 09:23:38.594919-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7etrog6ls8ko6ka2m4uf2m40a6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7etrog6ls8ko6ka2m4uf2m40a6'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (77, '2012-05-07', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''1''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (78, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''1''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''1'', ''1'', ''1'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (79, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''24''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''1''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''24'', ''1'', ''1'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (80, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''6''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''1''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''6'', ''1'', ''1'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (81, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''25''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''25'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (82, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''9''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''9'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (83, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''8''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''8'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (84, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''7''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''1''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''7'', ''1'', ''1'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (85, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''10''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''10'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (86, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''29''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''29'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (87, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''32''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''32'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (88, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''3''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''3'', ''1'', ''1'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (89, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''13''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''13'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (90, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''14''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''14'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (91, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''15''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''15'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (92, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''16''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''16'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (93, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''17''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''17'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (94, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''18''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''18'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (95, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''35''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''1''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''35'', ''1'', ''0'', ''0'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (96, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''4''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''4'', ''1'', ''1'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (97, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''20''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''1''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''20'', ''1'', ''1'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (98, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''21''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''1''<br />eliminar =  ''1''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''21'', ''1'', ''1'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (99, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''22''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''22'', ''1'', ''0'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (100, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''26''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''26'', ''1'', ''0'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (101, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''36''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''36'', ''1'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (102, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''5''<br />id_usuario =  ''1''<br />nuevo =  ''1''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''5'', ''1'', ''1'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (103, '2012-05-07', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''23''<br />id_usuario =  ''1''<br />nuevo =  ''0''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''23'', ''1'', ''0'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (104, '2012-05-07', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 7etrog6ls8ko6ka2m4uf2m40a6<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''7etrog6ls8ko6ka2m4uf2m40a6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (105, '2012-05-07', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''7etrog6ls8ko6ka2m4uf2m40a6'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (106, '2012-05-07', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7etrog6ls8ko6ka2m4uf2m40a6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 10:44:40.046164-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7etrog6ls8ko6ka2m4uf2m40a6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7etrog6ls8ko6ka2m4uf2m40a6'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (107, '2012-05-07', 202, 0, 'N/A', 'N/A', 'N/A', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', '', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''7rki8re0dcias268mgmpas0qi0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (108, '2012-05-07', 102, 0, 'N/A', 'N/A', 'N/A', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''7rki8re0dcias268mgmpas0qi0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (109, '2012-05-07', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 09:34:47.315624-04:30<br />conectado = 1<br />sesion = 8negg83b3fnjhe5qo1lr5rq5s2<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (110, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 7rki8re0dcias268mgmpas0qi0<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''7rki8re0dcias268mgmpas0qi0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (111, '2012-05-07', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''7rki8re0dcias268mgmpas0qi0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (112, '2012-05-07', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 13:04:22.204286-04:30<br />conectado = 1<br />sesion = 7etrog6ls8ko6ka2m4uf2m40a6<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (113, '2012-05-07', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 7rki8re0dcias268mgmpas0qi0<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''7rki8re0dcias268mgmpas0qi0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (114, '2012-05-07', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''7rki8re0dcias268mgmpas0qi0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (115, '2012-05-07', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 13:44:40.71664-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7rki8re0dcias268mgmpas0qi0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (116, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 7rki8re0dcias268mgmpas0qi0<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''7rki8re0dcias268mgmpas0qi0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (117, '2012-05-07', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '7rki8re0dcias268mgmpas0qi0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''7rki8re0dcias268mgmpas0qi0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (118, '2012-05-08', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '0f2kksltljl7tmhn19emj6r142', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 16:04:31.043685-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''0f2kksltljl7tmhn19emj6r142''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''0f2kksltljl7tmhn19emj6r142'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (119, '2012-05-08', 202, 0, 'N/A', 'N/A', 'N/A', '0f2kksltljl7tmhn19emj6r142', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 0f2kksltljl7tmhn19emj6r142<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''0f2kksltljl7tmhn19emj6r142''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (120, '2012-05-08', 102, 0, 'N/A', 'N/A', 'N/A', '0f2kksltljl7tmhn19emj6r142', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''0f2kksltljl7tmhn19emj6r142'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (121, '2012-05-08', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '0f2kksltljl7tmhn19emj6r142', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-08 07:41:20.513982-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''0f2kksltljl7tmhn19emj6r142''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''0f2kksltljl7tmhn19emj6r142'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (122, '2012-05-08', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'qrkamj7oea0ml52jc1qcj8qc30', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-08 09:11:21.64471-04:30<br />conectado = 1<br />sesion = 0f2kksltljl7tmhn19emj6r142<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrkamj7oea0ml52jc1qcj8qc30''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrkamj7oea0ml52jc1qcj8qc30'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (123, '2012-05-08', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'qrkamj7oea0ml52jc1qcj8qc30', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-08 11:10:36.55002-04:30<br />conectado = 1<br />sesion = qrkamj7oea0ml52jc1qcj8qc30<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrkamj7oea0ml52jc1qcj8qc30''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrkamj7oea0ml52jc1qcj8qc30'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (124, '2012-05-08', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '5ioghjn3n8sgl34mqesdhhdt13', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-08 13:08:52.558439-04:30<br />conectado = 1<br />sesion = qrkamj7oea0ml52jc1qcj8qc30<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5ioghjn3n8sgl34mqesdhhdt13''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5ioghjn3n8sgl34mqesdhhdt13'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (125, '2012-05-08', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '5ioghjn3n8sgl34mqesdhhdt13', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-04 13:37:53.571476-04:30<br />modificado = 2012-05-04 13:42:25.260416<br />', 'romana_ent = ''5'', peso_01l = ''25061'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''25061'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (126, '2012-05-08', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '5ioghjn3n8sgl34mqesdhhdt13', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-08 15:52:29.723711-04:30<br />modificado = 2012-05-08 15:52:29.723711<br />', 'romana_ent = ''5'', peso_01l = ''28604'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''28604'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (127, '2012-05-08', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '5ioghjn3n8sgl34mqesdhhdt13', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 5ioghjn3n8sgl34mqesdhhdt13<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''5ioghjn3n8sgl34mqesdhhdt13''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (128, '2012-05-08', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '5ioghjn3n8sgl34mqesdhhdt13', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''5ioghjn3n8sgl34mqesdhhdt13'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (129, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-08 15:01:13.297139-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (158, '2012-05-09', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''31''<br />id_usuario =  ''3''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''31'', ''3'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (130, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-08 16:15:45.254656-04:30<br />modificado = 2012-05-08 16:15:45.254656<br />', 'romana_ent = ''5'', peso_01l = ''34719'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''34719'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (131, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 07:43:50.817991-04:30<br />conectado = 1<br />sesion = iri0b9kbuua7i98tcn5si06d05<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (132, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''19''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''19'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (133, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (134, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (135, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''23''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''23'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (136, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''24''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''24'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (137, '2012-05-09', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (138, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 6<br />estatus_rec = 4<br />muestra = 0<br />modificado = 2012-05-09 07:56:35.058265<br />', 'id = ''6'', estatus_rec = ''6'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''6'', estatus_rec = ''6'', muestra = null, modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (139, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-09 07:56:35.058265-04:30<br />modificado = 2012-05-09 07:58:23.262642<br />', 'romana_ent = ''5'', peso_01l = ''35509'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''35509'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (140, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 07:56:53.45033-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (141, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:22:23.886668-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (142, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:24:20.486408-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (143, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:26:45.770946-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (144, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:28:56.152557-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (145, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:32:39.556747-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (146, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:34:59.272286-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (147, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:42:39.762123-04:30<br />conectado = 1<br />sesion = iri0b9kbuua7i98tcn5si06d05<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (148, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:43:06.289582-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (149, '2012-05-09', 101, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-18 15:58:22.135194-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (150, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-09 08:03:20.607201-04:30<br />modificado = 2012-05-09 08:03:20.607201<br />', 'romana_ent = ''5'', peso_01l = ''27400'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''27400'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (151, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 6<br />estatus_rec = 3<br />fecha_pel = 2012-05-09 09:52:57.284195-04:30<br />modificado = 2012-05-09 09:52:57.284195<br />', 'romana_ent = ''5'', peso_01l = ''30179'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''30179'', id = ''6'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (152, '2012-05-09', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (153, '2012-05-09', 102, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (154, '2012-05-09', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-07 15:23:56.972766-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (155, '2012-05-09', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (156, '2012-05-09', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''3''<br />nuevo =  ''5''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''3'', ''5'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (157, '2012-05-09', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''27''<br />id_usuario =  ''3''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''27'', ''3'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (159, '2012-05-09', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''38''<br />id_usuario =  ''3''<br />nuevo =  ''0''<br />modificar =  ''1''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''38'', ''3'', ''0'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (160, '2012-05-09', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (161, '2012-05-09', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (162, '2012-05-09', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:08:39.485703-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (163, '2012-05-09', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (164, '2012-05-09', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (165, '2012-05-09', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:09:05.972848-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (166, '2012-05-09', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (167, '2012-05-09', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (168, '2012-05-09', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:09:35.996123-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (169, '2012-05-09', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (170, '2012-05-09', 102, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''1'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (171, '2012-05-09', 101, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:52:24.907291-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''3bul6da5ik3m406cvchk53qqq2'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (172, '2012-05-09', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 3bul6da5ik3m406cvchk53qqq2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (173, '2012-05-09', 102, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', '3bul6da5ik3m406cvchk53qqq2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''3bul6da5ik3m406cvchk53qqq2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (174, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''jefg580g3hu1ul1bgkjbc04oo4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (175, '2012-05-09', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''jefg580g3hu1ul1bgkjbc04oo4'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (176, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 09:45:05.248979-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (177, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = iri0b9kbuua7i98tcn5si06d05<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''iri0b9kbuua7i98tcn5si06d05''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (178, '2012-05-09', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''iri0b9kbuua7i98tcn5si06d05'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (179, '2012-05-09', 101, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'iri0b9kbuua7i98tcn5si06d05', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-04 10:32:26.015077-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''iri0b9kbuua7i98tcn5si06d05'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (180, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:24:59.863496-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (181, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:26:43.940579-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (182, '2012-05-09', 101, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'ugamatlen6s5rhqe7afrm3pqd7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:25:54.602006-04:30<br />conectado = 1<br />sesion = iri0b9kbuua7i98tcn5si06d05<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ugamatlen6s5rhqe7afrm3pqd7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ugamatlen6s5rhqe7afrm3pqd7'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (183, '2012-05-09', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''jefg580g3hu1ul1bgkjbc04oo4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (184, '2012-05-09', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''jefg580g3hu1ul1bgkjbc04oo4'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (185, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:30:19.312573-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (186, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:40:33.494781-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (187, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'jefg580g3hu1ul1bgkjbc04oo4', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:41:07.492786-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''jefg580g3hu1ul1bgkjbc04oo4'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (188, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '4j8ad5ffmhk0ottf09jqmb9le2', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:53:17.001476-04:30<br />conectado = 1<br />sesion = jefg580g3hu1ul1bgkjbc04oo4<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4j8ad5ffmhk0ottf09jqmb9le2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4j8ad5ffmhk0ottf09jqmb9le2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (189, '2012-05-09', 101, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'ugamatlen6s5rhqe7afrm3pqd7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:39:34.145552-04:30<br />conectado = 1<br />sesion = ugamatlen6s5rhqe7afrm3pqd7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ugamatlen6s5rhqe7afrm3pqd7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ugamatlen6s5rhqe7afrm3pqd7'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (190, '2012-05-09', 101, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 13:03:04.188216-04:30<br />conectado = 1<br />sesion = ugamatlen6s5rhqe7afrm3pqd7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''oe2tahhuhgu8uueh79sq6mpjb0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''oe2tahhuhgu8uueh79sq6mpjb0'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (191, '2012-05-09', 202, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />id = 6<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />peso_02v = <br />humedad_des = <br />impureza_des = <br />peso_acon = <br />modificado = 2012-05-09 09:57:56.52836<br />', 'romana_sal = ''5'', peso_01v = ''8500'', id = ''6'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''12'', impureza = ''4.5'', peso_02v = null, humedad_des = null, impureza_des = ''743'', peso_acon = ''15757'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''8500'', id = ''6'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''12'', impureza = ''4.5'', peso_02v = null, humedad_des = null, impureza_des = ''743'', peso_acon = ''15757'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (192, '2012-05-09', 202, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />peso_02l = <br />id = 5<br />estatus_rec = 3<br />fecha_pel = 2012-05-04 13:37:43.509464-04:30<br />modificado = 2012-05-04 13:42:13.898325<br />', 'romana_ent = ''5'', peso_01l = ''15000'', peso_02l = ''10000'', id = ''5'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''15000'', peso_02l = ''10000'', id = ''5'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=5', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (193, '2012-05-09', 202, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />peso_02v = <br />id = 5<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />humedad_des = <br />impureza_des = <br />peso_acon = <br />modificado = 2012-05-09 14:33:24.829315<br />', 'romana_sal = ''5'', peso_01v = ''4000'', peso_02v = ''4500'', id = ''5'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''12'', impureza = ''4.5'', humedad_des = null, impureza_des = ''743'', peso_acon = ''15757'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''4000'', peso_02v = ''4500'', id = ''5'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''12'', impureza = ''4.5'', humedad_des = null, impureza_des = ''743'', peso_acon = ''15757'', modificado=now() WHERE id=5', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (194, '2012-05-09', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'qrp60qj0b479ufuch5v4d56852', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:58:31.874238-04:30<br />conectado = 1<br />sesion = 4j8ad5ffmhk0ottf09jqmb9le2<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrp60qj0b479ufuch5v4d56852''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''qrp60qj0b479ufuch5v4d56852'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (195, '2012-05-09', 202, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />peso_02l = <br />id = 5<br />estatus_rec = 3<br />fecha_pel = 2012-05-09 14:33:24.829315-04:30<br />modificado = 2012-05-09 14:54:09.95833<br />', 'romana_ent = ''5'', peso_01l = ''15000'', peso_02l = ''10000'', id = ''5'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''15000'', peso_02l = ''10000'', id = ''5'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=5', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (196, '2012-05-09', 202, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = oe2tahhuhgu8uueh79sq6mpjb0<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''4'' AND sesion = ''oe2tahhuhgu8uueh79sq6mpjb0''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (197, '2012-05-09', 102, 4, 'JESUS RODRIGUEZ', 'N/A', 'ARAURE', 'oe2tahhuhgu8uueh79sq6mpjb0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''4'' AND sesion = ''oe2tahhuhgu8uueh79sq6mpjb0'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (198, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 15:24:44.041294-04:30<br />conectado = 1<br />sesion = qrp60qj0b479ufuch5v4d56852<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (199, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 1hf4ec7nschrsili38otpg05n7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''1hf4ec7nschrsili38otpg05n7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (200, '2012-05-10', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''1hf4ec7nschrsili38otpg05n7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (201, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 07:30:07.077433-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (202, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'ah7s29jjhlj5kd78jieaeei0g0', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 07:40:24.975055-04:30<br />conectado = 1<br />sesion = 1hf4ec7nschrsili38otpg05n7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (203, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_ordenes', 'No data', 'numero_orden = ''56121201''<br />id_cliente =  ''2''<br />fecha_emision =  ''24-01-2012''<br />toneladas =  ''3500''<br />descuento =  ''F''<br />cod_verificacion =  ''56125206''<br />id_centro_acopio =  ''2''<br />id_cultivo =  ''12''<br />estatus =  ''N''<br />creado = now()<br />', 'INSERT INTO si_ordenes  (numero_orden, id_cliente, fecha_emision, toneladas, descuento, cod_verificacion, id_centro_acopio, id_cultivo, estatus, creado) VALUES  (''56121201'', ''2'', ''24-01-2012'', ''3500'', ''F'', ''56125206'', ''2'', ''12'', ''N'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (204, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_ordenes', 'No data', 'numero_orden = ''56101103''<br />id_cliente =  ''3''<br />fecha_emision =  ''09-11-2011''<br />toneladas =  ''125''<br />descuento =  ''F''<br />cod_verificacion =  ''56101725''<br />id_centro_acopio =  ''2''<br />id_cultivo =  ''10''<br />estatus =  ''N''<br />creado = now()<br />', 'INSERT INTO si_ordenes  (numero_orden, id_cliente, fecha_emision, toneladas, descuento, cod_verificacion, id_centro_acopio, id_cultivo, estatus, creado) VALUES  (''56101103'', ''3'', ''09-11-2011'', ''125'', ''F'', ''56101725'', ''2'', ''10'', ''N'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (205, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_ordenes', 'Register No.0<br />estatus = N<br />modificado = <br />', 'estatus = ''f'', modificado = now()', 'UPDATE si_ordenes SET estatus = ''f'', modificado = now() WHERE id = ''6''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (206, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_ordenes', 'No data', 'numero_orden = ''56121202''<br />id_cliente =  ''3''<br />fecha_emision =  ''24-01-2012''<br />toneladas =  ''3500''<br />descuento =  ''T''<br />cod_verificacion =  ''56125207''<br />id_centro_acopio =  ''2''<br />id_cultivo =  ''12''<br />estatus =  ''N''<br />creado = now()<br />', 'INSERT INTO si_ordenes  (numero_orden, id_cliente, fecha_emision, toneladas, descuento, cod_verificacion, id_centro_acopio, id_cultivo, estatus, creado) VALUES  (''56121202'', ''3'', ''24-01-2012'', ''3500'', ''T'', ''56125207'', ''2'', ''12'', ''N'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (207, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'No data', 'numero = ''1''<br />id_orden =  ''5''<br />id_cultivo =  ''12''<br />id_cliente =  ''2''<br />id_chofer =  ''10''<br />id_vehiculo =  ''1''<br />cant_muestras =  ''1''<br />id_centro_acopio =  ''2''<br />id_usuario =  ''5''<br />id_transporte =  ''1''<br />id_punto_entrega =  ''2''<br />fecha_des =  ''NOW()''<br />id_silo =  ''2''<br />estatus =  ''1''<br />creado = now()<br />', 'INSERT INTO si_despacho  (numero, id_orden, id_cultivo, id_cliente, id_chofer, id_vehiculo, cant_muestras, id_centro_acopio, id_usuario, id_transporte, id_punto_entrega, fecha_des, id_silo, estatus, creado) VALUES  (''1'', ''5'', ''12'', ''2'', ''10'', ''1'', ''1'', ''2'', ''5'', ''1'', ''2'', ''NOW()'', ''2'', ''1'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (208, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'ah7s29jjhlj5kd78jieaeei0g0', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 08:04:31.199391-04:30<br />conectado = 1<br />sesion = ah7s29jjhlj5kd78jieaeei0g0<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (209, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'No data', 'numero = ''2''<br />id_orden =  ''7''<br />id_cultivo =  ''12''<br />id_cliente =  ''3''<br />id_chofer =  ''10''<br />id_vehiculo =  ''4''<br />cant_muestras =  ''2''<br />id_centro_acopio =  ''2''<br />id_usuario =  ''5''<br />id_transporte =  ''1''<br />id_punto_entrega =  ''3''<br />fecha_des =  ''NOW()''<br />id_silo =  ''2''<br />estatus =  ''1''<br />creado = now()<br />', 'INSERT INTO si_despacho  (numero, id_orden, id_cultivo, id_cliente, id_chofer, id_vehiculo, cant_muestras, id_centro_acopio, id_usuario, id_transporte, id_punto_entrega, fecha_des, id_silo, estatus, creado) VALUES  (''2'', ''7'', ''12'', ''3'', ''10'', ''4'', ''2'', ''2'', ''5'', ''1'', ''3'', ''NOW()'', ''2'', ''1'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (210, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'ah7s29jjhlj5kd78jieaeei0g0', '192.168.66.123', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 08:40:16.913938-04:30<br />conectado = 1<br />sesion = ah7s29jjhlj5kd78jieaeei0g0<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ah7s29jjhlj5kd78jieaeei0g0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (211, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '1hf4ec7nschrsili38otpg05n7', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 09:01:08.367482-04:30<br />conectado = 1<br />sesion = ah7s29jjhlj5kd78jieaeei0g0<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1hf4ec7nschrsili38otpg05n7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (212, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 09:51:30.525959-04:30<br />conectado = 1<br />sesion = 1hf4ec7nschrsili38otpg05n7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (213, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 10:38:12.564629-04:30<br />conectado = 1<br />sesion = gtv8nmk2k8h3s874pceh7eapl1<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (214, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = gtv8nmk2k8h3s874pceh7eapl1<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''gtv8nmk2k8h3s874pceh7eapl1''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (215, '2012-05-10', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''gtv8nmk2k8h3s874pceh7eapl1'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (216, '2012-05-10', 101, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:09:49.511554-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''gtv8nmk2k8h3s874pceh7eapl1'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (217, '2012-05-10', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'R', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (218, '2012-05-10', 203, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'No data', 'DELETE FROM si_menu_usuario WHERE id_usuario = ''4''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (219, '2012-05-10', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''2''<br />id_usuario =  ''4''<br />nuevo =  ''7''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''2'', ''4'', ''7'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (220, '2012-05-10', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''11''<br />id_usuario =  ''4''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''11'', ''4'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (221, '2012-05-10', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''12''<br />id_usuario =  ''4''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''12'', ''4'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (222, '2012-05-10', 201, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_menu_usuario', 'No data', 'id_menu = ''28''<br />id_usuario =  ''4''<br />nuevo =  ''0''<br />modificar =  ''0''<br />eliminar =  ''0''<br />imprimir =  ''0''<br />', 'INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir)                      VALUES (''28'', ''4'', ''0'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (223, '2012-05-10', 202, 1, 'JOSE PELUZZO', 'N/A', 'AGROPATRIA', 'gtv8nmk2k8h3s874pceh7eapl1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_cultivo', 'Register No.0<br />estatus = t<br />modificado = <br />', 'estatus = ''f'', modificado = now()', 'UPDATE si_cultivo SET estatus = ''f'', modificado = now() WHERE id = ''1''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (224, '2012-05-10', 202, 0, 'N/A', 'N/A', 'N/A', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', '', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''riek505akgs2lb6am6apkud720''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (225, '2012-05-10', 102, 0, 'N/A', 'N/A', 'N/A', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE sesion = ''riek505akgs2lb6am6apkud720'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (226, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 13:00:28.370038-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (227, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />id = 6<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''5'', peso_01v = ''20720'', id = ''6'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''20720'', id = ''6'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (228, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''1'', ''5'', ''8.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (229, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''2.200''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''2'', ''5'', ''2.200'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (230, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''13'', ''5'', ''0.330'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (231, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (232, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (233, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (234, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''38'', ''5'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (235, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 6<br />estatus = 2<br />modificado = 2012-05-10 13:49:01.337592-04:30<br />', 'id = ''6'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''6'', estatus = ''3'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (236, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />peso_02v = <br />id = 7<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''5'', peso_01v = ''47350'', peso_02v = ''49000'', id = ''7'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''47350'', peso_02v = ''49000'', id = ''7'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=7', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (237, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''1'', ''5'', ''8.000'', ''8.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (238, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''2'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (239, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.330''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''13'', ''5'', ''0.330'', ''0.330'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (240, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''21'', ''5'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (241, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''22'', ''5'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (242, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''20'', ''5'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (243, '2012-05-10', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''38'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (244, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 7<br />estatus = 2<br />modificado = 2012-05-10 14:21:06.584624-04:30<br />', 'id = ''7'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''7'', estatus = ''3'', modificado=now() WHERE id=7', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (245, '2012-05-10', 101, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-09 10:10:28.899942-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''sjm1pm7euibfnl1kilsuabfpa3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''sjm1pm7euibfnl1kilsuabfpa3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (246, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 13:39:28.250842-04:30<br />conectado = 1<br />sesion = riek505akgs2lb6am6apkud720<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (247, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />peso_02v = <br />id = 1<br />estatus = 1<br />fecha_v = <br />modificado = 2012-04-23 14:55:03.392292-04:30<br />', 'romana_ent = ''5'', peso_01v = ''13000'', peso_02v = ''13500'', id = ''1'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''13000'', peso_02v = ''13500'', id = ''1'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (248, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />id = 6<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''6'', peso_01v = ''20720'', id = ''6'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''6'', peso_01v = ''20720'', id = ''6'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (249, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />peso_02v = <br />id = 7<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''7'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''7'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=7', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (250, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_ent = <br />peso_01v = <br />peso_02v = <br />id = 4<br />estatus = 1<br />fecha_v = <br />modificado = <br />', 'romana_ent = ''5'', peso_01v = ''20300'', peso_02v = ''19800'', id = ''4'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now()', 'UPDATE si_despacho SET  romana_ent = ''5'', peso_01v = ''20300'', peso_02v = ''19800'', id = ''4'', estatus = ''2'', fecha_v = ''NOW()'', modificado=now() WHERE id=4', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (251, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''12.000''<br />muestra2 =  ''12.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''1'', ''3'', ''12.000'', ''12.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (252, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''2'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (253, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''3'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (254, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''4'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (255, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''5'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (256, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''6'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (257, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''7'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (258, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''8'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (259, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''9'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (260, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.200''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''10'', ''3'', ''0.000'', ''0.200'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (261, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''11.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''11'', ''3'', ''0.000'', ''11.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (262, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''3.000''<br />muestra2 =  ''3.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''12'', ''3'', ''3.000'', ''3.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (263, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.790''<br />muestra2 =  ''0.790''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''13'', ''3'', ''0.790'', ''0.790'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (264, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''1.000''<br />muestra2 =  ''1.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''14'', ''3'', ''1.000'', ''1.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (265, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''20.000''<br />muestra2 =  ''20.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''15'', ''3'', ''20.000'', ''20.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (266, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''19'', ''3'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (267, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (268, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (269, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''23''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''23'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (270, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''24'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (271, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''1''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''1'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (272, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 1<br />estatus = 2<br />modificado = 2012-05-10 15:21:16.489998-04:30<br />', 'id = ''1'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''1'', estatus = ''3'', modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (273, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''6.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''1'', ''3'', ''6.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (274, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''2'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (275, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''13'', ''3'', ''0.330'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (276, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''21'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (277, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''22'', ''3'', ''A'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (278, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''20'', ''3'', ''NO'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (279, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''6''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''6'', ''38'', ''3'', ''0.000'', '''', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (280, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 6<br />estatus = 2<br />modificado = 2012-05-10 15:22:07.370723-04:30<br />', 'id = ''6'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''6'', estatus = ''3'', modificado=now() WHERE id=6', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (281, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''6.000''<br />muestra2 =  ''6.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''1'', ''3'', ''6.000'', ''6.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (282, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''6.000''<br />muestra2 =  ''6.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''2'', ''3'', ''6.000'', ''6.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (283, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.333''<br />muestra2 =  ''0.333''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''13'', ''3'', ''0.333'', ''0.333'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (284, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (285, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (286, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (287, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''7''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''38'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (288, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 7<br />estatus = 2<br />modificado = 2012-05-10 15:22:31.969196-04:30<br />', 'id = ''7'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''7'', estatus = ''3'', modificado=now() WHERE id=7', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (289, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''12.000''<br />muestra2 =  ''12.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''1'', ''3'', ''12.000'', ''12.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (290, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''2'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (291, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''14'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (292, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (293, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (294, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''24'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (295, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (296, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''25''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''25'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (297, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''26''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''26'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (298, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''27''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''27'', ''3'', ''A'', ''A'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (299, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''28''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''28'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (300, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''29''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''29'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (301, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''30''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''30'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (302, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''31''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''31'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (303, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''32''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''32'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (304, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''33''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''33'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (305, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''36''<br />id_usuario =  ''3''<br />muestra1 =  ''46.000''<br />muestra2 =  ''46.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''36'', ''3'', ''46.000'', ''46.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (306, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''20.000''<br />muestra2 =  ''20.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''38'', ''3'', ''20.000'', ''20.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (307, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_despacho = ''4''<br />id_analisis =  ''39''<br />id_usuario =  ''3''<br />muestra1 =  ''50.000''<br />muestra2 =  ''50.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''D''<br />', 'INSERT INTO si_analisis_resultado (id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''4'', ''39'', ''3'', ''50.000'', ''50.000'', '''', ''2'', ''D'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (308, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />id = 4<br />estatus = 2<br />modificado = 2012-05-10 15:23:09.614967-04:30<br />', 'id = ''4'', estatus = ''3'', modificado=now()', 'UPDATE si_despacho SET  id = ''4'', estatus = ''3'', modificado=now() WHERE id=4', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (309, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''8.000''<br />muestra2 =  ''19.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''1'', ''3'', ''8.000'', ''19.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (310, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''2'', ''3'', ''0.000'', ''8.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (311, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.480''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''13'', ''3'', ''0.330'', ''0.480'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (312, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (313, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (314, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (315, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''38'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (316, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 8<br />estatus_rec = 1<br />muestra = <br />modificado = <br />', 'id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (317, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''12.000''<br />muestra2 =  ''12.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''1'', ''3'', ''12.000'', ''12.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (318, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''5.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''2'', ''3'', ''0.000'', ''5.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (319, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''3'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (320, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''4'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (321, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''5'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (322, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''6'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (323, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''7'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (324, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''8'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (325, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''9'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (326, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''10'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (327, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''11'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (328, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''12'', ''3'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (329, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.710''<br />muestra2 =  ''0.790''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''13'', ''3'', ''0.710'', ''0.790'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (330, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''1.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''14'', ''3'', ''0.000'', ''1.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (331, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''20.000''<br />muestra2 =  ''20.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''15'', ''3'', ''20.000'', ''20.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (332, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''19'', ''3'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (333, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''21'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (334, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''22'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (335, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''23''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''23'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (336, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''24'', ''3'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (337, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''2'', ''20'', ''3'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (338, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 2<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''2'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''2'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (339, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''24.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''1'', ''3'', ''24.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (340, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''10.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''2'', ''3'', ''10.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (341, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''2.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''7'', ''3'', ''2.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (342, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''1.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''8'', ''3'', ''1.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (343, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.760''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''13'', ''3'', ''0.760'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (344, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''19'', ''3'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (345, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''21'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (346, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''22'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (347, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''24''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''24'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (348, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''7''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''7'', ''20'', ''3'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (349, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 7<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''7'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''7'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=7', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (350, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''8.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''1'', ''3'', ''8.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (351, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''2'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (352, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0.333''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''13'', ''3'', ''0.333'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (353, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''21'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (354, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''22''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''22'', ''3'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (355, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''20'', ''3'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (356, '2012-05-10', 201, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''38''<br />id_usuario =  ''3''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''38'', ''3'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (357, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 9<br />estatus_rec = 1<br />muestra = <br />modificado = <br />', 'id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (358, '2012-05-10', 202, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = sjm1pm7euibfnl1kilsuabfpa3<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''sjm1pm7euibfnl1kilsuabfpa3''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (359, '2012-05-10', 102, 3, 'JUAN TABORDA', 'N/A', 'ARAURE', 'sjm1pm7euibfnl1kilsuabfpa3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''3'' AND sesion = ''sjm1pm7euibfnl1kilsuabfpa3'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (360, '2012-05-10', 101, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-05-10 15:16:34.652278-04:30<br />conectado = 1<br />sesion = riek505akgs2lb6am6apkud720<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''riek505akgs2lb6am6apkud720'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (361, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_despacho', 'Register No.0<br />romana_sal = <br />peso_01v = 3000<br />peso_02v = 3860<br />id = 1<br />estatus = 3<br />fecha_pel = <br />humedad = <br />impureza = <br />humedad_des = <br />impureza_des = <br />peso_acon = <br />peso_acon_liq = <br />humedad2 = <br />impureza2 = <br />humedad_des2 = <br />impureza_des2 = <br />peso_acon2 = <br />peso_acon_liq2 = <br />peso_01l = <br />peso_02l = <br />modificado = 2012-05-10 15:28:41.780487-04:30<br />', 'romana_sal = ''5'', peso_01v = ''3000'', peso_02v = ''3860'', id = ''1'', estatus = ''5'', fecha_pel = ''NOW()'', humedad = ''19.600'', impureza = ''3.400'', humedad_des = ''864'', impureza_des = ''311'', peso_acon = null, peso_acon_liq = ''8826'', humedad2 = ''19.600'', impureza2 = ''3.400'', humedad_des2 = ''833'', impureza_des2 = ''299'', peso_acon2 = null, peso_acon_liq2 = ''8508'', peso_01l = ''13000'', peso_02l = ''13500'', modificado=now()', 'UPDATE si_despacho SET  romana_sal = ''5'', peso_01v = ''3000'', peso_02v = ''3860'', id = ''1'', estatus = ''5'', fecha_pel = ''NOW()'', humedad = ''19.600'', impureza = ''3.400'', humedad_des = ''864'', impureza_des = ''311'', peso_acon = null, peso_acon_liq = ''8826'', humedad2 = ''19.600'', impureza2 = ''3.400'', humedad_des2 = ''833'', impureza_des2 = ''299'', peso_acon2 = null, peso_acon_liq2 = ''8508'', peso_01l = ''13000'', peso_02l = ''13500'', modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (362, '2012-05-10', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = riek505akgs2lb6am6apkud720<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''riek505akgs2lb6am6apkud720''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (363, '2012-05-10', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'riek505akgs2lb6am6apkud720', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''riek505akgs2lb6am6apkud720'' ', '');


--
-- TOC entry 2482 (class 0 OID 36125)
-- Dependencies: 203
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


--
-- TOC entry 2483 (class 0 OID 36130)
-- Dependencies: 204
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (24, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (6, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (32, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (21, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (22, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (5, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (23, 2, 0, 1, 0, 0);
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
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (13, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (14, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (15, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (16, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (35, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 5, 0, 0, 0, 0);
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
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (21, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (5, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (23, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (27, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (31, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (38, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (2, 4, 7, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, nuevo, modificar, eliminar, imprimir) VALUES (28, 4, 0, 0, 0, 0);


--
-- TOC entry 2484 (class 0 OID 36139)
-- Dependencies: 206
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
-- TOC entry 2485 (class 0 OID 36145)
-- Dependencies: 208
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (2, 2, 2, 1, 56011212, '2012-04-13 00:00:00-04:30', NULL, 650, false, 'N', NULL, '2012-04-23 14:15:36.726353-04:30', NULL, '56012348');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (3, 2, 1, 2, 56021211, '2012-04-03 00:00:00-04:30', NULL, 765, true, 'N', NULL, '2012-04-23 14:16:02.53446-04:30', NULL, '56022453');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (4, 2, 3, 2, 56021210, '2012-04-02 00:00:00-04:30', NULL, 196, false, 'N', NULL, '2012-04-23 14:18:36.656458-04:30', NULL, '56021882');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (1, 2, 1, 1, 56011201, '2012-04-18 00:00:00-04:30', NULL, 700, false, 'N', NULL, '2012-04-18 14:51:00.510284-04:30', '2012-05-03 15:54:44.728857', '56012392');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (5, 2, 2, 12, 56121201, '2012-01-24 00:00:00-04:30', NULL, 3500, false, 'N', NULL, '2012-05-10 08:11:06.742624-04:30', NULL, '56125206');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (6, 2, 3, 10, 56101103, '2011-11-09 00:00:00-04:30', NULL, 125, false, 'f', NULL, '2012-05-10 08:11:57.970983-04:30', '2012-05-10 08:12:18.773587', '56101725');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (7, 2, 3, 12, 56121202, '2012-01-24 00:00:00-04:30', NULL, 3500, true, 'N', NULL, '2012-05-10 08:37:15.932029-04:30', NULL, '56125207');


--
-- TOC entry 2486 (class 0 OID 36153)
-- Dependencies: 209
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes_det (id, id_orden, numero_orden, fecha, descripcion, kilogramos) VALUES (1, 1, '11232123', NULL, '', 12000);


--
-- TOC entry 2487 (class 0 OID 36160)
-- Dependencies: 212
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2488 (class 0 OID 36169)
-- Dependencies: 214
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'VENEZUELA');


--
-- TOC entry 2489 (class 0 OID 36175)
-- Dependencies: 216
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
-- TOC entry 2490 (class 0 OID 36184)
-- Dependencies: 218
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
-- TOC entry 2491 (class 0 OID 36188)
-- Dependencies: 219
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
-- TOC entry 2492 (class 0 OID 36193)
-- Dependencies: 221
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2493 (class 0 OID 36200)
-- Dependencies: 224
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (2, 1, NULL, 'G000000', NULL, 'BANCO AGRICOLA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:25.998447-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (3, 1, NULL, 'G000001', NULL, 'FONDAS', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:56.023047-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (4, 1, NULL, 'G123456', NULL, 'CONSEJO COMUNAL 1', NULL, NULL, NULL, NULL, NULL, 1, 8, 91, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:22.105165-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (7, 1, NULL, 'V16269763', NULL, 'PRODUCTOR 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:16.897952-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (8, 1, NULL, 'V15610226', NULL, 'PRODUCTOR 3', NULL, NULL, NULL, NULL, NULL, 1, 14, 160, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 16:12:42.012754-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (6, 1, NULL, 'V17247200', NULL, 'PRODUCTOR 1', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:00.31368-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (10, 1, NULL, 'V12789456', NULL, 'PRODUCTOR 5', NULL, NULL, NULL, NULL, NULL, 1, 16, 203, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 11:06:26.497-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (12, 1, NULL, 'G789456', NULL, 'CONSEJO COMUNAL 3', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 22:58:46.545-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (11, 1, NULL, 'V10123456', NULL, 'PRODUCTOR 6', NULL, NULL, NULL, NULL, NULL, 1, 5, 43, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 14:24:04.48-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (9, 1, NULL, 'V14785236', NULL, 'PRODUCTOR 4', NULL, NULL, NULL, NULL, NULL, 1, 24, 319, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 10:24:44.811-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (5, 1, NULL, 'G456789', NULL, 'CONSEJO COMUNAL 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:41.603699-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (13, 1, NULL, 'G0123456', NULL, 'CONSEJO COMUNAL 4', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 08:34:16.836892-04:30', '2012-05-03 15:20:51.557328-04:30');


--
-- TOC entry 2494 (class 0 OID 36209)
-- Dependencies: 226
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (2, 2, 'INVIERNO 2012', 'INVIERNO 2012', '2012-04-18 15:25:47.739787-04:30', NULL, true, '201201', '2012-09-03', '2013-09-03', 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (3, 2, 'PROGRAMA SORGO', NULL, '2012-04-29 22:43:28.902-04:30', '2012-05-03 15:03:26.829691-04:30', true, '201203', '2012-04-29', '2013-04-29', 3);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (4, 2, 'PROGRAMA GIRASOL', NULL, '2012-05-07 00:19:27.451-04:30', NULL, true, '201212', '2012-05-07', '2013-05-07', 12);


--
-- TOC entry 2495 (class 0 OID 36216)
-- Dependencies: 227
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2496 (class 0 OID 36224)
-- Dependencies: 229
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (1, 1, NULL, NULL, NULL, NULL, 'PTO LA CRUZ', NULL, NULL, NULL, '2012-04-18 14:56:38.350798', NULL, NULL);
INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (2, 2, NULL, NULL, NULL, NULL, 'ASOCOPRONA', NULL, NULL, NULL, '2012-04-23 14:20:55.493459', NULL, NULL);
INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (3, 3, NULL, NULL, NULL, NULL, 'PRIMER PUNTO', NULL, NULL, NULL, '2012-04-23 14:22:02.577104', NULL, NULL);


--
-- TOC entry 2497 (class 0 OID 36232)
-- Dependencies: 231
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (2, 2, 1, NULL, 6, 2, 5, 1, '2012-04-29 19:20:15.965-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 19:20:15.965-04:30', '2012-05-10 15:59:43.176996', 2, 9, 5, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (7, 2, 2, NULL, 10, 7, 4, 1, '2012-05-04 10:46:21.988047-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-04 10:46:21.988047-04:30', '2012-05-10 15:59:58.028376', 1, 14, 10, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (9, 2, 3, NULL, 7, 9, 5, 2, '2012-05-07 00:28:45.32-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-07 00:28:45.32-04:30', '2012-05-10 16:00:11.665819', 1, 16, 12, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (3, 2, 1, NULL, 11, 3, 5, 2, '2012-04-29 20:25:21.751-04:30', 2, '2012-05-04 13:37:21.860574-04:30', 32150, NULL, NULL, '2012-05-04 13:41:46.820441-04:30', 15000, NULL, 12, NULL, NULL, NULL, '2012-04-29 20:25:21.751-04:30', '2012-05-04 13:41:46.820441', 1, 10, 6, 6, 6, 17150, NULL, 0, 9);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (4, 2, 1, NULL, 11, 4, 5, 3, '2012-04-29 20:32:39.489-04:30', 1, '2012-05-04 13:37:30.87956-04:30', 28560, NULL, NULL, '2012-05-04 13:42:01.927864-04:30', 8000, NULL, 25, NULL, 3037.2730000000001, NULL, '2012-04-29 20:32:39.489-04:30', '2012-05-04 13:42:01.927864', 1, 11, 7, 5, 5, 17522.726999999999, NULL, 0, 9);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (6, 2, 1, NULL, 6, 6, 5, 2, '2012-04-30 10:34:12.974384-04:30', 1, '2012-05-09 09:57:56.52836-04:30', 25000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:34:12.974384-04:30', '2012-05-09 14:23:53.600686', 1, 13, 9, 5, NULL, NULL, NULL, NULL, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (5, 2, 1, NULL, 6, 5, 5, 1, '2012-04-30 10:14:22.310566-04:30', 1, '2012-05-09 16:07:03.434924-04:30', 15000, 10000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:14:22.310566-04:30', '2012-05-09 16:07:03.434924', 2, 12, 8, 5, NULL, NULL, NULL, 0, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra, estatus_rec) VALUES (8, 2, 3, NULL, 6, 8, 5, 1, '2012-05-07 00:27:33.587-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-07 00:27:33.587-04:30', '2012-05-10 15:52:26.869557', 2, 15, 11, NULL, NULL, NULL, NULL, NULL, 2);


--
-- TOC entry 2498 (class 0 OID 36237)
-- Dependencies: 232
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2499 (class 0 OID 36244)
-- Dependencies: 235
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
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (56, 'Cuarentenas Pendientes', 'admin', 'cuarentena_pendiente_listado.php', 1, '2012-04-09 00:00:00-04:30', NULL);


--
-- TOC entry 2500 (class 0 OID 36251)
-- Dependencies: 236
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
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (43, 1, 'M_Chofer', 'Chofer', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (38, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (37, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (41, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (42, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (44, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (45, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (47, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (48, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (50, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (49, 1, 'M_Auditoria', 'Auditoria del Sistema', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (46, 1, 'M_Ordenes', 'Ordenes de Despacho', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (52, 1, 'M_CuarentenaPendiente', 'Cuarentenas Pendientes', 1, '2012-04-09 00:00:00-04:30', NULL);


--
-- TOC entry 2501 (class 0 OID 36264)
-- Dependencies: 240
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
-- TOC entry 2502 (class 0 OID 36274)
-- Dependencies: 242
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
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado, parametros) VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
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


--
-- TOC entry 2503 (class 0 OID 36280)
-- Dependencies: 243
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_transporte (id, id_centro_acopio, rif, nombre, contacto, direccion, telefono1, telefono2, fax, email, id_pais, id_estado, id_municipio, creado, modificado) VALUES (1, 2, NULL, 'ASOTRAMACHAQ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:56:38.350798-04:30', NULL);


--
-- TOC entry 2504 (class 0 OID 36290)
-- Dependencies: 246
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-05-03 13:26:22.155497-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, 'JUANCARRIZALEZ@AGROPATRIA.CO.VE', '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'JESUSRODRIGUEZ@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-05-09 13:40:13.441932-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'JOSEPELUZZO@AGROPATRIA.CO.VE', '2012-02-12 00:00:00-04:30', NULL, true, 1, 'gtv8nmk2k8h3s874pceh7eapl1', '2012-05-10 13:33:29.608072-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JUANTABORDA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 0, NULL, '2012-05-10 15:12:50.017982-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (5, 'MARIELY', 'CORONADO', '16538158', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 0, NULL, '2012-05-10 16:09:24.414915-04:30');


--
-- TOC entry 2505 (class 0 OID 36301)
-- Dependencies: 248
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (6, 6, 2, 8, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (5, 5, 2, 2, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 3, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');


--
-- TOC entry 2506 (class 0 OID 36305)
-- Dependencies: 249
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (1, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:53:45.757646-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (3, 'ASD-ASH', 'AZUL', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:58:04.663656-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (4, 'ASD-ASG', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:58:43.589592-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (5, '18LABAS', 'FORD', NULL, NULL, NULL, NULL, '14LABS', '2012-04-18 15:56:47.128604-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (6, 'DFG-GFD', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-20 07:45:47.285401-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (2, 'ASD-ASE', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:54:47.40262-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (7, 'TYU-TYU', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-23 14:20:39.026996-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (8, 'IOYTYUR', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-23 14:21:48.824864-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (9, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, '123-123', '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (10, 'TYG-SDF', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (11, 'DFG-SDF', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (12, 'DFG-DFG', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (13, 'FGH-DFGH', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (14, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (15, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, '123-123', '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (16, 'ASD-ASE', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-05-07 00:28:45.32-04:30', NULL);


--
-- TOC entry 2238 (class 2606 OID 36338)
-- Dependencies: 154 154
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2284 (class 2606 OID 36340)
-- Dependencies: 199 199
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2226 (class 2606 OID 36342)
-- Dependencies: 143 143
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 36344)
-- Dependencies: 146 146
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 36346)
-- Dependencies: 148 148
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 36348)
-- Dependencies: 145 145 145
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2230 (class 2606 OID 36350)
-- Dependencies: 145 145
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 36352)
-- Dependencies: 152 152
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 36354)
-- Dependencies: 155 155
-- Name: si_asociacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociacion
    ADD CONSTRAINT si_asociacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 36356)
-- Dependencies: 158 158
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 36358)
-- Dependencies: 160 160
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 36360)
-- Dependencies: 162 162
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 36362)
-- Dependencies: 164 164
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 36364)
-- Dependencies: 165 165
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 36366)
-- Dependencies: 168 168
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 36368)
-- Dependencies: 170 170
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 36370)
-- Dependencies: 172 172 172 172
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2258 (class 2606 OID 36372)
-- Dependencies: 172 172
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 36374)
-- Dependencies: 174 174
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 36376)
-- Dependencies: 176 176
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2264 (class 2606 OID 36378)
-- Dependencies: 179 179
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 36380)
-- Dependencies: 180 180
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2268 (class 2606 OID 36382)
-- Dependencies: 183 183
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 36384)
-- Dependencies: 184 184
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2272 (class 2606 OID 36386)
-- Dependencies: 187 187
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 36388)
-- Dependencies: 189 189
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2276 (class 2606 OID 36390)
-- Dependencies: 190 190
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2278 (class 2606 OID 36392)
-- Dependencies: 192 192
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 36394)
-- Dependencies: 194 194
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2282 (class 2606 OID 36396)
-- Dependencies: 195 195
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2286 (class 2606 OID 36398)
-- Dependencies: 201 201
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2288 (class 2606 OID 36400)
-- Dependencies: 203 203
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 36402)
-- Dependencies: 204 204 204
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2292 (class 2606 OID 36404)
-- Dependencies: 206 206
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 36406)
-- Dependencies: 209 209
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 36408)
-- Dependencies: 208 208
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 36410)
-- Dependencies: 212 212
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2300 (class 2606 OID 36412)
-- Dependencies: 214 214
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 36414)
-- Dependencies: 216 216
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2304 (class 2606 OID 36416)
-- Dependencies: 218 218
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2306 (class 2606 OID 36418)
-- Dependencies: 219 219
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2308 (class 2606 OID 36420)
-- Dependencies: 221 221
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 36422)
-- Dependencies: 224 224
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2312 (class 2606 OID 36424)
-- Dependencies: 226 226
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2314 (class 2606 OID 36426)
-- Dependencies: 227 227
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 36428)
-- Dependencies: 229 229
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2320 (class 2606 OID 36430)
-- Dependencies: 232 232
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2318 (class 2606 OID 36432)
-- Dependencies: 231 231
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2324 (class 2606 OID 36434)
-- Dependencies: 236 236
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2322 (class 2606 OID 36436)
-- Dependencies: 235 235
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2326 (class 2606 OID 36438)
-- Dependencies: 240 240
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2328 (class 2606 OID 36440)
-- Dependencies: 242 242
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2330 (class 2606 OID 36442)
-- Dependencies: 243 243
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2336 (class 2606 OID 36444)
-- Dependencies: 248 248
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2332 (class 2606 OID 36446)
-- Dependencies: 246 246
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2334 (class 2606 OID 36448)
-- Dependencies: 246 246
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2338 (class 2606 OID 36450)
-- Dependencies: 249 249
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2339 (class 2606 OID 36451)
-- Dependencies: 2247 164 143
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2340 (class 2606 OID 36456)
-- Dependencies: 189 143 2273
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2341 (class 2606 OID 36461)
-- Dependencies: 206 143 2291
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2342 (class 2606 OID 36466)
-- Dependencies: 214 2299 143
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2344 (class 2606 OID 36471)
-- Dependencies: 146 2229 145
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2345 (class 2606 OID 36476)
-- Dependencies: 146 2247 164
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2346 (class 2606 OID 36481)
-- Dependencies: 148 2229 145
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2347 (class 2606 OID 36486)
-- Dependencies: 2297 148 212
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2348 (class 2606 OID 36491)
-- Dependencies: 150 2229 145
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2349 (class 2606 OID 36496)
-- Dependencies: 212 150 2297
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2343 (class 2606 OID 36501)
-- Dependencies: 2297 212 145
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2350 (class 2606 OID 36506)
-- Dependencies: 145 152 2229
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2351 (class 2606 OID 36511)
-- Dependencies: 152 184 2269
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2352 (class 2606 OID 36516)
-- Dependencies: 231 2317 152
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2353 (class 2606 OID 36521)
-- Dependencies: 152 246 2331
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2354 (class 2606 OID 36526)
-- Dependencies: 143 2225 160
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2355 (class 2606 OID 36531)
-- Dependencies: 162 2245 160
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2356 (class 2606 OID 36536)
-- Dependencies: 246 2331 160
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2357 (class 2606 OID 36541)
-- Dependencies: 164 2273 189
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2358 (class 2606 OID 36546)
-- Dependencies: 164 2291 206
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2359 (class 2606 OID 36551)
-- Dependencies: 164 2297 212
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2360 (class 2606 OID 36556)
-- Dependencies: 2299 214 164
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2361 (class 2606 OID 36561)
-- Dependencies: 165 2297 212
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2362 (class 2606 OID 36566)
-- Dependencies: 212 2297 168
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2363 (class 2606 OID 36571)
-- Dependencies: 179 170 2263
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2364 (class 2606 OID 36576)
-- Dependencies: 2311 226 170
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2365 (class 2606 OID 36581)
-- Dependencies: 171 164 2247
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2366 (class 2606 OID 36586)
-- Dependencies: 2253 171 170
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2367 (class 2606 OID 36591)
-- Dependencies: 224 171 2309
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2368 (class 2606 OID 36596)
-- Dependencies: 172 170 2253
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2369 (class 2606 OID 36601)
-- Dependencies: 172 179 2263
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2370 (class 2606 OID 36606)
-- Dependencies: 2325 172 240
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2371 (class 2606 OID 36611)
-- Dependencies: 145 2229 174
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2372 (class 2606 OID 36616)
-- Dependencies: 164 2247 174
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2373 (class 2606 OID 36621)
-- Dependencies: 179 174 2263
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2374 (class 2606 OID 36626)
-- Dependencies: 2317 231 174
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2375 (class 2606 OID 36631)
-- Dependencies: 246 174 2331
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2376 (class 2606 OID 36636)
-- Dependencies: 174 176 2259
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2377 (class 2606 OID 36641)
-- Dependencies: 179 2297 212
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2378 (class 2606 OID 36646)
-- Dependencies: 180 145 2229
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2379 (class 2606 OID 36651)
-- Dependencies: 2247 180 164
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2380 (class 2606 OID 36656)
-- Dependencies: 180 179 2263
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2381 (class 2606 OID 36661)
-- Dependencies: 183 179 2263
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2382 (class 2606 OID 36666)
-- Dependencies: 183 212 2297
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2383 (class 2606 OID 36671)
-- Dependencies: 164 184 2247
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2384 (class 2606 OID 36676)
-- Dependencies: 2251 168 184
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2385 (class 2606 OID 36681)
-- Dependencies: 2263 179 184
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2386 (class 2606 OID 36686)
-- Dependencies: 184 2293 208
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2387 (class 2606 OID 36691)
-- Dependencies: 184 229 2315
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2388 (class 2606 OID 36696)
-- Dependencies: 184 240 2325
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2389 (class 2606 OID 36701)
-- Dependencies: 184 243 2329
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2390 (class 2606 OID 36706)
-- Dependencies: 184 246 2331
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2391 (class 2606 OID 36711)
-- Dependencies: 184 249 2337
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2392 (class 2606 OID 36716)
-- Dependencies: 187 212 2297
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2393 (class 2606 OID 36721)
-- Dependencies: 189 214 2299
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2394 (class 2606 OID 36726)
-- Dependencies: 190 189 2273
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2395 (class 2606 OID 36731)
-- Dependencies: 190 206 2291
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2396 (class 2606 OID 36736)
-- Dependencies: 190 212 2297
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2397 (class 2606 OID 36741)
-- Dependencies: 190 214 2299
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2398 (class 2606 OID 36746)
-- Dependencies: 190 224 2309
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2399 (class 2606 OID 36751)
-- Dependencies: 192 164 2247
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2400 (class 2606 OID 36756)
-- Dependencies: 192 179 2263
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2401 (class 2606 OID 36761)
-- Dependencies: 192 212 2297
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2402 (class 2606 OID 36766)
-- Dependencies: 194 246 2331
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2403 (class 2606 OID 36771)
-- Dependencies: 195 194 2279
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2404 (class 2606 OID 36776)
-- Dependencies: 201 199 2283
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2405 (class 2606 OID 36781)
-- Dependencies: 204 203 2287
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2406 (class 2606 OID 36786)
-- Dependencies: 204 246 2331
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2407 (class 2606 OID 36791)
-- Dependencies: 206 189 2273
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2412 (class 2606 OID 36796)
-- Dependencies: 209 208 2293
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2408 (class 2606 OID 36801)
-- Dependencies: 208 164 2247
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2409 (class 2606 OID 36806)
-- Dependencies: 208 168 2251
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2410 (class 2606 OID 36811)
-- Dependencies: 208 179 2263
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2411 (class 2606 OID 36816)
-- Dependencies: 208 229 2315
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2413 (class 2606 OID 36821)
-- Dependencies: 212 189 2273
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2414 (class 2606 OID 36826)
-- Dependencies: 212 206 2291
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2415 (class 2606 OID 36831)
-- Dependencies: 212 214 2299
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2416 (class 2606 OID 36836)
-- Dependencies: 219 212 2297
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2417 (class 2606 OID 36841)
-- Dependencies: 2297 212 221
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2418 (class 2606 OID 36846)
-- Dependencies: 224 2273 189
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2419 (class 2606 OID 36851)
-- Dependencies: 2291 206 224
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2420 (class 2606 OID 36856)
-- Dependencies: 224 2297 212
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2421 (class 2606 OID 36861)
-- Dependencies: 224 2299 214
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2422 (class 2606 OID 36866)
-- Dependencies: 226 2247 164
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2423 (class 2606 OID 36871)
-- Dependencies: 2273 189 227
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2424 (class 2606 OID 36876)
-- Dependencies: 227 2291 206
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2425 (class 2606 OID 36881)
-- Dependencies: 212 2297 227
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2426 (class 2606 OID 36886)
-- Dependencies: 2299 214 227
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2427 (class 2606 OID 36891)
-- Dependencies: 2247 164 229
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2428 (class 2606 OID 36896)
-- Dependencies: 229 168 2251
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2429 (class 2606 OID 36901)
-- Dependencies: 2273 189 229
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2430 (class 2606 OID 36906)
-- Dependencies: 2291 229 206
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2431 (class 2606 OID 36911)
-- Dependencies: 229 2299 214
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2439 (class 2606 OID 36916)
-- Dependencies: 232 164 2247
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2440 (class 2606 OID 36921)
-- Dependencies: 2263 232 179
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2441 (class 2606 OID 36926)
-- Dependencies: 232 2317 231
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2432 (class 2606 OID 36931)
-- Dependencies: 2247 231 164
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2433 (class 2606 OID 36936)
-- Dependencies: 2249 165 231
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2434 (class 2606 OID 36941)
-- Dependencies: 231 170 2253
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2435 (class 2606 OID 36946)
-- Dependencies: 2279 194 231
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2436 (class 2606 OID 36951)
-- Dependencies: 231 2309 224
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2437 (class 2606 OID 36956)
-- Dependencies: 2325 231 240
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2438 (class 2606 OID 36961)
-- Dependencies: 231 246 2331
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2442 (class 2606 OID 36966)
-- Dependencies: 236 2321 235
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2443 (class 2606 OID 36971)
-- Dependencies: 143 240 2225
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2444 (class 2606 OID 36976)
-- Dependencies: 240 164 2247
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2445 (class 2606 OID 36981)
-- Dependencies: 242 2247 164
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2446 (class 2606 OID 36986)
-- Dependencies: 164 2247 243
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2447 (class 2606 OID 36991)
-- Dependencies: 2225 248 143
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2448 (class 2606 OID 36996)
-- Dependencies: 248 2303 218
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2449 (class 2606 OID 37001)
-- Dependencies: 248 2331 246
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-10 16:30:27 VET

--
-- PostgreSQL database dump complete
--

