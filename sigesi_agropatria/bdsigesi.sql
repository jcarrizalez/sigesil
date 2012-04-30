--
-- PostgreSQL database dump
--

-- Started on 2012-04-30 16:29:29 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 265 (class 1255 OID 33593)
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
-- TOC entry 140 (class 1259 OID 33594)
-- Dependencies: 2129 6
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
-- TOC entry 141 (class 1259 OID 33601)
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
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 141
-- Name: romana_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE romana_id_seq OWNED BY romana.id;


--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 141
-- Name: romana_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('romana_id_seq', 1, false);


--
-- TOC entry 142 (class 1259 OID 33603)
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
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 142
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


--
-- TOC entry 143 (class 1259 OID 33605)
-- Dependencies: 2131 6
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
-- TOC entry 144 (class 1259 OID 33612)
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
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 144
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 145 (class 1259 OID 33614)
-- Dependencies: 2132 2133 2134 6
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
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 146 (class 1259 OID 33620)
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
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 147 (class 1259 OID 33623)
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
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 148 (class 1259 OID 33625)
-- Dependencies: 2136 2137 2138 2139 2140 2141 6
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
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 149 (class 1259 OID 33634)
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
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 66, true);


--
-- TOC entry 150 (class 1259 OID 33636)
-- Dependencies: 2143 6
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
-- TOC entry 151 (class 1259 OID 33640)
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
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 152 (class 1259 OID 33642)
-- Dependencies: 6
-- Name: si_analisis_resultado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_resultado (
    id bigint NOT NULL,
    id_recepcion bigint,
    id_despacho bigint,
    id_analisis bigint NOT NULL,
    id_usuario bigint NOT NULL,
    muestra1 character(16),
    muestra2 character(16),
    muestra3 character(16),
    id_centro_acopio bigint NOT NULL,
    tipo_mov character(2) NOT NULL
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 153 (class 1259 OID 33645)
-- Dependencies: 6 152
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
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 153
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 153
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 130, true);


--
-- TOC entry 154 (class 1259 OID 33647)
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
-- TOC entry 155 (class 1259 OID 33653)
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
-- TOC entry 156 (class 1259 OID 33659)
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
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_asociacion_id_seq OWNED BY si_asociacion.id;


--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_asociacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociacion_id_seq', 1, false);


--
-- TOC entry 157 (class 1259 OID 33661)
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
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 157
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 158 (class 1259 OID 33663)
-- Dependencies: 2147 6
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
-- TOC entry 159 (class 1259 OID 33670)
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
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 160 (class 1259 OID 33672)
-- Dependencies: 2148 6
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
-- TOC entry 161 (class 1259 OID 33676)
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
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 162 (class 1259 OID 33678)
-- Dependencies: 2149 2150 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 163 (class 1259 OID 33683)
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 164 (class 1259 OID 33685)
-- Dependencies: 2151 2152 2153 2154 2155 2156 2157 6
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
-- TOC entry 165 (class 1259 OID 33698)
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
-- TOC entry 166 (class 1259 OID 33701)
-- Dependencies: 6 165
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
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 9, true);


--
-- TOC entry 167 (class 1259 OID 33703)
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
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 167
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 3, true);


--
-- TOC entry 168 (class 1259 OID 33705)
-- Dependencies: 2159 6
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
-- TOC entry 169 (class 1259 OID 33712)
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
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 2, true);


--
-- TOC entry 170 (class 1259 OID 33714)
-- Dependencies: 2160 2161 2162 2163 2164 6
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
-- TOC entry 171 (class 1259 OID 33725)
-- Dependencies: 6
-- Name: si_cosecha_productor; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha_productor (
    id bigint NOT NULL,
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
-- TOC entry 172 (class 1259 OID 33728)
-- Dependencies: 171 6
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
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;


--
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 4, true);


--
-- TOC entry 173 (class 1259 OID 33730)
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
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 174 (class 1259 OID 33733)
-- Dependencies: 173 6
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
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 175 (class 1259 OID 33735)
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
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 175
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
-- TOC entry 176 (class 1259 OID 33738)
-- Dependencies: 6 175
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 33740)
-- Dependencies: 2168 6
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
-- TOC entry 178 (class 1259 OID 33744)
-- Dependencies: 6 177
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
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 33746)
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 180 (class 1259 OID 33748)
-- Dependencies: 2170 2171 2172 6
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
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 181 (class 1259 OID 33754)
-- Dependencies: 2173 2174 6
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
-- TOC entry 182 (class 1259 OID 33759)
-- Dependencies: 181 6
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
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 10, true);


--
-- TOC entry 183 (class 1259 OID 33761)
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
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 184 (class 1259 OID 33763)
-- Dependencies: 2176 6
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
-- TOC entry 185 (class 1259 OID 33767)
-- Dependencies: 2177 6
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
    muestra smallint
);


ALTER TABLE public.si_despacho OWNER TO admin;

--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 185
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
-- TOC entry 186 (class 1259 OID 33771)
-- Dependencies: 6 185
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
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 5, true);


--
-- TOC entry 187 (class 1259 OID 33773)
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 188 (class 1259 OID 33775)
-- Dependencies: 2179 2180 6
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
-- TOC entry 189 (class 1259 OID 33780)
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
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 190 (class 1259 OID 33782)
-- Dependencies: 2181 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 191 (class 1259 OID 33786)
-- Dependencies: 2182 6
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
-- TOC entry 192 (class 1259 OID 33793)
-- Dependencies: 6 191
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
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 33795)
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
-- TOC entry 194 (class 1259 OID 33801)
-- Dependencies: 193 6
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
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 47, true);


--
-- TOC entry 195 (class 1259 OID 33803)
-- Dependencies: 2185 2186 6
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
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 196 (class 1259 OID 33808)
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
-- TOC entry 197 (class 1259 OID 33811)
-- Dependencies: 6 196
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
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 3, true);


--
-- TOC entry 198 (class 1259 OID 33813)
-- Dependencies: 195 6
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
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 6, true);


--
-- TOC entry 199 (class 1259 OID 33815)
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
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 199
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 200 (class 1259 OID 33817)
-- Dependencies: 2189 6
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
-- TOC entry 201 (class 1259 OID 33821)
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
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 22, true);


--
-- TOC entry 202 (class 1259 OID 33823)
-- Dependencies: 2190 6
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
-- TOC entry 203 (class 1259 OID 33830)
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
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 34, true);


--
-- TOC entry 204 (class 1259 OID 33832)
-- Dependencies: 2191 2192 6
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
-- TOC entry 205 (class 1259 OID 33837)
-- Dependencies: 2193 2194 2195 2196 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id bigint NOT NULL,
    id_perfil bigint NOT NULL,
    nuevo smallint DEFAULT 0,
    modificar smallint DEFAULT 0,
    eliminar smallint DEFAULT 0,
    imprimir smallint DEFAULT 0
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 206 (class 1259 OID 33844)
-- Dependencies: 205 6
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
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;


--
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_usuario_id_seq', 568, true);


--
-- TOC entry 207 (class 1259 OID 33846)
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
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 208 (class 1259 OID 33848)
-- Dependencies: 2198 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 209 (class 1259 OID 33852)
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
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 209
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 4, true);


--
-- TOC entry 210 (class 1259 OID 33854)
-- Dependencies: 2199 2200 6
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
-- TOC entry 211 (class 1259 OID 33862)
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
-- TOC entry 212 (class 1259 OID 33865)
-- Dependencies: 211 6
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
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 1, true);


--
-- TOC entry 213 (class 1259 OID 33867)
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
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 214 (class 1259 OID 33869)
-- Dependencies: 2202 6
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
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 215 (class 1259 OID 33876)
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
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 216 (class 1259 OID 33878)
-- Dependencies: 2203 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 33882)
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
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 218 (class 1259 OID 33884)
-- Dependencies: 2204 6
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
-- TOC entry 219 (class 1259 OID 33891)
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
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 9, true);


--
-- TOC entry 220 (class 1259 OID 33893)
-- Dependencies: 2205 6
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
-- TOC entry 221 (class 1259 OID 33897)
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
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 222 (class 1259 OID 33900)
-- Dependencies: 221 6
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
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 223 (class 1259 OID 33902)
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
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 224 (class 1259 OID 33905)
-- Dependencies: 223 6
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
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 225 (class 1259 OID 33907)
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
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 225
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 13, true);


--
-- TOC entry 226 (class 1259 OID 33909)
-- Dependencies: 2208 6
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
-- TOC entry 227 (class 1259 OID 33916)
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
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 3, true);


--
-- TOC entry 228 (class 1259 OID 33918)
-- Dependencies: 2209 6
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
-- TOC entry 229 (class 1259 OID 33925)
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
-- TOC entry 230 (class 1259 OID 33931)
-- Dependencies: 229 6
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
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 231 (class 1259 OID 33933)
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
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 232 (class 1259 OID 33939)
-- Dependencies: 6 231
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
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 3, true);


--
-- TOC entry 233 (class 1259 OID 33941)
-- Dependencies: 2212 6
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
    estatus_rec character(1),
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
    muestra smallint
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 233
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
-- TOC entry 234 (class 1259 OID 33945)
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
-- TOC entry 235 (class 1259 OID 33948)
-- Dependencies: 6 234
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
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 236 (class 1259 OID 33950)
-- Dependencies: 6 233
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
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 6, true);


--
-- TOC entry 237 (class 1259 OID 33952)
-- Dependencies: 2215 6
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
-- TOC entry 238 (class 1259 OID 33959)
-- Dependencies: 2217 6
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
-- TOC entry 239 (class 1259 OID 33966)
-- Dependencies: 238 6
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
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 48, true);


--
-- TOC entry 240 (class 1259 OID 33968)
-- Dependencies: 6 237
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
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 240
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 240
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 52, true);


--
-- TOC entry 241 (class 1259 OID 33970)
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
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 242 (class 1259 OID 33972)
-- Dependencies: 2219 2220 2221 6
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
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 243 (class 1259 OID 33981)
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
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 244 (class 1259 OID 33983)
-- Dependencies: 2222 2223 2224 6
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
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 245 (class 1259 OID 33989)
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
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 246 (class 1259 OID 33995)
-- Dependencies: 245 6
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
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, true);


--
-- TOC entry 247 (class 1259 OID 33997)
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
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 7, true);


--
-- TOC entry 248 (class 1259 OID 33999)
-- Dependencies: 2226 2227 2228 6
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
-- TOC entry 249 (class 1259 OID 34008)
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
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 249
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 7, true);


--
-- TOC entry 250 (class 1259 OID 34010)
-- Dependencies: 2229 6
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
-- TOC entry 251 (class 1259 OID 34014)
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
-- TOC entry 252 (class 1259 OID 34017)
-- Dependencies: 251 6
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
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 252
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 252
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 13, true);


--
-- TOC entry 2130 (class 2604 OID 34019)
-- Dependencies: 141 140
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY romana ALTER COLUMN id SET DEFAULT nextval('romana_id_seq'::regclass);


--
-- TOC entry 2135 (class 2604 OID 34020)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2142 (class 2604 OID 34021)
-- Dependencies: 149 148
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2144 (class 2604 OID 34022)
-- Dependencies: 151 150
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2145 (class 2604 OID 34023)
-- Dependencies: 153 152
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 34024)
-- Dependencies: 156 155
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociacion ALTER COLUMN id SET DEFAULT nextval('si_asociacion_id_seq'::regclass);


--
-- TOC entry 2158 (class 2604 OID 34025)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 34026)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);


--
-- TOC entry 2166 (class 2604 OID 34027)
-- Dependencies: 174 173
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 34028)
-- Dependencies: 176 175
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 34029)
-- Dependencies: 178 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2175 (class 2604 OID 34030)
-- Dependencies: 182 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 34031)
-- Dependencies: 186 185
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 34032)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 34033)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 34034)
-- Dependencies: 198 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 34035)
-- Dependencies: 197 196
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 34036)
-- Dependencies: 206 205
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 34037)
-- Dependencies: 212 211
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 34038)
-- Dependencies: 222 221
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 34039)
-- Dependencies: 224 223
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2210 (class 2604 OID 34040)
-- Dependencies: 230 229
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 34041)
-- Dependencies: 232 231
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 34042)
-- Dependencies: 236 233
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2214 (class 2604 OID 34043)
-- Dependencies: 235 234
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2216 (class 2604 OID 34044)
-- Dependencies: 240 237
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 34045)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2225 (class 2604 OID 34046)
-- Dependencies: 246 245
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2230 (class 2604 OID 34047)
-- Dependencies: 252 251
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2459 (class 0 OID 33594)
-- Dependencies: 140
-- Data for Name: romana; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2460 (class 0 OID 33605)
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
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (11, 2, 'PRODUCTOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-20 11:06:41.92', NULL, 2, '3');
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '1');


--
-- TOC entry 2461 (class 0 OID 33614)
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
-- TOC entry 2462 (class 0 OID 33620)
-- Dependencies: 146
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2463 (class 0 OID 33625)
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
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 144, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 84, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 117, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 143, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 145, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 146, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 20, 13, 'A', 0.000, 0.000, 'R', 147, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 149, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 150, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 151, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 152, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des, id_centro_acopio) VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 153, 0.000, 3.000, 0.000, 3.000, 2);
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


--
-- TOC entry 2464 (class 0 OID 33636)
-- Dependencies: 150
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2465 (class 0 OID 33642)
-- Dependencies: 152
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2466 (class 0 OID 33647)
-- Dependencies: 154
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2467 (class 0 OID 33653)
-- Dependencies: 155
-- Data for Name: si_asociacion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2468 (class 0 OID 33663)
-- Dependencies: 158
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2469 (class 0 OID 33672)
-- Dependencies: 160
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2470 (class 0 OID 33678)
-- Dependencies: 162
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2471 (class 0 OID 33685)
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
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (9, 1, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', NULL);
INSERT INTO si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) VALUES (2, 1, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-03-16 10:40:45.916545-04:30');


--
-- TOC entry 2472 (class 0 OID 33698)
-- Dependencies: 165
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (2, 1, NULL, NULL, NULL, 'V14894566', 'LEIDY SIFONTES', NULL, NULL, NULL, true, '2012-04-18 15:56:47.128604-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (1, 1, 1, 5, 51, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-18 14:52:10.222967-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (3, NULL, 1, 5, 54, 'V16538158', 'MARIELY CORONADO', NULL, NULL, NULL, true, '2012-04-23 14:20:23.712675-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (4, NULL, 1, 3, 11, 'V16321654', 'OTRO CHOFER', NULL, NULL, NULL, NULL, '2012-04-23 14:21:37.597326-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (5, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (6, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (7, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (8, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_choferes (id, id_org, id_pais, id_estado, id_municipio, ced_rif, nombre, celular, telefono, direccion, estatus, creado, modificado) VALUES (9, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:34:12.974384-04:30', NULL);


--
-- TOC entry 2473 (class 0 OID 33705)
-- Dependencies: 168
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (1, 1, NULL, 'V18264066', NULL, 'JESUS SILVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, '2012-04-18 14:50:40.359184-04:30', NULL);
INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (2, 1, NULL, 'V18264065', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, '2012-04-23 14:15:09.561428-04:30', NULL);
INSERT INTO si_cliente (id, id_org, id_sap, ced_rif, ref, nombre, telefono, fax, email_org, edo_civil, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) VALUES (3, 1, NULL, 'V17247200', NULL, 'JOSE PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 6, 56, NULL, true, '2012-04-23 14:18:33.708177-04:30', NULL);


--
-- TOC entry 2474 (class 0 OID 33714)
-- Dependencies: 170
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (1, 2, 1, 'INVIERNO 2012', 220000, NULL, 45000, '2012-09-03', '2013-02-04', true, '2012-04-18 15:25:47.739787-04:30', NULL, '2012011');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 3, 3, 'COSECHA 1 SORGO', NULL, NULL, NULL, '2012-04-29', '2012-07-29', true, '2012-04-29 22:43:28.902-04:30', NULL, '2012031');


--
-- TOC entry 2475 (class 0 OID 33725)
-- Dependencies: 171
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor (id, id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (1, 1, 2, 2, 4, 6, '2012-04-29 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor (id, id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (2, 1, 2, 2, 5, 7, '2012-04-29 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor (id, id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (3, 1, 2, 2, 4, 8, NULL, NULL);
INSERT INTO si_cosecha_productor (id, id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado, modificado) VALUES (4, 1, 2, 3, 12, 11, NULL, NULL);


--
-- TOC entry 2476 (class 0 OID 33730)
-- Dependencies: 173
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2477 (class 0 OID 33735)
-- Dependencies: 175
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2478 (class 0 OID 33740)
-- Dependencies: 177
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2479 (class 0 OID 33748)
-- Dependencies: 180
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (10, 1, '10', 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (12, 1, '12', 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (13, 1, '13', 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (14, 1, '14', 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (16, 1, '16', 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (19, 1, '92', 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (20, 1, '93', 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (21, 1, '94', 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (2, 1, '02', 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (3, 1, '03', 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (4, 1, '04', 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (5, 1, '05', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (6, 1, '06', 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (7, 1, '07', 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (8, 1, '08', 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (9, 1, '09', 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (22, 1, '95', 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (23, 1, '96', 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (1, 1, '01', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (11, 1, '11', 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (15, 1, '15', 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (17, 1, '17', 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (24, 1, '97', 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (26, 1, '99', 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (25, 1, '98', 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (18, 1, '68', 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);


--
-- TOC entry 2480 (class 0 OID 33754)
-- Dependencies: 181
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
-- TOC entry 2481 (class 0 OID 33763)
-- Dependencies: 184
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2482 (class 0 OID 33767)
-- Dependencies: 185
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra) VALUES (1, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-18 14:56:38.350798-04:30', 1, '2012-04-23 14:51:08.588936-04:30', 7000, 10000, '2012-04-23 14:55:03.392292-04:30', 17000, 22000, 12.5, 3.5, 125, 765.625, NULL, '5', 2, NULL, 6, 5, '2012-04-18 14:56:38.350798-04:30', '2012-04-23 14:55:03.392292-04:30', 21109.375, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra) VALUES (3, 2, 1, 2, 2, 3, 7, 5, 1, 2, 2, '2012-04-23 14:20:55.493459-04:30', 2, '2012-04-23 14:52:02.630034-04:30', 12300, 14850, '2012-04-23 14:55:30.370692-04:30', 18570, 25610, 17.5, 4.5, 1064.375, 718.45299999999997, NULL, '5', 2, NULL, 5, 5, '2012-04-23 14:20:55.493459-04:30', '2012-04-23 14:55:30.370692-04:30', 15247.172, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra) VALUES (4, 2, 2, 4, 3, 4, 8, 5, 1, 3, 2, '2012-04-23 14:22:02.577104-04:30', 3, '2012-04-23 14:52:16.524929-04:30', 16550, 12340, '2012-04-23 14:55:42.103705-04:30', 20000, 30000, 17, 9.5, 422.19999999999999, 1161.05, NULL, '5', 2, NULL, 5, 5, '2012-04-23 14:22:02.577104-04:30', '2012-04-23 14:55:42.103705-04:30', 19526.75, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra) VALUES (2, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-23 14:19:42.192099-04:30', 1, '2012-04-23 14:51:53.059302-04:30', 20000, 0, '2012-04-23 14:55:14.106328-04:30', 35000, NULL, 12, NULL, NULL, NULL, NULL, '5', 1, NULL, 5, 6, '2012-04-23 14:19:42.192099-04:30', '2012-04-23 14:55:14.106328-04:30', 15000, NULL, NULL);
INSERT INTO si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_cliente, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, fecha_v, peso_01v, peso_02v, fecha_pel, peso_01l, peso_02l, humedad, impureza, humedad_des, impureza_des, kac_des, estatus, cant_muestras, carril, romana_ent, romana_sal, creado, modificado, peso_acon, peso_acon_liq, muestra) VALUES (5, 2, 1, 1, 1, 1, 1, 4, 1, 1, 2, '2012-04-25 08:41:22.287997-04:30', 1, '2012-04-27 07:58:49.121647-04:30', 18550, NULL, '2012-04-27 07:59:40.632098-04:30', 32618, NULL, 15, 3, 479.59100000000001, 407.65199999999999, NULL, '5', 1, NULL, 5, 5, '2012-04-25 08:41:22.287997-04:30', '2012-04-27 07:59:40.632098-04:30', 13180.757, NULL, NULL);


--
-- TOC entry 2483 (class 0 OID 33775)
-- Dependencies: 188
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2484 (class 0 OID 33782)
-- Dependencies: 190
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
-- TOC entry 2485 (class 0 OID 33786)
-- Dependencies: 191
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2486 (class 0 OID 33795)
-- Dependencies: 193
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (16, 1, 1, 7, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 0, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (19, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I07', 0, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (20, 1, 1, 7, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H07', 0, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (4, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 0, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (5, 1, 1, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 0, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (22, 1, 1, 8, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 0, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (23, 1, 1, 8, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 0, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (25, 1, 1, 8, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 0, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (26, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I08', 0, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (47, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 0, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (1, 1, 1, NULL, '(PL1+PL2)', 'PL12', 0, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (27, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I08', 0, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (28, 1, 1, 8, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H08', 0, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (34, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I06', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (13, 1, 1, 7, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 0, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (14, 1, 1, 7, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 0, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (40, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I017', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (7, 1, 1, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 0, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (8, 1, 1, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 0, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (9, 1, 1, 2, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H02', 0, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (10, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I02', 0, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (11, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I02', 0, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (32, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I05', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (46, 1, 2, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (17, 1, 1, 7, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 0, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (18, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I07', 0, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (15, 1, 1, 7, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 0, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (36, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (42, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I03', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (44, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I04', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (38, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I015', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (21, 1, 1, 8, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 0, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (24, 1, 1, 8, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 0, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (30, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I01', 0, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (3, 1, 1, NULL, '((PL1+PL2)-(PV1+PV2))', 'PN', 0, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (2, 1, 1, NULL, '(PV1+PV2)', 'PV12', 0, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (45, 1, 2, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (6, 1, 1, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 0, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (43, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (41, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (39, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (37, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (35, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (33, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (31, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (29, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 0, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (12, 1, 1, 12, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIR', 0, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);


--
-- TOC entry 2487 (class 0 OID 33803)
-- Dependencies: 195
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (2, NULL, NULL, 5, 178923612, 15000, NULL, NULL, '2012-04-29 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (3, NULL, NULL, 5, 234234123, 10000, NULL, NULL, '2012-04-28 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (4, NULL, NULL, 5, 92374392, 16000, NULL, NULL, '2012-04-03 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (5, NULL, NULL, 5, 12312312, 30000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, fecha_emision, estatus, cedula_asociado, contrato, creado, modificado) VALUES (6, NULL, NULL, 5, 238947289, 32000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL);


--
-- TOC entry 2488 (class 0 OID 33808)
-- Dependencies: 196
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (3, 3, '23124343234     ', '2012-04-12 00:00:00-04:30', '');


--
-- TOC entry 2489 (class 0 OID 33817)
-- Dependencies: 200
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2490 (class 0 OID 33823)
-- Dependencies: 202
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (2, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', 'qvptig4b5e9149l34b29p126m0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 00:22:20.134-04:30<br />conectado = 1<br />sesion = tjecp5dqp6ubqugdddrg3h3c64<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''qvptig4b5e9149l34b29p126m0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''qvptig4b5e9149l34b29p126m0'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (3, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 02:38:05.868-04:30<br />conectado = 1<br />sesion = qvptig4b5e9149l34b29p126m0<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (4, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_productor', 'No data', 'id_org = ''1''<br />ced_rif =  ''G0123456''<br />cod_ref =  null<br />nombre =  ''CONSEJO COMUNAL 4''<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  null<br />id_sap =  null<br />id_pais =  ''1''<br />coordenadas_utm =  null<br />estatus =  ''T''<br />contacto1_nombre =  null<br />contacto1_telefono =  null<br />contacto1_email =  null<br />contacto2_nombre =  null<br />contacto2_telefono =  null<br />contacto2_email =  null<br />contacto3_nombre =  null<br />contacto3_telefono =  null<br />contacto3_email =  null<br />id_estado =  ''12''<br />id_municipio =  ''134''<br />creado = now()<br />', 'INSERT INTO si_productor  (id_org, ced_rif, cod_ref, nombre, telefono, fax, email, direccion, id_sap, id_pais, coordenadas_utm, estatus, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_estado, id_municipio, creado) VALUES  (''1'', ''G0123456'', null, ''CONSEJO COMUNAL 4'', null, null, null, null, null, ''1'', null, ''T'', null, null, null, null, null, null, null, null, null, ''12'', ''134'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (5, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 08:26:39.882418-04:30<br />conectado = 1<br />sesion = 8m9o8od4vu96aie63lm66vo6s7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (6, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''12312312''<br />fecha_emision =  ''30-04-2012''<br />contrato =  null<br />kilogramos =  ''30000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''12312312'', ''30-04-2012'', null, ''30000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (7, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (8, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''DFG-DFG''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''DFG-DFG'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (9, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''1''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''6''<br />id_guia =  ''5''<br />id_vehiculo =  ''12''<br />id_chofer =  ''8''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''1'', ''1'', ''NOW()'', ''1'', ''2'', ''5'', ''1'', ''2'', ''6'', ''5'', ''12'', ''8'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (10, '2012-04-30', 202, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 8m9o8od4vu96aie63lm66vo6s7<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''8m9o8od4vu96aie63lm66vo6s7''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (11, '2012-04-30', 102, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''8m9o8od4vu96aie63lm66vo6s7'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (12, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 09:30:52.57448-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8m9o8od4vu96aie63lm66vo6s7'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (13, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''238947289''<br />fecha_emision =  ''30-04-2012''<br />contrato =  null<br />kilogramos =  ''32000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''238947289'', ''30-04-2012'', null, ''32000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (14, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (15, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''FGH-DFGH''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''FGH-DFGH'', null, null,now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (16, '2012-04-30', 201, 5, 'N/A', 'N/A', 'N/A', '8m9o8od4vu96aie63lm66vo6s7', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''1''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''6''<br />id_guia =  ''6''<br />id_vehiculo =  ''13''<br />id_chofer =  ''9''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''2'', ''1'', ''NOW()'', ''1'', ''1'', ''5'', ''1'', ''2'', ''6'', ''6'', ''13'', ''9'',now())', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (17, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', 'h64nreflr3telq2l34p4n5bah2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 10:24:02.735656-04:30<br />conectado = 1<br />sesion = 8m9o8od4vu96aie63lm66vo6s7<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''h64nreflr3telq2l34p4n5bah2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''h64nreflr3telq2l34p4n5bah2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (18, '2012-04-30', 202, 5, 'N/A', 'N/A', 'N/A', 'h64nreflr3telq2l34p4n5bah2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = h64nreflr3telq2l34p4n5bah2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''h64nreflr3telq2l34p4n5bah2''', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (19, '2012-04-30', 102, 5, 'N/A', 'N/A', 'N/A', 'h64nreflr3telq2l34p4n5bah2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''h64nreflr3telq2l34p4n5bah2'' ', '');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (20, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', 'h64nreflr3telq2l34p4n5bah2', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 11:30:51.207548-04:30<br />conectado = 0<br />sesion = <br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''h64nreflr3telq2l34p4n5bah2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''h64nreflr3telq2l34p4n5bah2'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (21, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', 'mkrdsft03786k8ifq41631mo53', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 13:08:00.486149-04:30<br />conectado = 1<br />sesion = h64nreflr3telq2l34p4n5bah2<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''mkrdsft03786k8ifq41631mo53''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''mkrdsft03786k8ifq41631mo53'' WHERE id=''5''', 'User Login');
INSERT INTO si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) VALUES (22, '2012-04-30', 101, 5, 'N/A', 'N/A', 'N/A', 'mkrdsft03786k8ifq41631mo53', '::1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 11.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 11.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />ultimo_acceso = 2012-04-30 14:34:35.008436-04:30<br />conectado = 1<br />sesion = mkrdsft03786k8ifq41631mo53<br />', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''mkrdsft03786k8ifq41631mo53''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''mkrdsft03786k8ifq41631mo53'' WHERE id=''5''', 'User Login');


--
-- TOC entry 2491 (class 0 OID 33832)
-- Dependencies: 204
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
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (22, 'M_Configuracion', 4, NULL, true, 4, NULL, NULL);
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
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (33, 'M_Asociacion', 1, 'admin/asociacion.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (29, 'M_Chofer', 1, 'admin/chofer_listado.php', true, 10, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (32, 'M_Ordenes', 1, 'admin/ordenes_listado.php', true, 11, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (26, 'M_MenuUsuario', 4, 'admin/menu_usuario_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (17, 'M_Recepciones', 3, 'reportes/reporte_recepcion.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (5, 'M_Cuenta', 0, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (1, 'M_Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (6, 'M_CentrosA', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (34, 'M_CosechaProductor', 4, 'admin/cosecha_productor.php', true, 6, NULL, NULL);


--
-- TOC entry 2492 (class 0 OID 33837)
-- Dependencies: 205
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (1, 1, 477, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (6, 1, 479, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (25, 1, 480, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (9, 1, 481, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (8, 1, 482, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (7, 1, 483, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (10, 1, 484, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (29, 1, 485, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (32, 1, 486, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (2, 1, 487, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (11, 1, 488, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (12, 1, 489, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (27, 1, 490, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (31, 1, 491, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (28, 1, 492, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (2, 3, 29, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (27, 3, 30, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (31, 3, 39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (2, 4, 31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (11, 4, 32, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (12, 4, 40, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (28, 4, 35, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (3, 1, 493, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (13, 1, 494, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (14, 1, 495, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (15, 1, 496, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (16, 1, 497, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (17, 1, 498, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (18, 1, 499, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (4, 1, 500, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (19, 1, 501, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (20, 1, 502, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (21, 1, 503, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (22, 1, 504, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (26, 1, 505, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (5, 1, 506, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (23, 1, 507, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (2, 7, 519, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (11, 7, 520, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (12, 7, 521, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (27, 7, 522, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (31, 7, 523, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (28, 7, 524, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (24, 1, 478, 1, 0, 1, 1, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (1, 2, 525, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (25, 2, 526, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (9, 2, 527, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (8, 2, 528, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (7, 2, 529, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (10, 2, 530, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (29, 2, 531, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (4, 2, 532, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (20, 2, 533, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (21, 2, 534, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (5, 2, 535, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (23, 2, 536, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (1, 5, 537, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (24, 5, 538, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (6, 5, 539, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (25, 5, 540, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (9, 5, 541, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (8, 5, 542, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (7, 5, 543, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (10, 5, 544, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (29, 5, 545, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (32, 5, 546, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (2, 5, 547, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (11, 5, 548, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (12, 5, 549, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (27, 5, 550, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (31, 5, 551, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (28, 5, 552, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (3, 5, 553, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (13, 5, 554, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (14, 5, 555, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (15, 5, 556, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (16, 5, 557, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (17, 5, 558, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (18, 5, 559, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (4, 5, 560, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (19, 5, 561, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (20, 5, 562, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (21, 5, 563, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (22, 5, 564, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (26, 5, 565, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (34, 5, 566, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (5, 5, 567, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id, id_perfil, nuevo, modificar, eliminar, imprimir) VALUES (23, 5, 568, 1, 0, 0, 0, 0);


--
-- TOC entry 2493 (class 0 OID 33848)
-- Dependencies: 208
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
-- TOC entry 2494 (class 0 OID 33854)
-- Dependencies: 210
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (1, 2, 1, 1, 56011201, '2012-04-18 00:00:00-04:30', NULL, 700, false, 'N', NULL, '2012-04-18 14:51:00.510284-04:30', NULL, '56012392');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (2, 2, 2, 1, 56011212, '2012-04-13 00:00:00-04:30', NULL, 650, false, 'N', NULL, '2012-04-23 14:15:36.726353-04:30', NULL, '56012348');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (3, 2, 1, 2, 56021211, '2012-04-03 00:00:00-04:30', NULL, 765, true, 'N', NULL, '2012-04-23 14:16:02.53446-04:30', NULL, '56022453');
INSERT INTO si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, fecha_emision, numero_contrato, toneladas, descuento, estatus, id_punto_entrega, creado, modificado, cod_verificacion) VALUES (4, 2, 3, 2, 56021210, '2012-04-02 00:00:00-04:30', NULL, 196, false, 'N', NULL, '2012-04-23 14:18:36.656458-04:30', NULL, '56021882');


--
-- TOC entry 2495 (class 0 OID 33862)
-- Dependencies: 211
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes_det (id, id_orden, numero_orden, fecha, descripcion, kilogramos) VALUES (1, 1, '11232123', NULL, '', 12000);


--
-- TOC entry 2496 (class 0 OID 33869)
-- Dependencies: 214
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2497 (class 0 OID 33878)
-- Dependencies: 216
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'VENEZUELA');


--
-- TOC entry 2498 (class 0 OID 33884)
-- Dependencies: 218
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (6, 'PL1', 'Peso Lleno 1', 'Peso de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (7, 'PL2', 'Peso Lleno 2', 'Peso de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (8, 'PV1', 'Peso Vacio 1', 'Peso Vac&iacute;o de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (9, 'PV2', 'Peso Vacio 2', 'Peso Vac&iacute;o de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (10, 'IMPL', 'Impurezas de Laboratorio', 'Impurezas de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado, fecha_inicio, fecha_fin) VALUES (11, 'HUML', 'Humedad de Laboratorio', 'Humedad de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);


--
-- TOC entry 2499 (class 0 OID 33893)
-- Dependencies: 220
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
-- TOC entry 2500 (class 0 OID 33897)
-- Dependencies: 221
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
-- TOC entry 2501 (class 0 OID 33902)
-- Dependencies: 223
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2502 (class 0 OID 33909)
-- Dependencies: 226
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
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (13, 1, NULL, 'G0123456', NULL, 'CONSEJO COMUNAL 4', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 08:34:16.836892-04:30', NULL);


--
-- TOC entry 2503 (class 0 OID 33918)
-- Dependencies: 228
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (2, 2, 'INVIERNO 2012', 'INVIERNO 2012', '2012-04-18 15:25:47.739787-04:30', NULL, true, '201201', '2012-09-03', '2013-09-03', 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (3, 2, 'PROGRAMA SORGO', NULL, '2012-04-29 22:43:28.902-04:30', NULL, true, '201203', '2012-04-29', '2013-04-29', 3);


--
-- TOC entry 2504 (class 0 OID 33925)
-- Dependencies: 229
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2505 (class 0 OID 33933)
-- Dependencies: 231
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (1, 1, NULL, NULL, NULL, NULL, 'PTO LA CRUZ', NULL, NULL, NULL, '2012-04-18 14:56:38.350798', NULL, NULL);
INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (2, 2, NULL, NULL, NULL, NULL, 'ASOCOPRONA', NULL, NULL, NULL, '2012-04-23 14:20:55.493459', NULL, NULL);
INSERT INTO si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado, id_centro_acopio) VALUES (3, 3, NULL, NULL, NULL, NULL, 'PRIMER PUNTO', NULL, NULL, NULL, '2012-04-23 14:22:02.577104', NULL, NULL);


--
-- TOC entry 2506 (class 0 OID 33941)
-- Dependencies: 233
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra) VALUES (2, 2, 1, NULL, 6, 2, 5, 1, '2012-04-29 19:20:15.965-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 19:20:15.965-04:30', NULL, 2, 9, 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra) VALUES (3, 2, 1, NULL, 11, 3, 5, 2, '2012-04-29 20:25:21.751-04:30', 2, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL, 1, 10, 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra) VALUES (4, 2, 1, NULL, 11, 4, 5, 3, '2012-04-29 20:32:39.489-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL, 1, 11, 7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra) VALUES (5, 2, 1, NULL, 6, 5, 5, 1, '2012-04-30 10:14:22.310566-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL, 2, 12, 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo, id_chofer, romana_ent, romana_sal, peso_acon, peso_acon_liq, muestra) VALUES (6, 2, 1, NULL, 6, 6, 5, 2, '2012-04-30 10:34:12.974384-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL, 1, 13, 9, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2507 (class 0 OID 33945)
-- Dependencies: 234
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2508 (class 0 OID 33952)
-- Dependencies: 237
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


--
-- TOC entry 2509 (class 0 OID 33959)
-- Dependencies: 238
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
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (44, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-20 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (45, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-21 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (46, 1, 'M_Ordenes', 'Ordenes', 1, '2012-04-09 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (41, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (42, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (37, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (47, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-04-09 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (48, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-04-09 00:00:00-04:30', NULL);


--
-- TOC entry 2510 (class 0 OID 33972)
-- Dependencies: 242
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
-- TOC entry 2511 (class 0 OID 33983)
-- Dependencies: 244
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (1, 2, 'Tolva 1', 1, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (2, 2, 'Tolva 2', 2, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (3, 2, 'Carril 1', 1, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (4, 2, 'Carril 2', 2, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (5, 2, 'Romana 1', 1, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (6, 2, 'Romana 2', 2, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (7, 3, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (8, 3, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (9, 3, 'Carril 1', 1, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (10, 3, 'Carril 2', 2, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (11, 3, 'Romana 1', 1, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (12, 3, 'Romana 2', 2, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (13, 4, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (14, 4, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (15, 4, 'Carril 1', 1, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (16, 4, 'Carril 2', 2, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (19, 5, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (20, 5, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (21, 5, 'Carril 1', 1, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (22, 5, 'Carril 2', 2, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (23, 5, 'Romana 1', 1, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (24, 5, 'Romana 2', 2, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (25, 6, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (26, 6, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (27, 6, 'Carril 1', 1, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (28, 6, 'Carril 2', 2, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (29, 6, 'Romana 1', 1, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (30, 6, 'Romana 2', 2, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (31, 7, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (32, 7, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (33, 7, 'Carril 1', 1, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (34, 7, 'Carril 2', 2, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (35, 7, 'Romana 1', 1, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (36, 7, 'Romana 2', 2, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (37, 8, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (38, 8, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (39, 8, 'Carril 1', 1, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (40, 8, 'Carril 2', 2, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (41, 8, 'Romana 1', 1, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (42, 8, 'Romana 2', 2, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (43, 9, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (44, 9, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (45, 9, 'Carril 1', 1, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (46, 9, 'Carril 2', 2, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (47, 9, 'Romana 1', 1, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL);
INSERT INTO si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) VALUES (48, 9, 'Romana 2', 2, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL);


--
-- TOC entry 2512 (class 0 OID 33989)
-- Dependencies: 245
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_transporte (id, id_centro_acopio, rif, nombre, contacto, direccion, telefono1, telefono2, fax, email, id_pais, id_estado, id_municipio, creado, modificado) VALUES (1, 2, NULL, 'ASOTRAMACHAQ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:56:38.350798-04:30', NULL);


--
-- TOC entry 2513 (class 0 OID 33999)
-- Dependencies: 248
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, '2012-04-26 16:36:11.025588-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-04-27 10:37:28.060455-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'juantaborda@agropatria.co.ve', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 0, NULL, '2012-04-18 15:58:22.135194-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, NULL, '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-04-29 10:12:09.635-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (5, 'MARIELY', 'CORONADO', '16000000', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 1, 'mkrdsft03786k8ifq41631mo53', '2012-04-30 16:19:57.47329-04:30');


--
-- TOC entry 2514 (class 0 OID 34010)
-- Dependencies: 250
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (6, 6, 2, 8, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (5, 5, 2, 1, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);


--
-- TOC entry 2515 (class 0 OID 34014)
-- Dependencies: 251
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


--
-- TOC entry 2244 (class 2606 OID 34049)
-- Dependencies: 154 154
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2292 (class 2606 OID 34051)
-- Dependencies: 200 200
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2232 (class 2606 OID 34053)
-- Dependencies: 143 143
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 34055)
-- Dependencies: 146 146
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 34057)
-- Dependencies: 148 148
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 34059)
-- Dependencies: 145 145 145
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2236 (class 2606 OID 34061)
-- Dependencies: 145 145
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 34063)
-- Dependencies: 152 152
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 34065)
-- Dependencies: 155 155
-- Name: si_asociacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociacion
    ADD CONSTRAINT si_asociacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 34067)
-- Dependencies: 158 158
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 34069)
-- Dependencies: 160 160
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 34071)
-- Dependencies: 162 162
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 34073)
-- Dependencies: 164 164
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 34075)
-- Dependencies: 165 165
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 34077)
-- Dependencies: 168 168
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 34079)
-- Dependencies: 170 170
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 34081)
-- Dependencies: 171 171
-- Name: si_cosecha_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2264 (class 2606 OID 34083)
-- Dependencies: 173 173 173 173
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2266 (class 2606 OID 34085)
-- Dependencies: 173 173
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2268 (class 2606 OID 34087)
-- Dependencies: 175 175
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 34089)
-- Dependencies: 177 177
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2272 (class 2606 OID 34091)
-- Dependencies: 180 180
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 34093)
-- Dependencies: 181 181
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2276 (class 2606 OID 34095)
-- Dependencies: 184 184
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2278 (class 2606 OID 34097)
-- Dependencies: 185 185
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 34099)
-- Dependencies: 188 188
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2282 (class 2606 OID 34101)
-- Dependencies: 190 190
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2284 (class 2606 OID 34103)
-- Dependencies: 191 191
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2286 (class 2606 OID 34105)
-- Dependencies: 193 193
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 34107)
-- Dependencies: 195 195
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 34109)
-- Dependencies: 196 196
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 34111)
-- Dependencies: 202 202
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2296 (class 2606 OID 34113)
-- Dependencies: 204 204
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 34115)
-- Dependencies: 205 205 205
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2300 (class 2606 OID 34117)
-- Dependencies: 208 208
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2304 (class 2606 OID 34119)
-- Dependencies: 211 211
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 34121)
-- Dependencies: 210 210
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2306 (class 2606 OID 34123)
-- Dependencies: 214 214
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2308 (class 2606 OID 34125)
-- Dependencies: 216 216
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 34127)
-- Dependencies: 218 218
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2312 (class 2606 OID 34129)
-- Dependencies: 220 220
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2314 (class 2606 OID 34131)
-- Dependencies: 221 221
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 34133)
-- Dependencies: 223 223
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2318 (class 2606 OID 34135)
-- Dependencies: 226 226
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2320 (class 2606 OID 34137)
-- Dependencies: 228 228
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2322 (class 2606 OID 34139)
-- Dependencies: 229 229
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2324 (class 2606 OID 34141)
-- Dependencies: 231 231
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2328 (class 2606 OID 34143)
-- Dependencies: 234 234
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2326 (class 2606 OID 34145)
-- Dependencies: 233 233
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2332 (class 2606 OID 34147)
-- Dependencies: 238 238
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2330 (class 2606 OID 34149)
-- Dependencies: 237 237
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2334 (class 2606 OID 34151)
-- Dependencies: 242 242
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2336 (class 2606 OID 34153)
-- Dependencies: 244 244
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2338 (class 2606 OID 34155)
-- Dependencies: 245 245
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2344 (class 2606 OID 34157)
-- Dependencies: 250 250
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2340 (class 2606 OID 34159)
-- Dependencies: 248 248
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2342 (class 2606 OID 34161)
-- Dependencies: 248 248
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2346 (class 2606 OID 34163)
-- Dependencies: 251 251
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2347 (class 2606 OID 34164)
-- Dependencies: 164 143 2253
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2348 (class 2606 OID 34169)
-- Dependencies: 190 2281 143
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2349 (class 2606 OID 34174)
-- Dependencies: 2299 143 208
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2350 (class 2606 OID 34179)
-- Dependencies: 216 143 2307
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2352 (class 2606 OID 34184)
-- Dependencies: 2235 145 146
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2353 (class 2606 OID 34189)
-- Dependencies: 164 146 2253
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2354 (class 2606 OID 34194)
-- Dependencies: 2235 148 145
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2355 (class 2606 OID 34199)
-- Dependencies: 214 2305 148
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2356 (class 2606 OID 34204)
-- Dependencies: 150 145 2235
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2357 (class 2606 OID 34209)
-- Dependencies: 2305 214 150
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2351 (class 2606 OID 34214)
-- Dependencies: 2305 214 145
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2358 (class 2606 OID 34219)
-- Dependencies: 145 152 2235
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2359 (class 2606 OID 34224)
-- Dependencies: 2277 185 152
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2360 (class 2606 OID 34229)
-- Dependencies: 2325 152 233
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2361 (class 2606 OID 34234)
-- Dependencies: 248 152 2339
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2362 (class 2606 OID 34239)
-- Dependencies: 2231 160 143
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2363 (class 2606 OID 34244)
-- Dependencies: 2251 162 160
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2364 (class 2606 OID 34249)
-- Dependencies: 2339 248 160
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2365 (class 2606 OID 34254)
-- Dependencies: 2281 164 190
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2366 (class 2606 OID 34259)
-- Dependencies: 2299 164 208
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2367 (class 2606 OID 34264)
-- Dependencies: 164 2305 214
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2368 (class 2606 OID 34269)
-- Dependencies: 164 216 2307
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2369 (class 2606 OID 34274)
-- Dependencies: 165 2305 214
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2370 (class 2606 OID 34279)
-- Dependencies: 214 2305 168
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2371 (class 2606 OID 34284)
-- Dependencies: 170 2271 180
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2372 (class 2606 OID 34289)
-- Dependencies: 170 2319 228
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2373 (class 2606 OID 34294)
-- Dependencies: 2253 164 171
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2374 (class 2606 OID 34299)
-- Dependencies: 170 2259 171
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2375 (class 2606 OID 34304)
-- Dependencies: 171 2317 226
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2376 (class 2606 OID 34309)
-- Dependencies: 173 2259 170
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2377 (class 2606 OID 34314)
-- Dependencies: 2271 180 173
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2378 (class 2606 OID 34319)
-- Dependencies: 2333 242 173
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2379 (class 2606 OID 34324)
-- Dependencies: 175 2235 145
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2380 (class 2606 OID 34329)
-- Dependencies: 175 2253 164
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2381 (class 2606 OID 34334)
-- Dependencies: 175 180 2271
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2382 (class 2606 OID 34339)
-- Dependencies: 233 2325 175
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2383 (class 2606 OID 34344)
-- Dependencies: 248 175 2339
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2384 (class 2606 OID 34349)
-- Dependencies: 177 175 2267
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2385 (class 2606 OID 34354)
-- Dependencies: 180 214 2305
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2386 (class 2606 OID 34359)
-- Dependencies: 181 145 2235
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2387 (class 2606 OID 34364)
-- Dependencies: 181 164 2253
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2388 (class 2606 OID 34369)
-- Dependencies: 181 180 2271
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2389 (class 2606 OID 34374)
-- Dependencies: 184 180 2271
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2390 (class 2606 OID 34379)
-- Dependencies: 184 214 2305
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2391 (class 2606 OID 34384)
-- Dependencies: 185 164 2253
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2392 (class 2606 OID 34389)
-- Dependencies: 185 168 2257
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2393 (class 2606 OID 34394)
-- Dependencies: 185 180 2271
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2394 (class 2606 OID 34399)
-- Dependencies: 185 210 2301
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2395 (class 2606 OID 34404)
-- Dependencies: 185 231 2323
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2396 (class 2606 OID 34409)
-- Dependencies: 185 242 2333
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2397 (class 2606 OID 34414)
-- Dependencies: 185 245 2337
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2398 (class 2606 OID 34419)
-- Dependencies: 185 248 2339
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2399 (class 2606 OID 34424)
-- Dependencies: 185 251 2345
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2400 (class 2606 OID 34429)
-- Dependencies: 188 214 2305
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2401 (class 2606 OID 34434)
-- Dependencies: 190 216 2307
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2402 (class 2606 OID 34439)
-- Dependencies: 191 190 2281
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2403 (class 2606 OID 34444)
-- Dependencies: 191 208 2299
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2404 (class 2606 OID 34449)
-- Dependencies: 191 214 2305
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2405 (class 2606 OID 34454)
-- Dependencies: 191 216 2307
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2406 (class 2606 OID 34459)
-- Dependencies: 191 226 2317
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2407 (class 2606 OID 34464)
-- Dependencies: 193 164 2253
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2408 (class 2606 OID 34469)
-- Dependencies: 193 180 2271
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2409 (class 2606 OID 34474)
-- Dependencies: 193 214 2305
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2410 (class 2606 OID 34479)
-- Dependencies: 195 248 2339
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2411 (class 2606 OID 34484)
-- Dependencies: 196 195 2287
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2412 (class 2606 OID 34489)
-- Dependencies: 202 200 2291
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2413 (class 2606 OID 34494)
-- Dependencies: 205 204 2295
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2414 (class 2606 OID 34499)
-- Dependencies: 205 220 2311
-- Name: si_menu_usuario_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2415 (class 2606 OID 34504)
-- Dependencies: 205 248 2339
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2416 (class 2606 OID 34509)
-- Dependencies: 208 190 2281
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2421 (class 2606 OID 34514)
-- Dependencies: 211 210 2301
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2417 (class 2606 OID 34519)
-- Dependencies: 210 164 2253
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2418 (class 2606 OID 34524)
-- Dependencies: 210 168 2257
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2419 (class 2606 OID 34529)
-- Dependencies: 210 180 2271
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2420 (class 2606 OID 34534)
-- Dependencies: 210 231 2323
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2422 (class 2606 OID 34539)
-- Dependencies: 214 190 2281
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2423 (class 2606 OID 34544)
-- Dependencies: 214 208 2299
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2424 (class 2606 OID 34549)
-- Dependencies: 214 216 2307
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2425 (class 2606 OID 34554)
-- Dependencies: 221 214 2305
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2426 (class 2606 OID 34559)
-- Dependencies: 223 214 2305
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2427 (class 2606 OID 34564)
-- Dependencies: 226 190 2281
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2428 (class 2606 OID 34569)
-- Dependencies: 226 208 2299
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2429 (class 2606 OID 34574)
-- Dependencies: 226 214 2305
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2430 (class 2606 OID 34579)
-- Dependencies: 226 2307 216
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2431 (class 2606 OID 34584)
-- Dependencies: 228 2253 164
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2432 (class 2606 OID 34589)
-- Dependencies: 190 229 2281
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2433 (class 2606 OID 34594)
-- Dependencies: 229 2299 208
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2434 (class 2606 OID 34599)
-- Dependencies: 229 2305 214
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2435 (class 2606 OID 34604)
-- Dependencies: 216 2307 229
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2436 (class 2606 OID 34609)
-- Dependencies: 164 231 2253
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2437 (class 2606 OID 34614)
-- Dependencies: 2257 231 168
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2438 (class 2606 OID 34619)
-- Dependencies: 231 2281 190
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2439 (class 2606 OID 34624)
-- Dependencies: 2299 208 231
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2440 (class 2606 OID 34629)
-- Dependencies: 216 2307 231
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2448 (class 2606 OID 34634)
-- Dependencies: 234 164 2253
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2449 (class 2606 OID 34639)
-- Dependencies: 234 180 2271
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2450 (class 2606 OID 34644)
-- Dependencies: 2325 234 233
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2441 (class 2606 OID 34649)
-- Dependencies: 233 2253 164
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2442 (class 2606 OID 34654)
-- Dependencies: 2255 233 165
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2443 (class 2606 OID 34659)
-- Dependencies: 170 233 2259
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2444 (class 2606 OID 34664)
-- Dependencies: 2287 195 233
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2445 (class 2606 OID 34669)
-- Dependencies: 2317 233 226
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2446 (class 2606 OID 34674)
-- Dependencies: 233 242 2333
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2447 (class 2606 OID 34679)
-- Dependencies: 233 2339 248
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2451 (class 2606 OID 34684)
-- Dependencies: 238 2329 237
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2452 (class 2606 OID 34689)
-- Dependencies: 242 143 2231
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2453 (class 2606 OID 34694)
-- Dependencies: 242 2253 164
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2454 (class 2606 OID 34699)
-- Dependencies: 164 244 2253
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2455 (class 2606 OID 34704)
-- Dependencies: 2253 245 164
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2456 (class 2606 OID 34709)
-- Dependencies: 250 2231 143
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2457 (class 2606 OID 34714)
-- Dependencies: 250 2311 220
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2458 (class 2606 OID 34719)
-- Dependencies: 248 250 2339
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-04-30 16:29:30 VET

--
-- PostgreSQL database dump complete
--

