--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-05-07 01:16:14

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 272 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 272
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 284 (class 1255 OID 39200)
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
-- TOC entry 161 (class 1259 OID 39201)
-- Dependencies: 2202 6
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
-- TOC entry 162 (class 1259 OID 39208)
-- Dependencies: 6 161
-- Name: romana_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE romana_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.romana_id_seq OWNER TO admin;

--
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 162
-- Name: romana_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE romana_id_seq OWNED BY romana.id;


--
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 162
-- Name: romana_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('romana_id_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 39210)
-- Dependencies: 6
-- Name: si_almacenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_almacenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_almacenes_id_seq OWNER TO admin;

--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


--
-- TOC entry 164 (class 1259 OID 39212)
-- Dependencies: 2204 6
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
-- TOC entry 165 (class 1259 OID 39219)
-- Dependencies: 6
-- Name: si_analisis_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_id_seq OWNER TO admin;

--
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 165
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 166 (class 1259 OID 39221)
-- Dependencies: 2205 2206 2207 6
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
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 166
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 167 (class 1259 OID 39227)
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
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 168 (class 1259 OID 39230)
-- Dependencies: 167 6
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_centro_acopio_id_seq OWNER TO admin;

--
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 39232)
-- Dependencies: 2209 2210 2211 2212 2213 2214 6
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
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 170 (class 1259 OID 39241)
-- Dependencies: 6 169
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_cultivo_id_seq OWNER TO admin;

--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 230, true);


--
-- TOC entry 171 (class 1259 OID 39243)
-- Dependencies: 2216 6
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
-- TOC entry 172 (class 1259 OID 39247)
-- Dependencies: 171 6
-- Name: si_analisis_des_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_des_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_des_id_seq OWNER TO admin;

--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 39249)
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
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 174 (class 1259 OID 39252)
-- Dependencies: 173 6
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_resultado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_resultado_id_seq OWNER TO admin;

--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 293, true);


--
-- TOC entry 175 (class 1259 OID 39254)
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
-- TOC entry 176 (class 1259 OID 39260)
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
-- TOC entry 177 (class 1259 OID 39266)
-- Dependencies: 6 176
-- Name: si_asociacion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_asociacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_asociacion_id_seq OWNER TO admin;

--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 177
-- Name: si_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_asociacion_id_seq OWNED BY si_asociacion.id;


--
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 177
-- Name: si_asociacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociacion_id_seq', 1, false);


--
-- TOC entry 178 (class 1259 OID 39268)
-- Dependencies: 6
-- Name: si_asociado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_asociado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_asociado_id_seq OWNER TO admin;

--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 39270)
-- Dependencies: 2220 6
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
-- TOC entry 180 (class 1259 OID 39277)
-- Dependencies: 6
-- Name: si_cargo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_id_seq OWNER TO admin;

--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 39279)
-- Dependencies: 2221 6
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
-- TOC entry 182 (class 1259 OID 39283)
-- Dependencies: 6
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 39285)
-- Dependencies: 2222 2223 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 184 (class 1259 OID 39290)
-- Dependencies: 6
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_centro_acopio_id_seq OWNER TO admin;

--
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 185 (class 1259 OID 39292)
-- Dependencies: 2224 2225 2226 2227 2228 2229 2230 6
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
-- TOC entry 186 (class 1259 OID 39305)
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
-- TOC entry 187 (class 1259 OID 39308)
-- Dependencies: 186 6
-- Name: si_choferes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_choferes_id_seq OWNER TO admin;

--
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 12, true);


--
-- TOC entry 188 (class 1259 OID 39310)
-- Dependencies: 6
-- Name: si_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cliente_id_seq OWNER TO admin;

--
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 188
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 3, true);


--
-- TOC entry 189 (class 1259 OID 39312)
-- Dependencies: 2232 6
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
-- TOC entry 190 (class 1259 OID 39319)
-- Dependencies: 6
-- Name: si_cosecha_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_id_seq OWNER TO admin;

--
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 3, true);


--
-- TOC entry 191 (class 1259 OID 39321)
-- Dependencies: 2233 2234 2235 2236 2237 6
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
-- TOC entry 192 (class 1259 OID 39332)
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
-- TOC entry 193 (class 1259 OID 39337)
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
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 194 (class 1259 OID 39340)
-- Dependencies: 193 6
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_silo_id_seq OWNER TO admin;

--
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 195 (class 1259 OID 39342)
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
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 195
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
-- TOC entry 196 (class 1259 OID 39345)
-- Dependencies: 195 6
-- Name: si_cuarentena_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_id_seq OWNER TO admin;

--
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 197 (class 1259 OID 39347)
-- Dependencies: 2240 6
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
-- TOC entry 198 (class 1259 OID 39351)
-- Dependencies: 197 6
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_plaga_id_seq OWNER TO admin;

--
-- TOC entry 2623 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2624 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 1, false);


--
-- TOC entry 199 (class 1259 OID 39353)
-- Dependencies: 6
-- Name: si_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cultivo_id_seq OWNER TO admin;

--
-- TOC entry 2625 (class 0 OID 0)
-- Dependencies: 199
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 200 (class 1259 OID 39355)
-- Dependencies: 2242 2243 2244 6
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
-- TOC entry 201 (class 1259 OID 39361)
-- Dependencies: 2245 2246 6
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
-- TOC entry 202 (class 1259 OID 39366)
-- Dependencies: 6 201
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 10, true);


--
-- TOC entry 203 (class 1259 OID 39368)
-- Dependencies: 6
-- Name: si_denom_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_denom_tip_id_seq OWNER TO admin;

--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 204 (class 1259 OID 39370)
-- Dependencies: 2248 6
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
-- TOC entry 205 (class 1259 OID 39374)
-- Dependencies: 2249 6
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
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 205
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
-- TOC entry 206 (class 1259 OID 39378)
-- Dependencies: 6 205
-- Name: si_despacho_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_despacho_id_seq OWNER TO admin;

--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 5, true);


--
-- TOC entry 207 (class 1259 OID 39380)
-- Dependencies: 6
-- Name: si_ejes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ejes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_ejes_id_seq OWNER TO admin;

--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 208 (class 1259 OID 39382)
-- Dependencies: 2251 2252 6
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
-- TOC entry 209 (class 1259 OID 39387)
-- Dependencies: 6
-- Name: si_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_estado_id_seq OWNER TO admin;

--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 209
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 210 (class 1259 OID 39389)
-- Dependencies: 2253 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 211 (class 1259 OID 39393)
-- Dependencies: 2254 6
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
-- TOC entry 212 (class 1259 OID 39400)
-- Dependencies: 211 6
-- Name: si_finca_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_finca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_finca_id_seq OWNER TO admin;

--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 213 (class 1259 OID 39402)
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
-- TOC entry 214 (class 1259 OID 39408)
-- Dependencies: 6 213
-- Name: si_formulas_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_formulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_formulas_id_seq OWNER TO admin;

--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 47, true);


--
-- TOC entry 215 (class 1259 OID 39410)
-- Dependencies: 2257 2258 6
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
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 216 (class 1259 OID 39415)
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
-- TOC entry 217 (class 1259 OID 39418)
-- Dependencies: 216 6
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_det_id_seq OWNER TO admin;

--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 3, true);


--
-- TOC entry 218 (class 1259 OID 39420)
-- Dependencies: 6 215
-- Name: si_guiarec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_id_seq OWNER TO admin;

--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 9, true);


--
-- TOC entry 219 (class 1259 OID 39422)
-- Dependencies: 6
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_codigos_log_codigo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_log_codigos_log_codigo_id_seq OWNER TO admin;

--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 220 (class 1259 OID 39424)
-- Dependencies: 2261 6
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
-- TOC entry 221 (class 1259 OID 39428)
-- Dependencies: 6
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_consultas_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_log_consultas_log_id_seq OWNER TO admin;

--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 52, true);


--
-- TOC entry 222 (class 1259 OID 39430)
-- Dependencies: 2262 6
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
-- TOC entry 223 (class 1259 OID 39437)
-- Dependencies: 6
-- Name: si_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_menu_id_seq OWNER TO admin;

--
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 223
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 36, true);


--
-- TOC entry 224 (class 1259 OID 39439)
-- Dependencies: 2263 2264 6
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
-- TOC entry 225 (class 1259 OID 39444)
-- Dependencies: 2265 2266 2267 2268 6
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
-- TOC entry 226 (class 1259 OID 39453)
-- Dependencies: 6
-- Name: si_municipio_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_municipio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_municipio_id_seq OWNER TO admin;

--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 227 (class 1259 OID 39455)
-- Dependencies: 2269 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 228 (class 1259 OID 39459)
-- Dependencies: 6
-- Name: si_ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_id_seq OWNER TO admin;

--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 4, true);


--
-- TOC entry 229 (class 1259 OID 39461)
-- Dependencies: 2270 2271 6
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
-- TOC entry 230 (class 1259 OID 39469)
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
-- TOC entry 231 (class 1259 OID 39472)
-- Dependencies: 6 230
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_det_id_seq OWNER TO admin;

--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 1, true);


--
-- TOC entry 232 (class 1259 OID 39474)
-- Dependencies: 6
-- Name: si_organizacion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_organizacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_organizacion_id_seq OWNER TO admin;

--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 233 (class 1259 OID 39476)
-- Dependencies: 2273 6
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
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 234 (class 1259 OID 39483)
-- Dependencies: 6
-- Name: si_pais_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_pais_id_seq OWNER TO admin;

--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 235 (class 1259 OID 39485)
-- Dependencies: 2274 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 236 (class 1259 OID 39489)
-- Dependencies: 6
-- Name: si_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_parametros_id_seq OWNER TO admin;

--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 237 (class 1259 OID 39491)
-- Dependencies: 2275 6
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
-- TOC entry 238 (class 1259 OID 39498)
-- Dependencies: 6
-- Name: si_perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_perfiles_id_seq OWNER TO admin;

--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 9, true);


--
-- TOC entry 239 (class 1259 OID 39500)
-- Dependencies: 2276 6
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
-- TOC entry 240 (class 1259 OID 39504)
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
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 241 (class 1259 OID 39507)
-- Dependencies: 240 6
-- Name: si_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_plaga_id_seq OWNER TO admin;

--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 242 (class 1259 OID 39509)
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
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 243 (class 1259 OID 39512)
-- Dependencies: 242 6
-- Name: si_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_producto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_producto_id_seq OWNER TO admin;

--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 244 (class 1259 OID 39514)
-- Dependencies: 6
-- Name: si_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_productor_id_seq OWNER TO admin;

--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 244
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 13, true);


--
-- TOC entry 245 (class 1259 OID 39516)
-- Dependencies: 2279 6
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
-- TOC entry 246 (class 1259 OID 39523)
-- Dependencies: 6
-- Name: si_programa_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_programa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_programa_id_seq OWNER TO admin;

--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 4, true);


--
-- TOC entry 247 (class 1259 OID 39525)
-- Dependencies: 2280 6
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
-- TOC entry 248 (class 1259 OID 39532)
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
-- TOC entry 249 (class 1259 OID 39538)
-- Dependencies: 6 248
-- Name: si_proveedor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_proveedor_id_seq OWNER TO admin;

--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 249
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 249
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 250 (class 1259 OID 39540)
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
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 251 (class 1259 OID 39546)
-- Dependencies: 250 6
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_punto_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_punto_entrega_id_seq OWNER TO admin;

--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 3, true);


--
-- TOC entry 252 (class 1259 OID 39548)
-- Dependencies: 2283 2284 6
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
    muestra smallint DEFAULT 0
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 252
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
-- TOC entry 253 (class 1259 OID 39553)
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
-- TOC entry 254 (class 1259 OID 39556)
-- Dependencies: 6 253
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 254
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 254
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 255 (class 1259 OID 39558)
-- Dependencies: 6 252
-- Name: si_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_id_seq OWNER TO admin;

--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 255
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 255
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 9, true);


--
-- TOC entry 256 (class 1259 OID 39560)
-- Dependencies: 2287 6
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
-- TOC entry 257 (class 1259 OID 39567)
-- Dependencies: 2289 6
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
-- TOC entry 258 (class 1259 OID 39574)
-- Dependencies: 6 257
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recursos_etiquetas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recursos_etiquetas_id_seq OWNER TO admin;

--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 258
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 258
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 50, true);


--
-- TOC entry 259 (class 1259 OID 39576)
-- Dependencies: 6 256
-- Name: si_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recursos_id_seq OWNER TO admin;

--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 259
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 259
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 54, true);


--
-- TOC entry 260 (class 1259 OID 39578)
-- Dependencies: 6
-- Name: si_silos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_silos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_silos_id_seq OWNER TO admin;

--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 260
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 261 (class 1259 OID 39580)
-- Dependencies: 2291 2292 6
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
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 262 (class 1259 OID 39588)
-- Dependencies: 6
-- Name: si_tolcarom_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_tolcarom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_tolcarom_id_seq OWNER TO admin;

--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 262
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 263 (class 1259 OID 39590)
-- Dependencies: 2293 2294 2295 6
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
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 264 (class 1259 OID 39596)
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
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 265 (class 1259 OID 39602)
-- Dependencies: 6 264
-- Name: si_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_transporte_id_seq OWNER TO admin;

--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 265
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 265
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, true);


--
-- TOC entry 266 (class 1259 OID 39604)
-- Dependencies: 6
-- Name: si_usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_usuarios_id_seq OWNER TO admin;

--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 266
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 7, true);


--
-- TOC entry 267 (class 1259 OID 39606)
-- Dependencies: 2297 2298 2299 6
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
-- TOC entry 268 (class 1259 OID 39615)
-- Dependencies: 6
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_usuarios_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_usuarios_perfiles_id_seq OWNER TO admin;

--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 268
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 7, true);


--
-- TOC entry 269 (class 1259 OID 39617)
-- Dependencies: 2300 6
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
-- TOC entry 270 (class 1259 OID 39621)
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
-- TOC entry 271 (class 1259 OID 39624)
-- Dependencies: 6 270
-- Name: si_vehiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_vehiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_vehiculos_id_seq OWNER TO admin;

--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 271
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 271
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 16, true);


--
-- TOC entry 2203 (class 2604 OID 39626)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE romana ALTER COLUMN id SET DEFAULT nextval('romana_id_seq'::regclass);


--
-- TOC entry 2208 (class 2604 OID 39627)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2215 (class 2604 OID 39628)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2217 (class 2604 OID 39629)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 39630)
-- Dependencies: 174 173
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 39631)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_asociacion ALTER COLUMN id SET DEFAULT nextval('si_asociacion_id_seq'::regclass);


--
-- TOC entry 2231 (class 2604 OID 39632)
-- Dependencies: 187 186
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2238 (class 2604 OID 39634)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2239 (class 2604 OID 39635)
-- Dependencies: 196 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2241 (class 2604 OID 39636)
-- Dependencies: 198 197
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2247 (class 2604 OID 39637)
-- Dependencies: 202 201
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2250 (class 2604 OID 39638)
-- Dependencies: 206 205
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2255 (class 2604 OID 39639)
-- Dependencies: 212 211
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2256 (class 2604 OID 39640)
-- Dependencies: 214 213
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2259 (class 2604 OID 39641)
-- Dependencies: 218 215
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2260 (class 2604 OID 39642)
-- Dependencies: 217 216
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2272 (class 2604 OID 39644)
-- Dependencies: 231 230
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2277 (class 2604 OID 39645)
-- Dependencies: 241 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2278 (class 2604 OID 39646)
-- Dependencies: 243 242
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2281 (class 2604 OID 39647)
-- Dependencies: 249 248
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2282 (class 2604 OID 39648)
-- Dependencies: 251 250
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2285 (class 2604 OID 39649)
-- Dependencies: 255 252
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2286 (class 2604 OID 39650)
-- Dependencies: 254 253
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2288 (class 2604 OID 39651)
-- Dependencies: 259 256
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 39652)
-- Dependencies: 258 257
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2296 (class 2604 OID 39653)
-- Dependencies: 265 264
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2301 (class 2604 OID 39654)
-- Dependencies: 271 270
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2527 (class 0 OID 39201)
-- Dependencies: 161
-- Data for Name: romana; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2528 (class 0 OID 39212)
-- Dependencies: 164
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_almacenes VALUES (8, 8, 'ALMACEN - SILOS', NULL, 1, 12, 137, NULL, NULL, NULL, true, NULL, '2012-02-19 15:35:00.454', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (9, 9, 'ALMACEN - SILOS', NULL, 1, 18, 229, NULL, NULL, NULL, true, NULL, '2012-02-19 15:39:25.17', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (7, 7, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-19 15:26:29', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (6, 6, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:25:07.74788', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (5, 5, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:12:33.325252', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (4, 4, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:06:27.331621', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (3, 3, 'ALMACEN - SILOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, '2012-02-13 11:05:32.030751', NULL, 1, '1');
INSERT INTO si_almacenes VALUES (1, 1, 'TODOS', NULL, 1, 1, 1, NULL, NULL, NULL, true, NULL, NULL, NULL, 1, '1');
INSERT INTO si_almacenes VALUES (10, 2, 'HERRAMIENTAS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-19 20:29:24.769', NULL, 2, '2');
INSERT INTO si_almacenes VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '1');
INSERT INTO si_almacenes VALUES (11, 2, 'PRODUCTOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-20 11:06:41.92', '2012-05-03 14:34:27.011983', 2, '3');


--
-- TOC entry 2529 (class 0 OID 39221)
-- Dependencies: 166
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8', false);
INSERT INTO si_analisis VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9', false);
INSERT INTO si_analisis VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10', false);
INSERT INTO si_analisis VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11', false);
INSERT INTO si_analisis VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12', false);
INSERT INTO si_analisis VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13', false);
INSERT INTO si_analisis VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14', false);
INSERT INTO si_analisis VALUES (4, 1, 'GRANOS DAÑADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4', false);
INSERT INTO si_analisis VALUES (5, 1, 'GRANOS DAÑADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5', false);
INSERT INTO si_analisis VALUES (6, 1, 'GRANOS DAÑADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6', false);
INSERT INTO si_analisis VALUES (7, 1, 'GRANOS DAÑADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7', false);
INSERT INTO si_analisis VALUES (15, 1, 'GRANO PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15', false);
INSERT INTO si_analisis VALUES (3, 1, 'GRANOS CON GERMEN DAÑADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3', false);
INSERT INTO si_analisis VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2', true);
INSERT INTO si_analisis VALUES (23, 1, 'COLOR', 2, true, '2012-02-22 00:00:00-04:30', NULL, '22', false);
INSERT INTO si_analisis VALUES (16, 1, 'MAIZ ENTERO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '16', false);
INSERT INTO si_analisis VALUES (17, 1, 'MAIZ PARTIDO GRANDE', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '17', false);
INSERT INTO si_analisis VALUES (18, 1, 'MAIZ PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '18', false);
INSERT INTO si_analisis VALUES (24, 1, 'LIMPIEZA', 2, true, '2012-02-22 00:00:00-04:30', NULL, '23', false);
INSERT INTO si_analisis VALUES (27, 1, 'GRANOS PUNTA NEGRA', 2, true, '2012-02-22 00:00:00-04:30', NULL, '27', false);
INSERT INTO si_analisis VALUES (25, 1, 'GRANOS MANCHADOS', 2, true, '2012-02-22 00:00:00-04:30', NULL, '25', false);
INSERT INTO si_analisis VALUES (28, 1, 'GRANOS YESOSOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '28', false);
INSERT INTO si_analisis VALUES (29, 1, 'GRANOS PANZA BLANCA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '29', false);
INSERT INTO si_analisis VALUES (30, 1, 'YESOSOS + PANZA BLANCA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '30', false);
INSERT INTO si_analisis VALUES (32, 1, 'GRANOS VERDES', 1, true, '2012-02-22 00:00:00-04:30', NULL, '32', false);
INSERT INTO si_analisis VALUES (31, 1, 'GRANOS ROJOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '31', false);
INSERT INTO si_analisis VALUES (33, 1, 'GRANOS SIN CASCARA', 1, true, '2012-02-22 00:00:00-04:30', NULL, '33', false);
INSERT INTO si_analisis VALUES (34, 1, 'ARROZ PADDY', 1, true, '2012-02-22 00:00:00-04:30', NULL, '34', false);
INSERT INTO si_analisis VALUES (36, 1, 'RENDIMIENTO GRANO ENTERO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '38', false);
INSERT INTO si_analisis VALUES (35, 1, 'SORGO ENTERO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '37', false);
INSERT INTO si_analisis VALUES (37, 1, 'BLANCO TOTAL', 1, true, '2012-02-22 00:00:00-04:30', NULL, '39', false);
INSERT INTO si_analisis VALUES (38, 1, 'TEMPERATURA DEL GRANO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '40', false);
INSERT INTO si_analisis VALUES (39, 1, 'MEZCLA DE COLOR EN AMARILLO', 1, true, '2012-02-22 00:00:00-04:30', NULL, '41', false);
INSERT INTO si_analisis VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1', true);
INSERT INTO si_analisis VALUES (19, 1, 'AFLATOXINA', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19', false);
INSERT INTO si_analisis VALUES (21, 1, 'ASPECTO', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20', false);
INSERT INTO si_analisis VALUES (20, 1, 'INSECTOS VIVOS', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24', false);
INSERT INTO si_analisis VALUES (22, 1, 'OLOR', 2, true, '2012-02-22 00:00:00-04:30', NULL, '21', false);
INSERT INTO si_analisis VALUES (26, 1, 'GRANOS DAÑADOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '26', false);


--
-- TOC entry 2530 (class 0 OID 39227)
-- Dependencies: 167
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2531 (class 0 OID 39232)
-- Dependencies: 169
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 2, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 3, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 4, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 5, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 6, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 7, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 8, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 9, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 10, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 11, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 12, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 13, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 14, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 15, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 16, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 22, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 23, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 24, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 29, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 30, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 31, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 32, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 33, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 34, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 35, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 36, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 37, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 38, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 2, 'C', 0.000, 0.000, 'R', 39, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 40, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 41, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 42, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 43, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 44, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 45, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 51, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 52, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 53, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 54, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 55, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 56, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 57, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 58, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 63, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 64, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 65, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 66, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 67, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 68, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 69, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 70, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 71, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 72, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'C', 47, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 21, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 25, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 28, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 50, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 62, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 73, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 74, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 75, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 76, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 77, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 78, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 79, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 80, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 81, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 82, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 83, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 85, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 86, 10.000, 26.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 87, 0.000, 7.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 88, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 89, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 90, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 91, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 92, 0.000, 17.000, 0.000, 17.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 93, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 94, 0.000, 30.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 95, 0.000, 20.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 96, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 97, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 98, 0.720, 0.790, 0.720, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 99, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 100, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 101, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 102, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 104, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 105, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 106, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 107, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 108, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 109, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 110, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 111, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 112, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 113, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 114, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 115, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 116, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 118, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 119, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 120, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 121, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 122, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 123, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 124, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 125, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 126, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 127, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 128, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 129, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 130, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 131, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 132, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 133, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 134, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 135, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 136, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 137, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 138, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 139, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 140, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 141, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 142, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 84, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 117, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 143, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'R', 147, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 149, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 150, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 151, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 152, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 153, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'A', 1.000, 1.000, 'R', 145, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'A', 0.000, 0.000, 'R', 146, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 154, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 155, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 156, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 157, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 158, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 159, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 160, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 161, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 162, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 163, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 164, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 165, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 166, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 167, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 168, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'R', 170, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 171, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 172, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 173, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 174, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 175, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 176, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 177, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 178, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 179, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 180, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 181, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 182, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 183, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 184, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 185, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 186, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 187, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 188, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 189, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 190, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 192, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 193, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 194, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 195, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 196, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 197, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 198, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 199, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 200, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 201, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 202, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 203, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 204, 0.720, 0.790, 0.720, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 205, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 206, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 207, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 208, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 209, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 210, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 211, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 213, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 214, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 215, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 216, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 217, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 169, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 191, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 212, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 218, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 219, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 220, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 221, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 222, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 223, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 224, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 225, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 226, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 17, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 103, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 148, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'A', 7.000, 7.000, 'R', 144, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 227, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 228, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 229, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 230, 0.000, 0.000, 0.000, 0.000, 2);


--
-- TOC entry 2532 (class 0 OID 39243)
-- Dependencies: 171
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2533 (class 0 OID 39249)
-- Dependencies: 173
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado VALUES (131, 2, NULL, 1, 5, '12.000          ', '13.000          ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (132, 2, NULL, 2, 5, '0.000           ', '3.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (133, 2, NULL, 3, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (134, 2, NULL, 4, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (135, 2, NULL, 5, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (136, 2, NULL, 6, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (137, 2, NULL, 7, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (138, 2, NULL, 8, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (139, 2, NULL, 9, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (140, 2, NULL, 10, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (141, 2, NULL, 11, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (142, 2, NULL, 12, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (143, 2, NULL, 13, 5, '0.710           ', '0.710           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (144, 2, NULL, 14, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (145, 2, NULL, 15, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (146, 2, NULL, 19, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (147, 2, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (148, 2, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (149, 2, NULL, 23, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (150, 2, NULL, 24, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (151, 2, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (152, 3, NULL, 1, 5, '12.000          ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (153, 3, NULL, 2, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (154, 3, NULL, 3, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (155, 3, NULL, 4, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (156, 3, NULL, 5, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (157, 3, NULL, 6, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (158, 3, NULL, 7, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (159, 3, NULL, 8, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (160, 3, NULL, 9, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (161, 3, NULL, 10, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (162, 3, NULL, 11, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (163, 3, NULL, 12, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (164, 3, NULL, 13, 5, '0.710           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (165, 3, NULL, 14, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (166, 3, NULL, 15, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (167, 3, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (168, 3, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (169, 3, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (170, 3, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (171, 3, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (172, 3, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (173, 4, NULL, 1, 5, '25.000          ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (174, 4, NULL, 2, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (175, 4, NULL, 3, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (176, 4, NULL, 4, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (177, 4, NULL, 5, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (178, 4, NULL, 6, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (179, 4, NULL, 7, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (180, 4, NULL, 8, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (181, 4, NULL, 9, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (182, 4, NULL, 10, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (183, 4, NULL, 11, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (184, 4, NULL, 12, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (185, 4, NULL, 13, 5, '0.710           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (186, 4, NULL, 14, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (187, 4, NULL, 15, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (188, 4, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (189, 4, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (190, 4, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (191, 4, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (192, 4, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (193, 4, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (194, 5, NULL, 1, 5, '12.000          ', '12.000          ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (195, 5, NULL, 2, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (196, 5, NULL, 3, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (197, 5, NULL, 4, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (198, 5, NULL, 5, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (199, 5, NULL, 6, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (200, 5, NULL, 7, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (201, 5, NULL, 8, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (202, 5, NULL, 9, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (203, 5, NULL, 10, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (204, 5, NULL, 11, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (205, 5, NULL, 12, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (206, 5, NULL, 13, 5, '0.710           ', '0.710           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (207, 5, NULL, 14, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (208, 5, NULL, 15, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (209, 5, NULL, 19, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (210, 5, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (211, 5, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (212, 5, NULL, 23, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (213, 5, NULL, 24, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (214, 5, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (215, 6, NULL, 1, 5, '26.000          ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (216, 6, NULL, 2, 5, '5.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (217, 6, NULL, 3, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (218, 6, NULL, 4, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (219, 6, NULL, 5, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (220, 6, NULL, 6, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (221, 6, NULL, 7, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (222, 6, NULL, 8, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (223, 6, NULL, 9, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (224, 6, NULL, 10, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (225, 6, NULL, 11, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (226, 6, NULL, 12, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (227, 6, NULL, 13, 5, '0.710           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (228, 6, NULL, 14, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (229, 6, NULL, 15, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (230, 6, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (231, 6, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (232, 6, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (233, 6, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (234, 6, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (235, 6, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (236, 2, NULL, 19, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (237, 2, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (238, 2, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (239, 2, NULL, 23, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (240, 2, NULL, 24, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (241, 2, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (242, 3, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (243, 3, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (244, 3, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (245, 3, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (246, 3, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (247, 3, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (248, 4, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (249, 4, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (250, 4, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (251, 4, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (252, 4, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (253, 4, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (254, 5, NULL, 19, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (255, 5, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (256, 5, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (257, 5, NULL, 23, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (258, 5, NULL, 24, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (259, 5, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (260, 6, NULL, 19, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (261, 6, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (262, 6, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (263, 6, NULL, 23, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (264, 6, NULL, 24, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (265, 6, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (268, 8, NULL, 13, 5, '0.330           ', '0.330           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (269, 8, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (270, 8, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (271, 8, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (272, 8, NULL, 38, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (275, 9, NULL, 13, 5, '0.330           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (276, 9, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (277, 9, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (278, 9, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (279, 9, NULL, 38, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (266, 8, NULL, 1, 5, '7.600           ', '8.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (267, 8, NULL, 2, 5, '12.200          ', '10.000          ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (273, 9, NULL, 1, 5, '7.600           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (274, 9, NULL, 2, 5, '2.200           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (282, 8, NULL, 13, 5, '0.330           ', '0.330           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (283, 8, NULL, 21, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (284, 8, NULL, 22, 5, 'A               ', 'A               ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (285, 8, NULL, 20, 5, 'NO              ', 'NO              ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (286, 8, NULL, 38, 5, '0.000           ', '0.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (289, 9, NULL, 13, 5, '0.330           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (290, 9, NULL, 21, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (291, 9, NULL, 22, 5, 'A               ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (292, 9, NULL, 20, 5, 'NO              ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (293, 9, NULL, 38, 5, '0.000           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (280, 8, NULL, 1, 5, '7.600           ', '8.000           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (281, 8, NULL, 2, 5, '12.200          ', '10.00           ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (287, 9, NULL, 1, 5, '7.600           ', '                ', '                ', 2, 'R ');
INSERT INTO si_analisis_resultado VALUES (288, 9, NULL, 2, 5, '2.200           ', '                ', '                ', 2, 'R ');


--
-- TOC entry 2534 (class 0 OID 39254)
-- Dependencies: 175
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error VALUES ('c6344b8b0fc8f949fe', '2012-05-06 09:24:17.617-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:266:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''12'', ''2'', ''1'', ''1'', ''GIRPAL'', ''(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)'', ''HUML+IMPL = 14 < 999999'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:24:17";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('4ae66491ad5f5366e8', '2012-05-06 09:31:29.095-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:190:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''ALGO = 13 < 14'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:31:29";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('de886ea108e5814ef2', '2012-05-06 09:32:26.634-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:189:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+2'', ''ASD = 13 < 15'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:32:26";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('915b5515e3ab90c1f9', '2012-05-06 09:34:06.058-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:40;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:187:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''123'', ''1+1'', ''ASD = 1 < 4'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:34:06";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('aca32892f9e1f60a39', '2012-05-06 09:35:58.368-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:40;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:187:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''123 = 1 < 2'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:35:58";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('4ba071dd6fb1cb8183', '2012-05-06 09:38:54.562-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:50:"http://localhost/sigesil/admin/formulacion.php<br>";s:4:"line";i:39;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «id_mov» viola la restricción not null";s:5:"query";s:190:"INSERT INTO si_formulas  (id_mov, id_cultivo, tipo_for, id_org, id_centro_acopio, codigo, formula, condicion, creado) VALUES  (null, ''1'', ''2'', ''1'', ''1'', ''ASD'', ''1+1'', ''123 = 1 < 2432'',now())";s:9:"user_name";s:8:"JPELUZZO";s:4:"date";s:19:"2012-05-06 09:38:54";}i:1;a:4:{s:4:"file";s:54:"http://localhost/sigesil/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('65ecfe24d8fc3eaf5b', '2012-05-06 12:00:54.831-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:56:"http://localhost/sigesil/admin/cosecha_productor.php<br>";s:4:"line";i:31;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 12:00:54";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('215064596f84b88770', '2012-05-06 12:01:01.161-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:56:"http://localhost/sigesil/admin/cosecha_productor.php<br>";s:4:"line";i:31;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 12:01:01";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('5df3bffbda93c0889f', '2012-05-06 12:01:47.411-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:54:"http://localhost/sigesil/ajax/cosecha_programa.php<br>";s:4:"line";i:58;s:5:"class";s:7:"Cosecha";s:8:"function";s:23:"asignarCosechaProductor";s:11:"mysql_error";s:208:"ERROR:  la sintaxis de entrada no es válida para integer: «[object»
LINE 8: ...ND cp.id_cosecha = "1" AND p.id = "2" AND p2.id = "[object" ...
                                                             ^";s:5:"query";s:918:"SELECT cp.id_cosecha, p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, <br />
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, <br />
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado<br />
                    FROM si_productor p<br />
                    LEFT JOIN si_cosecha_productor cp ON cp.id_productor = p.id<br />
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado<br />
                    WHERE ''1'' AND cp.id_cosecha = ''1'' AND p.id = ''2'' AND p2.id = ''[object'' OR NOT EXISTS (SELECT cp2.id_asociacion FROM si_cosecha_productor cp2 WHERE cp2.id_cosecha = ''1'' AND (cp2.id_productor = p.id OR cp2.id_asociacion = p.id OR cp2.id_asociado = p.id)) ORDER BY p.ced_rif, p2.ced_rif, p3.ced_rif";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-06 12:01:47";}i:1;a:4:{s:4:"file";s:56:"http://localhost/sigesil/lib/class/cosecha.class.php<br>";s:4:"line";i:71;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('767cf1259883906162', '2012-05-06 12:03:57.313-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:54:"http://localhost/sigesil/ajax/cosecha_programa.php<br>";s:4:"line";i:58;s:5:"class";s:7:"Cosecha";s:8:"function";s:23:"asignarCosechaProductor";s:11:"mysql_error";s:208:"ERROR:  la sintaxis de entrada no es válida para integer: «[object»
LINE 8: ...ND cp.id_cosecha = "1" AND p.id = "2" AND p2.id = "[object" ...
                                                             ^";s:5:"query";s:918:"SELECT cp.id_cosecha, p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, <br />
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, <br />
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado<br />
                    FROM si_productor p<br />
                    LEFT JOIN si_cosecha_productor cp ON cp.id_productor = p.id<br />
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion<br />
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado<br />
                    WHERE ''1'' AND cp.id_cosecha = ''1'' AND p.id = ''2'' AND p2.id = ''[object'' OR NOT EXISTS (SELECT cp2.id_asociacion FROM si_cosecha_productor cp2 WHERE cp2.id_cosecha = ''1'' AND (cp2.id_productor = p.id OR cp2.id_asociacion = p.id OR cp2.id_asociado = p.id)) ORDER BY p.ced_rif, p2.ced_rif, p3.ced_rif";s:9:"user_name";s:9:"MCORONADO";s:4:"date";s:19:"2012-05-06 12:03:57";}i:1;a:4:{s:4:"file";s:56:"http://localhost/sigesil/lib/class/cosecha.class.php<br>";s:4:"line";i:71;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('67526792ec9f2803da', '2012-05-06 22:39:00.576-04:30', 'a:4:{i:0;a:8:{s:4:"file";s:53:"http://localhost/sigesil/admin/boleta_virtual.php<br>";s:4:"line";i:3;s:5:"class";N;s:8:"function";s:7:"require";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE mh.id_usuario = "" AND mp.estatus ...
                                                  ^";s:5:"query";s:287:"SELECT mp.*, mh.nuevo, mh.modificar, mh.eliminar, mh.imprimir<br />
                    FROM si_menu mp<br />
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id<br />
                    WHERE mh.id_usuario = '''' AND mp.estatus = ''t'' ORDER BY mp.id_padre, mp.orden";s:9:"user_name";N;s:4:"date";s:19:"2012-05-06 10:39:00";}i:1;a:4:{s:4:"file";s:50:"http://localhost/sigesil/lib/common/header.php<br>";s:4:"line";i:115;s:5:"class";N;s:8:"function";s:7:"require";}i:2;a:4:{s:4:"file";s:48:"http://localhost/sigesil/lib/common/menu.php<br>";s:4:"line";i:2;s:5:"class";s:4:"Menu";s:8:"function";s:14:"menuPorUsuario";}i:3;a:4:{s:4:"file";s:53:"http://localhost/sigesil/lib/class/menu.class.php<br>";s:4:"line";i:13;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- TOC entry 2535 (class 0 OID 39260)
-- Dependencies: 176
-- Data for Name: si_asociacion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2536 (class 0 OID 39270)
-- Dependencies: 179
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2537 (class 0 OID 39279)
-- Dependencies: 181
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2538 (class 0 OID 39285)
-- Dependencies: 183
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2539 (class 0 OID 39292)
-- Dependencies: 185
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_centro_acopio VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (3, 1, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (4, 1, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (5, 1, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (6, 1, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (7, 1, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (8, 1, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio VALUES (2, 1, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-03-16 10:40:45.916545-04:30');
INSERT INTO si_centro_acopio VALUES (9, 1, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', '2012-05-03 14:24:41.877195-04:30');


--
-- TOC entry 2540 (class 0 OID 39305)
-- Dependencies: 186
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_choferes VALUES (1, 1, 1, 5, 51, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-18 14:52:10.222967-04:30', NULL);
INSERT INTO si_choferes VALUES (3, 1, 1, 5, 54, 'V16538158', 'MARIELY CORONADO', NULL, NULL, NULL, true, '2012-04-23 14:20:23.712675-04:30', NULL);
INSERT INTO si_choferes VALUES (2, 1, 1, 5, 51, 'V14894566', 'LEIDY SIFONTES', NULL, NULL, NULL, true, '2012-04-18 15:56:47.128604-04:30', NULL);
INSERT INTO si_choferes VALUES (5, 1, 1, 5, 51, 'V18264063', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_choferes VALUES (6, 1, 1, 5, 51, 'V18264062', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_choferes VALUES (7, 1, 1, 5, 51, 'V18264061', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_choferes VALUES (8, 1, 1, 5, 51, 'V18264068', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_choferes VALUES (9, 1, 1, 5, 51, 'V18264069', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_choferes VALUES (4, 1, 1, 3, 11, 'V16321654', 'OTRO CHOFER', NULL, NULL, NULL, true, '2012-04-23 14:21:37.597326-04:30', '2012-05-03 15:27:51.959201-04:30');
INSERT INTO si_choferes VALUES (10, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_choferes VALUES (11, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_choferes VALUES (12, 1, NULL, NULL, NULL, 'V18264067', 'JESUS RODRIGUEZ', NULL, NULL, NULL, true, '2012-05-07 00:28:45.32-04:30', NULL);


--
-- TOC entry 2541 (class 0 OID 39312)
-- Dependencies: 189
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cliente VALUES (1, 1, NULL, 'V18264066', NULL, 'JESUS SILVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, '2012-04-18 14:50:40.359184-04:30', NULL);
INSERT INTO si_cliente VALUES (2, 1, NULL, 'V18264065', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, '2012-04-23 14:15:09.561428-04:30', NULL);
INSERT INTO si_cliente VALUES (3, 1, NULL, 'V17247200', NULL, 'JOSE PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 6, 56, NULL, true, '2012-04-23 14:18:33.708177-04:30', NULL);


--
-- TOC entry 2542 (class 0 OID 39321)
-- Dependencies: 191
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha VALUES (1, 2, 1, 'INVIERNO 2012', 220000, NULL, 45000, '2012-09-03', '2013-02-04', true, '2012-04-18 15:25:47.739787-04:30', NULL, '2012011');
INSERT INTO si_cosecha VALUES (2, 3, 3, 'COSECHA 1 SORGO', NULL, NULL, NULL, '2012-04-29', '2012-07-29', true, '2012-04-29 22:43:28.902-04:30', NULL, '2012031');
INSERT INTO si_cosecha VALUES (3, 4, 12, 'COSECHA 1 GIR', NULL, NULL, NULL, NULL, NULL, true, '2012-05-07 00:19:27.451-04:30', NULL, '2012121');


--
-- TOC entry 2543 (class 0 OID 39332)
-- Dependencies: 192
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 5, 7, '2012-04-29 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 3, 12, 11, NULL, NULL);
INSERT INTO si_cosecha_productor VALUES (2, 2, 10, 0, 0, '2012-05-04 00:00:00-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 4, 9, '2012-05-06 19:33:59.834-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 4, 8, '2012-05-06 19:33:59.84-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 6, 0, 0, '2012-05-06 19:40:19.328-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 2, 0, 7, '2012-05-07 00:20:00.868-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 2, 0, 6, '2012-05-07 00:20:00.879-04:30', NULL);


--
-- TOC entry 2544 (class 0 OID 39337)
-- Dependencies: 193
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2545 (class 0 OID 39342)
-- Dependencies: 195
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2546 (class 0 OID 39347)
-- Dependencies: 197
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2547 (class 0 OID 39355)
-- Dependencies: 200
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo VALUES (10, 1, '10', 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (12, 1, '12', 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (13, 1, '13', 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (14, 1, '14', 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (16, 1, '16', 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (19, 1, '92', 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (20, 1, '93', 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (21, 1, '94', 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (2, 1, '02', 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (3, 1, '03', 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (4, 1, '04', 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (5, 1, '05', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (6, 1, '06', 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (7, 1, '07', 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (8, 1, '08', 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (9, 1, '09', 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (22, 1, '95', 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (23, 1, '96', 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (1, 1, '01', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (11, 1, '11', 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (15, 1, '15', 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (17, 1, '17', 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (24, 1, '97', 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (25, 1, '98', 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (18, 1, '68', 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (26, 1, '99', 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', '2012-05-03 15:13:02.029691-04:30', true);


--
-- TOC entry 2548 (class 0 OID 39361)
-- Dependencies: 201
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo_tipo VALUES (1, 2, 2, 26, 'A ', 0.00, 4.00);
INSERT INTO si_cultivo_tipo VALUES (2, 2, 2, 26, 'B ', 4.10, 11.00);
INSERT INTO si_cultivo_tipo VALUES (3, 2, 2, 30, 'A ', 0.00, 17.00);
INSERT INTO si_cultivo_tipo VALUES (4, 2, 2, 30, 'B ', 17.10, 30.00);
INSERT INTO si_cultivo_tipo VALUES (5, 2, 2, 31, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (6, 2, 2, 31, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (7, 2, 2, 32, 'A ', 0.00, 8.50);
INSERT INTO si_cultivo_tipo VALUES (8, 2, 2, 32, 'B ', 8.51, 14.00);
INSERT INTO si_cultivo_tipo VALUES (9, 2, 2, 33, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (10, 2, 2, 33, 'B ', 1.51, 3.00);


--
-- TOC entry 2549 (class 0 OID 39370)
-- Dependencies: 204
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2550 (class 0 OID 39374)
-- Dependencies: 205
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_despacho VALUES (1, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-18 14:56:38.350798-04:30', 1, '2012-04-23 14:51:08.588936-04:30', 7000, 10000, '2012-04-23 14:55:03.392292-04:30', 17000, 22000, 12.5, 3.5, 125, 765.625, NULL, '5', 2, NULL, 6, 5, '2012-04-18 14:56:38.350798-04:30', '2012-04-23 14:55:03.392292-04:30', 21109.375, NULL, NULL);
INSERT INTO si_despacho VALUES (3, 2, 1, 2, 2, 3, 7, 5, 1, 2, 2, '2012-04-23 14:20:55.493459-04:30', 2, '2012-04-23 14:52:02.630034-04:30', 12300, 14850, '2012-04-23 14:55:30.370692-04:30', 18570, 25610, 17.5, 4.5, 1064.375, 718.45299999999997, NULL, '5', 2, NULL, 5, 5, '2012-04-23 14:20:55.493459-04:30', '2012-04-23 14:55:30.370692-04:30', 15247.172, NULL, NULL);
INSERT INTO si_despacho VALUES (4, 2, 2, 4, 3, 4, 8, 5, 1, 3, 2, '2012-04-23 14:22:02.577104-04:30', 3, '2012-04-23 14:52:16.524929-04:30', 16550, 12340, '2012-04-23 14:55:42.103705-04:30', 20000, 30000, 17, 9.5, 422.19999999999999, 1161.05, NULL, '5', 2, NULL, 5, 5, '2012-04-23 14:22:02.577104-04:30', '2012-04-23 14:55:42.103705-04:30', 19526.75, NULL, NULL);
INSERT INTO si_despacho VALUES (2, 2, 1, 1, 1, 1, 1, 5, 1, 1, 2, '2012-04-23 14:19:42.192099-04:30', 1, '2012-04-23 14:51:53.059302-04:30', 20000, 0, '2012-04-23 14:55:14.106328-04:30', 35000, NULL, 12, NULL, NULL, NULL, NULL, '5', 1, NULL, 5, 6, '2012-04-23 14:19:42.192099-04:30', '2012-04-23 14:55:14.106328-04:30', 15000, NULL, NULL);
INSERT INTO si_despacho VALUES (5, 2, 1, 1, 1, 1, 1, 4, 1, 1, 2, '2012-04-25 08:41:22.287997-04:30', 1, '2012-04-27 07:58:49.121647-04:30', 18550, NULL, '2012-04-27 07:59:40.632098-04:30', 32618, NULL, 15, 3, 479.59100000000001, 407.65199999999999, NULL, '5', 1, NULL, 5, 5, '2012-04-25 08:41:22.287997-04:30', '2012-04-27 07:59:40.632098-04:30', 13180.757, NULL, NULL);


--
-- TOC entry 2551 (class 0 OID 39382)
-- Dependencies: 208
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2552 (class 0 OID 39389)
-- Dependencies: 210
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_estado VALUES (2, 1, 'AMAZONAS');
INSERT INTO si_estado VALUES (3, 1, 'ANZOATEGUI');
INSERT INTO si_estado VALUES (4, 1, 'APURE');
INSERT INTO si_estado VALUES (5, 1, 'ARAGUA');
INSERT INTO si_estado VALUES (6, 1, 'BARINAS');
INSERT INTO si_estado VALUES (7, 1, 'BOLIVAR');
INSERT INTO si_estado VALUES (8, 1, 'CARABOBO');
INSERT INTO si_estado VALUES (9, 1, 'COJEDES');
INSERT INTO si_estado VALUES (10, 1, 'DELTA AMACURO');
INSERT INTO si_estado VALUES (11, 1, 'FALCON');
INSERT INTO si_estado VALUES (12, 1, 'GUARICO');
INSERT INTO si_estado VALUES (13, 1, 'LARA');
INSERT INTO si_estado VALUES (14, 1, 'MERIDA');
INSERT INTO si_estado VALUES (15, 1, 'MIRANDA');
INSERT INTO si_estado VALUES (16, 1, 'MONAGAS');
INSERT INTO si_estado VALUES (17, 1, 'NUEVA ESPARTA');
INSERT INTO si_estado VALUES (18, 1, 'PORTUGUESA');
INSERT INTO si_estado VALUES (19, 1, 'SUCRE');
INSERT INTO si_estado VALUES (20, 1, 'TACHIRA');
INSERT INTO si_estado VALUES (21, 1, 'TRUJILLO');
INSERT INTO si_estado VALUES (22, 1, 'VARGAS');
INSERT INTO si_estado VALUES (23, 1, 'YARACUY');
INSERT INTO si_estado VALUES (24, 1, 'ZULIA');
INSERT INTO si_estado VALUES (1, 1, 'DISTRITO CAPITAL');


--
-- TOC entry 2553 (class 0 OID 39393)
-- Dependencies: 211
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2554 (class 0 OID 39402)
-- Dependencies: 213
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas VALUES (16, 1, 1, 7, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (19, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I07', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (20, 1, 1, 7, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H07', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (4, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (5, 1, 1, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (22, 1, 1, 8, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (23, 1, 1, 8, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (25, 1, 1, 8, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (26, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I08', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (47, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (1, 1, 1, NULL, '(PL1+PL2)', 'PL12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (27, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I08', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (28, 1, 1, 8, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H08', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (34, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I06', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (13, 1, 1, 7, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (14, 1, 1, 7, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (40, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I017', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (7, 1, 1, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (8, 1, 1, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (9, 1, 1, 2, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H02', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (10, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I02', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (11, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I02', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (32, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I05', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (46, 1, 2, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (17, 1, 1, 7, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (18, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I07', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (15, 1, 1, 7, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (36, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (42, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I03', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (44, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I04', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (38, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I015', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (21, 1, 1, 8, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (24, 1, 1, 8, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (3, 1, 1, NULL, '((PL1+PL2)-(PV1+PV2))', 'PN', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (2, 1, 1, NULL, '(PV1+PV2)', 'PV12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (45, 1, 2, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (6, 1, 1, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (43, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (41, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (39, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (37, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (35, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (33, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (31, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (29, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (30, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I01', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (12, 1, 1, 12, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);


--
-- TOC entry 2555 (class 0 OID 39410)
-- Dependencies: 215
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec VALUES (2, NULL, NULL, 5, 178923612, 15000, NULL, NULL, '2012-04-29 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_guiarec VALUES (3, NULL, NULL, 5, 234234123, 10000, NULL, NULL, '2012-04-28 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_guiarec VALUES (4, NULL, NULL, 5, 92374392, 16000, NULL, NULL, '2012-04-03 00:00:00-04:30', 'P', NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_guiarec VALUES (5, NULL, NULL, 5, 12312312, 30000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_guiarec VALUES (6, NULL, NULL, 5, 238947289, 32000, NULL, NULL, '2012-04-30 00:00:00-04:30', 'P', NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_guiarec VALUES (7, NULL, NULL, 4, 234213412, 15000, NULL, NULL, '2012-05-04 00:00:00-04:30', 'P', NULL, NULL, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_guiarec VALUES (8, NULL, NULL, 5, 565645234, 30000, NULL, NULL, '2012-05-07 00:00:00-04:30', 'P', NULL, NULL, '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_guiarec VALUES (9, NULL, NULL, 5, 980566523, 35000, NULL, NULL, '2012-05-08 00:00:00-04:30', 'P', NULL, NULL, '2012-05-07 00:28:45.32-04:30', NULL);


--
-- TOC entry 2556 (class 0 OID 39415)
-- Dependencies: 216
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det VALUES (3, 3, '23124343234     ', '2012-04-12 00:00:00-04:30', '');


--
-- TOC entry 2557 (class 0 OID 39424)
-- Dependencies: 220
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2558 (class 0 OID 39430)
-- Dependencies: 222
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas VALUES (2, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''201212''<br />id_cultivo =  ''12''<br />nombre =  ''PROGRAMA GIRASOL''<br />estatus =  ''T''<br />observacion =  null<br />fecha_inicio =  ''07-05-2012''<br />fecha_fin =  ''07-05-2013''<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, id_cultivo, nombre, estatus, observacion, fecha_inicio, fecha_fin, id_centro_acopio, creado) VALUES  (''201212'', ''12'', ''PROGRAMA GIRASOL'', ''T'', null, ''07-05-2012'', ''07-05-2013'', ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (3, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha', 'No data', 'id_programa = ''4''<br />id_cultivo =  ''12''<br />codigo =  ''2012121''<br />nombre =  ''COSECHA 1 GIR''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (id_programa, id_cultivo, codigo, nombre, proyectado, area_siembra, fecha_inicio, fecha_fin, estatus, creado) VALUES  (''4'', ''12'', ''2012121'', ''COSECHA 1 GIR'', null, null, null, null, ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (4, '2012-05-07', 203, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'No data', 'DELETE FROM si_cosecha_productor                       WHERE id_cosecha = ''3'' AND id_centro_acopio = ''2''                       AND id_productor = ''2'' AND id_asociacion = ''0''', '');
INSERT INTO si_log_consultas VALUES (5, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''3''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''0''<br />id_asociado =  ''7''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''3'', ''2'', ''2'', ''0'', ''7'', now())', '');
INSERT INTO si_log_consultas VALUES (6, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''3''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />id_asociacion =  ''0''<br />id_asociado =  ''6''<br />creado =  now()<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, creado)                      VALUES (''3'', ''2'', ''2'', ''0'', ''6'', now())', '');
INSERT INTO si_log_consultas VALUES (7, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''565645234''<br />fecha_emision =  ''07-05-2012''<br />contrato =  null<br />kilogramos =  ''30000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''565645234'', ''07-05-2012'', null, ''30000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas VALUES (8, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (9, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  ''FORD''<br />placa_remolques =  ''123-123''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', ''FORD'', ''123-123'',now())', '');
INSERT INTO si_log_consultas VALUES (10, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''3''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''6''<br />id_guia =  ''8''<br />id_vehiculo =  ''15''<br />id_chofer =  ''11''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''1'', ''3'', ''NOW()'', ''1'', ''2'', ''5'', ''1'', ''2'', ''6'', ''8'', ''15'', ''11'',now())', '');
INSERT INTO si_log_consultas VALUES (11, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''980566523''<br />fecha_emision =  ''08-05-2012''<br />contrato =  null<br />kilogramos =  ''35000''<br />id_usuario =  ''5''<br />estatus =  ''P''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, id_usuario, estatus, creado) VALUES  (''980566523'', ''08-05-2012'', null, ''35000'', ''5'', ''P'',now())', '');
INSERT INTO si_log_consultas VALUES (12, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_choferes', 'No data', 'ced_rif = ''V18264067''<br />nombre =  ''JESUS RODRIGUEZ''<br />id_org =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_choferes  (ced_rif, nombre, id_org, estatus, creado) VALUES  (''V18264067'', ''JESUS RODRIGUEZ'', ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (13, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASE''<br />marca =  ''MACK''<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASE'', ''MACK'', null,now())', '');
INSERT INTO si_log_consultas VALUES (14, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''3''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''5''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_productor =  ''7''<br />id_guia =  ''9''<br />id_vehiculo =  ''16''<br />id_chofer =  ''12''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_productor, id_guia, id_vehiculo, id_chofer, creado) VALUES  (''2'', ''3'', ''NOW()'', ''1'', ''1'', ''5'', ''1'', ''2'', ''7'', ''9'', ''16'', ''12'',now())', '');
INSERT INTO si_log_consultas VALUES (15, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''15.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''1'', ''5'', ''8.000'', ''15.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (16, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''7.000''<br />muestra2 =  ''1.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''2'', ''5'', ''7.000'', ''1.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (17, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.330''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''13'', ''5'', ''0.330'', ''0.330'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (18, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''21'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (19, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''22'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (20, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''20'', ''5'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (21, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''38'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (22, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 8<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''8'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas VALUES (23, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''10.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''1'', ''5'', ''10.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (24, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''2.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''2'', ''5'', ''2.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (25, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''13'', ''5'', ''0.330'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (26, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (27, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (28, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (29, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''38'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (30, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 9<br />estatus_rec = 1<br />muestra = 0<br />modificado = <br />', 'id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''9'', estatus_rec = ''3'', muestra = null, modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas VALUES (31, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />peso_02l = <br />id = 8<br />estatus_rec = 3<br />fecha_pel = <br />modificado = 2012-05-07 00:29:52.168<br />', 'romana_ent = ''5'', peso_01l = ''47350'', peso_02l = ''49000'', id = ''8'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''47350'', peso_02l = ''49000'', id = ''8'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas VALUES (32, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_ent = <br />peso_01l = <br />id = 9<br />estatus_rec = 3<br />fecha_pel = <br />modificado = 2012-05-07 00:30:10.949<br />', 'romana_ent = ''5'', peso_01l = ''47350'', id = ''9'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now()', 'UPDATE si_recepcion SET  romana_ent = ''5'', peso_01l = ''47350'', id = ''9'', estatus_rec = ''4'', fecha_pel = ''NOW()'', modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas VALUES (33, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''8.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''1'', ''5'', ''8.000'', ''8.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (34, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''2'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (35, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''0.330''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''13'', ''5'', ''0.330'', ''0.330'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (36, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''21'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (37, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''22'', ''5'', ''A'', ''A'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (38, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''NO''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''20'', ''5'', ''NO'', ''NO'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (39, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''0.000''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''8'', ''38'', ''5'', ''0.000'', ''0.000'', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (40, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 8<br />estatus_rec = 4<br />muestra = <br />modificado = 2012-05-07 00:33:25.61<br />', 'id = ''8'', estatus_rec = ''6'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''8'', estatus_rec = ''6'', muestra = null, modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas VALUES (41, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''1''<br />id_usuario =  ''5''<br />muestra1 =  ''8.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''1'', ''5'', ''8.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (42, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''2''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''2'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (43, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''13''<br />id_usuario =  ''5''<br />muestra1 =  ''0.330''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''13'', ''5'', ''0.330'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (44, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''21''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''21'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (45, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''22''<br />id_usuario =  ''5''<br />muestra1 =  ''A''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''22'', ''5'', ''A'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (46, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''20''<br />id_usuario =  ''5''<br />muestra1 =  ''NO''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''20'', ''5'', ''NO'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (47, '2012-05-07', 201, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''9''<br />id_analisis =  ''38''<br />id_usuario =  ''5''<br />muestra1 =  ''0.000''<br />muestra2 =  ''''<br />muestra3 =  ''''<br />id_centro_acopio =  ''2''<br />tipo_mov =  ''R''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3, id_centro_acopio, tipo_mov) VALUES (''9'', ''38'', ''5'', ''0.000'', '''', '''', ''2'', ''R'')', '');
INSERT INTO si_log_consultas VALUES (48, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />id = 9<br />estatus_rec = 4<br />muestra = <br />modificado = 2012-05-07 00:33:37.086<br />', 'id = ''9'', estatus_rec = ''6'', muestra = null, modificado=now()', 'UPDATE si_recepcion SET  id = ''9'', estatus_rec = ''6'', muestra = null, modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas VALUES (49, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />peso_02v = <br />id = 8<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />peso_acon = <br />modificado = 2012-05-07 00:35:21.295<br />', 'romana_sal = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''8'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.8'', impureza = ''11.1'', peso_acon = ''51287.43'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''20720'', peso_02v = ''21700'', id = ''8'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.8'', impureza = ''11.1'', peso_acon = ''51287.43'', modificado=now() WHERE id=8', '');
INSERT INTO si_log_consultas VALUES (50, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_recepcion', 'Register No.0<br />romana_sal = <br />peso_01v = <br />id = 9<br />estatus_rec = 6<br />fecha_v = <br />humedad = <br />impureza = <br />peso_02v = <br />peso_acon = <br />modificado = 2012-05-07 00:35:30.076<br />', 'romana_sal = ''5'', peso_01v = ''20720'', id = ''9'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.6'', impureza = ''2.2'', peso_02v = null, peso_acon = ''26630'', modificado=now()', 'UPDATE si_recepcion SET  romana_sal = ''5'', peso_01v = ''20720'', id = ''9'', estatus_rec = ''9'', fecha_v = ''NOW()'', humedad = ''7.6'', impureza = ''2.2'', peso_02v = null, peso_acon = ''26630'', modificado=now() WHERE id=9', '');
INSERT INTO si_log_consultas VALUES (51, '2012-05-07', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = rc9r74n57ere9mobmcrpicete2<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''rc9r74n57ere9mobmcrpicete2''', '');
INSERT INTO si_log_consultas VALUES (52, '2012-05-07', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', 'rc9r74n57ere9mobmcrpicete2', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''rc9r74n57ere9mobmcrpicete2'' ', '');


--
-- TOC entry 2559 (class 0 OID 39439)
-- Dependencies: 224
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (14, 'M_Cosecha', 3, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (15, 'M_Cultivo', 3, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (13, 'M_Programas', 3, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (19, 'M_Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (23, 'M_ConfigCta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (24, 'M_Organizacion', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (25, 'M_Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (21, 'M_Formulas', 4, 'admin/formulacion_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (16, 'M_Productores', 3, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (27, 'M_LabCentral', 2, 'admin/analisis_labcentral.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (28, 'M_Romana', 2, 'admin/romana_movimiento.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (31, 'M_labPlanta', 2, 'admin/analisis_labplanta.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (12, 'M_Despacho', 2, 'admin/despacho.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (18, 'M_Despacho', 3, 'reportes/reporte_despacho.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (29, 'M_Chofer', 1, 'admin/chofer_listado.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (32, 'M_Ordenes', 1, 'admin/ordenes_listado.php', true, 11, NULL, NULL);
INSERT INTO si_menu VALUES (26, 'M_MenuUsuario', 4, 'admin/menu_usuario_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (17, 'M_Recepciones', 3, 'reportes/reporte_recepcion.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (5, 'M_Cuenta', 0, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (1, 'M_Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (6, 'M_CentrosA', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (34, 'M_CosechaProductor', 4, 'admin/cosecha_productor.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (35, 'M_Auditoria', 3, 'reportes/reporte_actividad.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (22, 'M_Configuracion', 4, 'admin/parametros.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (36, 'M_BoletaVirtual', 4, 'admin/boleta_virtual.php', true, 7, NULL, NULL);


--
-- TOC entry 2560 (class 0 OID 39444)
-- Dependencies: 225
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (1, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (10, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (14, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (15, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (16, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (2, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (21, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (6, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (3, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (14, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (15, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (16, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (17, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (21, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (22, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (14, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (15, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (16, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 5, 0, 1, 0, 0);


--
-- TOC entry 2561 (class 0 OID 39455)
-- Dependencies: 227
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_municipio VALUES (1, 1, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (2, 2, 'ALTO ORINOCO         ');
INSERT INTO si_municipio VALUES (3, 2, 'ATABAPO');
INSERT INTO si_municipio VALUES (4, 2, 'ATURES');
INSERT INTO si_municipio VALUES (5, 2, 'AUTANA');
INSERT INTO si_municipio VALUES (6, 2, 'MANAPIARE');
INSERT INTO si_municipio VALUES (7, 2, 'MAROA');
INSERT INTO si_municipio VALUES (8, 2, 'RIO NEGRO');
INSERT INTO si_municipio VALUES (9, 3, 'ANACO');
INSERT INTO si_municipio VALUES (10, 3, 'ARAGUA');
INSERT INTO si_municipio VALUES (11, 3, 'BOLIVAR');
INSERT INTO si_municipio VALUES (12, 3, 'BRUZUAL');
INSERT INTO si_municipio VALUES (13, 3, 'CAJIGAL');
INSERT INTO si_municipio VALUES (14, 3, 'CARVAJAL');
INSERT INTO si_municipio VALUES (15, 3, 'DIEGO BAUTISTA URBANEJA');
INSERT INTO si_municipio VALUES (16, 3, 'FREITES');
INSERT INTO si_municipio VALUES (17, 3, 'GUANIPA');
INSERT INTO si_municipio VALUES (18, 3, 'GUANTA');
INSERT INTO si_municipio VALUES (19, 3, 'INDEPENDENCIA');
INSERT INTO si_municipio VALUES (20, 3, 'LIBERTAD');
INSERT INTO si_municipio VALUES (21, 3, 'MCGREGOR');
INSERT INTO si_municipio VALUES (22, 3, 'MIRANDA');
INSERT INTO si_municipio VALUES (23, 3, 'MONAGAS');
INSERT INTO si_municipio VALUES (24, 3, 'PENALVER');
INSERT INTO si_municipio VALUES (25, 3, 'PIRITU');
INSERT INTO si_municipio VALUES (26, 3, 'SAN JUAN DE CAPISTRANO');
INSERT INTO si_municipio VALUES (27, 3, 'SANTA ANA');
INSERT INTO si_municipio VALUES (28, 3, 'SIMON RODRIGUEZ');
INSERT INTO si_municipio VALUES (29, 3, 'SOTILLO');
INSERT INTO si_municipio VALUES (30, 4, 'ACHAGUAS');
INSERT INTO si_municipio VALUES (31, 4, 'BIRUACA');
INSERT INTO si_municipio VALUES (32, 4, 'MUNOZ');
INSERT INTO si_municipio VALUES (33, 4, 'PAEZ');
INSERT INTO si_municipio VALUES (34, 4, 'PEDRO CAMEJO');
INSERT INTO si_municipio VALUES (35, 4, 'ROMULO GALLEGOS');
INSERT INTO si_municipio VALUES (36, 4, 'SAN FERNANDO');
INSERT INTO si_municipio VALUES (37, 5, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (38, 5, 'CAMATAGUA');
INSERT INTO si_municipio VALUES (39, 5, 'FRANCISCO LINARES ALCÁNTARA');
INSERT INTO si_municipio VALUES (40, 5, 'GIRARDOT');
INSERT INTO si_municipio VALUES (41, 5, 'JOSÉ ANGEL LAMAS');
INSERT INTO si_municipio VALUES (42, 5, 'JOSÉ FÉLIX RIBAS');
INSERT INTO si_municipio VALUES (43, 5, 'JOSÉ RAFAEL REVENGA');
INSERT INTO si_municipio VALUES (44, 5, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (45, 5, 'MARIO BRICEÑO IRAGORRY');
INSERT INTO si_municipio VALUES (46, 5, 'OCUMARE DE LA COSTA DE ORO');
INSERT INTO si_municipio VALUES (47, 5, 'SAN CASIMIRO');
INSERT INTO si_municipio VALUES (48, 5, 'SAN SEBASTIÁN');
INSERT INTO si_municipio VALUES (49, 5, 'SANTIAGO MARIÑO');
INSERT INTO si_municipio VALUES (50, 5, 'SANTOS MICHELENA');
INSERT INTO si_municipio VALUES (51, 5, 'SUCRE');
INSERT INTO si_municipio VALUES (52, 5, 'TOVAR');
INSERT INTO si_municipio VALUES (53, 5, 'URDANETA');
INSERT INTO si_municipio VALUES (54, 5, 'ZAMORA');
INSERT INTO si_municipio VALUES (55, 6, 'ALBERTO ARVELO TORREALBA');
INSERT INTO si_municipio VALUES (56, 6, 'ANDRÉS ELOY BLANCO');
INSERT INTO si_municipio VALUES (57, 6, 'ANTONIO JOSÉ DE SUCRE');
INSERT INTO si_municipio VALUES (58, 6, 'ARISMENDI');
INSERT INTO si_municipio VALUES (59, 6, 'BARINAS');
INSERT INTO si_municipio VALUES (60, 6, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (61, 6, 'CRUZ PAREDES');
INSERT INTO si_municipio VALUES (62, 6, 'EZEQUIEL ZAMORA');
INSERT INTO si_municipio VALUES (63, 6, 'OBISPOS');
INSERT INTO si_municipio VALUES (64, 6, 'PEDRAZA');
INSERT INTO si_municipio VALUES (65, 6, 'ROJAS');
INSERT INTO si_municipio VALUES (66, 6, 'SOSA');
INSERT INTO si_municipio VALUES (67, 7, 'CARONÍ');
INSERT INTO si_municipio VALUES (68, 7, 'CEDEÑO');
INSERT INTO si_municipio VALUES (69, 7, 'EL CALLAO');
INSERT INTO si_municipio VALUES (70, 7, 'GRAN SABANA');
INSERT INTO si_municipio VALUES (71, 7, 'HERES');
INSERT INTO si_municipio VALUES (72, 7, 'PIAR');
INSERT INTO si_municipio VALUES (73, 7, 'RAÚL LEONI');
INSERT INTO si_municipio VALUES (74, 7, 'ROSCIO');
INSERT INTO si_municipio VALUES (75, 7, 'SIFONTES');
INSERT INTO si_municipio VALUES (76, 7, 'SUCRE');
INSERT INTO si_municipio VALUES (77, 7, 'PADRE PEDRO CHIEN');
INSERT INTO si_municipio VALUES (78, 8, 'BEJUMA');
INSERT INTO si_municipio VALUES (79, 8, 'CARLOS ARVELO');
INSERT INTO si_municipio VALUES (80, 8, 'DIEGO IBARRA');
INSERT INTO si_municipio VALUES (81, 8, 'GUACARA');
INSERT INTO si_municipio VALUES (82, 8, 'JUAN JOSÉ MORA');
INSERT INTO si_municipio VALUES (83, 8, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (84, 8, 'LOS GUAYOS');
INSERT INTO si_municipio VALUES (85, 8, 'MIRANDA');
INSERT INTO si_municipio VALUES (86, 8, 'MONTALBÁN');
INSERT INTO si_municipio VALUES (87, 8, 'NAGUANAGUA');
INSERT INTO si_municipio VALUES (88, 8, 'PUERTO CABELLO');
INSERT INTO si_municipio VALUES (89, 8, 'SAN DIEGO');
INSERT INTO si_municipio VALUES (90, 8, 'SAN JOAQUÍN');
INSERT INTO si_municipio VALUES (91, 8, 'VALENCIA');
INSERT INTO si_municipio VALUES (92, 9, 'ANZOÁTEGUI');
INSERT INTO si_municipio VALUES (93, 9, 'FALCÓN');
INSERT INTO si_municipio VALUES (94, 9, 'GIRARDOT');
INSERT INTO si_municipio VALUES (95, 9, 'LIMA BLANCO');
INSERT INTO si_municipio VALUES (96, 9, 'PAO DE SAN JUAN BAUTISTA');
INSERT INTO si_municipio VALUES (97, 9, 'RICAURTE');
INSERT INTO si_municipio VALUES (98, 9, 'RÓMULO GALLEGOS');
INSERT INTO si_municipio VALUES (99, 9, 'SAN CARLOS');
INSERT INTO si_municipio VALUES (100, 9, 'TINACO');
INSERT INTO si_municipio VALUES (101, 10, 'ANTONIO DÍAZ');
INSERT INTO si_municipio VALUES (102, 10, 'CASACOIMA');
INSERT INTO si_municipio VALUES (103, 10, 'PEDERNALES');
INSERT INTO si_municipio VALUES (104, 10, 'TUCUPITA');
INSERT INTO si_municipio VALUES (105, 10, 'ANTONIO DIAZ');
INSERT INTO si_municipio VALUES (106, 10, 'CASACOIMA');
INSERT INTO si_municipio VALUES (107, 10, 'PEDERNALES');
INSERT INTO si_municipio VALUES (108, 10, 'TUCUPITA');
INSERT INTO si_municipio VALUES (109, 11, 'ACOSTA');
INSERT INTO si_municipio VALUES (110, 11, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (111, 11, 'BUCHIVACOA');
INSERT INTO si_municipio VALUES (112, 11, 'CACIQUE MANAURE');
INSERT INTO si_municipio VALUES (113, 11, 'CARIRUBANA');
INSERT INTO si_municipio VALUES (114, 11, 'COLINA');
INSERT INTO si_municipio VALUES (115, 11, 'DABAJURO');
INSERT INTO si_municipio VALUES (116, 11, 'DEMOCRACIA');
INSERT INTO si_municipio VALUES (117, 11, 'FALCÓN');
INSERT INTO si_municipio VALUES (118, 11, 'FEDERACIÓN');
INSERT INTO si_municipio VALUES (119, 11, 'JACURA');
INSERT INTO si_municipio VALUES (120, 11, 'LOS TAQUES');
INSERT INTO si_municipio VALUES (121, 11, 'MAUROA');
INSERT INTO si_municipio VALUES (122, 11, 'MIRANDA');
INSERT INTO si_municipio VALUES (123, 11, 'MONSEÑOR ITURRIZA');
INSERT INTO si_municipio VALUES (124, 11, 'PALMASOLA');
INSERT INTO si_municipio VALUES (125, 11, 'PETIT');
INSERT INTO si_municipio VALUES (126, 11, 'PÍRITU');
INSERT INTO si_municipio VALUES (127, 11, 'SAN FRANCISCO');
INSERT INTO si_municipio VALUES (128, 11, 'SILVA');
INSERT INTO si_municipio VALUES (129, 11, 'SUCRE');
INSERT INTO si_municipio VALUES (130, 11, 'TOCÓPERO');
INSERT INTO si_municipio VALUES (131, 11, 'UNIÓN');
INSERT INTO si_municipio VALUES (132, 11, 'URUMACO');
INSERT INTO si_municipio VALUES (133, 11, 'ZAMORA');
INSERT INTO si_municipio VALUES (134, 12, 'CAMAGUÁN');
INSERT INTO si_municipio VALUES (135, 12, 'CHAGUARAMAS');
INSERT INTO si_municipio VALUES (136, 12, 'EL SOCORRO');
INSERT INTO si_municipio VALUES (137, 12, 'SEBASTIAN FRANCISCO DE MIRANDA');
INSERT INTO si_municipio VALUES (138, 12, 'JOSÉ FÉLIX RIBAS');
INSERT INTO si_municipio VALUES (139, 12, 'JOSÉ TADEO MONAGAS');
INSERT INTO si_municipio VALUES (140, 12, 'JUAN GERMÁN ROSCIO');
INSERT INTO si_municipio VALUES (141, 12, 'JULIÁN MELLADO');
INSERT INTO si_municipio VALUES (142, 12, 'LAS MERCEDES');
INSERT INTO si_municipio VALUES (143, 12, 'LEONARDO INFANTE');
INSERT INTO si_municipio VALUES (144, 12, 'PEDRO ZARAZA');
INSERT INTO si_municipio VALUES (145, 12, 'ORTIZ');
INSERT INTO si_municipio VALUES (146, 12, 'SAN GERÓNIMO DE GUAYABAL');
INSERT INTO si_municipio VALUES (147, 12, 'SAN JOSÉ DE GUARIBE');
INSERT INTO si_municipio VALUES (148, 12, 'SANTA MARÍA DE IPIRE');
INSERT INTO si_municipio VALUES (149, 13, 'ANDRÉS ELOY BLANCO');
INSERT INTO si_municipio VALUES (150, 13, 'CRESPO');
INSERT INTO si_municipio VALUES (151, 13, 'IRIBARREN');
INSERT INTO si_municipio VALUES (152, 13, 'JIMÉNEZ');
INSERT INTO si_municipio VALUES (153, 13, 'MORÁN');
INSERT INTO si_municipio VALUES (154, 13, 'PALAVECINO');
INSERT INTO si_municipio VALUES (213, 16, 'SOTILLO');
INSERT INTO si_municipio VALUES (214, 16, 'URACOA');
INSERT INTO si_municipio VALUES (215, 17, 'ANTOLÍN DEL CAMPO');
INSERT INTO si_municipio VALUES (216, 17, 'ARISMENDI ');
INSERT INTO si_municipio VALUES (217, 17, 'DÍAZ');
INSERT INTO si_municipio VALUES (218, 17, 'GARCÍA');
INSERT INTO si_municipio VALUES (219, 17, 'GÓMEZ');
INSERT INTO si_municipio VALUES (220, 17, 'MANEIRO');
INSERT INTO si_municipio VALUES (221, 17, 'MARCANO ');
INSERT INTO si_municipio VALUES (222, 17, 'MARIÑO ');
INSERT INTO si_municipio VALUES (223, 17, 'PENÍNSULA DE MACANAO ');
INSERT INTO si_municipio VALUES (224, 17, 'TUBORES ');
INSERT INTO si_municipio VALUES (225, 17, 'VILLALBA');
INSERT INTO si_municipio VALUES (226, 18, 'AGUA BLANCA');
INSERT INTO si_municipio VALUES (227, 18, 'ARAURE ');
INSERT INTO si_municipio VALUES (228, 18, 'ESTELLER ');
INSERT INTO si_municipio VALUES (229, 18, 'GUANARE ');
INSERT INTO si_municipio VALUES (230, 18, 'GUANARITO');
INSERT INTO si_municipio VALUES (231, 18, 'MONSEÑOR JOSÉ VICENTE DE UNDA ');
INSERT INTO si_municipio VALUES (232, 18, 'OSPINO ');
INSERT INTO si_municipio VALUES (233, 18, 'PÁEZ ');
INSERT INTO si_municipio VALUES (234, 18, 'PAPELÓN ');
INSERT INTO si_municipio VALUES (235, 18, 'SAN GENARO DE BOCONOÍTO');
INSERT INTO si_municipio VALUES (236, 18, 'SAN RAFAEL DE ONOTO');
INSERT INTO si_municipio VALUES (237, 18, 'SANTA ROSALÍA ');
INSERT INTO si_municipio VALUES (238, 18, 'SUCRE');
INSERT INTO si_municipio VALUES (239, 18, 'TURÉN');
INSERT INTO si_municipio VALUES (240, 19, 'ANDRÉS ELOY BLANCO ');
INSERT INTO si_municipio VALUES (241, 19, 'ANDRÉS MATA');
INSERT INTO si_municipio VALUES (242, 19, 'ARISMENDI ');
INSERT INTO si_municipio VALUES (243, 19, 'BENÍTEZ ');
INSERT INTO si_municipio VALUES (244, 19, 'BERMÚDEZ');
INSERT INTO si_municipio VALUES (245, 19, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (246, 19, 'CAJIGAL ');
INSERT INTO si_municipio VALUES (247, 19, 'CRUZ SALMERÓN ACOSTA');
INSERT INTO si_municipio VALUES (248, 19, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (249, 19, 'MARIÑO ');
INSERT INTO si_municipio VALUES (250, 19, 'MEJÍA ');
INSERT INTO si_municipio VALUES (251, 19, 'MONTES');
INSERT INTO si_municipio VALUES (252, 19, 'RIBERO');
INSERT INTO si_municipio VALUES (253, 19, 'SUCRE');
INSERT INTO si_municipio VALUES (254, 19, 'VALDEZ ');
INSERT INTO si_municipio VALUES (255, 20, 'ANDRÉS BELLO ');
INSERT INTO si_municipio VALUES (256, 20, 'ANTONIO RÓMULO COSTA');
INSERT INTO si_municipio VALUES (257, 20, 'AYACUCHO ');
INSERT INTO si_municipio VALUES (258, 20, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (259, 20, 'CÁRDENAS ');
INSERT INTO si_municipio VALUES (260, 20, 'CÓRDOBA (SANTA ANA DE TÁCHIRA)');
INSERT INTO si_municipio VALUES (261, 20, 'FERNÁNDEZ FEO');
INSERT INTO si_municipio VALUES (262, 20, 'FRANCISCO DE MIRANDA');
INSERT INTO si_municipio VALUES (156, 13, 'TORRES');
INSERT INTO si_municipio VALUES (157, 13, 'URDANETA');
INSERT INTO si_municipio VALUES (158, 14, 'ALBERTO ADRIANI');
INSERT INTO si_municipio VALUES (159, 14, 'ANDRÉS BELLO');
INSERT INTO si_municipio VALUES (160, 14, 'ANTONIO PINTO SALINAS');
INSERT INTO si_municipio VALUES (161, 14, 'ARICAGUA');
INSERT INTO si_municipio VALUES (162, 14, 'ARZOBISPO CHACÓN');
INSERT INTO si_municipio VALUES (163, 14, 'CAMPO ELÍAS');
INSERT INTO si_municipio VALUES (164, 14, 'CARACCIOLO PARRA OLMEDO');
INSERT INTO si_municipio VALUES (165, 14, 'CARDENAL QUINTERO');
INSERT INTO si_municipio VALUES (166, 14, 'GUARAQUE');
INSERT INTO si_municipio VALUES (167, 14, 'JULIO CÉSAR SALAS');
INSERT INTO si_municipio VALUES (168, 14, 'JUSTO BRICEÑO');
INSERT INTO si_municipio VALUES (169, 14, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (170, 14, 'MIRANDA');
INSERT INTO si_municipio VALUES (171, 14, 'OBISPO RAMOS DE LORA');
INSERT INTO si_municipio VALUES (172, 14, 'PADRE NOGUERA');
INSERT INTO si_municipio VALUES (173, 14, 'PUEBLO LLANO');
INSERT INTO si_municipio VALUES (174, 14, 'RANGEL');
INSERT INTO si_municipio VALUES (175, 14, 'RIVAS DÁVILA');
INSERT INTO si_municipio VALUES (176, 14, 'SANTOS MARQUINA');
INSERT INTO si_municipio VALUES (177, 14, 'SUCRE');
INSERT INTO si_municipio VALUES (178, 14, 'TOVAR');
INSERT INTO si_municipio VALUES (179, 14, 'TULIO FEBRES CORDERO');
INSERT INTO si_municipio VALUES (180, 14, 'ZEA');
INSERT INTO si_municipio VALUES (181, 15, 'ACEVEDO');
INSERT INTO si_municipio VALUES (182, 15, 'ANDRÉS BELLO');
INSERT INTO si_municipio VALUES (183, 15, 'BARUTA');
INSERT INTO si_municipio VALUES (184, 15, 'BRIÓN');
INSERT INTO si_municipio VALUES (185, 15, 'BUROZ');
INSERT INTO si_municipio VALUES (186, 15, 'CARRIZAL');
INSERT INTO si_municipio VALUES (187, 15, 'CHACAO');
INSERT INTO si_municipio VALUES (188, 15, 'CRISTÓBAL ROJAS');
INSERT INTO si_municipio VALUES (189, 15, 'EL HATILLO');
INSERT INTO si_municipio VALUES (190, 15, 'GUAICAIPURO');
INSERT INTO si_municipio VALUES (191, 15, 'INDEPENDENCIA');
INSERT INTO si_municipio VALUES (192, 15, 'LANDER');
INSERT INTO si_municipio VALUES (193, 15, 'LOS SALIAS');
INSERT INTO si_municipio VALUES (194, 15, 'PÁEZ');
INSERT INTO si_municipio VALUES (195, 15, 'PAZ CASTILLO');
INSERT INTO si_municipio VALUES (196, 15, 'PEDRO GUAL');
INSERT INTO si_municipio VALUES (197, 15, 'PLAZA');
INSERT INTO si_municipio VALUES (198, 15, 'SIMÓN BOLÍVAR');
INSERT INTO si_municipio VALUES (199, 15, 'SUCRE');
INSERT INTO si_municipio VALUES (200, 15, 'URDANETA');
INSERT INTO si_municipio VALUES (201, 15, 'ZAMORA');
INSERT INTO si_municipio VALUES (202, 16, 'ACOSTA');
INSERT INTO si_municipio VALUES (203, 16, 'AGUASAY');
INSERT INTO si_municipio VALUES (204, 16, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (205, 16, 'CARIPE');
INSERT INTO si_municipio VALUES (206, 16, 'CEDEÑO');
INSERT INTO si_municipio VALUES (207, 16, 'EZEQUIEL ZAMORA');
INSERT INTO si_municipio VALUES (208, 16, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (209, 16, 'MATURÍN');
INSERT INTO si_municipio VALUES (210, 16, 'PIAR');
INSERT INTO si_municipio VALUES (211, 16, 'PUNCERES');
INSERT INTO si_municipio VALUES (212, 16, 'SANTA BÁRBARA');
INSERT INTO si_municipio VALUES (263, 20, 'GARCÍA DE HEVIA');
INSERT INTO si_municipio VALUES (264, 20, 'GUÁSIMOS');
INSERT INTO si_municipio VALUES (265, 20, 'INDEPENDENCIA');
INSERT INTO si_municipio VALUES (266, 20, 'JÁUREGUI ');
INSERT INTO si_municipio VALUES (267, 20, 'JOSÉ MARÍA VARGAS');
INSERT INTO si_municipio VALUES (268, 20, 'JUNÍN ');
INSERT INTO si_municipio VALUES (269, 20, 'LIBERTAD (CAPACHO VIEJO)');
INSERT INTO si_municipio VALUES (270, 20, 'LIBERTADOR');
INSERT INTO si_municipio VALUES (271, 20, 'LOBATERA ');
INSERT INTO si_municipio VALUES (272, 20, 'MICHELENA');
INSERT INTO si_municipio VALUES (273, 20, 'PANAMERICANO');
INSERT INTO si_municipio VALUES (274, 20, 'PEDRO MARÍA UREÑA');
INSERT INTO si_municipio VALUES (275, 20, 'RAFAEL URDANETA');
INSERT INTO si_municipio VALUES (276, 20, 'SAMUEL DARÍO MALDONADO');
INSERT INTO si_municipio VALUES (277, 20, 'SAN CRISTÓBAL');
INSERT INTO si_municipio VALUES (278, 20, 'SEBORUCO');
INSERT INTO si_municipio VALUES (279, 20, 'SIMÓN RODRÍGUEZ');
INSERT INTO si_municipio VALUES (280, 20, 'SUCRE');
INSERT INTO si_municipio VALUES (281, 20, 'TORBES ');
INSERT INTO si_municipio VALUES (282, 20, 'URIBANTE');
INSERT INTO si_municipio VALUES (283, 20, 'SAN JUDAS TADEO');
INSERT INTO si_municipio VALUES (284, 21, 'ANDRÉS BELLO');
INSERT INTO si_municipio VALUES (285, 21, 'BOCONÓ');
INSERT INTO si_municipio VALUES (286, 21, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (287, 21, 'CANDELARIA');
INSERT INTO si_municipio VALUES (288, 21, 'CARACHE');
INSERT INTO si_municipio VALUES (289, 21, 'ESCUQUE');
INSERT INTO si_municipio VALUES (290, 21, 'JOSÉ FELIPE MÁRQUEZ CAÑIZALEZ ');
INSERT INTO si_municipio VALUES (291, 21, 'JUAN VICENTE CAMPOS ELÍAS');
INSERT INTO si_municipio VALUES (292, 21, 'LA CEIBA');
INSERT INTO si_municipio VALUES (293, 21, 'MIRANDA');
INSERT INTO si_municipio VALUES (294, 21, 'MONTE CARMELO ');
INSERT INTO si_municipio VALUES (295, 21, 'MOTATÁN ');
INSERT INTO si_municipio VALUES (296, 21, 'PAMPÁN');
INSERT INTO si_municipio VALUES (297, 21, 'PAMPANITO ');
INSERT INTO si_municipio VALUES (298, 21, 'RAFAEL RANGEL');
INSERT INTO si_municipio VALUES (299, 21, 'SAN RAFAEL DE CARVAJAL');
INSERT INTO si_municipio VALUES (300, 21, 'SUCRE');
INSERT INTO si_municipio VALUES (301, 21, 'TRUJILLO');
INSERT INTO si_municipio VALUES (302, 21, 'URDANETA');
INSERT INTO si_municipio VALUES (303, 21, 'VALERA');
INSERT INTO si_municipio VALUES (304, 22, 'VARGAS');
INSERT INTO si_municipio VALUES (305, 23, 'ARÍSTIDES BASTIDAS');
INSERT INTO si_municipio VALUES (306, 23, 'BOLÍVAR');
INSERT INTO si_municipio VALUES (307, 23, 'BRUZUAL');
INSERT INTO si_municipio VALUES (308, 23, 'COCOROTE');
INSERT INTO si_municipio VALUES (309, 23, 'INDEPENDENCIA');
INSERT INTO si_municipio VALUES (310, 23, 'JOSÉ ANTONIO PÁEZ ');
INSERT INTO si_municipio VALUES (311, 23, 'LA TRINIDAD');
INSERT INTO si_municipio VALUES (312, 23, 'MANUEL MONGE');
INSERT INTO si_municipio VALUES (313, 23, 'NIRGUA');
INSERT INTO si_municipio VALUES (314, 23, 'PEÑA');
INSERT INTO si_municipio VALUES (315, 23, 'SAN FELIPE');
INSERT INTO si_municipio VALUES (316, 23, 'SUCRE');
INSERT INTO si_municipio VALUES (317, 23, 'URACHICHE');
INSERT INTO si_municipio VALUES (318, 23, 'VEROES');
INSERT INTO si_municipio VALUES (319, 24, 'ALMIRANTE PADILLA');
INSERT INTO si_municipio VALUES (320, 24, 'BARALT');
INSERT INTO si_municipio VALUES (321, 24, 'CABIMAS');
INSERT INTO si_municipio VALUES (322, 24, 'CATATUMBO');
INSERT INTO si_municipio VALUES (323, 24, 'COLÓN');
INSERT INTO si_municipio VALUES (324, 24, 'FRANCISCO JAVIER PULGAR');
INSERT INTO si_municipio VALUES (325, 24, 'JESÚS ENRIQUE LOSADA ');
INSERT INTO si_municipio VALUES (326, 24, 'JESÚS MARÍA SEMPRÚN ');
INSERT INTO si_municipio VALUES (327, 24, 'CAÑADA DE URDANETA');
INSERT INTO si_municipio VALUES (328, 24, 'LAGUNILLAS');
INSERT INTO si_municipio VALUES (329, 24, 'MACHIQUES DE PERIJÁ');
INSERT INTO si_municipio VALUES (330, 24, 'MARA');
INSERT INTO si_municipio VALUES (331, 24, 'MARACAIBO');
INSERT INTO si_municipio VALUES (332, 24, 'MIRANDA');
INSERT INTO si_municipio VALUES (333, 24, 'PÁEZ');
INSERT INTO si_municipio VALUES (334, 24, 'ROSARIO DE PERIJÁ');
INSERT INTO si_municipio VALUES (335, 24, 'SAN FRANCISCO ');
INSERT INTO si_municipio VALUES (336, 24, 'SANTA RITA ');
INSERT INTO si_municipio VALUES (337, 24, 'SIMÓN BOLÍVAR ');
INSERT INTO si_municipio VALUES (338, 24, 'SUCRE ');
INSERT INTO si_municipio VALUES (339, 24, 'VALMORE RODRÍGUEZ ');
INSERT INTO si_municipio VALUES (155, 13, 'SIMÓN PLANAS');


--
-- TOC entry 2562 (class 0 OID 39461)
-- Dependencies: 229
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes VALUES (2, 2, 2, 1, 56011212, '2012-04-13 00:00:00-04:30', NULL, 650, false, 'N', NULL, '2012-04-23 14:15:36.726353-04:30', NULL, '56012348');
INSERT INTO si_ordenes VALUES (3, 2, 1, 2, 56021211, '2012-04-03 00:00:00-04:30', NULL, 765, true, 'N', NULL, '2012-04-23 14:16:02.53446-04:30', NULL, '56022453');
INSERT INTO si_ordenes VALUES (4, 2, 3, 2, 56021210, '2012-04-02 00:00:00-04:30', NULL, 196, false, 'N', NULL, '2012-04-23 14:18:36.656458-04:30', NULL, '56021882');
INSERT INTO si_ordenes VALUES (1, 2, 1, 1, 56011201, '2012-04-18 00:00:00-04:30', NULL, 700, false, 'N', NULL, '2012-04-18 14:51:00.510284-04:30', '2012-05-03 15:54:44.728857', '56012392');


--
-- TOC entry 2563 (class 0 OID 39469)
-- Dependencies: 230
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes_det VALUES (1, 1, '11232123', NULL, '', 12000);


--
-- TOC entry 2564 (class 0 OID 39476)
-- Dependencies: 233
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2565 (class 0 OID 39485)
-- Dependencies: 235
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'VENEZUELA');


--
-- TOC entry 2566 (class 0 OID 39491)
-- Dependencies: 237
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (6, 'PL1', 'Peso Lleno 1', 'Peso de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (7, 'PL2', 'Peso Lleno 2', 'Peso de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (8, 'PV1', 'Peso Vacio 1', 'Peso Vac&iacute;o de la Muestra 1', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (9, 'PV2', 'Peso Vacio 2', 'Peso Vac&iacute;o de la Muestra 2', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (10, 'IMPL', 'Impurezas de Laboratorio', 'Impurezas de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (11, 'HUML', 'Humedad de Laboratorio', 'Humedad de Laboratorio', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);
INSERT INTO si_parametros VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);
INSERT INTO si_parametros VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07 00:00:00-04:30', '2012-02-07 00:00:00-04:30', NULL, NULL);


--
-- TOC entry 2567 (class 0 OID 39500)
-- Dependencies: 239
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles VALUES (1, 'GERENTE GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (9, 'DESPACHO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (3, 'ADMINISTRADOR GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (8, 'RECEPCION', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (7, 'ROMANERO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (5, 'CALIDAD GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (2, 'GERENTE DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (4, 'ADMINISTRADOR DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (6, 'CALIDAD DE SILO', '2012-02-07 00:00:00-04:30', NULL);


--
-- TOC entry 2568 (class 0 OID 39504)
-- Dependencies: 240
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_plaga VALUES (1, 1, 'SITOPHILUS ORYZAE-GRANARIUS', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (3, 1, 'TRIBOLIUM CASTANEUN', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (4, 1, 'CRYPTOLETES FERRUGINEUS', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (5, 1, 'ALPHITOBUS SURINAMESIS', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (6, 1, 'RHIZOPERTA DOMINICANA', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (7, 1, 'ORYZAPHILUS SURNAMESIS', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (8, 1, 'SITOTROGA CEREALELLA', NULL, NULL, NULL);
INSERT INTO si_plaga VALUES (9, 1, 'OTROS', NULL, NULL, NULL);


--
-- TOC entry 2569 (class 0 OID 39509)
-- Dependencies: 242
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2570 (class 0 OID 39516)
-- Dependencies: 245
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor VALUES (2, 1, NULL, 'G000000', NULL, 'BANCO AGRICOLA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:25.998447-04:30', NULL);
INSERT INTO si_productor VALUES (3, 1, NULL, 'G000001', NULL, 'FONDAS', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:56.023047-04:30', NULL);
INSERT INTO si_productor VALUES (4, 1, NULL, 'G123456', NULL, 'CONSEJO COMUNAL 1', NULL, NULL, NULL, NULL, NULL, 1, 8, 91, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:22.105165-04:30', NULL);
INSERT INTO si_productor VALUES (7, 1, NULL, 'V16269763', NULL, 'PRODUCTOR 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:16.897952-04:30', NULL);
INSERT INTO si_productor VALUES (8, 1, NULL, 'V15610226', NULL, 'PRODUCTOR 3', NULL, NULL, NULL, NULL, NULL, 1, 14, 160, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 16:12:42.012754-04:30', NULL);
INSERT INTO si_productor VALUES (6, 1, NULL, 'V17247200', NULL, 'PRODUCTOR 1', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:00.31368-04:30', NULL);
INSERT INTO si_productor VALUES (10, 1, NULL, 'V12789456', NULL, 'PRODUCTOR 5', NULL, NULL, NULL, NULL, NULL, 1, 16, 203, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 11:06:26.497-04:30', NULL);
INSERT INTO si_productor VALUES (12, 1, NULL, 'G789456', NULL, 'CONSEJO COMUNAL 3', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 22:58:46.545-04:30', NULL);
INSERT INTO si_productor VALUES (11, 1, NULL, 'V10123456', NULL, 'PRODUCTOR 6', NULL, NULL, NULL, NULL, NULL, 1, 5, 43, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 14:24:04.48-04:30', NULL);
INSERT INTO si_productor VALUES (9, 1, NULL, 'V14785236', NULL, 'PRODUCTOR 4', NULL, NULL, NULL, NULL, NULL, 1, 24, 319, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 10:24:44.811-04:30', NULL);
INSERT INTO si_productor VALUES (5, 1, NULL, 'G456789', NULL, 'CONSEJO COMUNAL 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:41.603699-04:30', NULL);
INSERT INTO si_productor VALUES (13, 1, NULL, 'G0123456', NULL, 'CONSEJO COMUNAL 4', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 08:34:16.836892-04:30', '2012-05-03 15:20:51.557328-04:30');


--
-- TOC entry 2571 (class 0 OID 39525)
-- Dependencies: 247
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa VALUES (2, 2, 'INVIERNO 2012', 'INVIERNO 2012', '2012-04-18 15:25:47.739787-04:30', NULL, true, '201201', '2012-09-03', '2013-09-03', 1);
INSERT INTO si_programa VALUES (3, 2, 'PROGRAMA SORGO', NULL, '2012-04-29 22:43:28.902-04:30', '2012-05-03 15:03:26.829691-04:30', true, '201203', '2012-04-29', '2013-04-29', 3);
INSERT INTO si_programa VALUES (4, 2, 'PROGRAMA GIRASOL', NULL, '2012-05-07 00:19:27.451-04:30', NULL, true, '201212', '2012-05-07', '2013-05-07', 12);


--
-- TOC entry 2572 (class 0 OID 39532)
-- Dependencies: 248
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2573 (class 0 OID 39540)
-- Dependencies: 250
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_punto_entrega VALUES (1, 1, NULL, NULL, NULL, NULL, 'PTO LA CRUZ', NULL, NULL, NULL, '2012-04-18 14:56:38.350798', NULL, NULL);
INSERT INTO si_punto_entrega VALUES (2, 2, NULL, NULL, NULL, NULL, 'ASOCOPRONA', NULL, NULL, NULL, '2012-04-23 14:20:55.493459', NULL, NULL);
INSERT INTO si_punto_entrega VALUES (3, 3, NULL, NULL, NULL, NULL, 'PRIMER PUNTO', NULL, NULL, NULL, '2012-04-23 14:22:02.577104', NULL, NULL);


--
-- TOC entry 2574 (class 0 OID 39548)
-- Dependencies: 252
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion VALUES (2, 2, 1, NULL, 6, 2, 5, 1, '2012-04-29 19:20:15.965-04:30', 1, '9', '2012-05-04 13:37:14.13116-04:30', 15780, 15000, NULL, '2012-05-04 13:41:10.488767-04:30', 7500, 10000, 12.5, 1.5, 75.454999999999998, 198.06800000000001, '2012-04-29 19:20:15.965-04:30', '2012-05-04 13:41:10.488767', 2, 9, 5, 5, 5, 13006.477000000001, NULL, 0);
INSERT INTO si_recepcion VALUES (3, 2, 1, NULL, 11, 3, 5, 2, '2012-04-29 20:25:21.751-04:30', 2, '9', '2012-05-04 13:37:21.860574-04:30', 32150, NULL, NULL, '2012-05-04 13:41:46.820441-04:30', 15000, NULL, 12, NULL, NULL, NULL, '2012-04-29 20:25:21.751-04:30', '2012-05-04 13:41:46.820441', 1, 10, 6, 6, 6, 17150, NULL, 0);
INSERT INTO si_recepcion VALUES (4, 2, 1, NULL, 11, 4, 5, 3, '2012-04-29 20:32:39.489-04:30', 1, '9', '2012-05-04 13:37:30.87956-04:30', 28560, NULL, NULL, '2012-05-04 13:42:01.927864-04:30', 8000, NULL, 25, NULL, 3037.2730000000001, NULL, '2012-04-29 20:32:39.489-04:30', '2012-05-04 13:42:01.927864', 1, 11, 7, 5, 5, 17522.726999999999, NULL, 0);
INSERT INTO si_recepcion VALUES (5, 2, 1, NULL, 6, 5, 5, 1, '2012-04-30 10:14:22.310566-04:30', 1, '9', '2012-05-04 13:37:43.509464-04:30', 12000, 21658, NULL, '2012-05-04 13:42:13.898325-04:30', 6000, 12000, 12, NULL, NULL, NULL, '2012-04-30 10:14:22.310566-04:30', '2012-05-04 13:42:13.898325', 2, 12, 8, 5, 6, 15658, NULL, 0);
INSERT INTO si_recepcion VALUES (7, 2, 2, NULL, 10, 7, 4, 1, '2012-05-04 10:46:21.988047-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-04 10:46:21.988047-04:30', NULL, 1, 14, 10, NULL, NULL, NULL, NULL, 0);
INSERT INTO si_recepcion VALUES (6, 2, 1, NULL, 6, 6, 5, 2, '2012-04-30 10:34:12.974384-04:30', 1, '6', '2012-05-04 13:37:53.571476-04:30', 23641, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:34:12.974384-04:30', '2012-05-04 13:42:25.260416', 1, 13, 9, 5, NULL, NULL, NULL, 0);
INSERT INTO si_recepcion VALUES (8, 2, 3, NULL, 6, 8, 5, 1, '2012-05-07 00:27:33.587-04:30', 1, '9', '2012-05-07 00:33:25.61-04:30', 47350, 49000, NULL, '2012-05-07 00:37:00.485-04:30', 20720, 21700, 7.80000019, 11.1000004, NULL, NULL, '2012-05-07 00:27:33.587-04:30', '2012-05-07 00:37:00.485', 2, 15, 11, 5, 5, 51287.43, NULL, NULL);
INSERT INTO si_recepcion VALUES (9, 2, 3, NULL, 7, 9, 5, 2, '2012-05-07 00:28:45.32-04:30', 1, '9', '2012-05-07 00:33:37.086-04:30', 47350, NULL, NULL, '2012-05-07 00:37:26.028-04:30', 20720, NULL, 7.5999999, 2.20000005, NULL, NULL, '2012-05-07 00:28:45.32-04:30', '2012-05-07 00:37:26.028', 1, 16, 12, 5, 5, 26630, NULL, NULL);


--
-- TOC entry 2575 (class 0 OID 39553)
-- Dependencies: 253
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2576 (class 0 OID 39560)
-- Dependencies: 256
-- Data for Name: si_recursos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recursos VALUES (1, 'Global', NULL, NULL, 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (2, 'Index', 'pages', 'index.php', 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (3, 'Analisis de Resultados', 'admin', 'analisis_resultado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (4, 'Principal', 'pages', 'principal.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (5, 'Recepcion', 'admin', 'recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (6, 'Almacen', 'admin', 'almacen.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (7, 'Listado Almacen', 'admin', 'almacen_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (8, 'Analisis Lab C', 'admin', 'analisis_labcentral.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (9, 'Analisis Lab P', 'admin', 'analisis_labplanta.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (10, 'Analisis Recepcion', 'admin', 'analisis_recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (11, 'Listado Analisis Resultado', 'admin', 'analisis_resultado_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (12, 'Listado Cargo', 'admin', 'cargo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (13, 'Cargo', 'admin', 'cargos.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (14, 'Centros de Acopio', 'admin', 'centros_acopio.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (15, 'Listado de Centros de Acopio', 'admin', 'centros_acopio_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (16, 'Chofer', 'admin', 'chofer.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (17, 'Listado de Choferes', 'admin', 'chofer_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (18, 'Popup de Clientes', 'admin', 'cliente_popup.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (19, 'Config de Parametros', 'admin', 'conf_parametros.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (20, 'Config de Usuario', 'admin', 'conf_usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (21, 'Cosecha', 'admin', 'cosecha.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (22, 'Cuarentena', 'admin', 'cuarentena.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (23, 'Cultivo', 'admin', 'cultivo.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (24, 'Listado de Cultivos', 'admin', 'cultivo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (25, 'Despacho', 'admin', 'despacho.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (26, 'Formulacion', 'admin', 'formulacion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (27, 'Listado Formulacion', 'admin', 'formulacion_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (28, 'Menu Usuario', 'admin', 'menu_usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (29, 'Menu', 'lib/common', 'menu.php', 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (30, 'Ordenes', 'admin', 'ordenes.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (31, 'Listado de Ordenes', 'admin', 'ordenes_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (32, 'Organizacion', 'admin', 'organizacion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (33, 'Listado de Organizaciones', 'admin', 'organizacion_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (34, 'Productor', 'admin', 'productor.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (35, 'Listado de Productores', 'admin', 'productor_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (36, 'Programa', 'admin', 'programa.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (37, 'Listado de Programas', 'admin', 'programa_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (38, 'Recepcion', 'admin', 'recepcion.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (39, 'Romana', 'admin', 'romana.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (40, 'Listado de Romana', 'admin', 'romana_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (41, 'Romana Movimiento', 'admin', 'romana_movimiento.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (42, 'Silos', 'admin', 'silos.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (43, 'Listado de Silos', 'admin', 'silos_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (44, 'Tipo Cultivo', 'admin', 'tipo_cultivo.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (45, 'Listado Tipo Cultivo', 'admin', 'tipo_cultivo_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (46, 'Usuario', 'admin', 'usuario.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (47, 'Listado de Usuarios', 'admin', 'usuarios_listado.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (49, 'Imprimir', 'reportes', 'imprimir.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (48, 'Boleta Recepcion', 'reportes', 'imprimir_recepcion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (50, 'Boleta Liquidacion', 'reportes', 'imprimir_boleta_liquidacion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (51, 'Boleta Rechazo', 'reportes', 'imprimir_boleta_rechazo.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (52, 'Boleta Tipificacion', 'reportes', 'imprimir_boleta_tipificacion.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (53, 'Reporte Despacho', 'reportes', 'reporte_despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (54, 'Reporte Recepcion', 'reportes', 'reporte_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);


--
-- TOC entry 2577 (class 0 OID 39567)
-- Dependencies: 257
-- Data for Name: si_recursos_etiquetas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recursos_etiquetas VALUES (1, 1, 'txtUsuario', 'Usuario', 1, '2012-03-06 09:37:56.586579-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (2, 1, 'txtContrasena', 'Contrase&ntilde;a', 1, '2012-03-06 09:37:56.586579-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (3, 1, 'txtEntrar', 'Entrar', 1, '2012-03-06 09:42:42.170218-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (4, 1, 'txtCancelar', 'Cancelar', 1, '2012-03-06 09:42:42.170218-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (5, 1, 'txtPiePagina', 'Sistema de Gesti&oacute;n de Silos - SIGESIL<br/>&copy; 2012 Todos los Derechos Reservados.<br/><br/>', 1, '2012-03-06 09:52:09.440852-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (6, 2, 'loginerror', 'Usuario y/o Contrase&ntilde;a Inv&aacute;lidos', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (7, 2, 'auth_requerida', 'Debe Iniciar Sesi&oacute;n', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (8, 2, 'usuario_inactivo', 'Usuario y/o Centro de Acopio Inactivo', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (9, 2, 'captcha_invalido', 'Captcha Inv&aacute;lido', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (10, 2, 'captcha_vacio', 'Debe introducir el Captcha', 0, '2012-03-06 09:57:57.901245-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (11, 1, 'E_NO40TNA', 'Existen analisis fuera de norma la muestra sera rechazada , NO SE ENVIARA A CUARENTENA', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (12, 1, 'M_Maestros', 'Maestros', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (13, 1, 'M_Procesos', 'Procesos', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (14, 1, 'M_Reportes', 'Reportes', 1, '2012-03-06 10:24:33.951075-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (16, 1, 'M_Cuenta', 'Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (17, 1, 'M_CentrosA', 'Centros de Acopio', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (18, 1, 'M_Cultivo', 'Cultivo', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (19, 1, 'M_Programas', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (20, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (21, 1, 'M_Productor', 'Productor', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (22, 1, 'M_Recepcion', 'Recepci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (23, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (24, 1, 'M_Programa', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (25, 1, 'M_Cosecha', 'Cosechas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (26, 1, 'M_Cultivo', 'Cultivos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (27, 1, 'M_Productores', 'Productores', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (28, 1, 'M_Recepciones', 'Recepciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (29, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (30, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (31, 1, 'M_Usuarios', 'Usuarios', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (33, 1, 'M_Configuracion', 'Configuraci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (34, 1, 'M_ConfigCta', 'Config. Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (35, 1, 'M_Organizacion', 'Organizaciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (36, 1, 'M_Almacenes', 'Almacenes', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (32, 1, 'M_Formulas', 'F&oacute;rmulas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (40, 3, 'E_FueraNorma', 'El valor indicado está fuera de norma.!!!', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (39, 1, 'M_Romana', 'Romana', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (43, 1, 'M_Chofer', 'Chofer', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (38, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (37, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (41, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (42, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (44, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (45, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (46, 1, 'M_Ordenes', 'Ordenes', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (47, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (48, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (49, 1, 'M_Auditoria', 'Reporte de Actividad', 1, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (50, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-14 00:00:00-04:30', NULL);


--
-- TOC entry 2578 (class 0 OID 39580)
-- Dependencies: 261
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_silos VALUES (7, 3, 3, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:05:32.047308-04:30', NULL, true);
INSERT INTO si_silos VALUES (8, 3, 3, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:05:32.064005-04:30', NULL, true);
INSERT INTO si_silos VALUES (29, 4, 4, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:06:27.548043-04:30', NULL, true);
INSERT INTO si_silos VALUES (53, 5, 5, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:12:33.541914-04:30', NULL, true);
INSERT INTO si_silos VALUES (17, 4, 4, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:06:27.348165-04:30', NULL, true);
INSERT INTO si_silos VALUES (41, 5, 5, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:12:33.341886-04:30', NULL, true);
INSERT INTO si_silos VALUES (18, 4, 4, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:06:27.365003-04:30', NULL, true);
INSERT INTO si_silos VALUES (42, 5, 5, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:12:33.358622-04:30', NULL, true);
INSERT INTO si_silos VALUES (62, 6, 6, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:25:07.781128-04:30', NULL, true);
INSERT INTO si_silos VALUES (3, 2, 2, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:01:40.147421-04:30', NULL, true);
INSERT INTO si_silos VALUES (74, 7, 7, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:27:55-04:30', NULL, true);
INSERT INTO si_silos VALUES (9, 3, 3, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:05:32.080546-04:30', NULL, true);
INSERT INTO si_silos VALUES (19, 4, 4, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:06:27.381487-04:30', NULL, true);
INSERT INTO si_silos VALUES (43, 5, 5, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:12:33.375377-04:30', NULL, true);
INSERT INTO si_silos VALUES (63, 6, 6, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:25:07.797725-04:30', NULL, true);
INSERT INTO si_silos VALUES (10, 3, 3, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:05:32.097424-04:30', NULL, true);
INSERT INTO si_silos VALUES (20, 4, 4, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:06:27.39829-04:30', NULL, true);
INSERT INTO si_silos VALUES (44, 5, 5, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:12:33.39185-04:30', NULL, true);
INSERT INTO si_silos VALUES (64, 6, 6, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:25:07.814551-04:30', NULL, true);
INSERT INTO si_silos VALUES (11, 3, 3, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:05:32.114005-04:30', NULL, true);
INSERT INTO si_silos VALUES (21, 4, 4, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:06:27.414956-04:30', NULL, true);
INSERT INTO si_silos VALUES (45, 5, 5, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:12:33.408492-04:30', NULL, true);
INSERT INTO si_silos VALUES (65, 6, 6, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:25:07.831087-04:30', NULL, true);
INSERT INTO si_silos VALUES (12, 3, 3, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:05:32.130658-04:30', NULL, true);
INSERT INTO si_silos VALUES (22, 4, 4, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:06:27.431423-04:30', NULL, true);
INSERT INTO si_silos VALUES (46, 5, 5, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:12:33.425069-04:30', NULL, true);
INSERT INTO si_silos VALUES (66, 6, 6, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:25:07.847859-04:30', NULL, true);
INSERT INTO si_silos VALUES (13, 3, 3, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:05:32.147097-04:30', NULL, true);
INSERT INTO si_silos VALUES (23, 4, 4, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:06:27.448256-04:30', NULL, true);
INSERT INTO si_silos VALUES (47, 5, 5, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:12:33.442001-04:30', NULL, true);
INSERT INTO si_silos VALUES (67, 6, 6, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:25:07.864434-04:30', NULL, true);
INSERT INTO si_silos VALUES (14, 3, 3, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:05:32.164022-04:30', NULL, true);
INSERT INTO si_silos VALUES (24, 4, 4, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:06:27.464898-04:30', NULL, true);
INSERT INTO si_silos VALUES (48, 5, 5, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:12:33.458509-04:30', NULL, true);
INSERT INTO si_silos VALUES (68, 6, 6, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:25:07.880988-04:30', NULL, true);
INSERT INTO si_silos VALUES (15, 3, 3, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:05:32.180592-04:30', NULL, true);
INSERT INTO si_silos VALUES (25, 4, 4, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:06:27.481472-04:30', NULL, true);
INSERT INTO si_silos VALUES (49, 5, 5, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:12:33.475215-04:30', NULL, true);
INSERT INTO si_silos VALUES (69, 6, 6, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:25:07.897561-04:30', NULL, true);
INSERT INTO si_silos VALUES (16, 3, 3, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:05:32.197159-04:30', NULL, true);
INSERT INTO si_silos VALUES (26, 4, 4, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:06:27.498121-04:30', NULL, true);
INSERT INTO si_silos VALUES (50, 5, 5, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:12:33.491855-04:30', NULL, true);
INSERT INTO si_silos VALUES (70, 6, 6, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:25:07.914479-04:30', NULL, true);
INSERT INTO si_silos VALUES (27, 4, 4, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:06:27.514982-04:30', NULL, true);
INSERT INTO si_silos VALUES (51, 5, 5, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:12:33.508602-04:30', NULL, true);
INSERT INTO si_silos VALUES (71, 6, 6, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:25:07.931073-04:30', NULL, true);
INSERT INTO si_silos VALUES (28, 4, 4, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:06:27.531417-04:30', NULL, true);
INSERT INTO si_silos VALUES (52, 5, 5, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:12:33.525128-04:30', NULL, true);
INSERT INTO si_silos VALUES (72, 6, 6, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:25:07.947754-04:30', NULL, true);
INSERT INTO si_silos VALUES (31, 4, 4, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:06:27.585406-04:30', NULL, true);
INSERT INTO si_silos VALUES (55, 5, 5, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:12:33.575171-04:30', NULL, true);
INSERT INTO si_silos VALUES (32, 4, 4, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:06:27.598079-04:30', NULL, true);
INSERT INTO si_silos VALUES (56, 5, 5, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:12:33.59178-04:30', NULL, true);
INSERT INTO si_silos VALUES (33, 4, 4, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:06:27.614882-04:30', NULL, true);
INSERT INTO si_silos VALUES (57, 5, 5, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:12:33.60849-04:30', NULL, true);
INSERT INTO si_silos VALUES (34, 4, 4, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:06:27.631368-04:30', NULL, true);
INSERT INTO si_silos VALUES (58, 5, 5, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:12:33.625125-04:30', NULL, true);
INSERT INTO si_silos VALUES (35, 4, 4, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:06:27.64816-04:30', NULL, true);
INSERT INTO si_silos VALUES (59, 5, 5, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:12:33.64196-04:30', NULL, true);
INSERT INTO si_silos VALUES (36, 4, 4, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:06:27.664683-04:30', NULL, true);
INSERT INTO si_silos VALUES (60, 5, 5, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:12:33.658508-04:30', NULL, true);
INSERT INTO si_silos VALUES (37, 4, 4, 'SILO 21', 'MODULO A', 21, 1000, NULL, 'A ', '2012-02-13 11:06:27.681424-04:30', NULL, true);
INSERT INTO si_silos VALUES (38, 4, 4, 'SILO 22', 'MODULO A', 22, 1000, NULL, 'A ', '2012-02-13 11:06:27.698087-04:30', NULL, true);
INSERT INTO si_silos VALUES (39, 4, 4, 'SILO 23', 'MODULO A', 23, 1000, NULL, 'A ', '2012-02-13 11:06:27.714699-04:30', NULL, true);
INSERT INTO si_silos VALUES (40, 4, 4, 'SILO 24', 'MODULO A', 24, 1000, NULL, 'A ', '2012-02-13 11:06:27.731507-04:30', NULL, true);
INSERT INTO si_silos VALUES (61, 6, 6, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:25:07.764398-04:30', NULL, true);
INSERT INTO si_silos VALUES (73, 7, 7, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:27:38-04:30', NULL, true);
INSERT INTO si_silos VALUES (4, 2, 2, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:01:40.164032-04:30', NULL, true);
INSERT INTO si_silos VALUES (2, 2, 2, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:01:40.130888-04:30', '2012-02-19 19:46:46.671-04:30', true);
INSERT INTO si_silos VALUES (5, 2, 2, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:01:40.180896-04:30', NULL, true);
INSERT INTO si_silos VALUES (6, 2, 2, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:01:40.197353-04:30', '2012-05-03 14:47:10.601082-04:30', true);
INSERT INTO si_silos VALUES (30, 4, 4, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:06:27.565593-04:30', NULL, true);
INSERT INTO si_silos VALUES (54, 5, 5, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:12:33.561376-04:30', NULL, true);
INSERT INTO si_silos VALUES (77, 8, 8, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:35:00.481-04:30', NULL, true);
INSERT INTO si_silos VALUES (76, 8, 8, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:35:00.478-04:30', NULL, true);
INSERT INTO si_silos VALUES (75, 8, 8, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:35:00.46-04:30', NULL, true);
INSERT INTO si_silos VALUES (83, 9, 9, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:39:25.175-04:30', NULL, true);
INSERT INTO si_silos VALUES (84, 9, 9, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:39:25.182-04:30', NULL, true);
INSERT INTO si_silos VALUES (85, 9, 9, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:39:25.185-04:30', NULL, true);


--
-- TOC entry 2579 (class 0 OID 39590)
-- Dependencies: 263
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_tolcarom VALUES (5, 2, 'Romana 1', 1, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, '192.168.56.89:9600');
INSERT INTO si_tolcarom VALUES (6, 2, 'Romana 2', 2, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, '192.168.56.89:9601');
INSERT INTO si_tolcarom VALUES (1, 2, 'Tolva 1', 1, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (2, 2, 'Tolva 2', 2, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (3, 2, 'Carril 1', 1, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (4, 2, 'Carril 2', 2, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (7, 3, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (8, 3, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (9, 3, 'Carril 1', 1, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (10, 3, 'Carril 2', 2, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (11, 3, 'Romana 1', 1, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (12, 3, 'Romana 2', 2, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (13, 4, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (14, 4, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (15, 4, 'Carril 1', 1, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (16, 4, 'Carril 2', 2, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (19, 5, 'Tolva 1', 1, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (20, 5, 'Tolva 2', 2, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (21, 5, 'Carril 1', 1, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (22, 5, 'Carril 2', 2, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (23, 5, 'Romana 1', 1, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (24, 5, 'Romana 2', 2, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (25, 6, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (26, 6, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (27, 6, 'Carril 1', 1, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (28, 6, 'Carril 2', 2, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (29, 6, 'Romana 1', 1, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (30, 6, 'Romana 2', 2, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (31, 7, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (32, 7, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (33, 7, 'Carril 1', 1, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (34, 7, 'Carril 2', 2, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (35, 7, 'Romana 1', 1, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (36, 7, 'Romana 2', 2, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (37, 8, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (38, 8, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (39, 8, 'Carril 1', 1, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (40, 8, 'Carril 2', 2, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (41, 8, 'Romana 1', 1, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (42, 8, 'Romana 2', 2, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (43, 9, 'Tolva 1', 1, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (44, 9, 'Tolva 2', 2, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (45, 9, 'Carril 1', 1, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (46, 9, 'Carril 2', 2, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (47, 9, 'Romana 1', 1, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (48, 9, 'Romana 2', 2, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);


--
-- TOC entry 2580 (class 0 OID 39596)
-- Dependencies: 264
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_transporte VALUES (1, 2, NULL, 'ASOTRAMACHAQ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:56:38.350798-04:30', NULL);


--
-- TOC entry 2581 (class 0 OID 39606)
-- Dependencies: 267
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL);
INSERT INTO si_usuarios VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-05-03 13:26:22.155497-04:30');
INSERT INTO si_usuarios VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JUANTABORDA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 0, NULL, '2012-04-18 15:58:22.135194-04:30');
INSERT INTO si_usuarios VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, 'JUANCARRIZALEZ@AGROPATRIA.CO.VE', '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'JESUSRODRIGUEZ@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-05-04 10:32:26.015077-04:30');
INSERT INTO si_usuarios VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'JOSEPELUZZO@AGROPATRIA.CO.VE', '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, '2012-05-06 23:20:39.624-04:30');
INSERT INTO si_usuarios VALUES (5, 'MARIELY', 'CORONADO', '16538158', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 0, NULL, '2012-05-06 22:39:11.292-04:30');


--
-- TOC entry 2582 (class 0 OID 39617)
-- Dependencies: 269
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (6, 6, 2, 8, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');
INSERT INTO si_usuarios_perfiles VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (5, 5, 2, 2, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 3, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');


--
-- TOC entry 2583 (class 0 OID 39621)
-- Dependencies: 270
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos VALUES (1, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:53:45.757646-04:30', NULL);
INSERT INTO si_vehiculos VALUES (3, 'ASD-ASH', 'AZUL', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:58:04.663656-04:30', NULL);
INSERT INTO si_vehiculos VALUES (4, 'ASD-ASG', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:58:43.589592-04:30', NULL);
INSERT INTO si_vehiculos VALUES (5, '18LABAS', 'FORD', NULL, NULL, NULL, NULL, '14LABS', '2012-04-18 15:56:47.128604-04:30', NULL);
INSERT INTO si_vehiculos VALUES (6, 'DFG-GFD', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-20 07:45:47.285401-04:30', NULL);
INSERT INTO si_vehiculos VALUES (2, 'ASD-ASE', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-18 14:54:47.40262-04:30', NULL);
INSERT INTO si_vehiculos VALUES (7, 'TYU-TYU', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-23 14:20:39.026996-04:30', NULL);
INSERT INTO si_vehiculos VALUES (8, 'IOYTYUR', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-04-23 14:21:48.824864-04:30', NULL);
INSERT INTO si_vehiculos VALUES (9, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, '123-123', '2012-04-29 19:20:15.965-04:30', NULL);
INSERT INTO si_vehiculos VALUES (10, 'TYG-SDF', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:25:21.751-04:30', NULL);
INSERT INTO si_vehiculos VALUES (11, 'DFG-SDF', 'CHEVROLET', NULL, NULL, NULL, NULL, NULL, '2012-04-29 20:32:39.489-04:30', NULL);
INSERT INTO si_vehiculos VALUES (12, 'DFG-DFG', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:14:22.310566-04:30', NULL);
INSERT INTO si_vehiculos VALUES (13, 'FGH-DFGH', NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 10:34:12.974384-04:30', NULL);
INSERT INTO si_vehiculos VALUES (14, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-04 10:46:21.988047-04:30', NULL);
INSERT INTO si_vehiculos VALUES (15, 'ASD-ASD', 'FORD', NULL, NULL, NULL, NULL, '123-123', '2012-05-07 00:27:33.587-04:30', NULL);
INSERT INTO si_vehiculos VALUES (16, 'ASD-ASE', 'MACK', NULL, NULL, NULL, NULL, NULL, '2012-05-07 00:28:45.32-04:30', NULL);


--
-- TOC entry 2315 (class 2606 OID 39656)
-- Dependencies: 175 175
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2361 (class 2606 OID 39658)
-- Dependencies: 220 220
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2303 (class 2606 OID 39660)
-- Dependencies: 164 164
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2309 (class 2606 OID 39662)
-- Dependencies: 167 167
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2311 (class 2606 OID 39664)
-- Dependencies: 169 169
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2305 (class 2606 OID 39666)
-- Dependencies: 166 166 166
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2307 (class 2606 OID 39668)
-- Dependencies: 166 166
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2313 (class 2606 OID 39670)
-- Dependencies: 173 173
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 39672)
-- Dependencies: 176 176
-- Name: si_asociacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociacion
    ADD CONSTRAINT si_asociacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2319 (class 2606 OID 39674)
-- Dependencies: 179 179
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2321 (class 2606 OID 39676)
-- Dependencies: 181 181
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2323 (class 2606 OID 39678)
-- Dependencies: 183 183
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2325 (class 2606 OID 39680)
-- Dependencies: 185 185
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2327 (class 2606 OID 39682)
-- Dependencies: 186 186
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2329 (class 2606 OID 39684)
-- Dependencies: 189 189
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2331 (class 2606 OID 39686)
-- Dependencies: 191 191
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2333 (class 2606 OID 39690)
-- Dependencies: 193 193 193 193
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2335 (class 2606 OID 39692)
-- Dependencies: 193 193
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2337 (class 2606 OID 39694)
-- Dependencies: 195 195
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2339 (class 2606 OID 39696)
-- Dependencies: 197 197
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2341 (class 2606 OID 39698)
-- Dependencies: 200 200
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2343 (class 2606 OID 39700)
-- Dependencies: 201 201
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2345 (class 2606 OID 39702)
-- Dependencies: 204 204
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2347 (class 2606 OID 39704)
-- Dependencies: 205 205
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2349 (class 2606 OID 39706)
-- Dependencies: 208 208
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2351 (class 2606 OID 39708)
-- Dependencies: 210 210
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2353 (class 2606 OID 39710)
-- Dependencies: 211 211
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2355 (class 2606 OID 39712)
-- Dependencies: 213 213
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2357 (class 2606 OID 39714)
-- Dependencies: 215 215
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2359 (class 2606 OID 39716)
-- Dependencies: 216 216
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2363 (class 2606 OID 39718)
-- Dependencies: 222 222
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2365 (class 2606 OID 39720)
-- Dependencies: 224 224
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2367 (class 2606 OID 39722)
-- Dependencies: 225 225 225
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2369 (class 2606 OID 39724)
-- Dependencies: 227 227
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2373 (class 2606 OID 39726)
-- Dependencies: 230 230
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2371 (class 2606 OID 39728)
-- Dependencies: 229 229
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2375 (class 2606 OID 39730)
-- Dependencies: 233 233
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2377 (class 2606 OID 39732)
-- Dependencies: 235 235
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2379 (class 2606 OID 39734)
-- Dependencies: 237 237
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2381 (class 2606 OID 39736)
-- Dependencies: 239 239
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2383 (class 2606 OID 39738)
-- Dependencies: 240 240
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2385 (class 2606 OID 39740)
-- Dependencies: 242 242
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2387 (class 2606 OID 39742)
-- Dependencies: 245 245
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2389 (class 2606 OID 39744)
-- Dependencies: 247 247
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2391 (class 2606 OID 39746)
-- Dependencies: 248 248
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2393 (class 2606 OID 39748)
-- Dependencies: 250 250
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2397 (class 2606 OID 39750)
-- Dependencies: 253 253
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2395 (class 2606 OID 39752)
-- Dependencies: 252 252
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2401 (class 2606 OID 39754)
-- Dependencies: 257 257
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2399 (class 2606 OID 39756)
-- Dependencies: 256 256
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2403 (class 2606 OID 39758)
-- Dependencies: 261 261
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2405 (class 2606 OID 39760)
-- Dependencies: 263 263
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2407 (class 2606 OID 39762)
-- Dependencies: 264 264
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2413 (class 2606 OID 39764)
-- Dependencies: 269 269
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2409 (class 2606 OID 39766)
-- Dependencies: 267 267
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2411 (class 2606 OID 39768)
-- Dependencies: 267 267
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2415 (class 2606 OID 39770)
-- Dependencies: 270 270
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2416 (class 2606 OID 39771)
-- Dependencies: 2324 164 185
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2417 (class 2606 OID 39776)
-- Dependencies: 210 2350 164
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2418 (class 2606 OID 39781)
-- Dependencies: 2368 227 164
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2419 (class 2606 OID 39786)
-- Dependencies: 164 2376 235
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2421 (class 2606 OID 39791)
-- Dependencies: 2306 167 166
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2422 (class 2606 OID 39796)
-- Dependencies: 185 167 2324
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2423 (class 2606 OID 39801)
-- Dependencies: 2306 166 169
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2424 (class 2606 OID 39806)
-- Dependencies: 2374 233 169
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2425 (class 2606 OID 39811)
-- Dependencies: 171 2306 166
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2426 (class 2606 OID 39816)
-- Dependencies: 171 233 2374
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2420 (class 2606 OID 39821)
-- Dependencies: 166 233 2374
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2427 (class 2606 OID 39826)
-- Dependencies: 173 166 2306
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2428 (class 2606 OID 39831)
-- Dependencies: 173 205 2346
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2429 (class 2606 OID 39836)
-- Dependencies: 173 252 2394
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2430 (class 2606 OID 39841)
-- Dependencies: 173 267 2408
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2431 (class 2606 OID 39846)
-- Dependencies: 181 164 2302
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2432 (class 2606 OID 39851)
-- Dependencies: 181 183 2322
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2433 (class 2606 OID 39856)
-- Dependencies: 181 267 2408
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2434 (class 2606 OID 39861)
-- Dependencies: 185 210 2350
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2435 (class 2606 OID 39866)
-- Dependencies: 185 227 2368
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2436 (class 2606 OID 39871)
-- Dependencies: 185 233 2374
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2437 (class 2606 OID 39876)
-- Dependencies: 185 235 2376
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2438 (class 2606 OID 39881)
-- Dependencies: 186 233 2374
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2439 (class 2606 OID 39886)
-- Dependencies: 189 233 2374
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2440 (class 2606 OID 39891)
-- Dependencies: 191 200 2340
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2441 (class 2606 OID 39896)
-- Dependencies: 191 247 2388
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2442 (class 2606 OID 39901)
-- Dependencies: 192 185 2324
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2443 (class 2606 OID 39906)
-- Dependencies: 192 191 2330
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2444 (class 2606 OID 39911)
-- Dependencies: 192 245 2386
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2445 (class 2606 OID 39916)
-- Dependencies: 193 191 2330
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2446 (class 2606 OID 39921)
-- Dependencies: 193 200 2340
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2447 (class 2606 OID 39926)
-- Dependencies: 193 261 2402
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2448 (class 2606 OID 39931)
-- Dependencies: 195 166 2306
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2449 (class 2606 OID 39936)
-- Dependencies: 195 185 2324
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2450 (class 2606 OID 39941)
-- Dependencies: 195 200 2340
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2451 (class 2606 OID 39946)
-- Dependencies: 252 195 2394
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2452 (class 2606 OID 39951)
-- Dependencies: 2408 195 267
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2453 (class 2606 OID 39956)
-- Dependencies: 195 2336 197
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2454 (class 2606 OID 39961)
-- Dependencies: 233 200 2374
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2455 (class 2606 OID 39966)
-- Dependencies: 166 2306 201
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2456 (class 2606 OID 39971)
-- Dependencies: 201 2324 185
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2457 (class 2606 OID 39976)
-- Dependencies: 2340 200 201
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2458 (class 2606 OID 39981)
-- Dependencies: 2340 200 204
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2459 (class 2606 OID 39986)
-- Dependencies: 204 233 2374
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2460 (class 2606 OID 39991)
-- Dependencies: 2324 205 185
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2461 (class 2606 OID 39996)
-- Dependencies: 189 205 2328
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2462 (class 2606 OID 40001)
-- Dependencies: 2340 200 205
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2463 (class 2606 OID 40006)
-- Dependencies: 2370 205 229
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2464 (class 2606 OID 40011)
-- Dependencies: 2392 205 250
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2465 (class 2606 OID 40016)
-- Dependencies: 205 261 2402
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2466 (class 2606 OID 40021)
-- Dependencies: 205 2406 264
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2467 (class 2606 OID 40026)
-- Dependencies: 267 205 2408
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2468 (class 2606 OID 40031)
-- Dependencies: 2414 205 270
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2469 (class 2606 OID 40036)
-- Dependencies: 233 208 2374
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2470 (class 2606 OID 40041)
-- Dependencies: 210 235 2376
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2471 (class 2606 OID 40046)
-- Dependencies: 211 210 2350
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2472 (class 2606 OID 40051)
-- Dependencies: 211 2368 227
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2473 (class 2606 OID 40056)
-- Dependencies: 211 233 2374
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2474 (class 2606 OID 40061)
-- Dependencies: 211 235 2376
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2475 (class 2606 OID 40066)
-- Dependencies: 211 2386 245
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2476 (class 2606 OID 40071)
-- Dependencies: 213 185 2324
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2477 (class 2606 OID 40076)
-- Dependencies: 213 200 2340
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2478 (class 2606 OID 40081)
-- Dependencies: 213 233 2374
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2479 (class 2606 OID 40086)
-- Dependencies: 215 267 2408
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2480 (class 2606 OID 40091)
-- Dependencies: 216 215 2356
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2481 (class 2606 OID 40096)
-- Dependencies: 222 220 2360
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2482 (class 2606 OID 40101)
-- Dependencies: 225 224 2364
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2483 (class 2606 OID 40106)
-- Dependencies: 225 267 2408
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2484 (class 2606 OID 40111)
-- Dependencies: 227 210 2350
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2489 (class 2606 OID 40116)
-- Dependencies: 230 229 2370
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2485 (class 2606 OID 40121)
-- Dependencies: 229 185 2324
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2486 (class 2606 OID 40126)
-- Dependencies: 229 189 2328
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2487 (class 2606 OID 40131)
-- Dependencies: 229 200 2340
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2488 (class 2606 OID 40136)
-- Dependencies: 229 250 2392
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2490 (class 2606 OID 40141)
-- Dependencies: 233 210 2350
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2491 (class 2606 OID 40146)
-- Dependencies: 233 227 2368
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2492 (class 2606 OID 40151)
-- Dependencies: 233 235 2376
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2493 (class 2606 OID 40156)
-- Dependencies: 240 233 2374
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2494 (class 2606 OID 40161)
-- Dependencies: 242 233 2374
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2495 (class 2606 OID 40166)
-- Dependencies: 245 210 2350
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2496 (class 2606 OID 40171)
-- Dependencies: 245 2368 227
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2497 (class 2606 OID 40176)
-- Dependencies: 233 2374 245
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2498 (class 2606 OID 40181)
-- Dependencies: 235 2376 245
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2499 (class 2606 OID 40186)
-- Dependencies: 2324 247 185
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2500 (class 2606 OID 40191)
-- Dependencies: 248 2350 210
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2501 (class 2606 OID 40196)
-- Dependencies: 248 227 2368
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2502 (class 2606 OID 40201)
-- Dependencies: 248 233 2374
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2503 (class 2606 OID 40206)
-- Dependencies: 248 235 2376
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2504 (class 2606 OID 40211)
-- Dependencies: 2324 250 185
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2505 (class 2606 OID 40216)
-- Dependencies: 250 2328 189
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2506 (class 2606 OID 40221)
-- Dependencies: 250 2350 210
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2507 (class 2606 OID 40226)
-- Dependencies: 250 227 2368
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2508 (class 2606 OID 40231)
-- Dependencies: 250 235 2376
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2516 (class 2606 OID 40236)
-- Dependencies: 185 2324 253
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2517 (class 2606 OID 40241)
-- Dependencies: 200 253 2340
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2518 (class 2606 OID 40246)
-- Dependencies: 2394 252 253
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2509 (class 2606 OID 40251)
-- Dependencies: 2324 185 252
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2510 (class 2606 OID 40256)
-- Dependencies: 252 2326 186
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2511 (class 2606 OID 40261)
-- Dependencies: 2330 252 191
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2512 (class 2606 OID 40266)
-- Dependencies: 2356 215 252
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2513 (class 2606 OID 40271)
-- Dependencies: 252 245 2386
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2514 (class 2606 OID 40276)
-- Dependencies: 252 261 2402
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2515 (class 2606 OID 40281)
-- Dependencies: 252 267 2408
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2519 (class 2606 OID 40286)
-- Dependencies: 2398 257 256
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2520 (class 2606 OID 40291)
-- Dependencies: 164 261 2302
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2521 (class 2606 OID 40296)
-- Dependencies: 261 2324 185
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2522 (class 2606 OID 40301)
-- Dependencies: 263 2324 185
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2523 (class 2606 OID 40306)
-- Dependencies: 2324 264 185
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2524 (class 2606 OID 40311)
-- Dependencies: 269 2302 164
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2525 (class 2606 OID 40316)
-- Dependencies: 269 2380 239
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2526 (class 2606 OID 40321)
-- Dependencies: 267 2408 269
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-07 01:16:16

--
-- PostgreSQL database dump complete
--

