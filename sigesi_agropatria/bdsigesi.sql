--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-05-20 23:50:22

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 270 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 270
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 282 (class 1255 OID 43948)
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
-- TOC entry 161 (class 1259 OID 43949)
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
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 43951)
-- Dependencies: 2196 6
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
-- TOC entry 163 (class 1259 OID 43958)
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
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 164 (class 1259 OID 43960)
-- Dependencies: 2197 2198 2199 6
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
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 165 (class 1259 OID 43966)
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
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 166 (class 1259 OID 43969)
-- Dependencies: 6 165
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
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 43971)
-- Dependencies: 2201 2202 2203 2204 2205 2206 6
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
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 168 (class 1259 OID 43980)
-- Dependencies: 167 6
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
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 728, true);


--
-- TOC entry 169 (class 1259 OID 43982)
-- Dependencies: 2208 6
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
-- TOC entry 170 (class 1259 OID 43986)
-- Dependencies: 6 169
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
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 43988)
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
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 172 (class 1259 OID 43991)
-- Dependencies: 6 171
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
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 672, true);


--
-- TOC entry 173 (class 1259 OID 43993)
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
-- TOC entry 174 (class 1259 OID 43999)
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
-- TOC entry 175 (class 1259 OID 44005)
-- Dependencies: 6 174
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
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_asociacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_asociacion_id_seq OWNED BY si_asociacion.id;


--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_asociacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociacion_id_seq', 1, false);


--
-- TOC entry 176 (class 1259 OID 44007)
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
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 44009)
-- Dependencies: 2212 6
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
-- TOC entry 178 (class 1259 OID 44016)
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
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 44018)
-- Dependencies: 2213 6
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
-- TOC entry 180 (class 1259 OID 44022)
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
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 44024)
-- Dependencies: 2214 2215 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 182 (class 1259 OID 44029)
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
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 183 (class 1259 OID 44031)
-- Dependencies: 2216 2217 2218 2219 2220 2221 2222 6
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
-- TOC entry 184 (class 1259 OID 44044)
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
-- TOC entry 185 (class 1259 OID 44047)
-- Dependencies: 184 6
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
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 35, true);


--
-- TOC entry 186 (class 1259 OID 44049)
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
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 13, true);


--
-- TOC entry 187 (class 1259 OID 44051)
-- Dependencies: 2224 6
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
-- TOC entry 188 (class 1259 OID 44058)
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
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 188
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 4, true);


--
-- TOC entry 189 (class 1259 OID 44060)
-- Dependencies: 2225 2226 2227 2228 2229 6
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
-- TOC entry 190 (class 1259 OID 44071)
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
-- TOC entry 191 (class 1259 OID 44074)
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
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 192 (class 1259 OID 44077)
-- Dependencies: 191 6
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
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 193 (class 1259 OID 44079)
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
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 193
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
-- TOC entry 194 (class 1259 OID 44085)
-- Dependencies: 193 6
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
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, true);


--
-- TOC entry 195 (class 1259 OID 44087)
-- Dependencies: 2232 6
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
-- TOC entry 196 (class 1259 OID 44091)
-- Dependencies: 6 195
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
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 2, true);


--
-- TOC entry 197 (class 1259 OID 44093)
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
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 198 (class 1259 OID 44095)
-- Dependencies: 2234 2235 2236 6
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
-- TOC entry 199 (class 1259 OID 44101)
-- Dependencies: 2237 2238 6
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
-- TOC entry 200 (class 1259 OID 44106)
-- Dependencies: 199 6
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
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 10, true);


--
-- TOC entry 201 (class 1259 OID 44108)
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
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 202 (class 1259 OID 44110)
-- Dependencies: 2240 6
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
-- TOC entry 203 (class 1259 OID 44114)
-- Dependencies: 2241 6
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
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 203
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
-- TOC entry 204 (class 1259 OID 44118)
-- Dependencies: 203 6
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
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 204
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 204
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 20, true);


--
-- TOC entry 205 (class 1259 OID 44120)
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
-- TOC entry 2623 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 206 (class 1259 OID 44122)
-- Dependencies: 2243 2244 6
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
-- TOC entry 207 (class 1259 OID 44127)
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
-- TOC entry 2624 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 208 (class 1259 OID 44129)
-- Dependencies: 2245 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 209 (class 1259 OID 44133)
-- Dependencies: 2246 6
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
-- TOC entry 210 (class 1259 OID 44140)
-- Dependencies: 209 6
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
-- TOC entry 2625 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 211 (class 1259 OID 44142)
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
-- TOC entry 212 (class 1259 OID 44148)
-- Dependencies: 6 211
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
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 48, true);


--
-- TOC entry 213 (class 1259 OID 44150)
-- Dependencies: 2249 2250 6
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
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 214 (class 1259 OID 44155)
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
-- TOC entry 215 (class 1259 OID 44158)
-- Dependencies: 6 214
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
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 6, true);


--
-- TOC entry 216 (class 1259 OID 44160)
-- Dependencies: 6 213
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
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 216
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 216
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 25, true);


--
-- TOC entry 217 (class 1259 OID 44162)
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
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 218 (class 1259 OID 44164)
-- Dependencies: 2253 6
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
-- TOC entry 219 (class 1259 OID 44168)
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
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 1668, true);


--
-- TOC entry 220 (class 1259 OID 44170)
-- Dependencies: 2254 6
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
-- TOC entry 221 (class 1259 OID 44177)
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
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 42, true);


--
-- TOC entry 222 (class 1259 OID 44179)
-- Dependencies: 2255 2256 6
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
-- TOC entry 223 (class 1259 OID 44184)
-- Dependencies: 2257 2258 2259 2260 6
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
-- TOC entry 224 (class 1259 OID 44191)
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
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 225 (class 1259 OID 44193)
-- Dependencies: 2261 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 44197)
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
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 19, true);


--
-- TOC entry 227 (class 1259 OID 44199)
-- Dependencies: 2262 2263 6
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
-- TOC entry 228 (class 1259 OID 44207)
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
-- TOC entry 229 (class 1259 OID 44210)
-- Dependencies: 6 228
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
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 1, true);


--
-- TOC entry 230 (class 1259 OID 44212)
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
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 231 (class 1259 OID 44214)
-- Dependencies: 2265 6
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
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 232 (class 1259 OID 44221)
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
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 233 (class 1259 OID 44223)
-- Dependencies: 2266 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 44227)
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
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 12, true);


--
-- TOC entry 235 (class 1259 OID 44229)
-- Dependencies: 2267 6
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
-- TOC entry 236 (class 1259 OID 44236)
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
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 9, true);


--
-- TOC entry 237 (class 1259 OID 44238)
-- Dependencies: 2268 6
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
-- TOC entry 238 (class 1259 OID 44242)
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
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 239 (class 1259 OID 44245)
-- Dependencies: 238 6
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
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 240 (class 1259 OID 44247)
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
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 241 (class 1259 OID 44250)
-- Dependencies: 240 6
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
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 242 (class 1259 OID 44252)
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
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 13, true);


--
-- TOC entry 243 (class 1259 OID 44254)
-- Dependencies: 2271 6
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
-- TOC entry 244 (class 1259 OID 44261)
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
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 244
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 5, true);


--
-- TOC entry 245 (class 1259 OID 44263)
-- Dependencies: 2272 6
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
-- TOC entry 246 (class 1259 OID 44270)
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
-- TOC entry 247 (class 1259 OID 44276)
-- Dependencies: 246 6
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
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 248 (class 1259 OID 44278)
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
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 249 (class 1259 OID 44284)
-- Dependencies: 6 248
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
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 249
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 249
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 4, true);


--
-- TOC entry 250 (class 1259 OID 44286)
-- Dependencies: 2275 2276 2277 2278 6
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
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 250
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
-- TOC entry 251 (class 1259 OID 44293)
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
-- TOC entry 252 (class 1259 OID 44296)
-- Dependencies: 6 251
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
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 252
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 252
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 253 (class 1259 OID 44298)
-- Dependencies: 6 250
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
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 253
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 253
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 25, true);


--
-- TOC entry 254 (class 1259 OID 44300)
-- Dependencies: 2281 6
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
-- TOC entry 255 (class 1259 OID 44307)
-- Dependencies: 2283 6
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
-- TOC entry 256 (class 1259 OID 44314)
-- Dependencies: 6 255
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
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 256
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 256
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 55, true);


--
-- TOC entry 257 (class 1259 OID 44316)
-- Dependencies: 6 254
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
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 257
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 257
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 60, true);


--
-- TOC entry 258 (class 1259 OID 44318)
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
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 258
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 259 (class 1259 OID 44320)
-- Dependencies: 2285 2286 6
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
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 260 (class 1259 OID 44328)
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
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 260
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 261 (class 1259 OID 44330)
-- Dependencies: 2287 2288 2289 6
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
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 262 (class 1259 OID 44336)
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
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 263 (class 1259 OID 44342)
-- Dependencies: 6 262
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
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 263
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 263
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 2, true);


--
-- TOC entry 264 (class 1259 OID 44344)
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
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 264
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 8, true);


--
-- TOC entry 265 (class 1259 OID 44346)
-- Dependencies: 2291 2292 2293 6
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
-- TOC entry 266 (class 1259 OID 44355)
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
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 266
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 8, true);


--
-- TOC entry 267 (class 1259 OID 44357)
-- Dependencies: 2294 6
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
-- TOC entry 268 (class 1259 OID 44361)
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
-- TOC entry 269 (class 1259 OID 44364)
-- Dependencies: 6 268
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
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 269
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 269
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 48, true);


--
-- TOC entry 2200 (class 2604 OID 44366)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 44367)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 44368)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2210 (class 2604 OID 44369)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 44370)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_asociacion ALTER COLUMN id SET DEFAULT nextval('si_asociacion_id_seq'::regclass);


--
-- TOC entry 2223 (class 2604 OID 44371)
-- Dependencies: 185 184
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2230 (class 2604 OID 44372)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2231 (class 2604 OID 44373)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 44374)
-- Dependencies: 196 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2239 (class 2604 OID 44375)
-- Dependencies: 200 199
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2242 (class 2604 OID 44376)
-- Dependencies: 204 203
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2247 (class 2604 OID 44377)
-- Dependencies: 210 209
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2248 (class 2604 OID 44378)
-- Dependencies: 212 211
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2251 (class 2604 OID 44379)
-- Dependencies: 216 213
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2252 (class 2604 OID 44380)
-- Dependencies: 215 214
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2264 (class 2604 OID 44381)
-- Dependencies: 229 228
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2269 (class 2604 OID 44382)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2270 (class 2604 OID 44383)
-- Dependencies: 241 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2273 (class 2604 OID 44384)
-- Dependencies: 247 246
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2274 (class 2604 OID 44385)
-- Dependencies: 249 248
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2279 (class 2604 OID 44386)
-- Dependencies: 253 250
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2280 (class 2604 OID 44387)
-- Dependencies: 252 251
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2282 (class 2604 OID 44388)
-- Dependencies: 257 254
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2284 (class 2604 OID 44389)
-- Dependencies: 256 255
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 44390)
-- Dependencies: 263 262
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2295 (class 2604 OID 44391)
-- Dependencies: 269 268
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2521 (class 0 OID 43951)
-- Dependencies: 162
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
-- TOC entry 2522 (class 0 OID 43960)
-- Dependencies: 164
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
-- TOC entry 2523 (class 0 OID 43966)
-- Dependencies: 165
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2524 (class 0 OID 43971)
-- Dependencies: 167
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, NULL, 231, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, NULL, 232, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, NULL, 233, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, NULL, 234, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, NULL, 235, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, NULL, 236, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, NULL, 237, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, NULL, 238, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, NULL, 239, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, NULL, 240, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, NULL, 241, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, NULL, 242, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, NULL, 243, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, NULL, 244, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, NULL, 245, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, NULL, 246, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, NULL, 247, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, NULL, 248, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, NULL, 249, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, NULL, 250, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, NULL, 251, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, NULL, 252, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, NULL, 253, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, NULL, 254, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, NULL, 255, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, NULL, 256, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, NULL, 257, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, NULL, 258, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, NULL, 259, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, NULL, 260, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, NULL, 261, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, NULL, 262, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, NULL, 263, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, NULL, 264, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, NULL, 265, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, NULL, 266, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, NULL, 267, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, NULL, 268, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, NULL, 269, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, NULL, 270, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, NULL, 271, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, NULL, 272, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, NULL, 273, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, NULL, 274, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, NULL, 275, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, NULL, 276, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, NULL, 277, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, NULL, 278, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, NULL, 279, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, NULL, 280, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, NULL, 281, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, NULL, 282, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, NULL, 283, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, NULL, 284, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, NULL, 285, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, NULL, 286, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, NULL, 287, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, NULL, 288, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, NULL, 289, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, NULL, 290, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, NULL, 291, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, NULL, 292, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, NULL, 293, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, NULL, 294, 0.000, 5.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, NULL, 295, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, NULL, 296, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, NULL, 297, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, NULL, 298, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, NULL, 299, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, NULL, 300, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, NULL, 301, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, NULL, 302, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, NULL, 303, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, NULL, 304, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, NULL, 305, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, NULL, 306, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, NULL, 307, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, NULL, 308, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, NULL, 309, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, NULL, 310, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, NULL, 311, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, NULL, 312, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, NULL, 313, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, NULL, 314, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, NULL, 315, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, NULL, 316, 10.000, 26.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, NULL, 317, 0.000, 7.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, NULL, 318, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, NULL, 319, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, NULL, 320, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, NULL, 321, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, NULL, 322, 0.000, 17.000, 0.000, 17.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, NULL, 323, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, NULL, 324, 0.000, 30.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, NULL, 325, 0.000, 20.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, NULL, 326, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, NULL, 327, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, NULL, 328, 715.000, 0.790, 715.000, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, NULL, 329, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, NULL, 330, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, NULL, 331, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, NULL, 332, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, NULL, 333, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, NULL, 334, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, NULL, 335, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, NULL, 336, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, NULL, 337, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, NULL, 338, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, NULL, 339, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, NULL, 340, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, NULL, 341, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, NULL, 342, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, NULL, 343, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, NULL, 344, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, NULL, 345, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, NULL, 346, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, NULL, 347, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, NULL, 348, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, NULL, 349, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, NULL, 350, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, NULL, 351, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, NULL, 352, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, NULL, 353, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, NULL, 354, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, NULL, 355, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, NULL, 356, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, NULL, 357, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, NULL, 358, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, NULL, 359, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, NULL, 360, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, NULL, 361, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, NULL, 362, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, NULL, 363, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, NULL, 364, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, NULL, 365, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, NULL, 366, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, NULL, 367, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, NULL, 368, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, NULL, 369, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, NULL, 370, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, NULL, 371, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, NULL, 372, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, NULL, 373, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, NULL, 374, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, NULL, 375, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, NULL, 376, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, NULL, 377, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, NULL, 378, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, NULL, 379, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, NULL, 380, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, NULL, 381, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, NULL, 382, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, NULL, 383, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, NULL, 384, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, NULL, 385, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, NULL, 386, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, NULL, 387, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, NULL, 388, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, NULL, 389, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, NULL, 390, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, NULL, 391, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, NULL, 392, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, NULL, 393, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, NULL, 394, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, NULL, 395, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, NULL, 396, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, NULL, 397, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, NULL, 398, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, NULL, 399, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, NULL, 400, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, NULL, 401, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, NULL, 402, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, NULL, 403, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, NULL, 404, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, NULL, 405, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, NULL, 406, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, NULL, 407, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, NULL, 408, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, NULL, 409, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, NULL, 410, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, NULL, 411, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, NULL, 412, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, NULL, 413, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, NULL, 414, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, NULL, 415, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, NULL, 416, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, NULL, 417, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, NULL, 418, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, NULL, 419, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, NULL, 420, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, NULL, 421, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, NULL, 422, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, NULL, 423, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, NULL, 424, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, NULL, 425, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, NULL, 426, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, NULL, 427, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, NULL, 428, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, NULL, 429, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, NULL, 430, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, NULL, 431, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, NULL, 432, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, NULL, 433, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, NULL, 434, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, NULL, 435, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, NULL, 436, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, NULL, 437, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, NULL, 438, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, NULL, 439, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, NULL, 440, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, NULL, 441, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, NULL, 442, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, NULL, 443, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, NULL, 444, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, NULL, 445, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, NULL, 446, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, NULL, 447, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, NULL, 448, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, NULL, 449, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, NULL, 450, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, NULL, 451, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, NULL, 452, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, NULL, 453, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, NULL, 454, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, NULL, 455, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, NULL, 456, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, NULL, 457, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, NULL, 458, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, NULL, 459, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, NULL, 460, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, NULL, 461, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, NULL, 462, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, NULL, 463, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, NULL, 464, 715.000, 0.790, 715.000, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, NULL, 465, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, NULL, 466, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, NULL, 467, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, NULL, 468, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, NULL, 469, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, NULL, 470, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, NULL, 471, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, NULL, 472, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, NULL, 473, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, NULL, 474, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, NULL, 475, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, NULL, 476, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, NULL, 477, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, NULL, 478, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, NULL, 479, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, NULL, 480, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, NULL, 481, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, NULL, 482, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, NULL, 483, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, NULL, 484, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, NULL, 485, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, NULL, 486, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, NULL, 487, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, NULL, 488, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, NULL, 489, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, NULL, 490, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, NULL, 491, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, NULL, 492, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, NULL, 493, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, NULL, 494, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, NULL, 495, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, NULL, 496, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, NULL, 497, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, NULL, 498, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, NULL, 499, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, NULL, 500, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, NULL, 501, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, NULL, 502, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, NULL, 503, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, NULL, 504, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, NULL, 505, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, NULL, 506, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, NULL, 507, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, NULL, 508, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, NULL, 509, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, NULL, 510, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, NULL, 511, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, NULL, 512, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, NULL, 513, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, NULL, 514, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, NULL, 515, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, NULL, 516, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, NULL, 517, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, NULL, 518, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, NULL, 519, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, NULL, 520, 12.000, 24.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, NULL, 521, 0.000, 10.000, 0.000, 5.100, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, NULL, 522, 0.000, 2.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, NULL, 523, 0.000, 1.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, NULL, 524, 0.600, 0.760, 0.600, 0.760, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, NULL, 525, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, NULL, 526, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, NULL, 527, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, NULL, 528, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, NULL, 529, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, NULL, 530, 11.000, 22.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, NULL, 531, 0.000, 11.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, NULL, 532, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, NULL, 533, 0.000, 8.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, NULL, 534, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, NULL, 535, 0.680, 0.730, 0.680, 0.730, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, NULL, 536, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, NULL, 537, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, NULL, 538, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, NULL, 539, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, NULL, 540, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, NULL, 541, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, NULL, 542, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, NULL, 543, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, NULL, 544, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, NULL, 545, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, NULL, 546, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, NULL, 547, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, NULL, 548, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, NULL, 549, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, NULL, 550, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, NULL, 551, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, NULL, 552, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, NULL, 553, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, NULL, 554, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, NULL, 555, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, NULL, 556, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, NULL, 557, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, NULL, 558, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, NULL, 559, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, NULL, 560, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, NULL, 561, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, NULL, 562, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, NULL, 563, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, NULL, 564, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, NULL, 565, 10.000, 26.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, NULL, 566, 0.000, 7.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, NULL, 567, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, NULL, 568, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, NULL, 569, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, NULL, 570, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, NULL, 571, 0.000, 17.000, 0.000, 17.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, NULL, 572, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, NULL, 573, 0.000, 30.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, NULL, 574, 0.000, 20.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, NULL, 575, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, NULL, 576, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, NULL, 577, 715.000, 0.790, 715.000, 0.760, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, NULL, 578, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, NULL, 579, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, NULL, 580, 12.500, 15.000, 12.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, NULL, 581, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, NULL, 582, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, NULL, 583, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, NULL, 584, 0.000, 4.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, NULL, 585, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, NULL, 586, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, NULL, 587, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, NULL, 588, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, NULL, 589, 0.000, 26.000, 0.000, 26.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, NULL, 590, 0.000, 3.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, NULL, 591, 12.000, 24.000, 12.000, 24.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, NULL, 592, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, NULL, 593, 0.000, 40.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, NULL, 594, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, NULL, 595, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, NULL, 596, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, NULL, 597, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, NULL, 598, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, NULL, 599, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, NULL, 600, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, NULL, 601, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, NULL, 602, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, NULL, 603, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, NULL, 604, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, NULL, 605, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, NULL, 606, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, NULL, 607, 40.000, 60.000, 45.000, 60.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, NULL, 608, 65.000, 70.000, 65.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, NULL, 609, 25.000, 39.000, 30.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, NULL, 610, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, NULL, 611, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, NULL, 612, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, NULL, 613, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, NULL, 614, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, NULL, 615, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, NULL, 616, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, NULL, 617, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, NULL, 618, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, NULL, 619, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, NULL, 620, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, NULL, 621, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, NULL, 622, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, NULL, 623, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, NULL, 624, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, NULL, 625, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, NULL, 626, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, NULL, 627, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, NULL, 628, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, NULL, 629, 8.000, 19.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, NULL, 630, 0.000, 8.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, NULL, 631, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, NULL, 632, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, NULL, 633, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, NULL, 634, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, NULL, 635, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, NULL, 636, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, NULL, 637, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, NULL, 638, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, NULL, 639, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, NULL, 640, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, NULL, 641, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, NULL, 642, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, NULL, 643, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, NULL, 644, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, NULL, 645, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, NULL, 646, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, NULL, 647, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, NULL, 648, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, NULL, 649, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, NULL, 650, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, NULL, 651, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, NULL, 652, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, NULL, 653, 8.000, 19.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, NULL, 654, 0.000, 8.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, NULL, 655, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, NULL, 656, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, NULL, 657, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, NULL, 658, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, NULL, 659, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, NULL, 660, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, NULL, 661, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, NULL, 662, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, NULL, 663, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, NULL, 664, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, NULL, 665, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, NULL, 666, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, NULL, 667, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, NULL, 668, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, NULL, 669, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, NULL, 670, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, NULL, 671, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, NULL, 672, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, NULL, 673, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, NULL, 674, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, NULL, 675, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, NULL, 676, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, NULL, 677, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, NULL, 678, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, NULL, 679, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, NULL, 680, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, NULL, 681, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, NULL, 682, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, NULL, 683, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, NULL, 684, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, NULL, 685, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, NULL, 686, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, NULL, 687, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, NULL, 688, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, NULL, 689, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, NULL, 690, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, NULL, 691, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, NULL, 692, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, NULL, 693, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, NULL, 694, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, NULL, 695, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, NULL, 696, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, NULL, 697, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, NULL, 698, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, NULL, 699, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, NULL, 700, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, NULL, 701, 12.000, 30.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, NULL, 702, 0.000, 5.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, NULL, 703, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, NULL, 704, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, NULL, 705, 0.000, 3.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, NULL, 706, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, NULL, 707, 0.000, 11.000, 0.000, 60.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, NULL, 708, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, NULL, 709, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, NULL, 710, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, NULL, 711, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, NULL, 712, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, NULL, 713, 715.000, 0.790, 715.000, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, NULL, 714, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, NULL, 715, 0.000, 20.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, NULL, 716, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, NULL, 717, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, NULL, 718, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, NULL, 719, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, NULL, 720, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, NULL, 721, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, NULL, 722, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, NULL, 723, 0.000, 0.000, 0.000, 0.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, NULL, 724, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, NULL, 725, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, NULL, 726, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, NULL, 727, 1.000, 2.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, NULL, 728, 0.000, 1.000, 0.000, 1.000, 4);


--
-- TOC entry 2525 (class 0 OID 43982)
-- Dependencies: 169
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2526 (class 0 OID 43988)
-- Dependencies: 171
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado VALUES (413, 11, NULL, 1, 5, '13.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (414, 11, NULL, 2, 5, '4.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (415, 11, NULL, 3, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (416, 11, NULL, 4, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (417, 11, NULL, 5, 5, '8.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (418, 11, NULL, 6, 5, '6.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (419, 11, NULL, 7, 5, '6.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (420, 11, NULL, 8, 5, '5.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (421, 11, NULL, 9, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (422, 11, NULL, 10, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (423, 11, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (424, 11, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (425, 11, NULL, 13, 5, '0.714', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (426, 11, NULL, 14, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (427, 11, NULL, 15, 5, '15.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (428, 11, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (429, 11, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (430, 11, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (431, 11, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (432, 11, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (433, 11, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (434, 10, NULL, 1, 5, '12.000', '20.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (435, 10, NULL, 2, 5, '0.000', '4.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (436, 10, NULL, 3, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (437, 10, NULL, 4, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (438, 10, NULL, 5, 5, '0.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (439, 10, NULL, 6, 5, '0.000', '9.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (440, 10, NULL, 7, 5, '0.000', '8.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (441, 10, NULL, 8, 5, '0.000', '5.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (442, 10, NULL, 9, 5, '0.000', '14.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (443, 10, NULL, 10, 5, '0.000', '0.100', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (444, 10, NULL, 11, 5, '0.000', '10.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (445, 10, NULL, 12, 5, '0.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (446, 10, NULL, 13, 5, '0.710', '0.790', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (447, 10, NULL, 14, 5, '0.000', '0.100', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (448, 10, NULL, 15, 5, '0.000', '19.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (449, 10, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (450, 10, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (451, 10, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (452, 10, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (453, 10, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (454, 10, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (455, 13, NULL, 1, 5, '15.000', '13.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (456, 13, NULL, 2, 5, '9.000', '8.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (457, 13, NULL, 7, 5, '1.000', '2.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (458, 13, NULL, 8, 5, '1.000', '1.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (459, 13, NULL, 13, 5, '0.600', '0.700', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (460, 13, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (461, 13, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (462, 13, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (463, 13, NULL, 24, 5, 'B', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (464, 13, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (465, 12, NULL, 1, 5, '13.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (466, 12, NULL, 2, 5, '8.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (467, 12, NULL, 7, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (468, 12, NULL, 8, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (469, 12, NULL, 13, 5, '0.700', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (470, 12, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (471, 12, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (472, 12, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (473, 12, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (474, 12, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (475, 14, NULL, 1, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (476, 14, NULL, 2, 5, '0.500', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (477, 14, NULL, 13, 5, '0.340', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (478, 14, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (479, 14, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (480, 14, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (481, 14, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (482, 15, NULL, 1, 5, '10.000', '11.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (483, 15, NULL, 2, 5, '5.000', '6.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (484, 15, NULL, 13, 5, '0.400', '0.400', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (485, 15, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (486, 15, NULL, 22, 5, 'B', 'B', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (487, 15, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (488, 15, NULL, 38, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (489, 10, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (490, 10, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (491, 10, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (492, 10, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (493, 10, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (494, 10, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (495, 11, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (496, 11, NULL, 21, 5, 'C', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (497, 11, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (498, 11, NULL, 23, 5, 'D', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (499, 11, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (500, 11, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (501, 12, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (502, 12, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (503, 12, NULL, 24, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (504, 12, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (505, 13, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (506, 13, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (507, 13, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (508, 13, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (509, 15, NULL, 1, 5, '10.000', '12.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (510, 15, NULL, 2, 5, '5.000', '7.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (511, 15, NULL, 13, 5, '0.400', '0.350', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (512, 15, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (513, 15, NULL, 22, 5, 'B', 'C', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (514, 15, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (515, 15, NULL, 38, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (516, 14, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (517, 14, NULL, 2, 5, '0.500', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (518, 14, NULL, 13, 5, '0.400', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (519, 14, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (520, 14, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (521, 14, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (522, 14, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (523, 16, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (524, 16, NULL, 2, 5, '4.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (525, 16, NULL, 3, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (526, 16, NULL, 4, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (527, 16, NULL, 5, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (528, 16, NULL, 6, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (529, 16, NULL, 7, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (530, 16, NULL, 8, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (531, 16, NULL, 9, 5, '14.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (532, 16, NULL, 10, 5, '0.100', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (533, 16, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (534, 16, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (535, 16, NULL, 13, 5, '0.730', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (536, 16, NULL, 14, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (537, 16, NULL, 15, 5, '19.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (538, 16, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (539, 16, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (540, 16, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (541, 16, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (542, 16, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (543, 16, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (544, 17, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (545, 17, NULL, 2, 5, '5.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (546, 17, NULL, 3, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (547, 17, NULL, 4, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (548, 17, NULL, 5, 5, '3.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (549, 17, NULL, 6, 5, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (550, 17, NULL, 7, 5, '11.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (551, 17, NULL, 8, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (552, 17, NULL, 9, 5, '15.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (553, 17, NULL, 10, 5, '0.200', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (554, 17, NULL, 11, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (555, 17, NULL, 12, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (556, 17, NULL, 13, 5, '0.710', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (557, 17, NULL, 14, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (558, 17, NULL, 15, 5, '19.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (559, 17, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (560, 17, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (561, 17, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (562, 17, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (563, 17, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (564, 17, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (565, 18, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (566, 18, NULL, 2, 5, '10.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (567, 18, NULL, 7, 5, '2.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (568, 18, NULL, 8, 5, '1.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (569, 18, NULL, 13, 5, '0.600', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (570, 18, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (571, 18, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (572, 18, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (573, 18, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (574, 18, NULL, 20, 5, 'SI', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (575, 20, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (576, 20, NULL, 2, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (577, 20, NULL, 13, 5, '0.335', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (578, 20, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (579, 20, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (580, 20, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (581, 20, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (582, 20, NULL, 1, 5, '9.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (583, 20, NULL, 2, 5, '7.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (584, 20, NULL, 13, 5, '0.335', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (585, 20, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (586, 20, NULL, 22, 5, 'B', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (587, 20, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (588, 20, NULL, 38, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (589, 21, NULL, 1, 5, '12.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (590, 21, NULL, 2, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (591, 21, NULL, 3, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (592, 21, NULL, 4, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (593, 21, NULL, 5, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (594, 21, NULL, 6, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (595, 21, NULL, 7, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (596, 21, NULL, 8, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (597, 21, NULL, 9, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (598, 21, NULL, 10, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (599, 21, NULL, 11, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (600, 21, NULL, 12, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (601, 21, NULL, 13, 5, '0.710', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (602, 21, NULL, 14, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (603, 21, NULL, 15, 5, '0.000', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (604, 21, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (605, 21, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (606, 21, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (607, 21, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (608, 21, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (609, 21, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (610, 21, NULL, 19, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (611, 21, NULL, 21, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (612, 21, NULL, 22, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (613, 21, NULL, 23, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (614, 21, NULL, 24, 5, 'A', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (615, 21, NULL, 20, 5, 'NO', '', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (616, 22, NULL, 1, 5, '12.000', '13.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (617, 22, NULL, 2, 5, '2.000', '3.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (618, 22, NULL, 3, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (619, 22, NULL, 4, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (620, 22, NULL, 5, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (621, 22, NULL, 6, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (622, 22, NULL, 7, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (623, 22, NULL, 8, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (624, 22, NULL, 9, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (625, 22, NULL, 10, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (626, 22, NULL, 11, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (627, 22, NULL, 12, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (628, 22, NULL, 13, 5, '0.710', '0.710', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (629, 22, NULL, 14, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (630, 22, NULL, 15, 5, '0.000', '0.000', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (631, 22, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (632, 22, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (633, 22, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (634, 22, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (635, 22, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (636, 22, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (637, 22, NULL, 19, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (638, 22, NULL, 21, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (639, 22, NULL, 22, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (640, 22, NULL, 23, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (641, 22, NULL, 24, 5, 'A', 'A', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (642, 22, NULL, 20, 5, 'NO', 'NO', '', 2, 'R');
INSERT INTO si_analisis_resultado VALUES (643, NULL, 8, 1, 5, '7.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado VALUES (644, NULL, 8, 2, 5, '6.000', '', '', 2, 'D');
INSERT INTO si_analisis_resultado VALUES (645, NULL, 8, 13, 5, '0.335', '', '', 2, 'D');
INSERT INTO si_analisis_resultado VALUES (646, 25, NULL, 1, 2, '12.000', '13.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (647, 25, NULL, 2, 2, '2.000', '3.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (648, 25, NULL, 3, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (649, 25, NULL, 4, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (650, 25, NULL, 5, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (651, 25, NULL, 6, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (652, 25, NULL, 7, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (653, 25, NULL, 8, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (654, 25, NULL, 9, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (655, 25, NULL, 10, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (656, 25, NULL, 11, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (657, 25, NULL, 12, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (658, 25, NULL, 13, 2, '0.710', '0.710', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (659, 25, NULL, 14, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (660, 25, NULL, 15, 2, '0.000', '0.000', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (661, 25, NULL, 19, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (662, 25, NULL, 21, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (663, 25, NULL, 22, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (664, 25, NULL, 23, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (665, 25, NULL, 24, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (666, 25, NULL, 20, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (667, 25, NULL, 19, 2, '', '', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (668, 25, NULL, 21, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (669, 25, NULL, 22, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (670, 25, NULL, 23, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (671, 25, NULL, 24, 2, 'A', 'A', '', 3, 'R');
INSERT INTO si_analisis_resultado VALUES (672, 25, NULL, 20, 2, '', '', '', 3, 'R');


--
-- TOC entry 2527 (class 0 OID 43993)
-- Dependencies: 173
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2528 (class 0 OID 43999)
-- Dependencies: 174
-- Data for Name: si_asociacion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2529 (class 0 OID 44009)
-- Dependencies: 177
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2530 (class 0 OID 44018)
-- Dependencies: 179
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2531 (class 0 OID 44024)
-- Dependencies: 181
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2532 (class 0 OID 44031)
-- Dependencies: 183
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
-- TOC entry 2533 (class 0 OID 44044)
-- Dependencies: 184
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_choferes VALUES (14, 1, NULL, NULL, NULL, 'V9668397', 'JESUS SILVA', NULL, NULL, NULL, true, '2012-05-11 10:54:45.201067-04:30', NULL);
INSERT INTO si_choferes VALUES (26, 1, NULL, NULL, NULL, 'V10852147', 'ASD ASD', NULL, NULL, NULL, true, '2012-05-15 16:34:05.29467-04:30', NULL);
INSERT INTO si_choferes VALUES (27, 1, 1, 2, 2, 'V23123123', 'NUEVO CHOFER', NULL, NULL, NULL, true, '2012-05-15 16:36:16.531554-04:30', NULL);
INSERT INTO si_choferes VALUES (13, 1, NULL, NULL, NULL, 'V16538158', 'JOSE TORRES', NULL, NULL, NULL, true, '2012-05-11 10:53:44.289468-04:30', '2012-05-17 15:29:42.034425-04:30');


--
-- TOC entry 2534 (class 0 OID 44051)
-- Dependencies: 187
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cliente VALUES (4, 1, NULL, 'V16538158', NULL, 'JOSE FUENTES', NULL, NULL, NULL, '2  ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 6, 64, NULL, true, '2012-05-14 16:19:58.764204-04:30', NULL);


--
-- TOC entry 2535 (class 0 OID 44060)
-- Dependencies: 189
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha VALUES (1, 2, 1, 'INVIERNO 2012', 220000, NULL, 45000, '2012-09-03', '2013-02-04', true, '2012-04-18 15:25:47.739787-04:30', NULL, '2012011');
INSERT INTO si_cosecha VALUES (2, 3, 3, 'COSECHA 1 SORGO', NULL, NULL, NULL, '2012-04-29', '2012-07-29', true, '2012-04-29 22:43:28.902-04:30', NULL, '2012031');
INSERT INTO si_cosecha VALUES (3, 4, 12, 'COSECHA 1 GIR', NULL, NULL, NULL, NULL, NULL, true, '2012-05-07 00:19:27.451-04:30', NULL, '2012121');
INSERT INTO si_cosecha VALUES (4, 5, 1, 'C-MAIZ SABANA', NULL, NULL, NULL, NULL, NULL, true, '2012-05-17 15:08:09.679749-04:30', NULL, '2012011');


--
-- TOC entry 2536 (class 0 OID 44071)
-- Dependencies: 190
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 4, 7, '2012-05-11 10:19:08.669778-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 4, 6, '2012-05-11 10:19:08.686443-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 2, 5, 8, '2012-05-11 10:19:23.312938-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 3, 0, 10, '2012-05-11 10:19:33.635405-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 3, 0, 9, '2012-05-11 10:19:33.652063-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (1, 2, 11, 0, 0, '2012-05-11 10:19:40.19555-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (2, 2, 2, 12, 11, '2012-05-11 10:19:52.365962-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (2, 2, 2, 12, 10, '2012-05-11 10:19:52.382516-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (2, 2, 3, 4, 6, '2012-05-11 10:20:02.430589-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (2, 2, 7, 0, 0, '2012-05-11 10:20:12.012387-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 10, 0, 0, '2012-05-11 10:20:19.879273-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 2, 13, 9, '2012-05-11 10:20:40.249582-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 2, 13, 7, '2012-05-11 10:20:40.26608-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 8, 0, 11, '2012-05-11 10:21:23.146523-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (3, 2, 8, 0, 6, '2012-05-11 10:21:23.163078-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (4, 3, 2, 4, 7, '2012-05-17 15:28:01.669213-04:30', NULL);
INSERT INTO si_cosecha_productor VALUES (4, 3, 2, 4, 6, '2012-05-17 15:28:01.685993-04:30', NULL);


--
-- TOC entry 2537 (class 0 OID 44074)
-- Dependencies: 191
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2538 (class 0 OID 44079)
-- Dependencies: 193
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cuarentena VALUES (1, 2, 20, 3, 18, 5, 'R ', '2012-05-11 00:00:00-04:30', '2012-05-11 00:00:00-04:30', NULL, 'C ', 1, 2, 8, NULL, '08:05 AM  ', '2012-05-13 00:00:00-04:30', '12:05 AM  ', '2', '2012-05-11 15:46:40.652736-04:30', '2012-05-14 08:05:27.437234-04:30', 'APROBADO POR MARIELY ', 'SE PROCEDE A CUARENTENA');


--
-- TOC entry 2539 (class 0 OID 44087)
-- Dependencies: 195
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cuarentena_plaga VALUES (1, 1, 1, 5);
INSERT INTO si_cuarentena_plaga VALUES (2, 1, 8, 40);


--
-- TOC entry 2540 (class 0 OID 44095)
-- Dependencies: 198
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
INSERT INTO si_cultivo VALUES (11, 1, '11', 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (15, 1, '15', 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (17, 1, '17', 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (24, 1, '97', 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (25, 1, '98', 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (18, 1, '68', 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true);
INSERT INTO si_cultivo VALUES (26, 1, '99', 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', '2012-05-03 15:13:02.029691-04:30', true);
INSERT INTO si_cultivo VALUES (1, 1, '01', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', '2012-05-10 13:37:19.05023-04:30', true);


--
-- TOC entry 2541 (class 0 OID 44101)
-- Dependencies: 199
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
-- TOC entry 2542 (class 0 OID 44110)
-- Dependencies: 202
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2543 (class 0 OID 44114)
-- Dependencies: 203
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_despacho VALUES (9, 2, 10, 8, 4, 26, 19, 5, 2, 4, 2, '2012-05-15 16:35:35.488808-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, NULL, NULL, NULL, '2012-05-15 16:35:35.488808-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho VALUES (10, 2, 10, 8, 4, 27, 42, 5, 2, 4, 2, '2012-05-15 16:36:32.504747-04:30', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 2, NULL, NULL, NULL, '2012-05-15 16:36:32.504747-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO si_despacho VALUES (8, 2, 10, 8, 4, 13, 38, 5, 2, 4, 2, '2012-05-14 16:31:42.218487-04:30', 1, '2012-05-14 16:34:45.869718-04:30', 12997, NULL, '2012-05-15 17:00:00.611296-04:30', 17940, NULL, 7, 6, NULL, NULL, NULL, '5', 1, NULL, 5, 5, '2012-05-14 16:31:42.218487-04:30', '2012-05-15 17:00:00.611296-04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2544 (class 0 OID 44122)
-- Dependencies: 206
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2545 (class 0 OID 44129)
-- Dependencies: 208
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
-- TOC entry 2546 (class 0 OID 44133)
-- Dependencies: 209
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2547 (class 0 OID 44142)
-- Dependencies: 211
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas VALUES (12, 1, 1, 12, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (4, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (5, 1, 1, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (1, 1, 1, NULL, '(PL1+PL2)', 'PL12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (7, 1, 1, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (8, 1, 1, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (9, 1, 1, 2, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H02', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (10, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I02', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (11, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I02', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (3, 1, 1, NULL, '((PL1+PL2)-(PV1+PV2))', 'PN', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (2, 1, 1, NULL, '(PV1+PV2)', 'PV12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (6, 1, 1, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (13, 1, 1, 12, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (14, 1, 1, 7, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (15, 1, 1, 7, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (16, 1, 1, 7, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (17, 1, 1, 7, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (18, 1, 1, 7, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (19, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I07', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (20, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I07', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (21, 1, 1, 7, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H07', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (22, 1, 1, 8, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (23, 1, 1, 8, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (24, 1, 1, 8, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (25, 1, 1, 8, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (26, 1, 1, 8, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 3, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (27, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I08', 3, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (28, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I08', 3, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (29, 1, 1, 8, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H08', 3, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (30, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (31, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I01', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (32, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (33, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I05', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (34, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (35, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I06', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (36, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (37, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (38, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (39, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I015', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (40, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (41, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I017', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (42, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (43, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I03', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (44, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (45, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I04', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (46, 1, 2, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (47, 1, 2, 11, '((((PL1+PL2)-(PV1+PV2))-PHUM)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (48, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);


--
-- TOC entry 2548 (class 0 OID 44150)
-- Dependencies: 213
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec VALUES (21, NULL, NULL, 5, 761312123, 15000, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 11:33:44.415664-04:30', NULL);
INSERT INTO si_guiarec VALUES (22, NULL, NULL, 5, 723897289, 123123, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 13:38:04.836066-04:30', NULL);
INSERT INTO si_guiarec VALUES (23, NULL, NULL, 5, 123412312, 123123, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 16:31:57.351332-04:30', NULL);
INSERT INTO si_guiarec VALUES (24, NULL, NULL, 5, 231231212, 12312, NULL, NULL, '2012-05-15 00:00:00-04:30', 'P', NULL, NULL, '2012-05-15 16:34:05.29467-04:30', NULL);
INSERT INTO si_guiarec VALUES (25, NULL, NULL, 2, 341234123, 15000, NULL, NULL, '2012-05-17 00:00:00-04:30', 'P', NULL, NULL, '2012-05-17 15:29:42.034425-04:30', NULL);
INSERT INTO si_guiarec VALUES (10, NULL, NULL, 5, 1, 2000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '1', '2012-05-11 10:53:44.289468-04:30', NULL);
INSERT INTO si_guiarec VALUES (11, NULL, NULL, 5, 2, 100, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, NULL, '2012-05-11 10:54:45.201067-04:30', NULL);
INSERT INTO si_guiarec VALUES (12, NULL, NULL, 5, 3, 1000, NULL, NULL, '2012-05-09 00:00:00-04:30', 'P', NULL, '2', '2012-05-11 10:58:07.51559-04:30', NULL);
INSERT INTO si_guiarec VALUES (13, NULL, NULL, 5, 4, 150, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '155', '2012-05-11 10:58:29.375606-04:30', NULL);
INSERT INTO si_guiarec VALUES (14, NULL, NULL, 5, 5, 130, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '156', '2012-05-11 11:01:04.877065-04:30', NULL);
INSERT INTO si_guiarec VALUES (15, NULL, NULL, 5, 6, 2000, NULL, NULL, '2012-05-16 00:00:00-04:30', 'P', NULL, '4578496', '2012-05-11 11:01:25.253897-04:30', NULL);
INSERT INTO si_guiarec VALUES (16, NULL, NULL, 5, 7, 2000, NULL, NULL, '2012-05-08 00:00:00-04:30', 'P', NULL, '25487', '2012-05-11 14:44:04.70865-04:30', NULL);
INSERT INTO si_guiarec VALUES (17, NULL, NULL, 5, 8, 1000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '123659', '2012-05-11 15:10:48.737671-04:30', NULL);
INSERT INTO si_guiarec VALUES (18, NULL, NULL, 5, 9, 2000, NULL, NULL, '2012-05-11 00:00:00-04:30', 'P', NULL, '65450', '2012-05-11 15:43:25.121714-04:30', NULL);
INSERT INTO si_guiarec VALUES (19, NULL, NULL, 5, 10, 2000, NULL, NULL, '2012-05-02 00:00:00-04:30', 'P', NULL, '15478', '2012-05-11 16:07:00.187586-04:30', NULL);
INSERT INTO si_guiarec VALUES (20, NULL, NULL, 5, 11, 2000, NULL, NULL, '2012-05-14 00:00:00-04:30', 'P', NULL, '489023', '2012-05-14 14:31:58.405515-04:30', NULL);


--
-- TOC entry 2549 (class 0 OID 44155)
-- Dependencies: 214
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det VALUES (4, 12, '48759           ', '2012-05-10 00:00:00-04:30', '');
INSERT INTO si_guiarec_det VALUES (5, 12, '1245            ', '2012-05-11 00:00:00-04:30', '');
INSERT INTO si_guiarec_det VALUES (6, 20, '254672          ', '2012-05-14 00:00:00-04:30', '');


--
-- TOC entry 2550 (class 0 OID 44164)
-- Dependencies: 218
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2551 (class 0 OID 44170)
-- Dependencies: 220
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas VALUES (1667, '2012-05-20', 202, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '613uodp69a891obtup37f5ni15', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'si_usuarios', 'Register No.0<br />conectado = 1<br />sesion = 613uodp69a891obtup37f5ni15<br />', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''613uodp69a891obtup37f5ni15''', '');
INSERT INTO si_log_consultas VALUES (1668, '2012-05-20', 102, 5, 'MARIELY CORONADO', 'N/A', 'ARAURE', '613uodp69a891obtup37f5ni15', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 12.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 12.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL                  WHERE id=''5'' AND sesion = ''613uodp69a891obtup37f5ni15'' ', '');


--
-- TOC entry 2552 (class 0 OID 44179)
-- Dependencies: 222
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
INSERT INTO si_menu VALUES (38, 'M_CuarentenaPendiente', 2, 'admin/cuarentena_pendiente_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (39, 'M_GerenteRecepcion', 3, 'reportes/gerente_recepcion.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (40, 'M_GerenteDespacho', 3, 'reportes/gerente_despacho.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (42, 'M_UtilitarioRecepciones', 4, 'admin/utilitario_recepcion_listado.php', true, 7, NULL, NULL);


--
-- TOC entry 2553 (class 0 OID 44184)
-- Dependencies: 223
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (2, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 4, 7, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (14, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (15, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (16, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 5, 0, 1, 0, 0);
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
INSERT INTO si_menu_usuario VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (21, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 3, 5, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (14, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (15, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (16, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (17, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (5, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (23, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 8, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 8, 0, 0, 0, 0);


--
-- TOC entry 2554 (class 0 OID 44193)
-- Dependencies: 225
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
-- TOC entry 2555 (class 0 OID 44199)
-- Dependencies: 227
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ordenes VALUES (8, 2, 4, 10, 56101201, '2012-05-11 00:00:00-04:30', NULL, 125000, NULL, 'N', NULL, '2012-05-14 16:26:49.478641-04:30', NULL, '56226695');


--
-- TOC entry 2556 (class 0 OID 44207)
-- Dependencies: 228
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2557 (class 0 OID 44214)
-- Dependencies: 231
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2558 (class 0 OID 44223)
-- Dependencies: 233
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'VENEZUELA');


--
-- TOC entry 2559 (class 0 OID 44229)
-- Dependencies: 235
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
INSERT INTO si_parametros VALUES (12, 'REFGUIA', 'MAT - SADA - INSAE', 'Referencias de Subguia', 1, '2012-03-01 00:00:00-04:30', NULL, NULL, NULL);


--
-- TOC entry 2560 (class 0 OID 44238)
-- Dependencies: 237
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
-- TOC entry 2561 (class 0 OID 44242)
-- Dependencies: 238
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
-- TOC entry 2562 (class 0 OID 44247)
-- Dependencies: 240
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2563 (class 0 OID 44254)
-- Dependencies: 243
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor VALUES (7, 1, NULL, 'V16269763', NULL, 'PRODUCTOR 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:16.897952-04:30', NULL);
INSERT INTO si_productor VALUES (8, 1, NULL, 'V15610226', NULL, 'PRODUCTOR 3', NULL, NULL, NULL, NULL, NULL, 1, 14, 160, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 16:12:42.012754-04:30', NULL);
INSERT INTO si_productor VALUES (6, 1, NULL, 'V17247200', NULL, 'PRODUCTOR 1', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:18:00.31368-04:30', NULL);
INSERT INTO si_productor VALUES (10, 1, NULL, 'V12789456', NULL, 'PRODUCTOR 5', NULL, NULL, NULL, NULL, NULL, 1, 16, 203, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 11:06:26.497-04:30', NULL);
INSERT INTO si_productor VALUES (11, 1, NULL, 'V10123456', NULL, 'PRODUCTOR 6', NULL, NULL, NULL, NULL, NULL, 1, 5, 43, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 14:24:04.48-04:30', NULL);
INSERT INTO si_productor VALUES (9, 1, NULL, 'V14785236', NULL, 'PRODUCTOR 4', NULL, NULL, NULL, NULL, NULL, 1, 24, 319, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 10:24:44.811-04:30', NULL);
INSERT INTO si_productor VALUES (2, 1, NULL, 'G00000000', NULL, 'BANCO AGRICOLA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:25.998447-04:30', NULL);
INSERT INTO si_productor VALUES (3, 1, NULL, 'G00000001', NULL, 'FONDAS', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:16:56.023047-04:30', NULL);
INSERT INTO si_productor VALUES (4, 1, NULL, 'G00123456', NULL, 'CONSEJO COMUNAL 1', NULL, NULL, NULL, NULL, NULL, 1, 8, 91, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:22.105165-04:30', NULL);
INSERT INTO si_productor VALUES (5, 1, NULL, 'G00456789', NULL, 'CONSEJO COMUNAL 2', NULL, NULL, NULL, NULL, NULL, 1, 5, 40, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-27 15:17:41.603699-04:30', NULL);
INSERT INTO si_productor VALUES (12, 1, NULL, 'G00789456', NULL, 'CONSEJO COMUNAL 3', NULL, NULL, NULL, NULL, NULL, 1, 5, 51, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-29 22:58:46.545-04:30', NULL);
INSERT INTO si_productor VALUES (13, 1, NULL, 'G00123456', NULL, 'CONSEJO COMUNAL 4', NULL, NULL, NULL, NULL, NULL, 1, 12, 134, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-04-30 08:34:16.836892-04:30', '2012-05-03 15:20:51.557328-04:30');


--
-- TOC entry 2564 (class 0 OID 44263)
-- Dependencies: 245
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa VALUES (2, 2, 'INVIERNO 2012', 'INVIERNO 2012', '2012-04-18 15:25:47.739787-04:30', NULL, true, '201201', '2012-09-03', '2013-09-03', 1);
INSERT INTO si_programa VALUES (3, 2, 'PROGRAMA SORGO', NULL, '2012-04-29 22:43:28.902-04:30', '2012-05-03 15:03:26.829691-04:30', true, '201203', '2012-04-29', '2013-04-29', 3);
INSERT INTO si_programa VALUES (4, 2, 'PROGRAMA GIRASOL', NULL, '2012-05-07 00:19:27.451-04:30', NULL, true, '201212', '2012-05-07', '2013-05-07', 12);
INSERT INTO si_programa VALUES (5, 3, 'MAIZ SABANA DE P', NULL, '2012-05-17 15:08:09.679749-04:30', NULL, true, '201201', '2012-05-17', '2013-05-17', 1);


--
-- TOC entry 2565 (class 0 OID 44270)
-- Dependencies: 246
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2566 (class 0 OID 44278)
-- Dependencies: 248
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_punto_entrega VALUES (4, 4, NULL, NULL, NULL, NULL, 'CHAGUARAMAS', NULL, NULL, NULL, '2012-05-14 16:31:42.218487', NULL, NULL);


--
-- TOC entry 2567 (class 0 OID 44286)
-- Dependencies: 250
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion VALUES (10, 2, 1, NULL, 2, 10, 5, 1, '2012-05-11 10:53:44.289468-04:30', 1, '2012-05-11 13:44:49.351478-04:30', 30509, 34221, NULL, '2012-05-11 14:45:43.175191-04:30', 20475, 20146, 12, 0, 1096, 460, '2012-05-11 10:53:44.289468-04:30', '2012-05-11 14:45:43.175191', 2, 18, 13, 5, 5, NULL, 22553, 0, 9, 4, 7);
INSERT INTO si_recepcion VALUES (17, 2, 1, NULL, 3, 17, 5, 8, '2012-05-11 15:10:48.737671-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:10:48.737671-04:30', '2012-05-11 15:31:05.736435', 1, 28, 13, NULL, NULL, NULL, NULL, 0, 3, NULL, 10);
INSERT INTO si_recepcion VALUES (18, 2, 2, NULL, 2, 18, 5, 9, '2012-05-11 15:43:25.121714-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:43:25.121714-04:30', '2012-05-11 16:00:33.746091', 1, 30, 13, NULL, NULL, NULL, NULL, 1, 11, 12, 10);
INSERT INTO si_recepcion VALUES (19, 2, 3, NULL, 10, 19, 5, 10, '2012-05-11 16:07:00.187586-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 16:07:00.187586-04:30', NULL, 1, 32, 13, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL);
INSERT INTO si_recepcion VALUES (21, 2, 1, NULL, 2, 21, 5, 1, '2012-05-15 11:33:44.415664-04:30', 1, '2012-05-15 11:34:28.810589-04:30', 41822, NULL, NULL, '2012-05-15 11:34:55.810439-04:30', 19292, NULL, 12, 0, NULL, NULL, '2012-05-15 11:33:44.415664-04:30', '2012-05-15 11:34:55.810439', 1, 26, 13, 5, 5, NULL, 22530, 0, 9, 5, 8);
INSERT INTO si_recepcion VALUES (23, 2, 1, NULL, 2, 23, 5, 3, '2012-05-15 16:31:57.351332-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-15 16:31:57.351332-04:30', NULL, 2, 17, 13, NULL, NULL, NULL, NULL, 0, 1, 4, 7);
INSERT INTO si_recepcion VALUES (24, 2, 2, NULL, 2, 24, 5, 4, '2012-05-15 16:34:05.29467-04:30', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-15 16:34:05.29467-04:30', NULL, 1, 41, 26, NULL, NULL, NULL, NULL, 0, 1, 12, 11);
INSERT INTO si_recepcion VALUES (22, 2, 1, NULL, 2, 22, 5, 2, '2012-05-15 13:38:04.836066-04:30', 1, '2012-05-15 13:38:51.100021-04:30', 22717, 25973, NULL, '2012-05-15 13:39:25.011505-04:30', 10411, 12000, 12, 2, 149, 653, '2012-05-15 13:38:04.836066-04:30', '2012-05-15 13:39:25.011505', 2, 17, 13, 5, 5, NULL, 25476, 0, 9, 4, 7);
INSERT INTO si_recepcion VALUES (11, 2, 1, NULL, 2, 11, 5, 2, '2012-05-11 10:54:45.201067-04:30', 1, '2012-05-11 13:45:01.60294-04:30', 40755, NULL, NULL, '2012-05-11 14:46:07.66782-04:30', 33856, NULL, 13, 4, 78, 273, '2012-05-11 10:54:45.201067-04:30', '2012-05-11 14:46:07.66782', 1, 19, 14, 6, 6, NULL, 6548, 0, 9, 4, 6);
INSERT INTO si_recepcion VALUES (25, 3, 4, NULL, 2, 25, 2, 1, '2012-05-17 15:29:42.034425-04:30', 1, '2012-05-17 15:36:13.724105-04:30', 32930, 24871, NULL, '2012-05-17 15:37:48.697534-04:30', 22609, 13402, 12, 2, 124, 542, '2012-05-17 15:29:42.034425-04:30', '2012-05-17 15:37:48.697534', 2, 18, 13, 11, 11, NULL, 21125, 0, 9, 4, 6);
INSERT INTO si_recepcion VALUES (12, 2, 2, NULL, 3, 12, 5, 3, '2012-05-11 10:58:07.51559-04:30', 2, '2012-05-11 13:45:09.151378-04:30', 20687, NULL, NULL, '2012-05-11 14:47:00.024669-04:30', 9694, NULL, 13, 8, 125, 869, '2012-05-11 10:58:07.51559-04:30', '2012-05-11 14:47:00.024669', 1, 21, 13, 5, 6, NULL, 9999, 0, 9, 4, 6);
INSERT INTO si_recepcion VALUES (13, 2, 2, NULL, 7, 13, 5, 4, '2012-05-11 10:58:29.375606-04:30', 1, '2012-05-11 13:45:15.221446-04:30', 43136, 35716, NULL, '2012-05-11 14:47:55.727065-04:30', 19682, 7820, 15, 9, 1167, 4266, '2012-05-11 10:58:29.375606-04:30', '2012-05-11 14:47:55.727065', 2, 19, 14, 5, 5, NULL, 45917, 0, 9, NULL, NULL);
INSERT INTO si_recepcion VALUES (14, 2, 3, NULL, 8, 14, 5, 5, '2012-05-11 11:01:04.877065-04:30', 2, '2012-05-11 13:45:20.226478-04:30', 33083, NULL, NULL, '2012-05-11 14:48:15.588618-04:30', 23826, NULL, 9, 0.5, NULL, NULL, '2012-05-11 11:01:04.877065-04:30', '2012-05-11 14:48:15.588618', 1, 19, 14, 6, 6, 9257, 9257, 0, 9, NULL, 11);
INSERT INTO si_recepcion VALUES (16, 2, 1, NULL, 2, 16, 5, 7, '2012-05-11 14:44:04.70865-04:30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-11 14:44:04.70865-04:30', '2012-05-11 15:01:33.393072', 1, 26, 13, NULL, NULL, NULL, NULL, 0, 3, 4, 6);
INSERT INTO si_recepcion VALUES (20, 2, 3, NULL, 10, 20, 5, 1, '2012-05-14 14:31:58.405515-04:30', 1, '2012-05-14 14:46:58.250043-04:30', 49026, NULL, NULL, '2012-05-20 23:19:51.987-04:30', 33820, NULL, 9, 7, NULL, NULL, '2012-05-14 14:31:58.405515-04:30', '2012-05-20 23:19:51.987', 1, 34, 13, 5, 5, 14273, 14902, 0, 9, NULL, NULL);
INSERT INTO si_recepcion VALUES (15, 2, 3, NULL, 10, 15, 5, 6, '2012-05-11 11:01:25.253897-04:30', 1, '2012-05-20 23:33:06.356-04:30', 30366, 31307, NULL, '2012-05-20 23:41:32.098-04:30', 25804, 13572, 10, 5, NULL, NULL, '2012-05-11 11:01:25.253897-04:30', '2012-05-20 23:41:32.098', 2, 21, 13, 5, 5, 20690, 21628, 0, 9, NULL, NULL);


--
-- TOC entry 2568 (class 0 OID 44293)
-- Dependencies: 251
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2569 (class 0 OID 44300)
-- Dependencies: 254
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
INSERT INTO si_recursos VALUES (55, 'Boleta Virtual', 'admin', 'boleta_virtual.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (56, 'Cuarentenas Pendientes', 'admin', 'cuarentena_pendiente_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (58, 'Consulta Gerente Despachos', 'reportes', 'gerente_despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (57, 'Consulta Gerente Recepcion', 'reportes', 'gerente_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (59, 'Reporte de Actividad', 'reportes', 'reporte_actividad.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (60, 'Utilitario Recepciones', 'admin', 'utilitario_recepcion_listado.php', 1, '2012-05-11 00:00:00-04:30', NULL);


--
-- TOC entry 2570 (class 0 OID 44307)
-- Dependencies: 255
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
INSERT INTO si_recursos_etiquetas VALUES (38, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (37, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (41, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (42, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (53, 1, 'M_GerenteRecepcion', 'Gerente Recepci&oacute;n', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (43, 1, 'M_Chofer', 'Chofer', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (54, 1, 'M_GerenteDespacho', 'Gerente Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (52, 1, 'M_CuarentenaPendiente', 'Cuarentenas Pendientes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (50, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (49, 1, 'M_Auditoria', 'Auditoria del Sistema', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (48, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (44, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (45, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (46, 1, 'M_Ordenes', 'Ordenes de Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (47, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (55, 1, 'M_UtilitarioRecepciones', 'Utilitario Recepciones', 1, '2012-05-11 00:00:00-04:30', NULL);


--
-- TOC entry 2571 (class 0 OID 44320)
-- Dependencies: 259
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
-- TOC entry 2572 (class 0 OID 44330)
-- Dependencies: 261
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

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
INSERT INTO si_tolcarom VALUES (6, 2, 'Romana 2', 2, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'http://192.168.56.89:9600');
INSERT INTO si_tolcarom VALUES (5, 2, 'Romana 1', 1, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'http://192.168.56.89:9601');


--
-- TOC entry 2573 (class 0 OID 44336)
-- Dependencies: 262
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_transporte VALUES (2, 2, NULL, 'ASOTRAMACHA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:31:42.218487-04:30', NULL);


--
-- TOC entry 2574 (class 0 OID 44346)
-- Dependencies: 265
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (6, 'YELITZA', 'GUZMAN', '13000000', NULL, 'F', 'YGUZMAN', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'YELITZAGUZMAN@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:48.981154-04:30', true, 0, NULL, NULL);
INSERT INTO si_usuarios VALUES (7, 'JUAN', 'CARRIZALEZ', '15650075', NULL, 'M', 'JUANMC', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', NULL, NULL, 'JUANCARRIZALEZ@AGROPATRIA.CO.VE', '2012-04-25 09:24:19.641208-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JESUSSILVA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:47:52.212876-04:30', true, 0, NULL, '2012-05-17 15:28:30.825707-04:30');
INSERT INTO si_usuarios VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'MARACAY', NULL, 'JUANTABORDA@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 0, NULL, '2012-05-16 16:25:17.241602-04:30');
INSERT INTO si_usuarios VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'CAGUA', NULL, 'JESUSRODRIGUEZ@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-05-15 15:47:23.514447-04:30');
INSERT INTO si_usuarios VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'Maracay', NULL, 'JOSEPELUZZO@AGROPATRIA.CO.VE', '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, '2012-05-18 15:57:41.5049-04:30');
INSERT INTO si_usuarios VALUES (8, 'LEIDY', 'SIFONTES', '123456', NULL, 'F', 'LSIFONTES', 'E34A43F70CD2570DC01BAAF1667C2FC91BBAACE6', NULL, NULL, NULL, '2012-05-18 15:54:34.262069-04:30', NULL, true, 1, 'cvnlol2bupjj73drgeo34hc4r5', '2012-05-18 15:58:12.225277-04:30');
INSERT INTO si_usuarios VALUES (5, 'MARIELY', 'CORONADO', '16538158', NULL, 'F', 'MCORONADO', '40BD001563085FC35165329EA1FF5C5ECBDBBEEF', 'LA VILLA', NULL, 'MARIELYCORONADO@AGROPATRIA.CO.VE', '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:37.144713-04:30', true, 0, NULL, '2012-05-20 23:05:11.882-04:30');


--
-- TOC entry 2575 (class 0 OID 44357)
-- Dependencies: 267
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles VALUES (3, 3, 2, 5, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles VALUES (4, 4, 2, 7, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (6, 6, 2, 8, '2012-02-13 00:00:00-04:30', '2012-03-16 11:42:49.010567-04:30');
INSERT INTO si_usuarios_perfiles VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (7, 7, 4, 2, '2012-04-25 09:24:19.69473-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (5, 5, 2, 2, '2012-02-13 16:15:23.105604-04:30', '2012-03-16 11:42:37.16459-04:30');
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 3, 2, '2012-02-13 11:34:56.142546-04:30', '2012-03-16 11:47:52.227861-04:30');
INSERT INTO si_usuarios_perfiles VALUES (8, 8, 4, 4, '2012-05-18 15:54:34.286197-04:30', NULL);


--
-- TOC entry 2576 (class 0 OID 44361)
-- Dependencies: 268
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos VALUES (17, '125MNJU', 'FORD', 'GRIS', 5000, NULL, NULL, NULL, '2012-05-11 10:52:24.547132-04:30', NULL);
INSERT INTO si_vehiculos VALUES (19, 'DAW06R', 'FIAT', 'ROJO', 120, NULL, NULL, NULL, '2012-05-11 10:54:26.103604-04:30', NULL);
INSERT INTO si_vehiculos VALUES (21, '147ÑLOJ', 'CHEVROLET', 'NEGRO', 3000, NULL, NULL, NULL, '2012-05-11 10:57:50.343025-04:30', NULL);
INSERT INTO si_vehiculos VALUES (26, '125MJH', 'FORD', 'AZUL', 2000, NULL, NULL, NULL, '2012-05-11 14:42:53.356585-04:30', NULL);
INSERT INTO si_vehiculos VALUES (28, '1453689', 'TOYOTA', NULL, NULL, NULL, NULL, NULL, '2012-05-11 15:10:27.540816-04:30', NULL);
INSERT INTO si_vehiculos VALUES (30, 'HGYTJUY', 'VOLVO', 'BLANCO', NULL, NULL, NULL, NULL, '2012-05-11 15:43:16.293216-04:30', NULL);
INSERT INTO si_vehiculos VALUES (32, '1458796', 'VOLVO', NULL, NULL, NULL, NULL, NULL, '2012-05-11 16:06:53.14973-04:30', NULL);
INSERT INTO si_vehiculos VALUES (18, '125MNJ', 'FORD', NULL, NULL, NULL, NULL, '147LKJU', '2012-05-11 10:53:44.289468-04:30', NULL);
INSERT INTO si_vehiculos VALUES (34, '2458KJU', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 14:31:31.07605-04:30', NULL);
INSERT INTO si_vehiculos VALUES (36, '254ñLK', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:15:53.890513-04:30', NULL);
INSERT INTO si_vehiculos VALUES (37, '123BNM', 'FORD', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:27:57.722339-04:30', NULL);
INSERT INTO si_vehiculos VALUES (38, '123MNB', 'VOVLO', NULL, NULL, NULL, NULL, NULL, '2012-05-14 16:29:29.815347-04:30', NULL);
INSERT INTO si_vehiculos VALUES (41, '123123', 'NUEVA', 'NUEVO', NULL, NULL, NULL, NULL, '2012-05-15 16:33:58.872515-04:30', NULL);
INSERT INTO si_vehiculos VALUES (42, 'QWEQWE', 'QWEQWE', 'QWE', NULL, NULL, NULL, NULL, '2012-05-15 16:36:26.862256-04:30', NULL);


--
-- TOC entry 2309 (class 2606 OID 44393)
-- Dependencies: 173 173
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2355 (class 2606 OID 44395)
-- Dependencies: 218 218
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2297 (class 2606 OID 44397)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2303 (class 2606 OID 44399)
-- Dependencies: 165 165
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2305 (class 2606 OID 44401)
-- Dependencies: 167 167
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 44403)
-- Dependencies: 164 164 164
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2301 (class 2606 OID 44405)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2307 (class 2606 OID 44407)
-- Dependencies: 171 171
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2311 (class 2606 OID 44409)
-- Dependencies: 174 174
-- Name: si_asociacion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociacion
    ADD CONSTRAINT si_asociacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2313 (class 2606 OID 44411)
-- Dependencies: 177 177
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2315 (class 2606 OID 44413)
-- Dependencies: 179 179
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 44415)
-- Dependencies: 181 181
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2319 (class 2606 OID 44417)
-- Dependencies: 183 183
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2321 (class 2606 OID 44419)
-- Dependencies: 184 184
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2323 (class 2606 OID 44421)
-- Dependencies: 187 187
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2325 (class 2606 OID 44423)
-- Dependencies: 189 189
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2327 (class 2606 OID 44425)
-- Dependencies: 191 191 191 191
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2329 (class 2606 OID 44427)
-- Dependencies: 191 191
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2331 (class 2606 OID 44429)
-- Dependencies: 193 193
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2333 (class 2606 OID 44431)
-- Dependencies: 195 195
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2335 (class 2606 OID 44433)
-- Dependencies: 198 198
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2337 (class 2606 OID 44435)
-- Dependencies: 199 199
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2339 (class 2606 OID 44437)
-- Dependencies: 202 202
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2341 (class 2606 OID 44439)
-- Dependencies: 203 203
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2343 (class 2606 OID 44441)
-- Dependencies: 206 206
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2345 (class 2606 OID 44443)
-- Dependencies: 208 208
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2347 (class 2606 OID 44445)
-- Dependencies: 209 209
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2349 (class 2606 OID 44447)
-- Dependencies: 211 211
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2351 (class 2606 OID 44449)
-- Dependencies: 213 213
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2353 (class 2606 OID 44451)
-- Dependencies: 214 214
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2357 (class 2606 OID 44453)
-- Dependencies: 220 220
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2359 (class 2606 OID 44455)
-- Dependencies: 222 222
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2361 (class 2606 OID 44457)
-- Dependencies: 223 223 223
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2363 (class 2606 OID 44459)
-- Dependencies: 225 225
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2367 (class 2606 OID 44461)
-- Dependencies: 228 228
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2365 (class 2606 OID 44463)
-- Dependencies: 227 227
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2369 (class 2606 OID 44465)
-- Dependencies: 231 231
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2371 (class 2606 OID 44467)
-- Dependencies: 233 233
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2373 (class 2606 OID 44469)
-- Dependencies: 235 235
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2375 (class 2606 OID 44471)
-- Dependencies: 237 237
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2377 (class 2606 OID 44473)
-- Dependencies: 238 238
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2379 (class 2606 OID 44475)
-- Dependencies: 240 240
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2381 (class 2606 OID 44477)
-- Dependencies: 243 243
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2383 (class 2606 OID 44479)
-- Dependencies: 245 245
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2385 (class 2606 OID 44481)
-- Dependencies: 246 246
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2387 (class 2606 OID 44483)
-- Dependencies: 248 248
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2391 (class 2606 OID 44485)
-- Dependencies: 251 251
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2389 (class 2606 OID 44487)
-- Dependencies: 250 250
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2395 (class 2606 OID 44489)
-- Dependencies: 255 255
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2393 (class 2606 OID 44491)
-- Dependencies: 254 254
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2397 (class 2606 OID 44493)
-- Dependencies: 259 259
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2399 (class 2606 OID 44495)
-- Dependencies: 261 261
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2401 (class 2606 OID 44497)
-- Dependencies: 262 262
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2407 (class 2606 OID 44499)
-- Dependencies: 267 267
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2403 (class 2606 OID 44501)
-- Dependencies: 265 265
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2405 (class 2606 OID 44503)
-- Dependencies: 265 265
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2409 (class 2606 OID 44505)
-- Dependencies: 268 268
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2410 (class 2606 OID 44506)
-- Dependencies: 183 2318 162
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2411 (class 2606 OID 44511)
-- Dependencies: 208 162 2344
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2412 (class 2606 OID 44516)
-- Dependencies: 225 2362 162
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2413 (class 2606 OID 44521)
-- Dependencies: 233 162 2370
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2415 (class 2606 OID 44526)
-- Dependencies: 165 2300 164
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2416 (class 2606 OID 44531)
-- Dependencies: 183 165 2318
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2417 (class 2606 OID 44536)
-- Dependencies: 164 167 2300
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2418 (class 2606 OID 44541)
-- Dependencies: 167 2368 231
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2419 (class 2606 OID 44546)
-- Dependencies: 164 2300 169
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2420 (class 2606 OID 44551)
-- Dependencies: 2368 169 231
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2414 (class 2606 OID 44556)
-- Dependencies: 2368 231 164
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2421 (class 2606 OID 44561)
-- Dependencies: 171 2300 164
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2422 (class 2606 OID 44566)
-- Dependencies: 171 2340 203
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2423 (class 2606 OID 44571)
-- Dependencies: 250 171 2388
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2424 (class 2606 OID 44576)
-- Dependencies: 171 265 2402
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2425 (class 2606 OID 44581)
-- Dependencies: 162 2296 179
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2426 (class 2606 OID 44586)
-- Dependencies: 2316 181 179
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2427 (class 2606 OID 44591)
-- Dependencies: 265 179 2402
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2428 (class 2606 OID 44596)
-- Dependencies: 2344 208 183
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2429 (class 2606 OID 44601)
-- Dependencies: 2362 225 183
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2430 (class 2606 OID 44606)
-- Dependencies: 231 2368 183
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2431 (class 2606 OID 44611)
-- Dependencies: 2370 233 183
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2432 (class 2606 OID 44616)
-- Dependencies: 2368 231 184
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2433 (class 2606 OID 44621)
-- Dependencies: 231 187 2368
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2434 (class 2606 OID 44626)
-- Dependencies: 198 189 2334
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2435 (class 2606 OID 44631)
-- Dependencies: 245 189 2382
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2436 (class 2606 OID 44636)
-- Dependencies: 183 2318 190
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2437 (class 2606 OID 44641)
-- Dependencies: 189 190 2324
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2438 (class 2606 OID 44646)
-- Dependencies: 243 190 2380
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2439 (class 2606 OID 44651)
-- Dependencies: 191 2324 189
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2440 (class 2606 OID 44656)
-- Dependencies: 198 191 2334
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2441 (class 2606 OID 44661)
-- Dependencies: 191 2396 259
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2442 (class 2606 OID 44666)
-- Dependencies: 2300 164 193
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2443 (class 2606 OID 44671)
-- Dependencies: 193 2318 183
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2444 (class 2606 OID 44676)
-- Dependencies: 198 193 2334
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2445 (class 2606 OID 44681)
-- Dependencies: 193 250 2388
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2446 (class 2606 OID 44686)
-- Dependencies: 193 265 2402
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2447 (class 2606 OID 44691)
-- Dependencies: 195 193 2330
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2448 (class 2606 OID 44696)
-- Dependencies: 198 231 2368
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2449 (class 2606 OID 44701)
-- Dependencies: 199 164 2300
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2450 (class 2606 OID 44706)
-- Dependencies: 199 183 2318
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2451 (class 2606 OID 44711)
-- Dependencies: 199 198 2334
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2452 (class 2606 OID 44716)
-- Dependencies: 202 198 2334
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2453 (class 2606 OID 44721)
-- Dependencies: 202 231 2368
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2454 (class 2606 OID 44726)
-- Dependencies: 203 183 2318
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2455 (class 2606 OID 44731)
-- Dependencies: 203 187 2322
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2456 (class 2606 OID 44736)
-- Dependencies: 203 198 2334
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2457 (class 2606 OID 44741)
-- Dependencies: 203 227 2364
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2458 (class 2606 OID 44746)
-- Dependencies: 203 248 2386
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2459 (class 2606 OID 44751)
-- Dependencies: 203 259 2396
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2460 (class 2606 OID 44756)
-- Dependencies: 203 262 2400
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2461 (class 2606 OID 44761)
-- Dependencies: 203 265 2402
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2462 (class 2606 OID 44766)
-- Dependencies: 203 268 2408
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2463 (class 2606 OID 44771)
-- Dependencies: 206 231 2368
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2464 (class 2606 OID 44776)
-- Dependencies: 208 233 2370
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2465 (class 2606 OID 44781)
-- Dependencies: 209 208 2344
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2466 (class 2606 OID 44786)
-- Dependencies: 209 225 2362
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2467 (class 2606 OID 44791)
-- Dependencies: 209 231 2368
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2468 (class 2606 OID 44796)
-- Dependencies: 209 233 2370
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2469 (class 2606 OID 44801)
-- Dependencies: 209 243 2380
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2470 (class 2606 OID 44806)
-- Dependencies: 211 183 2318
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2471 (class 2606 OID 44811)
-- Dependencies: 211 198 2334
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2472 (class 2606 OID 44816)
-- Dependencies: 211 231 2368
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2473 (class 2606 OID 44821)
-- Dependencies: 213 265 2402
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2474 (class 2606 OID 44826)
-- Dependencies: 214 213 2350
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2475 (class 2606 OID 44831)
-- Dependencies: 220 218 2354
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2476 (class 2606 OID 44836)
-- Dependencies: 223 222 2358
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2477 (class 2606 OID 44841)
-- Dependencies: 223 265 2402
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2478 (class 2606 OID 44846)
-- Dependencies: 225 208 2344
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2483 (class 2606 OID 44851)
-- Dependencies: 228 227 2364
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2479 (class 2606 OID 44856)
-- Dependencies: 227 183 2318
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2480 (class 2606 OID 44861)
-- Dependencies: 227 187 2322
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2481 (class 2606 OID 44866)
-- Dependencies: 227 198 2334
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2482 (class 2606 OID 44871)
-- Dependencies: 227 248 2386
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2484 (class 2606 OID 44876)
-- Dependencies: 231 208 2344
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2485 (class 2606 OID 44881)
-- Dependencies: 231 225 2362
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2486 (class 2606 OID 44886)
-- Dependencies: 231 233 2370
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2487 (class 2606 OID 44891)
-- Dependencies: 238 231 2368
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2488 (class 2606 OID 44896)
-- Dependencies: 240 231 2368
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2489 (class 2606 OID 44901)
-- Dependencies: 243 208 2344
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2490 (class 2606 OID 44906)
-- Dependencies: 243 225 2362
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2491 (class 2606 OID 44911)
-- Dependencies: 243 231 2368
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2492 (class 2606 OID 44916)
-- Dependencies: 243 233 2370
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2493 (class 2606 OID 44921)
-- Dependencies: 245 183 2318
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2494 (class 2606 OID 44926)
-- Dependencies: 246 208 2344
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2495 (class 2606 OID 44931)
-- Dependencies: 246 225 2362
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2496 (class 2606 OID 44936)
-- Dependencies: 246 231 2368
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2497 (class 2606 OID 44941)
-- Dependencies: 246 233 2370
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2498 (class 2606 OID 44946)
-- Dependencies: 248 183 2318
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2499 (class 2606 OID 44951)
-- Dependencies: 248 187 2322
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2500 (class 2606 OID 44956)
-- Dependencies: 248 208 2344
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2501 (class 2606 OID 44961)
-- Dependencies: 248 225 2362
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2502 (class 2606 OID 44966)
-- Dependencies: 248 233 2370
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2510 (class 2606 OID 44971)
-- Dependencies: 251 183 2318
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2511 (class 2606 OID 44976)
-- Dependencies: 251 198 2334
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2512 (class 2606 OID 44981)
-- Dependencies: 251 250 2388
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2503 (class 2606 OID 44986)
-- Dependencies: 250 183 2318
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2504 (class 2606 OID 44991)
-- Dependencies: 250 184 2320
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2505 (class 2606 OID 44996)
-- Dependencies: 250 189 2324
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2506 (class 2606 OID 45001)
-- Dependencies: 250 213 2350
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2507 (class 2606 OID 45006)
-- Dependencies: 250 243 2380
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2508 (class 2606 OID 45011)
-- Dependencies: 250 259 2396
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2509 (class 2606 OID 45016)
-- Dependencies: 250 265 2402
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2513 (class 2606 OID 45021)
-- Dependencies: 254 2392 255
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2514 (class 2606 OID 45026)
-- Dependencies: 259 162 2296
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2515 (class 2606 OID 45031)
-- Dependencies: 2318 259 183
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2516 (class 2606 OID 45036)
-- Dependencies: 183 261 2318
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2517 (class 2606 OID 45041)
-- Dependencies: 262 2318 183
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2518 (class 2606 OID 45046)
-- Dependencies: 2296 267 162
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2519 (class 2606 OID 45051)
-- Dependencies: 267 237 2374
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2520 (class 2606 OID 45056)
-- Dependencies: 2402 267 265
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-20 23:50:23

--
-- PostgreSQL database dump complete
--

