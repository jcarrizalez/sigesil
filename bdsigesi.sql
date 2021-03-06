--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-08-10 16:25:26 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 268 (class 3079 OID 11710)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 268
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 280 (class 1255 OID 100744)
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
-- TOC entry 161 (class 1259 OID 100745)
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
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 10, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 100747)
-- Dependencies: 2259 6
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
-- TOC entry 163 (class 1259 OID 100754)
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
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 164 (class 1259 OID 100756)
-- Dependencies: 2260 2261 2262 6
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
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 165 (class 1259 OID 100762)
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
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 166 (class 1259 OID 100765)
-- Dependencies: 165 6
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
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 100767)
-- Dependencies: 2264 2265 2266 2267 2268 2269 6
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
    id_centro_acopio bigint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 168 (class 1259 OID 100776)
-- Dependencies: 6 167
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_cultivo_id_seq OWNER TO admin;

--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 2032, true);


--
-- TOC entry 169 (class 1259 OID 100778)
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
    tipo_mov character varying(2) NOT NULL,
    lab character varying(1) NOT NULL
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 170 (class 1259 OID 100781)
-- Dependencies: 6 169
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_resultado_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_analisis_resultado_id_seq OWNER TO admin;

--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 0, true);


--
-- TOC entry 171 (class 1259 OID 100783)
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
-- TOC entry 172 (class 1259 OID 100789)
-- Dependencies: 6
-- Name: si_cargo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_id_seq OWNER TO admin;

--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 0, true);


--
-- TOC entry 173 (class 1259 OID 100791)
-- Dependencies: 2272 6
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
-- TOC entry 174 (class 1259 OID 100795)
-- Dependencies: 6
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cargo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 0, true);


--
-- TOC entry 175 (class 1259 OID 100797)
-- Dependencies: 2273 2274 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 176 (class 1259 OID 100802)
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
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 177 (class 1259 OID 100804)
-- Dependencies: 2275 2276 2277 2278 2279 2280 2281 6
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
-- TOC entry 178 (class 1259 OID 100817)
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
    nombre character varying(255) NOT NULL,
    celular character varying(32),
    telefono character varying(32),
    direccion character varying(255),
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_choferes OWNER TO admin;

--
-- TOC entry 179 (class 1259 OID 100823)
-- Dependencies: 178 6
-- Name: si_choferes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_choferes_id_seq OWNER TO admin;

--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 0, true);


--
-- TOC entry 180 (class 1259 OID 100825)
-- Dependencies: 6
-- Name: si_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cliente_id_seq OWNER TO admin;

--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 0, true);


--
-- TOC entry 181 (class 1259 OID 100827)
-- Dependencies: 2283 6
-- Name: si_cliente; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cliente (
    id bigint DEFAULT nextval('si_cliente_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_sap character(16),
    ced_rif character varying(16) NOT NULL,
    ref character(16),
    nombre character varying(255) NOT NULL,
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
-- TOC entry 182 (class 1259 OID 100834)
-- Dependencies: 6
-- Name: si_contrato; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_contrato (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_productor bigint NOT NULL,
    nro_contrato character varying NOT NULL,
    descripcion character varying,
    toneladas_rec real,
    toneladas_con real,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_contrato OWNER TO admin;

--
-- TOC entry 183 (class 1259 OID 100840)
-- Dependencies: 6 182
-- Name: si_contrato_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_contrato_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_contrato_id_seq OWNER TO admin;

--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_contrato_id_seq OWNED BY si_contrato.id;


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_contrato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_contrato_id_seq', 0, true);


--
-- TOC entry 184 (class 1259 OID 100842)
-- Dependencies: 6
-- Name: si_cosecha_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_id_seq OWNER TO admin;

--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 0, true);


--
-- TOC entry 185 (class 1259 OID 100844)
-- Dependencies: 2285 2286 2287 2288 2289 6
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
-- TOC entry 186 (class 1259 OID 100855)
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
-- TOC entry 187 (class 1259 OID 100858)
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
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 188 (class 1259 OID 100861)
-- Dependencies: 187 6
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_silo_id_seq OWNER TO admin;

--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 188
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 188
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 0, true);


--
-- TOC entry 189 (class 1259 OID 100863)
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
    observa_admon character varying(100),
    observa_lab character varying(100)
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 189
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
-- TOC entry 190 (class 1259 OID 100866)
-- Dependencies: 189 6
-- Name: si_cuarentena_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_id_seq OWNER TO admin;

--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 0, true);


--
-- TOC entry 191 (class 1259 OID 100868)
-- Dependencies: 2292 6
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
-- TOC entry 192 (class 1259 OID 100872)
-- Dependencies: 191 6
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cuarentena_plaga_id_seq OWNER TO admin;

--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 0, true);


--
-- TOC entry 193 (class 1259 OID 100874)
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
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 194 (class 1259 OID 100876)
-- Dependencies: 2294 2295 2296 6
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
    codigo character varying(16)
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 195 (class 1259 OID 100882)
-- Dependencies: 2297 2298 6
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
-- TOC entry 196 (class 1259 OID 100887)
-- Dependencies: 195 6
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 30, true);


--
-- TOC entry 197 (class 1259 OID 100889)
-- Dependencies: 6
-- Name: si_denom_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_denom_tip_id_seq OWNER TO admin;

--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 0, true);


--
-- TOC entry 198 (class 1259 OID 100891)
-- Dependencies: 2300 6
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
-- TOC entry 199 (class 1259 OID 100895)
-- Dependencies: 2301 6
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
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 199
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
-- TOC entry 200 (class 1259 OID 100899)
-- Dependencies: 6 199
-- Name: si_despacho_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_despacho_id_seq OWNER TO admin;

--
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 0, true);


--
-- TOC entry 201 (class 1259 OID 100901)
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
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 202 (class 1259 OID 100903)
-- Dependencies: 2303 2304 6
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
-- TOC entry 203 (class 1259 OID 100908)
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
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 204 (class 1259 OID 100910)
-- Dependencies: 2305 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 205 (class 1259 OID 100914)
-- Dependencies: 2306 6
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
-- TOC entry 206 (class 1259 OID 100921)
-- Dependencies: 6 205
-- Name: si_finca_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_finca_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_finca_id_seq OWNER TO admin;

--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 0, true);


--
-- TOC entry 207 (class 1259 OID 100923)
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
-- TOC entry 208 (class 1259 OID 100929)
-- Dependencies: 207 6
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
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 83, true);


--
-- TOC entry 209 (class 1259 OID 100931)
-- Dependencies: 2309 2310 6
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
    modificado timestamp with time zone,
    id_centro_acopio bigint NOT NULL
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 210 (class 1259 OID 100936)
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
-- TOC entry 211 (class 1259 OID 100939)
-- Dependencies: 6 210
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_det_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_det_id_seq OWNER TO admin;

--
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 211
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 211
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 0, true);


--
-- TOC entry 212 (class 1259 OID 100941)
-- Dependencies: 6 209
-- Name: si_guiarec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_guiarec_id_seq OWNER TO admin;

--
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 0, true);


--
-- TOC entry 213 (class 1259 OID 100943)
-- Dependencies: 6
-- Name: si_impresora; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_impresora (
    id bigint NOT NULL,
    id_centro_acopio bigint,
    estatus smallint,
    nombre character varying(64),
    parametros character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_impresora OWNER TO admin;

--
-- TOC entry 214 (class 1259 OID 100946)
-- Dependencies: 213 6
-- Name: si_impresora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_impresora_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_impresora_id_seq OWNER TO admin;

--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_impresora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_impresora_id_seq OWNED BY si_impresora.id;


--
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_impresora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_impresora_id_seq', 16, true);


--
-- TOC entry 215 (class 1259 OID 100948)
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
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 216 (class 1259 OID 100950)
-- Dependencies: 2314 6
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
-- TOC entry 217 (class 1259 OID 100954)
-- Dependencies: 6
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_consultas_log_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_log_consultas_log_id_seq OWNER TO admin;

--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 0, true);


--
-- TOC entry 218 (class 1259 OID 100956)
-- Dependencies: 2315 6
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
-- TOC entry 219 (class 1259 OID 100963)
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
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 49, true);


--
-- TOC entry 220 (class 1259 OID 100965)
-- Dependencies: 2316 2317 6
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
-- TOC entry 221 (class 1259 OID 100970)
-- Dependencies: 2318 2319 2320 2321 6
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
-- TOC entry 222 (class 1259 OID 100977)
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
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 223 (class 1259 OID 100979)
-- Dependencies: 2322 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 100983)
-- Dependencies: 6
-- Name: si_ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_id_seq OWNER TO admin;

--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 0, true);


--
-- TOC entry 225 (class 1259 OID 100985)
-- Dependencies: 2323 2324 6
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
-- TOC entry 226 (class 1259 OID 100993)
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
-- TOC entry 227 (class 1259 OID 100996)
-- Dependencies: 226 6
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_det_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_ordenes_det_id_seq OWNER TO admin;

--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 0, true);


--
-- TOC entry 228 (class 1259 OID 100998)
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
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 229 (class 1259 OID 101000)
-- Dependencies: 2326 6
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
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 230 (class 1259 OID 101007)
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
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 231 (class 1259 OID 101009)
-- Dependencies: 2327 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 232 (class 1259 OID 101013)
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
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 233 (class 1259 OID 101015)
-- Dependencies: 2328 6
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
-- TOC entry 234 (class 1259 OID 101022)
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
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 235 (class 1259 OID 101024)
-- Dependencies: 2329 6
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
-- TOC entry 236 (class 1259 OID 101028)
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
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 237 (class 1259 OID 101031)
-- Dependencies: 6 236
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
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 238 (class 1259 OID 101033)
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
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 239 (class 1259 OID 101036)
-- Dependencies: 238 6
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
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 240 (class 1259 OID 101038)
-- Dependencies: 6
-- Name: si_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_productor_id_seq OWNER TO admin;

--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 240
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 0, true);


--
-- TOC entry 241 (class 1259 OID 101040)
-- Dependencies: 2332 6
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
-- TOC entry 242 (class 1259 OID 101047)
-- Dependencies: 6
-- Name: si_programa_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_programa_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_programa_id_seq OWNER TO admin;

--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 0, true);


--
-- TOC entry 243 (class 1259 OID 101049)
-- Dependencies: 2333 6
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
-- TOC entry 244 (class 1259 OID 101056)
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
-- TOC entry 245 (class 1259 OID 101062)
-- Dependencies: 6 244
-- Name: si_proveedor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_proveedor_id_seq OWNER TO admin;

--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 0, true);


--
-- TOC entry 246 (class 1259 OID 101064)
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
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 247 (class 1259 OID 101070)
-- Dependencies: 246 6
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_punto_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_punto_entrega_id_seq OWNER TO admin;

--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 0, true);


--
-- TOC entry 248 (class 1259 OID 101072)
-- Dependencies: 2336 2337 2338 2339 6
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
    id_asociado bigint DEFAULT 0,
    humedad2 real,
    impureza2 real,
    humedad_des2 double precision,
    impureza_des2 double precision,
    peso_acon2 double precision,
    peso_acon_liq2 double precision
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 248
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
-- TOC entry 249 (class 1259 OID 101079)
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
-- TOC entry 250 (class 1259 OID 101082)
-- Dependencies: 6 249
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 250
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 250
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 0, true);


--
-- TOC entry 251 (class 1259 OID 101084)
-- Dependencies: 6 248
-- Name: si_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_recepcion_id_seq OWNER TO admin;

--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 0, true);


--
-- TOC entry 252 (class 1259 OID 101086)
-- Dependencies: 2342 6
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
-- TOC entry 253 (class 1259 OID 101093)
-- Dependencies: 2344 6
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
-- TOC entry 254 (class 1259 OID 101100)
-- Dependencies: 6 253
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
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 254
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 254
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 60, true);


--
-- TOC entry 255 (class 1259 OID 101102)
-- Dependencies: 252 6
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
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 255
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 255
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 80, true);


--
-- TOC entry 256 (class 1259 OID 101104)
-- Dependencies: 6
-- Name: si_silos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_silos_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_silos_id_seq OWNER TO admin;

--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 256
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 79, true);


--
-- TOC entry 257 (class 1259 OID 101106)
-- Dependencies: 2346 2347 6
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
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 258 (class 1259 OID 101114)
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
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 258
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 259 (class 1259 OID 101116)
-- Dependencies: 2348 2349 2350 6
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
    modificado timestamp with time zone,
    parametros character varying(30)
);


ALTER TABLE public.si_tolcarom OWNER TO admin;

--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 260 (class 1259 OID 101122)
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
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 261 (class 1259 OID 101128)
-- Dependencies: 6 260
-- Name: si_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_transporte_id_seq OWNER TO admin;

--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 261
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 261
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 0, true);


--
-- TOC entry 262 (class 1259 OID 101130)
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
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 262
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 25, true);


--
-- TOC entry 263 (class 1259 OID 101132)
-- Dependencies: 2352 2353 2354 6
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
-- TOC entry 264 (class 1259 OID 101141)
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
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 264
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 24, true);


--
-- TOC entry 265 (class 1259 OID 101143)
-- Dependencies: 2355 6
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
-- TOC entry 266 (class 1259 OID 101147)
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
-- TOC entry 267 (class 1259 OID 101150)
-- Dependencies: 6 266
-- Name: si_vehiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_vehiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_vehiculos_id_seq OWNER TO admin;

--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 267
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 267
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 0, true);


--
-- TOC entry 2263 (class 2604 OID 101152)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2270 (class 2604 OID 101153)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2271 (class 2604 OID 101154)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2282 (class 2604 OID 101155)
-- Dependencies: 179 178
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2284 (class 2604 OID 101156)
-- Dependencies: 183 182
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_contrato ALTER COLUMN id SET DEFAULT nextval('si_contrato_id_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 101157)
-- Dependencies: 188 187
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2291 (class 2604 OID 101158)
-- Dependencies: 190 189
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2293 (class 2604 OID 101159)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2299 (class 2604 OID 101160)
-- Dependencies: 196 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2302 (class 2604 OID 101161)
-- Dependencies: 200 199
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2307 (class 2604 OID 101162)
-- Dependencies: 206 205
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2308 (class 2604 OID 101163)
-- Dependencies: 208 207
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2311 (class 2604 OID 101164)
-- Dependencies: 212 209
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2312 (class 2604 OID 101165)
-- Dependencies: 211 210
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2313 (class 2604 OID 101166)
-- Dependencies: 214 213
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_impresora ALTER COLUMN id SET DEFAULT nextval('si_impresora_id_seq'::regclass);


--
-- TOC entry 2325 (class 2604 OID 101167)
-- Dependencies: 227 226
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2330 (class 2604 OID 101168)
-- Dependencies: 237 236
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2331 (class 2604 OID 101169)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2334 (class 2604 OID 101170)
-- Dependencies: 245 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2335 (class 2604 OID 101171)
-- Dependencies: 247 246
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2340 (class 2604 OID 101172)
-- Dependencies: 251 248
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2341 (class 2604 OID 101173)
-- Dependencies: 250 249
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2343 (class 2604 OID 101174)
-- Dependencies: 255 252
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2345 (class 2604 OID 101175)
-- Dependencies: 254 253
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2351 (class 2604 OID 101176)
-- Dependencies: 261 260
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2356 (class 2604 OID 101177)
-- Dependencies: 267 266
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2593 (class 0 OID 100747)
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
INSERT INTO si_almacenes VALUES (10, 8, 'ALMACEN CHAGUARAMA', NULL, 1, 12, 136, '123456', NULL, NULL, true, NULL, '2012-07-16 09:24:39.504069', NULL, 2, '123456');
INSERT INTO si_almacenes VALUES (2, 1, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-08-08 14:19:00.141787', 2, '1');


--
-- TOC entry 2594 (class 0 OID 100756)
-- Dependencies: 164
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10', false);
INSERT INTO si_analisis VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11', false);
INSERT INTO si_analisis VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12', false);
INSERT INTO si_analisis VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13', false);
INSERT INTO si_analisis VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14', false);
INSERT INTO si_analisis VALUES (15, 1, 'GRANO PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15', false);
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
INSERT INTO si_analisis VALUES (19, 1, 'AFLATOXINA', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19', false);
INSERT INTO si_analisis VALUES (21, 1, 'ASPECTO', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20', false);
INSERT INTO si_analisis VALUES (20, 1, 'INSECTOS VIVOS', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24', false);
INSERT INTO si_analisis VALUES (22, 1, 'OLOR', 2, true, '2012-02-22 00:00:00-04:30', NULL, '21', false);
INSERT INTO si_analisis VALUES (26, 1, 'GRANOS DAÑADOS', 1, true, '2012-02-22 00:00:00-04:30', NULL, '26', false);
INSERT INTO si_analisis VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '01', true);
INSERT INTO si_analisis VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '02', true);
INSERT INTO si_analisis VALUES (3, 1, 'GRANOS CON GERMEN DAÑADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '03', false);
INSERT INTO si_analisis VALUES (4, 1, 'GRANOS DAÑADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '04', false);
INSERT INTO si_analisis VALUES (5, 1, 'GRANOS DAÑADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '05', false);
INSERT INTO si_analisis VALUES (6, 1, 'GRANOS DAÑADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '06', false);
INSERT INTO si_analisis VALUES (7, 1, 'GRANOS DAÑADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '07', false);
INSERT INTO si_analisis VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '08', false);
INSERT INTO si_analisis VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '09', false);


--
-- TOC entry 2595 (class 0 OID 100762)
-- Dependencies: 165
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2596 (class 0 OID 100767)
-- Dependencies: 167
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1, 12.000, 26.000, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 2, 0.000, 5.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 3, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 4, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 5, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 6, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 7, 0.000, 11.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 8, 0.000, 7.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 9, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 10, 0.000, 0.200, 0.000, 0.200, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 11, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 12, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 13, 0.710, 0.790, 0.710, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 14, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 15, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 16, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 21, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 22, 16.000, 28.000, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 23, 0.000, 11.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 24, 0.000, 100.000, 0.000, 40.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 28, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 29, 0.000, 0.000, 0.000, 4.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 30, 0.000, 5.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 31, 0.000, 4.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 32, 0.000, 11.000, 0.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 33, 0.000, 15.000, 0.000, 18.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 34, 0.000, 26.000, 0.000, 25.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 35, 0.000, 11.000, 0.000, 4.500, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 36, 0.000, 20.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 37, 0.000, 5.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 38, 40.000, 999.000, 46.000, 65.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 39, 59.000, 999.000, 50.000, 70.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 40, 22.000, 46.000, 20.000, 39.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 41, 12.000, 24.000, 12.000, 12.900, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 42, 0.000, 10.000, 0.000, 5.100, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 43, 0.000, 2.000, 0.000, 4.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 44, 0.000, 1.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 45, 0.600, 0.760, 0.600, 0.760, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 50, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 51, 11.000, 22.000, 11.000, 14.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 52, 0.000, 11.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 53, 0.000, 8.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 54, 0.000, 8.000, 0.000, 5.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 55, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 56, 0.680, 0.730, 0.680, 0.730, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 57, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 62, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 63, 0.000, 5.000, 0.000, 5.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 64, 0.000, 5.000, 0.000, 5.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 65, 12.000, 26.000, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 66, 0.000, 5.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 67, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 68, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 69, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 70, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 71, 0.000, 11.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 72, 0.000, 7.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 73, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 74, 0.000, 0.200, 0.000, 0.200, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 75, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 76, 0.710, 0.790, 0.710, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 77, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 78, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 79, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 81, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 82, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 83, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 84, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 85, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 86, 10.000, 26.000, 12.000, 12.900, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 87, 0.000, 7.000, 0.000, 7.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 88, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 89, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 90, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 91, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 92, 0.000, 17.000, 0.000, 17.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 93, 0.000, 10.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 94, 0.000, 30.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 95, 0.000, 20.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 96, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 97, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 98, 715.000, 0.790, 715.000, 0.760, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 99, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 100, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 101, 12.500, 15.000, 12.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 102, 0.000, 8.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 104, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 105, 0.000, 4.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 106, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 107, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 108, 0.000, 13.000, 0.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 109, 0.000, 13.000, 0.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 110, 0.000, 26.000, 0.000, 26.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 111, 0.000, 3.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 112, 12.000, 24.000, 12.000, 24.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 113, 0.000, 8.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 114, 0.000, 40.000, 0.000, 40.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 116, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 117, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 118, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 119, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 120, 0.000, 6.000, 0.000, 6.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 121, 0.000, 50.000, 0.000, 50.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 122, 0.000, 50.000, 0.000, 50.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 123, 0.000, 50.000, 0.000, 50.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 124, 0.000, 50.000, 0.000, 50.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 125, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 126, 0.000, 8.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 127, 0.000, 8.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 128, 40.000, 60.000, 45.000, 60.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 129, 65.000, 70.000, 65.000, 70.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 130, 25.000, 39.000, 30.000, 39.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 131, 16.000, 28.000, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 132, 0.000, 11.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 133, 0.000, 100.000, 0.000, 40.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 135, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 136, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 137, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 138, 0.000, 0.000, 0.000, 4.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 139, 0.000, 5.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 140, 0.000, 4.000, 0.000, 8.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 141, 0.000, 11.000, 0.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 142, 0.000, 15.000, 0.000, 18.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 143, 0.000, 26.000, 0.000, 25.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 144, 0.000, 11.000, 0.000, 4.500, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 145, 0.000, 20.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 146, 0.000, 5.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 147, 40.000, 999.000, 46.000, 65.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 148, 59.000, 999.000, 50.000, 70.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 149, 22.000, 46.000, 20.000, 39.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 150, 8.000, 19.000, 6.000, 9.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 151, 0.000, 8.000, 0.000, 7.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 152, 0.330, 0.480, 0.330, 0.480, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 153, 12.000, 26.000, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 154, 0.000, 5.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 155, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 156, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 157, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 158, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 159, 0.000, 11.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 160, 0.000, 7.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 161, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 162, 0.000, 0.200, 0.000, 0.200, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 163, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 164, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 165, 0.710, 0.790, 0.710, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 166, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 167, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 168, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 170, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 171, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 172, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 173, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 174, 6.000, 24.000, 6.000, 9.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 175, 0.000, 20.000, 0.000, 7.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 176, 0.330, 0.480, 0.330, 0.480, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 178, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 179, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 180, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 181, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 184, 12.000, 13.900, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 185, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 186, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 187, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 188, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 189, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 190, 0.000, 11.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 191, 0.000, 10.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 192, 0.000, 7.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 193, 0.000, 0.200, 0.000, 0.200, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 194, 0.000, 10.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 195, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 196, 0.730, 0.760, 0.710, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 197, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 198, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 199, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 201, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 202, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 203, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 204, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 206, 12.000, 13.900, 12.000, 13.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 207, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 208, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 209, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 210, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 211, 0.000, 11.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 212, 0.000, 11.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 213, 0.000, 10.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 214, 0.000, 7.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 215, 0.000, 0.200, 0.000, 0.200, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 216, 0.000, 10.000, 0.000, 11.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 217, 0.000, 3.000, 0.000, 3.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 218, 0.730, 0.760, 0.710, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 219, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 220, 0.000, 20.000, 0.000, 20.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 221, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 223, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 224, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 225, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 226, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 227, 12.000, 30.000, 11.000, 14.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 228, 0.000, 5.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 229, 0.000, 11.000, 0.000, 30.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 230, 0.000, 11.000, 0.000, 30.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 231, 0.000, 3.000, 0.000, 30.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 232, 0.000, 11.000, 0.000, 30.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 233, 0.000, 11.000, 0.000, 60.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 234, 0.000, 7.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 235, 0.000, 15.000, 0.000, 15.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 236, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 237, 0.000, 10.000, 0.000, 10.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 238, 0.000, 6.000, 0.000, 6.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 239, 715.000, 0.790, 715.000, 0.790, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 240, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 241, 0.000, 20.000, 0.000, 40.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 242, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 244, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 245, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 246, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 247, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 248, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 249, 0.000, 0.000, 0.000, 0.500, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 250, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 251, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 252, 0.000, 2.000, 0.000, 2.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 253, 1.000, 2.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 254, 0.000, 1.000, 0.000, 1.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 17, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 25, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 47, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 58, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 80, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 103, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 115, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 134, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 169, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 177, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 182, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 183, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 200, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 205, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 222, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 243, 0.000, 0.000, 0.000, 0.000, 2, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 352, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 509, 12.000, 26.000, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 510, 0.000, 5.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 511, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 512, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 513, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 514, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 515, 0.000, 11.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 516, 0.000, 7.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 517, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 518, 0.000, 0.200, 0.000, 0.200, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 519, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 520, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 521, 0.710, 0.790, 0.710, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 522, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 523, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 524, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 525, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 526, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 527, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 528, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 529, 16.000, 28.000, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 530, 0.000, 11.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 531, 0.000, 100.000, 0.000, 40.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 532, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 533, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 534, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 535, 0.000, 0.000, 0.000, 4.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 536, 0.000, 5.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 537, 0.000, 4.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 538, 0.000, 11.000, 0.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 539, 0.000, 15.000, 0.000, 18.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 540, 0.000, 26.000, 0.000, 25.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 541, 0.000, 11.000, 0.000, 4.500, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 542, 0.000, 20.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 543, 0.000, 5.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 544, 40.000, 999.000, 46.000, 65.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 545, 59.000, 999.000, 50.000, 70.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 546, 22.000, 46.000, 20.000, 39.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 547, 12.000, 24.000, 12.000, 12.900, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 548, 0.000, 10.000, 0.000, 5.100, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 549, 0.000, 2.000, 0.000, 4.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 550, 0.000, 1.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 255, 12.000, 26.000, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 256, 0.000, 5.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 257, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 258, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 259, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 260, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 261, 0.000, 11.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 262, 0.000, 7.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 263, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 264, 0.000, 0.200, 0.000, 0.200, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 265, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 266, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 267, 0.710, 0.790, 0.710, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 268, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 269, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 270, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 271, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 272, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 273, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 274, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 275, 16.000, 28.000, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 276, 0.000, 11.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 277, 0.000, 100.000, 0.000, 40.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 278, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 279, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 280, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 281, 0.000, 0.000, 0.000, 4.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 282, 0.000, 5.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 283, 0.000, 4.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 284, 0.000, 11.000, 0.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 285, 0.000, 15.000, 0.000, 18.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 286, 0.000, 26.000, 0.000, 25.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 287, 0.000, 11.000, 0.000, 4.500, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 288, 0.000, 20.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 289, 0.000, 5.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 290, 40.000, 999.000, 46.000, 65.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 291, 59.000, 999.000, 50.000, 70.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 292, 22.000, 46.000, 20.000, 39.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 293, 12.000, 24.000, 12.000, 12.900, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 294, 0.000, 10.000, 0.000, 5.100, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 295, 0.000, 2.000, 0.000, 4.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 296, 0.000, 1.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 297, 0.600, 0.760, 0.600, 0.760, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 298, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 299, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 300, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 301, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 302, 11.000, 22.000, 11.000, 14.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 303, 0.000, 11.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 304, 0.000, 8.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 305, 0.000, 8.000, 0.000, 5.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 306, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 307, 0.680, 0.730, 0.680, 0.730, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 308, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 309, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 310, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 311, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 312, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 313, 0.000, 5.000, 0.000, 5.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 314, 0.000, 5.000, 0.000, 5.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 315, 12.000, 26.000, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 316, 0.000, 5.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 317, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 318, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 319, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 320, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 321, 0.000, 11.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 322, 0.000, 7.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 323, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 324, 0.000, 0.200, 0.000, 0.200, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 325, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 326, 0.710, 0.790, 0.710, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 327, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 328, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 329, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 330, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 331, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 332, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 333, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 334, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 335, 10.000, 26.000, 12.000, 12.900, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 336, 0.000, 7.000, 0.000, 7.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 337, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 338, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 339, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 340, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 341, 0.000, 17.000, 0.000, 17.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 342, 0.000, 10.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 343, 0.000, 30.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 344, 0.000, 20.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 345, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 346, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 347, 715.000, 0.790, 715.000, 0.760, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 348, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 349, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 350, 12.500, 15.000, 12.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 351, 0.000, 8.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 353, 0.000, 4.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 354, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 355, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 356, 0.000, 13.000, 0.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 357, 0.000, 13.000, 0.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 358, 0.000, 26.000, 0.000, 26.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 359, 0.000, 3.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 360, 12.000, 24.000, 12.000, 24.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 361, 0.000, 8.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 362, 0.000, 40.000, 0.000, 40.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 363, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 364, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 365, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 366, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 367, 0.000, 6.000, 0.000, 6.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 368, 0.000, 50.000, 0.000, 50.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 369, 0.000, 50.000, 0.000, 50.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 370, 0.000, 50.000, 0.000, 50.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 371, 0.000, 50.000, 0.000, 50.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 372, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 373, 0.000, 8.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 374, 0.000, 8.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 375, 40.000, 60.000, 45.000, 60.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 376, 65.000, 70.000, 65.000, 70.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 377, 25.000, 39.000, 30.000, 39.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 378, 16.000, 28.000, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 379, 0.000, 11.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 380, 0.000, 100.000, 0.000, 40.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 381, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 382, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 383, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 384, 0.000, 0.000, 0.000, 4.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 385, 0.000, 5.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 386, 0.000, 4.000, 0.000, 8.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 387, 0.000, 11.000, 0.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 388, 0.000, 15.000, 0.000, 18.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 389, 0.000, 26.000, 0.000, 25.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 390, 0.000, 11.000, 0.000, 4.500, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 391, 0.000, 20.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 392, 0.000, 5.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 393, 40.000, 999.000, 46.000, 65.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 394, 59.000, 999.000, 50.000, 70.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 395, 22.000, 46.000, 20.000, 39.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 396, 8.000, 19.000, 6.000, 9.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 397, 0.000, 8.000, 0.000, 7.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 398, 0.330, 0.480, 0.330, 0.480, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 399, 12.000, 26.000, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 400, 0.000, 5.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 401, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 402, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 403, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 404, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 405, 0.000, 11.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 406, 0.000, 7.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 407, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 408, 0.000, 0.200, 0.000, 0.200, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 409, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 410, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 411, 0.710, 0.790, 0.710, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 412, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 413, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 414, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 415, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 416, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 417, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 418, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 419, 6.000, 24.000, 6.000, 9.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 420, 0.000, 20.000, 0.000, 7.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 421, 0.330, 0.480, 0.330, 0.480, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 422, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 423, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 424, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 425, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 426, 12.000, 13.900, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 427, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 428, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 429, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 430, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 431, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 432, 0.000, 11.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 433, 0.000, 10.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 434, 0.000, 7.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 435, 0.000, 0.200, 0.000, 0.200, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 436, 0.000, 10.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 437, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 438, 0.730, 0.760, 0.710, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 439, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 440, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 441, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 442, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 443, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 444, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 445, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 446, 12.000, 13.900, 12.000, 13.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 447, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 448, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 449, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 450, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 451, 0.000, 11.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 452, 0.000, 11.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 453, 0.000, 10.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 454, 0.000, 7.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 455, 0.000, 0.200, 0.000, 0.200, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 456, 0.000, 10.000, 0.000, 11.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 457, 0.000, 3.000, 0.000, 3.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 458, 0.730, 0.760, 0.710, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 459, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 460, 0.000, 20.000, 0.000, 20.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 461, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 462, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 463, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 464, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 465, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 466, 12.000, 30.000, 11.000, 14.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 467, 0.000, 5.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 468, 0.000, 11.000, 0.000, 30.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 469, 0.000, 11.000, 0.000, 30.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 470, 0.000, 3.000, 0.000, 30.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 471, 0.000, 11.000, 0.000, 30.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 472, 0.000, 11.000, 0.000, 60.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 473, 0.000, 7.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 474, 0.000, 15.000, 0.000, 15.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 475, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 476, 0.000, 10.000, 0.000, 10.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 477, 0.000, 6.000, 0.000, 6.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 478, 715.000, 0.790, 715.000, 0.790, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 479, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 480, 0.000, 20.000, 0.000, 40.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 481, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 482, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 483, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 484, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 485, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 486, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 487, 0.000, 0.000, 0.000, 0.500, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 488, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 489, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 490, 0.000, 2.000, 0.000, 2.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 491, 1.000, 2.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 492, 0.000, 1.000, 0.000, 1.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 493, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 494, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 495, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 496, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 497, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 498, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 499, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 500, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 501, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 502, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 503, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 504, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 505, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 506, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 507, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 508, 0.000, 0.000, 0.000, 0.000, 3, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 551, 0.600, 0.760, 0.600, 0.760, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 552, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 553, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 554, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 555, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 556, 11.000, 22.000, 11.000, 14.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 557, 0.000, 11.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 558, 0.000, 8.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 559, 0.000, 8.000, 0.000, 5.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 560, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 561, 0.680, 0.730, 0.680, 0.730, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 562, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 563, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 564, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 565, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 566, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 567, 0.000, 5.000, 0.000, 5.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 568, 0.000, 5.000, 0.000, 5.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 569, 12.000, 26.000, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 570, 0.000, 5.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 571, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 572, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 573, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 574, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 575, 0.000, 11.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 576, 0.000, 7.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 577, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 578, 0.000, 0.200, 0.000, 0.200, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 579, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 580, 0.710, 0.790, 0.710, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 581, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 582, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 583, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 584, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 585, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 586, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 587, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 588, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 589, 10.000, 26.000, 12.000, 12.900, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 590, 0.000, 7.000, 0.000, 7.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 591, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 592, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 593, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 594, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 595, 0.000, 17.000, 0.000, 17.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 596, 0.000, 10.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 597, 0.000, 30.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 598, 0.000, 20.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 599, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 600, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 601, 715.000, 0.790, 715.000, 0.760, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 602, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 603, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 604, 12.500, 15.000, 12.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 605, 0.000, 8.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 606, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 607, 0.000, 4.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 608, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 609, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 610, 0.000, 13.000, 0.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 611, 0.000, 13.000, 0.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 612, 0.000, 26.000, 0.000, 26.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 613, 0.000, 3.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 614, 12.000, 24.000, 12.000, 24.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 615, 0.000, 8.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 616, 0.000, 40.000, 0.000, 40.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 617, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 618, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 619, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 620, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 621, 0.000, 6.000, 0.000, 6.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 622, 0.000, 50.000, 0.000, 50.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 623, 0.000, 50.000, 0.000, 50.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 624, 0.000, 50.000, 0.000, 50.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 625, 0.000, 50.000, 0.000, 50.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 626, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 627, 0.000, 8.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 628, 0.000, 8.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 629, 40.000, 60.000, 45.000, 60.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 630, 65.000, 70.000, 65.000, 70.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 631, 25.000, 39.000, 30.000, 39.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 632, 16.000, 28.000, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 633, 0.000, 11.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 634, 0.000, 100.000, 0.000, 40.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 635, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 636, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 637, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 638, 0.000, 0.000, 0.000, 4.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 639, 0.000, 5.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 640, 0.000, 4.000, 0.000, 8.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 641, 0.000, 11.000, 0.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 642, 0.000, 15.000, 0.000, 18.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 643, 0.000, 26.000, 0.000, 25.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 644, 0.000, 11.000, 0.000, 4.500, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 645, 0.000, 20.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 646, 0.000, 5.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 647, 40.000, 999.000, 46.000, 65.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 648, 59.000, 999.000, 50.000, 70.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 649, 22.000, 46.000, 20.000, 39.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 650, 8.000, 19.000, 6.000, 9.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 651, 0.000, 8.000, 0.000, 7.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 652, 0.330, 0.480, 0.330, 0.480, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 653, 12.000, 26.000, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 654, 0.000, 5.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 655, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 656, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 657, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 658, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 659, 0.000, 11.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 660, 0.000, 7.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 661, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 662, 0.000, 0.200, 0.000, 0.200, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 663, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 664, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 665, 0.710, 0.790, 0.710, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 666, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 667, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 668, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 669, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 670, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 671, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 672, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 673, 6.000, 24.000, 6.000, 9.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 674, 0.000, 20.000, 0.000, 7.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 675, 0.330, 0.480, 0.330, 0.480, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 676, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 677, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 678, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 679, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 680, 12.000, 13.900, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 681, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 682, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 683, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 684, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 685, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 686, 0.000, 11.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 687, 0.000, 10.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 688, 0.000, 7.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 689, 0.000, 0.200, 0.000, 0.200, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 690, 0.000, 10.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 691, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 692, 0.730, 0.760, 0.710, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 693, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 694, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 695, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 696, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 697, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 698, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 699, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 700, 12.000, 13.900, 12.000, 13.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 701, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 702, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 703, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 704, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 705, 0.000, 11.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 706, 0.000, 11.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 707, 0.000, 10.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 708, 0.000, 7.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 709, 0.000, 0.200, 0.000, 0.200, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 710, 0.000, 10.000, 0.000, 11.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 711, 0.000, 3.000, 0.000, 3.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 712, 0.730, 0.760, 0.710, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 713, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 714, 0.000, 20.000, 0.000, 20.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 715, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 716, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 717, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 718, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 719, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 720, 12.000, 30.000, 11.000, 14.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 721, 0.000, 5.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 722, 0.000, 11.000, 0.000, 30.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 723, 0.000, 11.000, 0.000, 30.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 724, 0.000, 3.000, 0.000, 30.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 725, 0.000, 11.000, 0.000, 30.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 726, 0.000, 11.000, 0.000, 60.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 727, 0.000, 7.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 728, 0.000, 15.000, 0.000, 15.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 729, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 730, 0.000, 10.000, 0.000, 10.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 731, 0.000, 6.000, 0.000, 6.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 732, 715.000, 0.790, 715.000, 0.790, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 733, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 734, 0.000, 20.000, 0.000, 40.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 735, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 736, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 737, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 738, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 739, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 740, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 741, 0.000, 0.000, 0.000, 0.500, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 742, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 743, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 744, 0.000, 2.000, 0.000, 2.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 745, 1.000, 2.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 746, 0.000, 1.000, 0.000, 1.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 747, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 748, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 749, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 750, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 751, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 752, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 753, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 754, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 755, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 756, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 757, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 758, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 759, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 760, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 761, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 762, 0.000, 0.000, 0.000, 0.000, 4, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 763, 12.000, 26.000, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 764, 0.000, 5.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 765, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 766, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 767, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 768, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 769, 0.000, 11.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 770, 0.000, 7.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 771, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 772, 0.000, 0.200, 0.000, 0.200, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 773, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 774, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 775, 0.710, 0.790, 0.710, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 776, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 777, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 778, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 779, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 780, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 781, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 782, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 783, 16.000, 28.000, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 784, 0.000, 11.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 785, 0.000, 100.000, 0.000, 40.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 786, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 787, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 788, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 789, 0.000, 0.000, 0.000, 4.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 790, 0.000, 5.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 791, 0.000, 4.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 792, 0.000, 11.000, 0.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 793, 0.000, 15.000, 0.000, 18.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 794, 0.000, 26.000, 0.000, 25.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 795, 0.000, 11.000, 0.000, 4.500, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 796, 0.000, 20.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 797, 0.000, 5.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 798, 40.000, 999.000, 46.000, 65.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 799, 59.000, 999.000, 50.000, 70.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 800, 22.000, 46.000, 20.000, 39.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 801, 12.000, 24.000, 12.000, 12.900, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 802, 0.000, 10.000, 0.000, 5.100, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 803, 0.000, 2.000, 0.000, 4.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 804, 0.000, 1.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 805, 0.600, 0.760, 0.600, 0.760, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 806, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 807, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 808, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 809, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 810, 11.000, 22.000, 11.000, 14.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 811, 0.000, 11.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 812, 0.000, 8.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 813, 0.000, 8.000, 0.000, 5.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 814, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 815, 0.680, 0.730, 0.680, 0.730, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 816, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 817, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 818, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 819, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 820, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 821, 0.000, 5.000, 0.000, 5.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 822, 0.000, 5.000, 0.000, 5.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 823, 12.000, 26.000, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 824, 0.000, 5.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 825, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 826, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 827, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 828, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 829, 0.000, 11.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 830, 0.000, 7.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 831, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 832, 0.000, 0.200, 0.000, 0.200, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 833, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 834, 0.710, 0.790, 0.710, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 835, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 836, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 837, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 838, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 839, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 840, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 841, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 842, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 843, 10.000, 26.000, 12.000, 12.900, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 844, 0.000, 7.000, 0.000, 7.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 845, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 846, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 847, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 848, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 849, 0.000, 17.000, 0.000, 17.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 850, 0.000, 10.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 851, 0.000, 30.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 852, 0.000, 20.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 853, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 854, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 855, 715.000, 0.790, 715.000, 0.760, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 856, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 857, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 858, 12.500, 15.000, 12.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 859, 0.000, 8.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 860, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 861, 0.000, 4.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 862, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 863, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 864, 0.000, 13.000, 0.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 865, 0.000, 13.000, 0.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 866, 0.000, 26.000, 0.000, 26.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 867, 0.000, 3.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 868, 12.000, 24.000, 12.000, 24.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 869, 0.000, 8.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 870, 0.000, 40.000, 0.000, 40.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 871, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 872, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 873, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 874, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 875, 0.000, 6.000, 0.000, 6.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 876, 0.000, 50.000, 0.000, 50.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 877, 0.000, 50.000, 0.000, 50.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 878, 0.000, 50.000, 0.000, 50.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 879, 0.000, 50.000, 0.000, 50.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 880, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 881, 0.000, 8.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 882, 0.000, 8.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 883, 40.000, 60.000, 45.000, 60.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 884, 65.000, 70.000, 65.000, 70.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 885, 25.000, 39.000, 30.000, 39.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 886, 16.000, 28.000, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 887, 0.000, 11.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 888, 0.000, 100.000, 0.000, 40.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 889, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 890, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 891, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 892, 0.000, 0.000, 0.000, 4.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 893, 0.000, 5.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 894, 0.000, 4.000, 0.000, 8.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 895, 0.000, 11.000, 0.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 896, 0.000, 15.000, 0.000, 18.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 897, 0.000, 26.000, 0.000, 25.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 898, 0.000, 11.000, 0.000, 4.500, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 899, 0.000, 20.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 900, 0.000, 5.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 901, 40.000, 999.000, 46.000, 65.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 902, 59.000, 999.000, 50.000, 70.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 903, 22.000, 46.000, 20.000, 39.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 904, 8.000, 19.000, 6.000, 9.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 905, 0.000, 8.000, 0.000, 7.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 906, 0.330, 0.480, 0.330, 0.480, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 907, 12.000, 26.000, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 908, 0.000, 5.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 909, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 910, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 911, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 912, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 913, 0.000, 11.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 914, 0.000, 7.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 915, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 916, 0.000, 0.200, 0.000, 0.200, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 917, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 918, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 919, 0.710, 0.790, 0.710, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 920, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 921, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 922, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 923, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 924, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 925, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 926, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 927, 6.000, 24.000, 6.000, 9.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 928, 0.000, 20.000, 0.000, 7.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 929, 0.330, 0.480, 0.330, 0.480, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 930, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 931, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 932, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 933, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 934, 12.000, 13.900, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 935, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 936, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 937, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 938, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 939, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 940, 0.000, 11.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 941, 0.000, 10.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 942, 0.000, 7.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 943, 0.000, 0.200, 0.000, 0.200, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 944, 0.000, 10.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 945, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 946, 0.730, 0.760, 0.710, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 947, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 948, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 949, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 950, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 951, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 952, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 953, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 954, 12.000, 13.900, 12.000, 13.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 955, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 956, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 957, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 958, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 959, 0.000, 11.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 960, 0.000, 11.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 961, 0.000, 10.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 962, 0.000, 7.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 963, 0.000, 0.200, 0.000, 0.200, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 964, 0.000, 10.000, 0.000, 11.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 965, 0.000, 3.000, 0.000, 3.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 966, 0.730, 0.760, 0.710, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 967, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 968, 0.000, 20.000, 0.000, 20.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 969, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 970, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 971, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 972, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 973, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 974, 12.000, 30.000, 11.000, 14.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 975, 0.000, 5.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 976, 0.000, 11.000, 0.000, 30.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 977, 0.000, 11.000, 0.000, 30.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 978, 0.000, 3.000, 0.000, 30.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 979, 0.000, 11.000, 0.000, 30.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 980, 0.000, 11.000, 0.000, 60.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 981, 0.000, 7.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 982, 0.000, 15.000, 0.000, 15.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 983, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 984, 0.000, 10.000, 0.000, 10.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 985, 0.000, 6.000, 0.000, 6.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 986, 715.000, 0.790, 715.000, 0.790, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 987, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 988, 0.000, 20.000, 0.000, 40.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 989, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 990, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 991, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 992, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 993, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 994, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 995, 0.000, 0.000, 0.000, 0.500, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 996, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 997, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 998, 0.000, 2.000, 0.000, 2.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 999, 1.000, 2.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1000, 0.000, 1.000, 0.000, 1.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1001, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1002, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1003, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1004, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1005, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1006, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1007, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1008, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1009, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1010, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1011, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1012, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1013, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1014, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1015, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1016, 0.000, 0.000, 0.000, 0.000, 5, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1525, 12.000, 26.000, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1526, 0.000, 5.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1527, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1528, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1529, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1530, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1531, 0.000, 11.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1532, 0.000, 7.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1533, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1534, 0.000, 0.200, 0.000, 0.200, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1535, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1536, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1537, 0.710, 0.790, 0.710, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1538, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1539, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1540, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1541, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1542, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1543, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1544, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1545, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1546, 16.000, 28.000, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1547, 0.000, 11.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1548, 0.000, 100.000, 0.000, 40.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1549, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1550, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1551, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1552, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1553, 0.000, 0.000, 0.000, 4.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1554, 0.000, 5.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1555, 0.000, 4.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1556, 0.000, 11.000, 0.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1557, 0.000, 15.000, 0.000, 18.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1558, 0.000, 26.000, 0.000, 25.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1559, 0.000, 11.000, 0.000, 4.500, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1560, 0.000, 20.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1561, 0.000, 5.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1562, 40.000, 999.000, 46.000, 65.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1563, 59.000, 999.000, 50.000, 70.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1564, 22.000, 46.000, 20.000, 39.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1565, 12.000, 24.000, 12.000, 12.900, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1566, 0.000, 10.000, 0.000, 5.100, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1567, 0.000, 2.000, 0.000, 4.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1568, 0.000, 1.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1569, 0.600, 0.760, 0.600, 0.760, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1570, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1571, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1572, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1573, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1574, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1575, 11.000, 22.000, 11.000, 14.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1576, 0.000, 11.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1577, 0.000, 8.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1578, 0.000, 8.000, 0.000, 5.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1579, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1580, 0.680, 0.730, 0.680, 0.730, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1581, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1582, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1583, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1584, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1585, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1586, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1587, 0.000, 5.000, 0.000, 5.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1588, 0.000, 5.000, 0.000, 5.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1589, 12.000, 26.000, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1590, 0.000, 5.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1591, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1592, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1593, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1594, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1595, 0.000, 11.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1596, 0.000, 7.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1597, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1598, 0.000, 0.200, 0.000, 0.200, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1599, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1600, 0.710, 0.790, 0.710, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1601, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1602, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1603, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1604, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1605, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1606, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1607, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1608, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1609, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1610, 10.000, 26.000, 12.000, 12.900, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1611, 0.000, 7.000, 0.000, 7.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1612, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1613, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1614, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1615, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1616, 0.000, 17.000, 0.000, 17.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1617, 0.000, 10.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1618, 0.000, 30.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1619, 0.000, 20.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1620, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1621, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1622, 715.000, 0.790, 715.000, 0.760, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1623, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1624, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1625, 12.500, 15.000, 12.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1626, 0.000, 8.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1627, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1628, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1629, 0.000, 4.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1630, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1631, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1632, 0.000, 13.000, 0.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1633, 0.000, 13.000, 0.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1634, 0.000, 26.000, 0.000, 26.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1635, 0.000, 3.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1636, 12.000, 24.000, 12.000, 24.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1637, 0.000, 8.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1638, 0.000, 40.000, 0.000, 40.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1639, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1640, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1641, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1642, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1643, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1644, 0.000, 6.000, 0.000, 6.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1645, 0.000, 50.000, 0.000, 50.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1646, 0.000, 50.000, 0.000, 50.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1647, 0.000, 50.000, 0.000, 50.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1648, 0.000, 50.000, 0.000, 50.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1649, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1650, 0.000, 8.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1651, 0.000, 8.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1652, 40.000, 60.000, 45.000, 60.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1653, 65.000, 70.000, 65.000, 70.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1654, 25.000, 39.000, 30.000, 39.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1655, 16.000, 28.000, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1656, 0.000, 11.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1657, 0.000, 100.000, 0.000, 40.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1658, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1659, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1660, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1661, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1662, 0.000, 0.000, 0.000, 4.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1663, 0.000, 5.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1664, 0.000, 4.000, 0.000, 8.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1665, 0.000, 11.000, 0.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1666, 0.000, 15.000, 0.000, 18.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1667, 0.000, 26.000, 0.000, 25.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1668, 0.000, 11.000, 0.000, 4.500, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1669, 0.000, 20.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1670, 0.000, 5.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1671, 40.000, 999.000, 46.000, 65.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1672, 59.000, 999.000, 50.000, 70.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1673, 22.000, 46.000, 20.000, 39.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1674, 8.000, 19.000, 6.000, 9.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1675, 0.000, 8.000, 0.000, 7.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1676, 0.330, 0.480, 0.330, 0.480, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1677, 12.000, 26.000, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1678, 0.000, 5.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1679, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1680, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1681, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1682, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1683, 0.000, 11.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1684, 0.000, 7.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1685, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1686, 0.000, 0.200, 0.000, 0.200, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1687, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1688, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1689, 0.710, 0.790, 0.710, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1690, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1691, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1692, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1693, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1694, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1695, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1696, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1697, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1698, 6.000, 24.000, 6.000, 9.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1699, 0.000, 20.000, 0.000, 7.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1700, 0.330, 0.480, 0.330, 0.480, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1701, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1702, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1703, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1704, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1705, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1706, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1707, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1708, 12.000, 13.900, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1709, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1710, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1711, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1712, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1713, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1714, 0.000, 11.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1715, 0.000, 10.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1716, 0.000, 7.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1717, 0.000, 0.200, 0.000, 0.200, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1718, 0.000, 10.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1719, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1720, 0.730, 0.760, 0.710, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1721, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1722, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1723, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1724, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1725, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1726, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1727, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1728, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1729, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1730, 12.000, 13.900, 12.000, 13.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1731, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1732, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1733, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1734, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1735, 0.000, 11.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1736, 0.000, 11.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1737, 0.000, 10.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1738, 0.000, 7.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1739, 0.000, 0.200, 0.000, 0.200, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1740, 0.000, 10.000, 0.000, 11.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1741, 0.000, 3.000, 0.000, 3.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1742, 0.730, 0.760, 0.710, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1743, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1744, 0.000, 20.000, 0.000, 20.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1745, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1746, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1747, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1748, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1749, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1750, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1751, 12.000, 30.000, 11.000, 14.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1752, 0.000, 5.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1753, 0.000, 11.000, 0.000, 30.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1754, 0.000, 11.000, 0.000, 30.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1755, 0.000, 3.000, 0.000, 30.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1756, 0.000, 11.000, 0.000, 30.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1757, 0.000, 11.000, 0.000, 60.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1758, 0.000, 7.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1759, 0.000, 15.000, 0.000, 15.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1760, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1761, 0.000, 10.000, 0.000, 10.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1762, 0.000, 6.000, 0.000, 6.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1763, 715.000, 0.790, 715.000, 0.790, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1764, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1765, 0.000, 20.000, 0.000, 40.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1766, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1767, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1768, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1769, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1770, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1771, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1772, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1773, 0.000, 0.000, 0.000, 0.500, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1774, 0.000, 0.000, 0.000, 0.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1775, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1776, 0.000, 2.000, 0.000, 2.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1777, 1.000, 2.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1017, 12.000, 26.000, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1018, 0.000, 5.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1019, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1020, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1021, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1022, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1023, 0.000, 11.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1024, 0.000, 7.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1025, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1026, 0.000, 0.200, 0.000, 0.200, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1027, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1028, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1029, 0.710, 0.790, 0.710, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1030, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1031, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1032, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1033, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1034, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1035, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1036, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1037, 16.000, 28.000, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1038, 0.000, 11.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1039, 0.000, 100.000, 0.000, 40.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1040, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1041, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1042, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1043, 0.000, 0.000, 0.000, 4.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1044, 0.000, 5.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1045, 0.000, 4.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1046, 0.000, 11.000, 0.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1047, 0.000, 15.000, 0.000, 18.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1048, 0.000, 26.000, 0.000, 25.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1049, 0.000, 11.000, 0.000, 4.500, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1050, 0.000, 20.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1051, 0.000, 5.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1052, 40.000, 999.000, 46.000, 65.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1053, 59.000, 999.000, 50.000, 70.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1054, 22.000, 46.000, 20.000, 39.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1055, 12.000, 24.000, 12.000, 12.900, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1056, 0.000, 10.000, 0.000, 5.100, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1057, 0.000, 2.000, 0.000, 4.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1058, 0.000, 1.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1059, 0.600, 0.760, 0.600, 0.760, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1060, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1061, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1062, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1063, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1064, 11.000, 22.000, 11.000, 14.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1065, 0.000, 11.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1066, 0.000, 8.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1067, 0.000, 8.000, 0.000, 5.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1068, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1069, 0.680, 0.730, 0.680, 0.730, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1070, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1071, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1072, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1073, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1074, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1075, 0.000, 5.000, 0.000, 5.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1076, 0.000, 5.000, 0.000, 5.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1077, 12.000, 26.000, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1078, 0.000, 5.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1079, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1080, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1081, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1082, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1083, 0.000, 11.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1084, 0.000, 7.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1085, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1086, 0.000, 0.200, 0.000, 0.200, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1087, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1088, 0.710, 0.790, 0.710, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1089, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1090, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1091, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1092, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1093, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1094, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1095, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1096, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1097, 10.000, 26.000, 12.000, 12.900, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1098, 0.000, 7.000, 0.000, 7.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1099, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1100, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1101, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1102, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1103, 0.000, 17.000, 0.000, 17.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1104, 0.000, 10.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1105, 0.000, 30.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1106, 0.000, 20.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1107, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1108, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1109, 715.000, 0.790, 715.000, 0.760, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1110, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1111, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1112, 12.500, 15.000, 12.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1113, 0.000, 8.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1114, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1115, 0.000, 4.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1116, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1117, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1118, 0.000, 13.000, 0.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1119, 0.000, 13.000, 0.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1120, 0.000, 26.000, 0.000, 26.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1121, 0.000, 3.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1122, 12.000, 24.000, 12.000, 24.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1123, 0.000, 8.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1124, 0.000, 40.000, 0.000, 40.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1125, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1126, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1127, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1128, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1129, 0.000, 6.000, 0.000, 6.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1130, 0.000, 50.000, 0.000, 50.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1131, 0.000, 50.000, 0.000, 50.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1132, 0.000, 50.000, 0.000, 50.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1133, 0.000, 50.000, 0.000, 50.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1134, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1135, 0.000, 8.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1136, 0.000, 8.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1137, 40.000, 60.000, 45.000, 60.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1138, 65.000, 70.000, 65.000, 70.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1139, 25.000, 39.000, 30.000, 39.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1140, 16.000, 28.000, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1141, 0.000, 11.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1142, 0.000, 100.000, 0.000, 40.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1143, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1144, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1145, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1146, 0.000, 0.000, 0.000, 4.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1147, 0.000, 5.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1148, 0.000, 4.000, 0.000, 8.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1149, 0.000, 11.000, 0.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1150, 0.000, 15.000, 0.000, 18.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1151, 0.000, 26.000, 0.000, 25.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1152, 0.000, 11.000, 0.000, 4.500, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1153, 0.000, 20.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1154, 0.000, 5.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1155, 40.000, 999.000, 46.000, 65.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1156, 59.000, 999.000, 50.000, 70.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1157, 22.000, 46.000, 20.000, 39.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1158, 8.000, 19.000, 6.000, 9.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1159, 0.000, 8.000, 0.000, 7.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1160, 0.330, 0.480, 0.330, 0.480, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1161, 12.000, 26.000, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1162, 0.000, 5.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1163, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1164, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1165, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1166, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1167, 0.000, 11.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1168, 0.000, 7.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1169, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1170, 0.000, 0.200, 0.000, 0.200, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1171, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1172, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1173, 0.710, 0.790, 0.710, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1174, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1175, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1176, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1177, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1178, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1179, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1180, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1181, 6.000, 24.000, 6.000, 9.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1182, 0.000, 20.000, 0.000, 7.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1183, 0.330, 0.480, 0.330, 0.480, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1184, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1185, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1186, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1187, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1188, 12.000, 13.900, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1189, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1190, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1191, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1192, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1193, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1194, 0.000, 11.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1195, 0.000, 10.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1196, 0.000, 7.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1197, 0.000, 0.200, 0.000, 0.200, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1198, 0.000, 10.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1199, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1200, 0.730, 0.760, 0.710, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1201, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1202, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1203, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1204, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1205, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1206, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1207, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1208, 12.000, 13.900, 12.000, 13.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1209, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1210, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1211, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1212, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1213, 0.000, 11.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1214, 0.000, 11.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1215, 0.000, 10.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1216, 0.000, 7.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1217, 0.000, 0.200, 0.000, 0.200, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1218, 0.000, 10.000, 0.000, 11.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1219, 0.000, 3.000, 0.000, 3.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1220, 0.730, 0.760, 0.710, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1221, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1222, 0.000, 20.000, 0.000, 20.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1223, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1224, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1225, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1226, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1227, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1228, 12.000, 30.000, 11.000, 14.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1229, 0.000, 5.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1230, 0.000, 11.000, 0.000, 30.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1231, 0.000, 11.000, 0.000, 30.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1232, 0.000, 3.000, 0.000, 30.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1233, 0.000, 11.000, 0.000, 30.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1234, 0.000, 11.000, 0.000, 60.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1235, 0.000, 7.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1236, 0.000, 15.000, 0.000, 15.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1237, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1238, 0.000, 10.000, 0.000, 10.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1239, 0.000, 6.000, 0.000, 6.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1240, 715.000, 0.790, 715.000, 0.790, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1241, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1242, 0.000, 20.000, 0.000, 40.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1243, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1244, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1245, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1246, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1247, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1248, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1249, 0.000, 0.000, 0.000, 0.500, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1250, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1251, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1252, 0.000, 2.000, 0.000, 2.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1253, 1.000, 2.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1254, 0.000, 1.000, 0.000, 1.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1255, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1256, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1257, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1258, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1259, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1260, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1261, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1262, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1263, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1264, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1265, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1266, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1267, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1268, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1269, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1270, 0.000, 0.000, 0.000, 0.000, 6, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1778, 0.000, 1.000, 0.000, 1.000, 8, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1271, 12.000, 26.000, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1272, 0.000, 5.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1273, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1274, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1275, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1276, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1277, 0.000, 11.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1278, 0.000, 7.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1279, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1280, 0.000, 0.200, 0.000, 0.200, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1281, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1282, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1283, 0.710, 0.790, 0.710, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1284, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1285, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1286, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1287, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1288, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1289, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1290, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1291, 16.000, 28.000, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1292, 0.000, 11.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1293, 0.000, 100.000, 0.000, 40.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1294, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1295, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1296, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1297, 0.000, 0.000, 0.000, 4.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1298, 0.000, 5.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1299, 0.000, 4.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1300, 0.000, 11.000, 0.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1301, 0.000, 15.000, 0.000, 18.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1302, 0.000, 26.000, 0.000, 25.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1303, 0.000, 11.000, 0.000, 4.500, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1304, 0.000, 20.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1305, 0.000, 5.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1306, 40.000, 999.000, 46.000, 65.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1307, 59.000, 999.000, 50.000, 70.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1308, 22.000, 46.000, 20.000, 39.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1309, 12.000, 24.000, 12.000, 12.900, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1310, 0.000, 10.000, 0.000, 5.100, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1311, 0.000, 2.000, 0.000, 4.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1312, 0.000, 1.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1313, 0.600, 0.760, 0.600, 0.760, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1314, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1315, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1316, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1317, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1318, 11.000, 22.000, 11.000, 14.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1319, 0.000, 11.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1320, 0.000, 8.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1321, 0.000, 8.000, 0.000, 5.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1322, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1323, 0.680, 0.730, 0.680, 0.730, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1324, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1325, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1326, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1327, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1328, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1329, 0.000, 5.000, 0.000, 5.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1330, 0.000, 5.000, 0.000, 5.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1331, 12.000, 26.000, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1332, 0.000, 5.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1333, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1334, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1335, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1336, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1337, 0.000, 11.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1338, 0.000, 7.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1339, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1340, 0.000, 0.200, 0.000, 0.200, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1341, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1342, 0.710, 0.790, 0.710, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1343, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1344, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1345, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1346, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1347, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1348, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1349, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1350, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1351, 10.000, 26.000, 12.000, 12.900, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1352, 0.000, 7.000, 0.000, 7.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1353, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1354, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1355, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1356, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1357, 0.000, 17.000, 0.000, 17.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1358, 0.000, 10.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1359, 0.000, 30.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1360, 0.000, 20.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1361, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1362, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1363, 715.000, 0.790, 715.000, 0.760, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1364, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1365, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1366, 12.500, 15.000, 12.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1367, 0.000, 8.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1368, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1369, 0.000, 4.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1370, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1371, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1372, 0.000, 13.000, 0.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1373, 0.000, 13.000, 0.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1374, 0.000, 26.000, 0.000, 26.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1375, 0.000, 3.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1376, 12.000, 24.000, 12.000, 24.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1377, 0.000, 8.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1378, 0.000, 40.000, 0.000, 40.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1379, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1380, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1381, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1382, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1383, 0.000, 6.000, 0.000, 6.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1384, 0.000, 50.000, 0.000, 50.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1385, 0.000, 50.000, 0.000, 50.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1386, 0.000, 50.000, 0.000, 50.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1387, 0.000, 50.000, 0.000, 50.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1388, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1389, 0.000, 8.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1390, 0.000, 8.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1391, 40.000, 60.000, 45.000, 60.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1392, 65.000, 70.000, 65.000, 70.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1393, 25.000, 39.000, 30.000, 39.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1394, 16.000, 28.000, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1395, 0.000, 11.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1396, 0.000, 100.000, 0.000, 40.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1397, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1398, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1399, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1400, 0.000, 0.000, 0.000, 4.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1401, 0.000, 5.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1402, 0.000, 4.000, 0.000, 8.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1403, 0.000, 11.000, 0.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1404, 0.000, 15.000, 0.000, 18.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1405, 0.000, 26.000, 0.000, 25.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1406, 0.000, 11.000, 0.000, 4.500, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1407, 0.000, 20.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1408, 0.000, 5.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1409, 40.000, 999.000, 46.000, 65.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1410, 59.000, 999.000, 50.000, 70.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1411, 22.000, 46.000, 20.000, 39.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1412, 8.000, 19.000, 6.000, 9.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1413, 0.000, 8.000, 0.000, 7.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1414, 0.330, 0.480, 0.330, 0.480, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1415, 12.000, 26.000, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1416, 0.000, 5.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1417, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1418, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1419, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1420, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1421, 0.000, 11.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1422, 0.000, 7.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1423, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1424, 0.000, 0.200, 0.000, 0.200, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1425, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1426, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1427, 0.710, 0.790, 0.710, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1428, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1429, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1430, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1431, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1432, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1433, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1434, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1435, 6.000, 24.000, 6.000, 9.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1436, 0.000, 20.000, 0.000, 7.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1437, 0.330, 0.480, 0.330, 0.480, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1438, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1439, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1440, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1441, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1442, 12.000, 13.900, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1443, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1444, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1445, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1446, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1447, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1448, 0.000, 11.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1449, 0.000, 10.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1450, 0.000, 7.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1451, 0.000, 0.200, 0.000, 0.200, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1452, 0.000, 10.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1453, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1454, 0.730, 0.760, 0.710, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1455, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1456, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1457, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1458, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1459, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1460, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1461, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1462, 12.000, 13.900, 12.000, 13.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1463, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1464, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1465, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1466, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1467, 0.000, 11.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1468, 0.000, 11.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1469, 0.000, 10.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1470, 0.000, 7.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1471, 0.000, 0.200, 0.000, 0.200, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1472, 0.000, 10.000, 0.000, 11.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1473, 0.000, 3.000, 0.000, 3.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1474, 0.730, 0.760, 0.710, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1475, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1476, 0.000, 20.000, 0.000, 20.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1477, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1478, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1479, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1480, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1481, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1482, 12.000, 30.000, 11.000, 14.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1483, 0.000, 5.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1484, 0.000, 11.000, 0.000, 30.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1485, 0.000, 11.000, 0.000, 30.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1486, 0.000, 3.000, 0.000, 30.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1487, 0.000, 11.000, 0.000, 30.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1488, 0.000, 11.000, 0.000, 60.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1489, 0.000, 7.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1490, 0.000, 15.000, 0.000, 15.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1491, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1492, 0.000, 10.000, 0.000, 10.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1493, 0.000, 6.000, 0.000, 6.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1494, 715.000, 0.790, 715.000, 0.790, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1495, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1496, 0.000, 20.000, 0.000, 40.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1497, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1498, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1499, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1500, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1501, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1502, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1503, 0.000, 0.000, 0.000, 0.500, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1504, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1505, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1506, 0.000, 2.000, 0.000, 2.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1507, 1.000, 2.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1508, 0.000, 1.000, 0.000, 1.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1509, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1510, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1511, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1512, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1513, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1514, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1515, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1516, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1517, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1518, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1519, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1520, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1521, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1522, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1523, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1524, 0.000, 0.000, 0.000, 0.000, 7, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1779, 12.000, 26.000, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1780, 0.000, 5.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1781, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1782, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1783, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1784, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1785, 0.000, 11.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1786, 0.000, 7.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1787, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1788, 0.000, 0.200, 0.000, 0.200, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1789, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1790, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1791, 0.710, 0.790, 0.710, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1792, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1793, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1794, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1795, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1796, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1797, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1798, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1799, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1800, 16.000, 28.000, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1801, 0.000, 11.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1802, 0.000, 100.000, 0.000, 40.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1803, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1804, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1805, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1806, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1807, 0.000, 0.000, 0.000, 4.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1808, 0.000, 5.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1809, 0.000, 4.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1810, 0.000, 11.000, 0.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1811, 0.000, 15.000, 0.000, 18.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1812, 0.000, 26.000, 0.000, 25.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1813, 0.000, 11.000, 0.000, 4.500, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1814, 0.000, 20.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1815, 0.000, 5.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1816, 40.000, 999.000, 46.000, 65.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1817, 59.000, 999.000, 50.000, 70.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1818, 22.000, 46.000, 20.000, 39.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1819, 12.000, 24.000, 12.000, 12.900, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1820, 0.000, 10.000, 0.000, 5.100, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1821, 0.000, 2.000, 0.000, 4.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1822, 0.000, 1.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1823, 0.600, 0.760, 0.600, 0.760, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1824, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1825, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1826, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1827, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1828, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1829, 11.000, 22.000, 11.000, 14.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1830, 0.000, 11.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1831, 0.000, 8.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1832, 0.000, 8.000, 0.000, 5.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1833, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1834, 0.680, 0.730, 0.680, 0.730, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1835, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1836, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1837, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1838, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1839, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1840, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1841, 0.000, 5.000, 0.000, 5.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1842, 0.000, 5.000, 0.000, 5.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1843, 12.000, 26.000, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1844, 0.000, 5.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1845, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1846, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1847, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1848, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1849, 0.000, 11.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1850, 0.000, 7.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1851, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1852, 0.000, 0.200, 0.000, 0.200, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1853, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1854, 0.710, 0.790, 0.710, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1855, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1856, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1857, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1858, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1859, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1860, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1861, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1862, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1863, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1864, 10.000, 26.000, 12.000, 12.900, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1865, 0.000, 7.000, 0.000, 7.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1866, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1867, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1868, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1869, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1870, 0.000, 17.000, 0.000, 17.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1871, 0.000, 10.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1872, 0.000, 30.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1873, 0.000, 20.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1874, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1875, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1876, 715.000, 0.790, 715.000, 0.760, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1877, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1878, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1879, 12.500, 15.000, 12.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1880, 0.000, 8.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1881, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1882, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1883, 0.000, 4.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1884, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1885, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1886, 0.000, 13.000, 0.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1887, 0.000, 13.000, 0.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1888, 0.000, 26.000, 0.000, 26.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1889, 0.000, 3.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1890, 12.000, 24.000, 12.000, 24.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1891, 0.000, 8.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1892, 0.000, 40.000, 0.000, 40.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1893, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1894, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1895, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1896, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1897, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1898, 0.000, 6.000, 0.000, 6.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1899, 0.000, 50.000, 0.000, 50.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1900, 0.000, 50.000, 0.000, 50.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1901, 0.000, 50.000, 0.000, 50.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1902, 0.000, 50.000, 0.000, 50.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1903, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1904, 0.000, 8.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1905, 0.000, 8.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1906, 40.000, 60.000, 45.000, 60.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1907, 65.000, 70.000, 65.000, 70.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1908, 25.000, 39.000, 30.000, 39.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1909, 16.000, 28.000, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1910, 0.000, 11.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1911, 0.000, 100.000, 0.000, 40.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1912, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1913, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1914, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1915, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1916, 0.000, 0.000, 0.000, 4.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1917, 0.000, 5.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1918, 0.000, 4.000, 0.000, 8.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1919, 0.000, 11.000, 0.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1920, 0.000, 15.000, 0.000, 18.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1921, 0.000, 26.000, 0.000, 25.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1922, 0.000, 11.000, 0.000, 4.500, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1923, 0.000, 20.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1924, 0.000, 5.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1925, 40.000, 999.000, 46.000, 65.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1926, 59.000, 999.000, 50.000, 70.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1927, 22.000, 46.000, 20.000, 39.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1928, 8.000, 19.000, 6.000, 9.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1929, 0.000, 8.000, 0.000, 7.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1930, 0.330, 0.480, 0.330, 0.480, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1931, 12.000, 26.000, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1932, 0.000, 5.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1933, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1934, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1935, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1936, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1937, 0.000, 11.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1938, 0.000, 7.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1939, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1940, 0.000, 0.200, 0.000, 0.200, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1941, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1942, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1943, 0.710, 0.790, 0.710, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1944, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1945, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1946, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1947, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1948, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1949, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1950, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1951, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1952, 6.000, 24.000, 6.000, 9.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1953, 0.000, 20.000, 0.000, 7.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1954, 0.330, 0.480, 0.330, 0.480, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1955, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1956, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1957, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1958, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1959, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1960, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1961, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1962, 12.000, 13.900, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1963, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1964, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1965, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1966, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1967, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1968, 0.000, 11.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1969, 0.000, 10.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1970, 0.000, 7.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1971, 0.000, 0.200, 0.000, 0.200, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1972, 0.000, 10.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1973, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1974, 0.730, 0.760, 0.710, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1975, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1976, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1977, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1978, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1979, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1980, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1981, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1982, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1983, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1984, 12.000, 13.900, 12.000, 13.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1985, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1986, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1987, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1988, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1989, 0.000, 11.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1990, 0.000, 11.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1991, 0.000, 10.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1992, 0.000, 7.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1993, 0.000, 0.200, 0.000, 0.200, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1994, 0.000, 10.000, 0.000, 11.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1995, 0.000, 3.000, 0.000, 3.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1996, 0.730, 0.760, 0.710, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1997, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1998, 0.000, 20.000, 0.000, 20.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1999, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 2000, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 2001, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 2002, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 2003, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 2004, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 2005, 12.000, 30.000, 11.000, 14.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 2006, 0.000, 5.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 2007, 0.000, 11.000, 0.000, 30.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 2008, 0.000, 11.000, 0.000, 30.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 2009, 0.000, 3.000, 0.000, 30.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 2010, 0.000, 11.000, 0.000, 30.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 2011, 0.000, 11.000, 0.000, 60.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 2012, 0.000, 7.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 2013, 0.000, 15.000, 0.000, 15.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 2014, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 2015, 0.000, 10.000, 0.000, 10.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 2016, 0.000, 6.000, 0.000, 6.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 2017, 715.000, 0.790, 715.000, 0.790, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 2018, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 2019, 0.000, 20.000, 0.000, 40.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 2020, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 2021, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 2022, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 2023, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 2024, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 2025, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 2026, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 2027, 0.000, 0.000, 0.000, 0.500, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 2028, 0.000, 0.000, 0.000, 0.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 2029, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 2030, 0.000, 2.000, 0.000, 2.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 2031, 1.000, 2.000, 0.000, 1.000, 9, NULL, NULL);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 2032, 0.000, 1.000, 0.000, 1.000, 9, NULL, NULL);


--
-- TOC entry 2597 (class 0 OID 100778)
-- Dependencies: 169
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2598 (class 0 OID 100783)
-- Dependencies: 171
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2599 (class 0 OID 100791)
-- Dependencies: 173
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2600 (class 0 OID 100797)
-- Dependencies: 175
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2601 (class 0 OID 100804)
-- Dependencies: 177
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
-- TOC entry 2602 (class 0 OID 100817)
-- Dependencies: 178
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2603 (class 0 OID 100827)
-- Dependencies: 181
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2604 (class 0 OID 100834)
-- Dependencies: 182
-- Data for Name: si_contrato; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2605 (class 0 OID 100844)
-- Dependencies: 185
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2606 (class 0 OID 100855)
-- Dependencies: 186
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2607 (class 0 OID 100858)
-- Dependencies: 187
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2608 (class 0 OID 100863)
-- Dependencies: 189
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2609 (class 0 OID 100868)
-- Dependencies: 191
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2610 (class 0 OID 100876)
-- Dependencies: 194
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo VALUES (10, 1, 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '10');
INSERT INTO si_cultivo VALUES (11, 1, 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '11');
INSERT INTO si_cultivo VALUES (12, 1, 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '12');
INSERT INTO si_cultivo VALUES (13, 1, 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '13');
INSERT INTO si_cultivo VALUES (14, 1, 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '14');
INSERT INTO si_cultivo VALUES (15, 1, 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '15');
INSERT INTO si_cultivo VALUES (16, 1, 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '16');
INSERT INTO si_cultivo VALUES (17, 1, 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '17');
INSERT INTO si_cultivo VALUES (18, 1, 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, '68');
INSERT INTO si_cultivo VALUES (19, 1, 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, '92');
INSERT INTO si_cultivo VALUES (20, 1, 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, '93');
INSERT INTO si_cultivo VALUES (21, 1, 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, '94');
INSERT INTO si_cultivo VALUES (22, 1, 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, '95');
INSERT INTO si_cultivo VALUES (23, 1, 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, '96');
INSERT INTO si_cultivo VALUES (24, 1, 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, '97');
INSERT INTO si_cultivo VALUES (25, 1, 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, '98');
INSERT INTO si_cultivo VALUES (26, 1, 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, '99');
INSERT INTO si_cultivo VALUES (1, 1, 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '01');
INSERT INTO si_cultivo VALUES (2, 1, 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '02');
INSERT INTO si_cultivo VALUES (3, 1, 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '03');
INSERT INTO si_cultivo VALUES (4, 1, 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '04');
INSERT INTO si_cultivo VALUES (5, 1, 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '05');
INSERT INTO si_cultivo VALUES (6, 1, 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '06');
INSERT INTO si_cultivo VALUES (7, 1, 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '07');
INSERT INTO si_cultivo VALUES (8, 1, 'ARROZ PADDY ACONDICIONADO', true, 1, '2012-02-18 15:22:10.224543-04:30', '2012-08-08 14:38:38.242918-04:30', true, '08');
INSERT INTO si_cultivo VALUES (9, 1, 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, '09');


--
-- TOC entry 2611 (class 0 OID 100882)
-- Dependencies: 195
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo_tipo VALUES (1, 8, 2, 26, 'A ', 0.00, 4.00);
INSERT INTO si_cultivo_tipo VALUES (2, 8, 2, 26, 'B ', 4.10, 11.00);
INSERT INTO si_cultivo_tipo VALUES (3, 8, 2, 30, 'A ', 0.00, 17.00);
INSERT INTO si_cultivo_tipo VALUES (4, 8, 2, 30, 'B ', 17.10, 30.00);
INSERT INTO si_cultivo_tipo VALUES (5, 8, 2, 31, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (6, 8, 2, 31, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (7, 8, 2, 32, 'A ', 0.00, 8.50);
INSERT INTO si_cultivo_tipo VALUES (8, 8, 2, 32, 'B ', 8.51, 14.00);
INSERT INTO si_cultivo_tipo VALUES (9, 8, 2, 33, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (10, 8, 2, 33, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (11, 8, 7, 26, 'A ', 0.00, 4.00);
INSERT INTO si_cultivo_tipo VALUES (12, 8, 7, 26, 'B ', 4.10, 11.00);
INSERT INTO si_cultivo_tipo VALUES (13, 8, 7, 30, 'A ', 0.00, 17.00);
INSERT INTO si_cultivo_tipo VALUES (14, 8, 7, 30, 'B ', 17.10, 30.00);
INSERT INTO si_cultivo_tipo VALUES (15, 8, 7, 31, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (16, 8, 7, 31, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (17, 8, 7, 32, 'A ', 0.00, 8.50);
INSERT INTO si_cultivo_tipo VALUES (18, 8, 7, 32, 'B ', 8.51, 14.00);
INSERT INTO si_cultivo_tipo VALUES (19, 8, 7, 33, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (20, 8, 7, 33, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (21, 8, 8, 26, 'A ', 0.00, 4.00);
INSERT INTO si_cultivo_tipo VALUES (22, 8, 8, 26, 'B ', 4.10, 11.00);
INSERT INTO si_cultivo_tipo VALUES (23, 8, 8, 30, 'A ', 0.00, 17.00);
INSERT INTO si_cultivo_tipo VALUES (24, 8, 8, 30, 'B ', 17.10, 30.00);
INSERT INTO si_cultivo_tipo VALUES (25, 8, 8, 31, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (26, 8, 8, 31, 'B ', 1.51, 3.00);
INSERT INTO si_cultivo_tipo VALUES (27, 8, 8, 32, 'A ', 0.00, 8.50);
INSERT INTO si_cultivo_tipo VALUES (28, 8, 8, 32, 'B ', 8.51, 14.00);
INSERT INTO si_cultivo_tipo VALUES (29, 8, 8, 33, 'A ', 0.00, 1.50);
INSERT INTO si_cultivo_tipo VALUES (30, 8, 8, 33, 'B ', 1.51, 3.00);


--
-- TOC entry 2612 (class 0 OID 100891)
-- Dependencies: 198
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2613 (class 0 OID 100895)
-- Dependencies: 199
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2614 (class 0 OID 100903)
-- Dependencies: 202
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2615 (class 0 OID 100910)
-- Dependencies: 204
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
-- TOC entry 2616 (class 0 OID 100914)
-- Dependencies: 205
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2617 (class 0 OID 100923)
-- Dependencies: 207
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas VALUES (1, 1, 1, NULL, '(PL1+PL2)', 'PL12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (3, 1, 1, NULL, '((PL1+PL2)-(PV1+PV2))', 'PN', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (2, 1, 1, NULL, '(PV1+PV2)', 'PV12', 3, 2, NULL, '2012-03-13 12:04:04.880697-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (48, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-22 00:00:00-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (49, 1, 1, 2, '(HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)', 'H02', 2, 1, NULL, '2012-08-01 09:07:20.493441-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (51, 1, 1, 7, '(HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)', 'H07', 2, 1, NULL, '2012-08-01 09:15:44.338791-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (52, 1, 1, 8, '(HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)', 'H08', 2, 1, NULL, '2012-08-01 09:16:13.889329-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (22, 1, 1, 8, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 1, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (23, 1, 1, 8, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 1, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (4, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 1, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (5, 1, 1, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 1, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (7, 1, 1, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 1, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (8, 1, 1, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 1, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (9, 1, 1, 2, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H02', 1, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (10, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I02', 1, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (11, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I02', 1, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (14, 1, 1, 7, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 1, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (15, 1, 1, 7, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 1, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (16, 1, 1, 7, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 1, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (17, 1, 1, 7, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 1, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (18, 1, 1, 7, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H07', 1, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (19, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I07', 1, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (20, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I07', 1, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (21, 1, 1, 7, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H07', 1, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (24, 1, 1, 8, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 1, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (25, 1, 1, 8, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 1, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (26, 1, 1, 8, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H08', 1, 1, '20 < 24.01', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (27, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-0)/100))', 'I08', 1, 1, '0 < 4.01', '2012-03-21 15:11:00.976082-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (28, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))*((IMPL-4)/100))', 'I08', 1, 1, '4 < 999999', '2012-03-21 15:53:26.542432-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (29, 1, 1, 8, '(((HUML-24)/1)/(100-12))*(PL1+PL2)', 'H08', 1, 1, '24 < 999999', '2012-03-13 00:00:00-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (6, 1, 1, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'H02', 1, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (53, 1, 1, 7, '(((PL1+PL2)-(PV1+PV2))-((HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)))*(IMPL/100)', 'I07', 2, 1, NULL, '2012-08-01 09:28:20.213246-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (54, 1, 1, 8, '(((PL1+PL2)-(PV1+PV2))-((HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)))*(IMPL/100)', 'I08', 2, 1, NULL, '2012-08-01 09:29:06.444248-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (12, 1, 1, 12, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 1, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (13, 1, 1, 12, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 1, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (56, 1, 1, 18, '((PL1+PL2)-(PV1+PV2))', 'P68', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:14:55.795185-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (57, 1, 1, 20, '((PL1+PL2)-(PV1+PV2))', 'P93', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:15:27.39136-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (58, 1, 1, 21, '((PL1+PL2)-(PV1+PV2))', 'P94', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:16:11.392814-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (59, 1, 1, 22, '((PL1+PL2)-(PV1+PV2))', 'P95', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:16:37.466472-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (60, 1, 1, 23, '((PL1+PL2)-(PV1+PV2))', 'P96', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:17:32.863301-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (61, 1, 1, 24, '((PL1+PL2)-(PV1+PV2))', 'P97', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:17:53.933107-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (62, 1, 1, 25, '((PL1+PL2)-(PV1+PV2))', 'P98', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:18:12.542513-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (63, 1, 1, 26, '((PL1+PL2)-(PV1+PV2))', 'P99', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:18:32.109778-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (50, 1, 1, 2, '(((PL1+PL2)-(PV1+PV2))-((HUML-12)*((PL1+PL2)-(PV1+PV2))/(100-12)))*(IMPL/100)', 'I02', 2, 1, NULL, '2012-08-01 09:08:11.882353-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (55, 1, 1, 19, '((PL1+PL2)-(PV1+PV2))', 'P92', 2, 2, 'HUML+IMPL = 1 < 1', '2012-08-08 16:02:54.119514-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (64, 1, 1, 12, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 2, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (65, 1, 1, 12, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 2, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (66, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (67, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (68, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (69, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (70, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (71, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (72, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (73, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 2, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (74, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I01', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (75, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I06', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (76, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I015', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (77, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I011', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (78, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I017', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (79, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I03', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (80, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I04', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (81, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I05', 2, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (82, 1, 1, 10, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 2, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (83, 1, 1, 10, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 2, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (30, 1, 1, 1, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H01', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (32, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (34, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (36, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (38, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (40, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (42, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (44, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 1, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (31, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I01', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (35, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I06', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (39, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I015', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (37, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I011', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (41, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I017', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (43, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I03', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (45, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I04', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (33, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I05', 1, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (46, 1, 1, 10, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 1, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (47, 1, 1, 10, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 1, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);


--
-- TOC entry 2618 (class 0 OID 100931)
-- Dependencies: 209
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2619 (class 0 OID 100936)
-- Dependencies: 210
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2620 (class 0 OID 100943)
-- Dependencies: 213
-- Data for Name: si_impresora; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_impresora VALUES (2, 2, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (1, 2, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (3, 3, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (4, 3, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (5, 4, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (6, 4, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (7, 5, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (8, 5, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (9, 6, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (10, 6, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (11, 7, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (12, 7, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (13, 8, 1, 'LABC69', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (15, 9, 1, 'IMPRESORA_A', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (16, 9, 9, 'IMPRESORA_B', NULL, '2012-06-01 00:00:00-04:30', NULL);
INSERT INTO si_impresora VALUES (14, 8, 9, 'ROMANA69', NULL, '2012-06-01 00:00:00-04:30', '2012-08-02 03:52:13.250698-04:30');


--
-- TOC entry 2621 (class 0 OID 100950)
-- Dependencies: 216
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2622 (class 0 OID 100956)
-- Dependencies: 218
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2623 (class 0 OID 100965)
-- Dependencies: 220
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (24, 'M_Organizacion', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (25, 'M_Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (21, 'M_Formulas', 4, 'admin/formulacion_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (27, 'M_LabCentral', 2, 'admin/analisis_labcentral.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (31, 'M_labPlanta', 2, 'admin/analisis_labplanta.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (12, 'M_Despacho', 2, 'admin/despacho.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (26, 'M_MenuUsuario', 4, 'admin/menu_usuario_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (1, 'M_Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (6, 'M_CentrosA', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (34, 'M_CosechaProductor', 4, 'admin/cosecha_productor.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (22, 'M_Configuracion', 4, 'admin/parametros.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (36, 'M_BoletaVirtual', 4, 'admin/boleta_virtual.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (5, 'M_Cuenta', 0, NULL, false, 5, NULL, NULL);
INSERT INTO si_menu VALUES (42, 'M_UtilitarioRecepciones', 4, 'admin/utilitario_recepcion_listado.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (44, 'M_UtilitarioDespachos', 4, 'admin/utilitario_despacho_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (38, 'M_CuarentenaPendiente', 2, 'admin/cuarentena_pendiente_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (28, 'M_Romana', 2, 'admin/romana_movimiento.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (13, 'M_Programas', 3, 'reportes/programas.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (14, 'M_Cosecha', 3, 'reportes/cosechas.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (15, 'M_Cultivo', 3, 'reportes/cultivos.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (16, 'M_Productores', 3, 'reportes/productores.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (17, 'M_Recepciones', 3, 'reportes/recepcion.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (18, 'M_Despacho', 3, 'reportes/despacho.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (46, 'M_CargaProductor', 4, 'admin/productor_carga.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (35, 'M_Auditoria', 3, 'reportes/actividad.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (39, 'M_GerenteRecepcion', 3, 'reportes/gerente_recepcion.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (40, 'M_GerenteDespacho', 3, 'reportes/gerente_despacho.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (45, 'M_GranosVerdes', 3, 'reportes/granos_verdes.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (19, 'M_Silos', 4, NULL, false, 1, NULL, NULL);
INSERT INTO si_menu VALUES (23, 'M_ConfigCta', 5, NULL, false, 1, NULL, NULL);
INSERT INTO si_menu VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (47, 'M_Cliente', 1, 'admin/cliente_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (29, 'M_Chofer', 1, 'admin/chofer_listado.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (32, 'M_Ordenes', 1, 'admin/ordenes_listado.php', true, 11, NULL, NULL);
INSERT INTO si_menu VALUES (48, 'M_Contrato', 1, 'admin/contrato_listado.php', true, 12, NULL, NULL);
INSERT INTO si_menu VALUES (49, 'M_Analisis', 1, 'admin/analisis_listado.php', true, 6, NULL, NULL);


--
-- TOC entry 2624 (class 0 OID 100970)
-- Dependencies: 221
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (1, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (49, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (10, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (3, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 1, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (21, 1, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 4, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 4, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 4, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 4, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 4, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 6, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 6, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 6, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 6, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 6, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (1, 14, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 14, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 7, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 12, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 12, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 12, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 12, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 12, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 12, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 12, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 12, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 12, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 12, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 12, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 11, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 11, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 11, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 11, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 11, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 11, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 11, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 11, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 11, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 11, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 11, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 13, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 13, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 13, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 13, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 13, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 3, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 3, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 3, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 3, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 3, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 3, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 3, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 3, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 3, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 2, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 5, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 7, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 10, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 10, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 10, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 10, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 10, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 21, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 21, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 21, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 21, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 21, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 25, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 25, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 25, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 25, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (48, 25, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 25, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 25, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 25, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 25, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 25, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 18, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 18, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 18, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 18, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 18, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 23, 7, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 23, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 23, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 23, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 16, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 16, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 16, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 16, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 16, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 24, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 24, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 24, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 24, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 24, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 22, 7, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 22, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 22, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 22, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 20, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (48, 20, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 20, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 20, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 20, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 20, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 20, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 20, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 20, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 20, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 20, 4, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 20, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 20, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 20, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 20, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 17, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 17, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 17, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 17, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 17, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 19, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 19, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 19, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 19, 6, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 19, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 8, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 8, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 8, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 8, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 8, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 8, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 8, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 9, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (48, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (2, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 9, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 9, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (39, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 9, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (4, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (21, 9, 1, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 9, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 9, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 9, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (46, 9, 0, 0, 0, 0);


--
-- TOC entry 2625 (class 0 OID 100979)
-- Dependencies: 223
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
-- TOC entry 2626 (class 0 OID 100985)
-- Dependencies: 225
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2627 (class 0 OID 100993)
-- Dependencies: 226
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2628 (class 0 OID 101000)
-- Dependencies: 229
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2629 (class 0 OID 101009)
-- Dependencies: 231
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'VENEZUELA');


--
-- TOC entry 2630 (class 0 OID 101015)
-- Dependencies: 233
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
-- TOC entry 2631 (class 0 OID 101024)
-- Dependencies: 235
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles VALUES (1, 'GERENTE GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (3, 'ADMINISTRADOR GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (5, 'CALIDAD GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (2, 'GERENTE DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (4, 'ADMINISTRADOR DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (6, 'CALIDAD DE SILO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles VALUES (7, 'USUARIO', '2012-02-07 00:00:00-04:30', NULL);


--
-- TOC entry 2632 (class 0 OID 101028)
-- Dependencies: 236
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
-- TOC entry 2633 (class 0 OID 101033)
-- Dependencies: 238
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2634 (class 0 OID 101040)
-- Dependencies: 241
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2635 (class 0 OID 101049)
-- Dependencies: 243
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2636 (class 0 OID 101056)
-- Dependencies: 244
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2637 (class 0 OID 101064)
-- Dependencies: 246
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2638 (class 0 OID 101072)
-- Dependencies: 248
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2639 (class 0 OID 101079)
-- Dependencies: 249
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2640 (class 0 OID 101086)
-- Dependencies: 252
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
INSERT INTO si_recursos VALUES (55, 'Boleta Virtual', 'admin', 'boleta_virtual.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (58, 'Consulta Gerente Despachos', 'reportes', 'gerente_despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (57, 'Consulta Gerente Recepcion', 'reportes', 'gerente_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (60, 'Utilitario Recepciones', 'admin', 'utilitario_recepcion_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (61, 'Utilitario Despachos', 'admin', 'utilitario_despacho_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (70, 'Reporte de Cosechas', 'reportes', 'cosechas.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (18, 'Popup de Cliente', 'admin', 'cliente_popup.php', 1, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos VALUES (63, 'Popup de Chofer', 'admin', 'chofer_popup.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (64, 'Popup de Vehiculo', 'admin', 'vehiculo_popup.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (65, 'Cosecha Productor', 'admin', 'cosecha_productor.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (66, 'Cuarentena Pendiente', 'admin', 'cuarentena_pendiente.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (56, 'Cuarentena Pendiente Listado', 'admin', 'cuarentena_pendiente_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (67, 'Menu Usuario Listado', 'admin', 'menu_usuario_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (68, 'Parametros', 'admin', 'parametros.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (59, 'Reporte de Actividad', 'reportes', 'actividad.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (69, 'Popup de Analisis', 'reportes', 'analisis_popup.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (53, 'Reporte Despacho', 'reportes', 'despacho.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (54, 'Reporte Recepcion', 'reportes', 'recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (71, 'Reporte de Cultivos', 'reportes', 'cultivos.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (72, 'Consulta Gerente Recepcion Detalle', 'reportes', 'gerente_recepcion_detalle.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (73, 'Consulta Gerente Despacho Detalle', 'reportes', 'gerente_despacho_detalle.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (74, 'Reporte Granos Verdes', 'reportes', 'granos_verdes.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (75, 'Reporte de Productores', 'reportes', 'productores.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (76, 'Reporte de Programas', 'reportes', 'programas.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (77, 'Reporte de Activididad Detalle', 'reportes', 'ver_log.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (62, 'Cambiar Contrasena', 'admin', 'cambiar_contrasena.php', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (78, 'Carga de Productores', 'admin', 'productor_carga.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (79, 'Ver Archivo Productores', 'admin', 'productor_carga_ver.php', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos VALUES (80, 'Contratos', 'admin', 'contrato_listado.php', 1, '2012-03-06 00:00:00-04:30', NULL);


--
-- TOC entry 2641 (class 0 OID 101093)
-- Dependencies: 253
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
INSERT INTO si_recursos_etiquetas VALUES (19, 1, 'M_Programas', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (20, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (22, 1, 'M_Recepcion', 'Recepci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (23, 1, 'M_Despacho', 'Despacho', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (24, 1, 'M_Programa', 'Programas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (25, 1, 'M_Cosecha', 'Cosechas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (15, 1, 'M_CtrolProcesos', 'Control de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (18, 1, 'M_Cultivo', 'Cultivos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (50, 1, 'M_CuarentenaPendiente', 'Cuarentenas Pendientes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (26, 1, 'M_Productores', 'Productores', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (27, 1, 'M_Recepciones', 'Recepciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (28, 1, 'M_Despacho', 'Despachos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (29, 1, 'M_Silos', 'Silos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (30, 1, 'M_Usuarios', 'Usuarios', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (31, 1, 'M_Formulas', 'F&oacute;rmulas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (32, 1, 'M_Configuracion', 'Configuraci&oacute;n', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (33, 1, 'M_ConfigCta', 'Config. Cuenta', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (34, 1, 'M_Organizacion', 'Organizaciones', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (35, 1, 'M_Almacenes', 'Almacenes', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (36, 1, 'M_MenuUsuario', 'Asignar Men&uacute;', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (37, 1, 'M_LabCentral', 'Laboratorio Central', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (38, 1, 'M_Romana', 'Romana', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (39, 3, 'E_FueraNorma', 'El valor indicado está fuera de norma.!!!', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (40, 1, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (41, 1, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (43, 1, 'M_labPlanta', 'Laboratorio Planta', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (44, 1, 'M_BoletaRechazo', 'NO APTO PARA LA RECEPCION EN NUESTRA PLANTA POR SOBREPASAR LOS LIMITES EVALUADOS EN CUANTO A:', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (45, 1, 'M_Ordenes', 'Ordenes de Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (46, 1, 'M_Asociacion', 'Asociaciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (47, 1, 'M_CosechaProductor', 'Productores Cosecha', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (48, 1, 'M_Auditoria', 'Auditoria del Sistema', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (49, 1, 'M_BoletaVirtual', 'Boleta Virtual', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (51, 1, 'M_GerenteRecepcion', 'Gerente Recepci&oacute;n', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (52, 1, 'M_GerenteDespacho', 'Gerente Despacho', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (55, 1, 'M_GranosVerdes', 'Granos Verdes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (53, 1, 'M_UtilitarioRecepciones', 'Utilitario Recepciones', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (54, 1, 'M_UtilitarioDespachos', 'Utilitario Despachos', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (56, 1, 'M_CargaProductor', 'Carga de Productores', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (57, 1, 'M_Cliente', 'Clientes', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (21, 1, 'M_Productor', 'Productores', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (42, 1, 'M_Chofer', 'Choferes', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (58, 2, 'usuario_conectado', 'Usuario ya conectado', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (59, 1, 'M_Contrato', 'Contratos', 1, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas VALUES (60, 1, 'M_Analisis', 'Analisis', 1, '2012-03-06 00:00:00-04:30', NULL);


--
-- TOC entry 2642 (class 0 OID 101106)
-- Dependencies: 257
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_silos VALUES (1, 2, 2, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:01:40.130888-04:30', '2012-02-19 19:46:46.671-04:30', true);
INSERT INTO si_silos VALUES (2, 2, 2, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:01:40.147421-04:30', '2012-06-22 09:50:30.405966-04:30', true);
INSERT INTO si_silos VALUES (3, 2, 2, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:01:40.164032-04:30', NULL, true);
INSERT INTO si_silos VALUES (4, 2, 2, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:01:40.180896-04:30', NULL, true);
INSERT INTO si_silos VALUES (5, 2, 2, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:01:40.197353-04:30', '2012-05-03 14:47:10.601082-04:30', true);
INSERT INTO si_silos VALUES (6, 3, 3, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:05:32.047308-04:30', NULL, true);
INSERT INTO si_silos VALUES (7, 3, 3, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:05:32.064005-04:30', NULL, true);
INSERT INTO si_silos VALUES (8, 3, 3, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:05:32.080546-04:30', NULL, true);
INSERT INTO si_silos VALUES (9, 3, 3, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:05:32.097424-04:30', NULL, true);
INSERT INTO si_silos VALUES (10, 3, 3, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:05:32.114005-04:30', NULL, true);
INSERT INTO si_silos VALUES (11, 3, 3, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:05:32.130658-04:30', NULL, true);
INSERT INTO si_silos VALUES (12, 3, 3, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:05:32.147097-04:30', NULL, true);
INSERT INTO si_silos VALUES (13, 3, 3, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:05:32.164022-04:30', NULL, true);
INSERT INTO si_silos VALUES (14, 3, 3, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:05:32.180592-04:30', NULL, true);
INSERT INTO si_silos VALUES (15, 3, 3, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:05:32.197159-04:30', NULL, true);
INSERT INTO si_silos VALUES (16, 4, 4, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:06:27.348165-04:30', NULL, true);
INSERT INTO si_silos VALUES (17, 4, 4, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:06:27.365003-04:30', NULL, true);
INSERT INTO si_silos VALUES (18, 4, 4, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:06:27.381487-04:30', NULL, true);
INSERT INTO si_silos VALUES (19, 4, 4, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:06:27.39829-04:30', NULL, true);
INSERT INTO si_silos VALUES (20, 4, 4, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:06:27.414956-04:30', NULL, true);
INSERT INTO si_silos VALUES (21, 4, 4, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:06:27.431423-04:30', NULL, true);
INSERT INTO si_silos VALUES (22, 4, 4, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:06:27.448256-04:30', NULL, true);
INSERT INTO si_silos VALUES (23, 4, 4, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:06:27.464898-04:30', NULL, true);
INSERT INTO si_silos VALUES (24, 4, 4, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:06:27.481472-04:30', NULL, true);
INSERT INTO si_silos VALUES (25, 4, 4, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:06:27.498121-04:30', NULL, true);
INSERT INTO si_silos VALUES (26, 4, 4, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:06:27.514982-04:30', NULL, true);
INSERT INTO si_silos VALUES (27, 4, 4, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:06:27.531417-04:30', NULL, true);
INSERT INTO si_silos VALUES (28, 4, 4, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:06:27.548043-04:30', NULL, true);
INSERT INTO si_silos VALUES (29, 4, 4, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:06:27.565593-04:30', NULL, true);
INSERT INTO si_silos VALUES (30, 4, 4, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:06:27.585406-04:30', NULL, true);
INSERT INTO si_silos VALUES (31, 4, 4, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:06:27.598079-04:30', NULL, true);
INSERT INTO si_silos VALUES (32, 4, 4, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:06:27.614882-04:30', NULL, true);
INSERT INTO si_silos VALUES (33, 4, 4, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:06:27.631368-04:30', NULL, true);
INSERT INTO si_silos VALUES (34, 4, 4, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:06:27.64816-04:30', NULL, true);
INSERT INTO si_silos VALUES (35, 4, 4, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:06:27.664683-04:30', NULL, true);
INSERT INTO si_silos VALUES (36, 4, 4, 'SILO 21', 'MODULO A', 21, 1000, NULL, 'A ', '2012-02-13 11:06:27.681424-04:30', NULL, true);
INSERT INTO si_silos VALUES (37, 4, 4, 'SILO 22', 'MODULO A', 22, 1000, NULL, 'A ', '2012-02-13 11:06:27.698087-04:30', NULL, true);
INSERT INTO si_silos VALUES (38, 4, 4, 'SILO 23', 'MODULO A', 23, 1000, NULL, 'A ', '2012-02-13 11:06:27.714699-04:30', NULL, true);
INSERT INTO si_silos VALUES (39, 4, 4, 'SILO 24', 'MODULO A', 24, 1000, NULL, 'A ', '2012-02-13 11:06:27.731507-04:30', NULL, true);
INSERT INTO si_silos VALUES (40, 5, 5, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:12:33.341886-04:30', NULL, true);
INSERT INTO si_silos VALUES (41, 5, 5, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:12:33.358622-04:30', NULL, true);
INSERT INTO si_silos VALUES (42, 5, 5, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:12:33.375377-04:30', NULL, true);
INSERT INTO si_silos VALUES (43, 5, 5, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:12:33.39185-04:30', NULL, true);
INSERT INTO si_silos VALUES (44, 5, 5, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:12:33.408492-04:30', NULL, true);
INSERT INTO si_silos VALUES (45, 5, 5, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:12:33.425069-04:30', NULL, true);
INSERT INTO si_silos VALUES (46, 5, 5, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:12:33.442001-04:30', NULL, true);
INSERT INTO si_silos VALUES (47, 5, 5, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:12:33.458509-04:30', NULL, true);
INSERT INTO si_silos VALUES (48, 5, 5, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:12:33.475215-04:30', NULL, true);
INSERT INTO si_silos VALUES (49, 5, 5, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:12:33.491855-04:30', NULL, true);
INSERT INTO si_silos VALUES (50, 5, 5, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:12:33.508602-04:30', NULL, true);
INSERT INTO si_silos VALUES (51, 5, 5, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:12:33.525128-04:30', NULL, true);
INSERT INTO si_silos VALUES (52, 5, 5, 'SILO 13', 'MODULO A', 13, 1000, NULL, 'A ', '2012-02-13 11:12:33.541914-04:30', NULL, true);
INSERT INTO si_silos VALUES (53, 5, 5, 'SILO 14', 'MODULO A', 14, 1000, NULL, 'A ', '2012-02-13 11:12:33.561376-04:30', NULL, true);
INSERT INTO si_silos VALUES (54, 5, 5, 'SILO 15', 'MODULO A', 15, 1000, NULL, 'A ', '2012-02-13 11:12:33.575171-04:30', NULL, true);
INSERT INTO si_silos VALUES (55, 5, 5, 'SILO 16', 'MODULO A', 16, 1000, NULL, 'A ', '2012-02-13 11:12:33.59178-04:30', NULL, true);
INSERT INTO si_silos VALUES (56, 5, 5, 'SILO 17', 'MODULO A', 17, 1000, NULL, 'A ', '2012-02-13 11:12:33.60849-04:30', NULL, true);
INSERT INTO si_silos VALUES (57, 5, 5, 'SILO 18', 'MODULO A', 18, 1000, NULL, 'A ', '2012-02-13 11:12:33.625125-04:30', NULL, true);
INSERT INTO si_silos VALUES (58, 5, 5, 'SILO 19', 'MODULO A', 19, 1000, NULL, 'A ', '2012-02-13 11:12:33.64196-04:30', NULL, true);
INSERT INTO si_silos VALUES (59, 5, 5, 'SILO 20', 'MODULO A', 20, 1000, NULL, 'A ', '2012-02-13 11:12:33.658508-04:30', NULL, true);
INSERT INTO si_silos VALUES (60, 6, 6, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-13 11:25:07.764398-04:30', NULL, true);
INSERT INTO si_silos VALUES (61, 6, 6, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-13 11:25:07.781128-04:30', NULL, true);
INSERT INTO si_silos VALUES (62, 6, 6, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-13 11:25:07.797725-04:30', NULL, true);
INSERT INTO si_silos VALUES (63, 6, 6, 'SILO 4', 'MODULO A', 4, 1000, NULL, 'A ', '2012-02-13 11:25:07.814551-04:30', NULL, true);
INSERT INTO si_silos VALUES (64, 6, 6, 'SILO 5', 'MODULO A', 5, 1000, NULL, 'A ', '2012-02-13 11:25:07.831087-04:30', NULL, true);
INSERT INTO si_silos VALUES (66, 6, 6, 'SILO 7', 'MODULO A', 7, 1000, NULL, 'A ', '2012-02-13 11:25:07.864434-04:30', NULL, true);
INSERT INTO si_silos VALUES (67, 6, 6, 'SILO 8', 'MODULO A', 8, 1000, NULL, 'A ', '2012-02-13 11:25:07.880988-04:30', NULL, true);
INSERT INTO si_silos VALUES (68, 6, 6, 'SILO 9', 'MODULO A', 9, 1000, NULL, 'A ', '2012-02-13 11:25:07.897561-04:30', NULL, true);
INSERT INTO si_silos VALUES (69, 6, 6, 'SILO 10', 'MODULO A', 10, 1000, NULL, 'A ', '2012-02-13 11:25:07.914479-04:30', NULL, true);
INSERT INTO si_silos VALUES (70, 6, 6, 'SILO 11', 'MODULO A', 11, 1000, NULL, 'A ', '2012-02-13 11:25:07.931073-04:30', NULL, true);
INSERT INTO si_silos VALUES (71, 6, 6, 'SILO 12', 'MODULO A', 12, 1000, NULL, 'A ', '2012-02-13 11:25:07.947754-04:30', NULL, true);
INSERT INTO si_silos VALUES (72, 7, 7, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:27:38-04:30', NULL, true);
INSERT INTO si_silos VALUES (73, 7, 7, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:27:55-04:30', NULL, true);
INSERT INTO si_silos VALUES (74, 8, 8, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:35:00.46-04:30', NULL, true);
INSERT INTO si_silos VALUES (75, 8, 8, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:35:00.478-04:30', NULL, true);
INSERT INTO si_silos VALUES (76, 8, 8, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:35:00.481-04:30', NULL, true);
INSERT INTO si_silos VALUES (77, 9, 9, 'SILO 1', 'MODULO A', 1, 1000, NULL, 'A ', '2012-02-19 15:39:25.175-04:30', NULL, true);
INSERT INTO si_silos VALUES (78, 9, 9, 'SILO 2', 'MODULO A', 2, 1000, NULL, 'A ', '2012-02-19 15:39:25.182-04:30', NULL, true);
INSERT INTO si_silos VALUES (79, 9, 9, 'SILO 3', 'MODULO A', 3, 1000, NULL, 'A ', '2012-02-19 15:39:25.185-04:30', NULL, true);
INSERT INTO si_silos VALUES (65, 6, 6, 'SILO 6', 'MODULO A', 6, 1000, NULL, 'A ', '2012-02-13 11:25:07.847859-04:30', NULL, true);


--
-- TOC entry 2643 (class 0 OID 101116)
-- Dependencies: 259
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_tolcarom VALUES (37, 8, 'TOLVA 1', 1, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (38, 8, 'TOLVA 2', 2, '1', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (39, 8, 'CARRIL 1', 1, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (40, 8, 'CARRIL 2', 2, '2', true, '2012-03-20 15:51:17.53979-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (41, 8, 'ROMANA 1', 1, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, 'HTTP://192.168.69.50:9600');
INSERT INTO si_tolcarom VALUES (42, 8, 'ROMANA 2', 2, '3', true, '2012-03-20 15:51:17.53979-04:30', NULL, 'HTTP://192.168.69.50:9601');
INSERT INTO si_tolcarom VALUES (43, 9, 'TOLVA 1', 1, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (44, 9, 'TOLVA 2', 2, '1', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (45, 9, 'CARRIL 1', 1, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (46, 9, 'CARRIL 2', 2, '2', true, '2012-03-20 15:51:22.130722-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (1, 2, 'TOLVA 1', 1, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (2, 2, 'TOLVA 2', 2, '1', true, '2012-03-20 15:49:42.254884-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (3, 2, 'CARRIL 1', 1, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (4, 2, 'CARRIL 2', 2, '2', true, '2012-03-20 15:50:13.473772-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (5, 2, 'ROMANA 1', 1, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'HTTP://192.168.56.89:9601');
INSERT INTO si_tolcarom VALUES (6, 2, 'ROMANA 2', 2, '3', true, '2012-03-20 15:50:32.855835-04:30', NULL, 'HTTP://192.168.56.89:9600');
INSERT INTO si_tolcarom VALUES (7, 3, 'TOLVA 1', 1, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (8, 3, 'TOLVA 2', 2, '1', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (9, 3, 'CARRIL 1', 1, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (10, 3, 'CARRIL 2', 2, '2', true, '2012-03-20 15:50:48.726304-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (13, 4, 'TOLVA 1', 1, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (14, 4, 'TOLVA 2', 2, '1', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (15, 4, 'CARRIL 1', 1, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (16, 4, 'CARRIL 2', 2, '2', true, '2012-03-20 15:50:52.664404-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (17, 4, 'ROMANA 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'HTTP://192.168.58.74:9600');
INSERT INTO si_tolcarom VALUES (18, 4, 'ROMANA 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'HTTP://192.168.58.74:9600');
INSERT INTO si_tolcarom VALUES (19, 5, 'TOLVA 1', 1, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (20, 5, 'TOLVA 2', 2, '1', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (21, 5, 'CARRIL 1', 1, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (22, 5, 'CARRIL 2', 2, '2', true, '2012-03-20 15:50:58.99675-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (25, 6, 'TOLVA 1', 1, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (26, 6, 'TOLVA 2', 2, '1', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (27, 6, 'CARRIL 1', 1, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (28, 6, 'CARRIL 2', 2, '2', true, '2012-03-20 15:51:09.572982-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (31, 7, 'TOLVA 1', 1, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (32, 7, 'TOLVA 2', 2, '1', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (33, 7, 'CARRIL 1', 1, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (34, 7, 'CARRIL 2', 2, '2', true, '2012-03-20 15:51:13.648062-04:30', NULL, NULL);
INSERT INTO si_tolcarom VALUES (47, 9, 'ROMANA 1', 1, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, 'HTTP://192.168.71.00:9600');
INSERT INTO si_tolcarom VALUES (48, 9, 'ROMANA 2', 2, '3', true, '2012-03-20 15:51:22.130722-04:30', NULL, 'HTTP://192.168.71.00:9601');
INSERT INTO si_tolcarom VALUES (11, 3, 'ROMANA 1', 1, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, 'HTTP://192.168.57.00:9600');
INSERT INTO si_tolcarom VALUES (12, 3, 'ROMANA 2', 2, '3', true, '2012-03-20 15:50:48.726304-04:30', NULL, 'HTTP://192.168.57.00:9601');
INSERT INTO si_tolcarom VALUES (23, 5, 'ROMANA 1', 1, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, 'HTTP://192.168.60.00:9600');
INSERT INTO si_tolcarom VALUES (24, 5, 'ROMANA 2', 2, '3', true, '2012-03-20 15:50:58.99675-04:30', NULL, 'HTTP://192.168.60.00:9601');
INSERT INTO si_tolcarom VALUES (29, 6, 'ROMANA 1', 1, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, 'HTTP://192.168.63.00:9600');
INSERT INTO si_tolcarom VALUES (30, 6, 'ROMANA 2', 2, '3', true, '2012-03-20 15:51:09.572982-04:30', NULL, 'HTTP://192.168.63.00:9601');
INSERT INTO si_tolcarom VALUES (35, 7, 'ROMANA 1', 1, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, 'HTTP://192.168.67.00:9600');
INSERT INTO si_tolcarom VALUES (36, 7, 'ROMANA 2', 2, '3', true, '2012-03-20 15:51:13.648062-04:30', NULL, 'HTTP://192.168.67.00:9601');


--
-- TOC entry 2644 (class 0 OID 101122)
-- Dependencies: 260
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2645 (class 0 OID 101132)
-- Dependencies: 263
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (7, 'JESUS', 'MACHUCA', '10123456', NULL, 'M', 'JMACHUCA', 'AE14A76B811E68F055D9B4ACFED84125EF89E02F', NULL, NULL, NULL, '2012-06-11 11:15:08.878579-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:15:08.878579-04:30');
INSERT INTO si_usuarios VALUES (3, 'MARIA MATILDE', 'SOSA RUIZ', '10123452', NULL, 'F', 'MMATILDE', '944F61B851E2C9689695C84EC79B85323337DD3C', NULL, NULL, NULL, '2012-06-11 10:56:19.826174-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 10:56:19.826174-04:30');
INSERT INTO si_usuarios VALUES (6, 'TEDDY', 'MRKIC', '10123455', NULL, 'M', 'TMRKIC', 'D968B0E240A1AA578FBF6D183037ED733253E496', NULL, NULL, NULL, '2012-06-11 11:14:34.207801-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:14:34.207801-04:30');
INSERT INTO si_usuarios VALUES (10, 'YESLEY', 'REYES', '10123459', NULL, 'M', 'YREYES', 'A21F63194A89DA6CA8CD5A93DC55DF507C1FE28E', NULL, NULL, NULL, '2012-06-11 11:16:44.137759-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:16:44.137759-04:30');
INSERT INTO si_usuarios VALUES (11, 'JOSE', 'PELUZZO', '10123460', NULL, 'M', 'JPELUZZO', 'BEA59914A3F4776602DBF491D08507A27D8AC7B5', NULL, NULL, NULL, '2012-06-11 13:38:17.68568-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 13:38:17.68568-04:30');
INSERT INTO si_usuarios VALUES (14, 'ANA', 'PEREZ', '16236123', '1985-07-20', 'F', 'ANA', '8CB2237D0679CA88DB6464EAC60DA96345513964', 'CAGUA CENTRO', '0424-3036768', 'ANAPEREZ@HOTMAIL.COM', '2012-07-10 08:51:59.251669-04:30', NULL, true, 0, NULL, NULL, '2012-07-10 08:51:59.251669-04:30');
INSERT INTO si_usuarios VALUES (4, 'RONNY', 'SOSA', '10123453', NULL, 'M', 'RSOSA', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-06-11 11:13:08.796151-04:30', NULL, true, 0, NULL, NULL, '2012-07-16 09:03:21.336466-04:30');
INSERT INTO si_usuarios VALUES (13, 'JUAN C', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '6E3AAF42AB888C78CE85DAF51E27D1E472D13166', NULL, NULL, NULL, '2012-06-11 13:39:42.787984-04:30', NULL, true, 0, NULL, NULL, '2012-07-17 11:37:48.147281-04:30');
INSERT INTO si_usuarios VALUES (2, 'LUIS', 'ESTRADA', '10123451', NULL, 'M', 'LESTRADA', '13D37B196E0D8B25B8F43BC303F84C6ECC4D604C', NULL, NULL, NULL, '2012-06-11 11:10:02.113171-04:30', '2012-07-21 20:31:12.833-04:30', true, 0, NULL, '2012-07-21 22:37:13.076-04:30', '2012-07-21 20:31:12.833-04:30');
INSERT INTO si_usuarios VALUES (25, 'DENNYS', 'LOVERA', '14239840', NULL, 'F', 'DLOVERA', 'C2A0283369DDBA58652C850C60546DD482FA1F8F', NULL, NULL, NULL, '2012-08-01 14:11:52.770948-04:30', '2012-08-02 04:11:53.106498-04:30', true, 0, NULL, '2012-08-03 10:33:26.220871-04:30', '2012-08-02 04:11:53.106498-04:30');
INSERT INTO si_usuarios VALUES (22, 'SORELIS', 'PURICA', '21277309', NULL, 'F', 'SPURICA', '8CBF9FB982FF4B2D629253B1C4172FB4D0C8BF46', NULL, NULL, NULL, '2012-08-01 14:04:41.32776-04:30', '2012-08-02 02:38:20.773951-04:30', true, 0, NULL, '2012-08-03 10:37:07.659515-04:30', '2012-08-02 02:38:20.773951-04:30');
INSERT INTO si_usuarios VALUES (16, 'RAFAEL', 'FLORES', '7947071', NULL, 'M', 'RFLORES', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 13:51:05.994777-04:30', NULL, true, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (17, 'WILMER ', 'TORREALBA', '8619055', NULL, 'M', 'WTORREALBA', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 13:52:38.317317-04:30', NULL, true, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (18, 'JORGE', 'GONZALEZ', '6255543', NULL, 'M', 'JGONZALEZ', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 13:55:02.350836-04:30', NULL, true, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (19, 'YOEL', 'MEZA', '13650902', NULL, 'M', 'YMEZA', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 13:57:31.214816-04:30', NULL, true, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (20, 'VLADMYS', 'RODRIGUEZ', '14539232', NULL, 'F', 'VRODRIGUEZ', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 14:00:47.303379-04:30', NULL, true, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (21, 'ALNARDO', 'PEREZ', '15481891', NULL, 'M', 'APEREZ', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-08-01 14:02:12.483345-04:30', NULL, true, 0, NULL, '2012-08-01 14:30:12.214594-04:30', '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (23, 'MARIELA', 'GARCIA', '17374383', NULL, 'F', 'MGARCIA', '562D186E0D266A613655B47765892429973356C2', NULL, NULL, NULL, '2012-08-01 14:06:23.015853-04:30', '2012-08-02 02:45:41.155926-04:30', true, 0, NULL, '2012-08-02 15:26:04.482352-04:30', '2012-08-02 02:45:41.155926-04:30');
INSERT INTO si_usuarios VALUES (24, 'ROSANGELA', 'CORDOVA', '17602815', NULL, 'F', 'RCORDOVA', 'F3B7E10E7C30D2B4C84DD33E625AC0736A92791C', NULL, NULL, NULL, '2012-08-01 14:09:34.264028-04:30', '2012-08-02 04:19:37.583011-04:30', true, 0, NULL, '2012-08-03 09:41:46.023622-04:30', '2012-08-02 04:19:37.583011-04:30');
INSERT INTO si_usuarios VALUES (1, 'ADMINISTRADOR', 'ADMINISTRADOR', '11111111', '1980-01-01', 'M', 'ADMIN', 'FE6268C04422554898E72C424D645519C2EFBE2D', NULL, NULL, NULL, '2012-02-12 00:00:00-04:30', '2012-07-22 00:44:13.694-04:30', true, 0, NULL, '2012-08-10 16:05:53.243168-04:30', '2012-07-22 00:44:13.694-04:30');
INSERT INTO si_usuarios VALUES (9, 'ROSNELL', 'JASPE', '10123458', NULL, 'M', 'RJASPE', '00C4968E225C1390F8F183513872DFDC1B9C7F1C', NULL, NULL, NULL, '2012-06-11 11:16:08.958747-04:30', NULL, true, 0, NULL, '2012-08-10 16:14:27.828048-04:30', '2012-07-16 09:17:46.173869-04:30');
INSERT INTO si_usuarios VALUES (5, 'LUIS', 'BLANCHARD', '10123454', NULL, 'M', 'LBLANCHARD', '99E991EADED1B70853A249972B4A3219514C944A', NULL, NULL, NULL, '2012-06-11 11:13:49.203357-04:30', '2012-08-07 10:26:46.504607-04:30', true, 0, NULL, '2012-08-09 16:24:49.255009-04:30', '2012-08-07 10:26:46.504607-04:30');
INSERT INTO si_usuarios VALUES (12, 'JESUS E', 'RODRIGUEZ V', '18264065', NULL, 'M', 'JRODRIGUEZ', '8CB2237D0679CA88DB6464EAC60DA96345513964', NULL, NULL, NULL, '2012-06-11 13:38:46.329242-04:30', '2012-08-07 10:04:39.549451-04:30', false, 0, NULL, NULL, '2012-01-01 00:00:00-04:30');
INSERT INTO si_usuarios VALUES (8, 'CARMEN', 'MORENO', '10123457', NULL, 'F', 'CMORENO', '8598CE4987C1195D19CF3E1E66DE1B1107AF0858', NULL, NULL, NULL, '2012-06-11 11:15:36.22558-04:30', '2012-08-09 09:33:15.182889-04:30', true, 1, 'q6119eos9lullqe1ru6ft4nj20', '2012-08-10 08:27:09.344837-04:30', '2012-08-09 09:33:15.182889-04:30');


--
-- TOC entry 2646 (class 0 OID 101143)
-- Dependencies: 265
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles VALUES (3, 3, 1, 1, '2012-06-11 10:56:19.867664-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (4, 4, 3, 2, '2012-06-11 11:13:08.859992-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (5, 5, 4, 2, '2012-06-11 11:13:49.237769-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (6, 6, 5, 2, '2012-06-11 11:14:34.244331-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (7, 7, 6, 2, '2012-06-11 11:15:08.910829-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (8, 8, 7, 2, '2012-06-11 11:15:36.259493-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (9, 9, 8, 2, '2012-06-11 11:16:09.036091-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (10, 10, 9, 2, '2012-06-11 11:16:44.168897-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (11, 11, 1, 1, '2012-06-11 13:38:17.713667-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (13, 13, 1, 1, '2012-06-11 13:39:42.814767-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', '2012-06-21 10:05:05.156525-04:30');
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', '2012-06-21 10:07:37.117918-04:30');
INSERT INTO si_usuarios_perfiles VALUES (14, 14, 2, 6, '2012-07-10 08:51:59.32012-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (15, 16, 8, 6, '2012-08-01 13:51:05.997489-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (16, 17, 8, 6, '2012-08-01 13:52:38.319847-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (17, 18, 8, 6, '2012-08-01 13:55:02.353395-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (18, 19, 8, 6, '2012-08-01 13:57:31.217264-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (19, 20, 8, 4, '2012-08-01 14:00:47.305945-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (20, 21, 8, 6, '2012-08-01 14:02:12.485725-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (21, 22, 8, 7, '2012-08-01 14:04:41.330269-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (22, 23, 8, 7, '2012-08-01 14:06:23.01833-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (23, 24, 8, 6, '2012-08-01 14:09:34.266519-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (24, 25, 8, 4, '2012-08-01 14:11:52.773098-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (12, 12, 1, 1, '2012-06-11 13:38:46.361-04:30', '2012-08-07 10:04:39.579811-04:30');


--
-- TOC entry 2647 (class 0 OID 101147)
-- Dependencies: 266
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2370 (class 2606 OID 101179)
-- Dependencies: 171 171
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2420 (class 2606 OID 101181)
-- Dependencies: 216 216
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2358 (class 2606 OID 101183)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2364 (class 2606 OID 101185)
-- Dependencies: 165 165
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2366 (class 2606 OID 101187)
-- Dependencies: 167 167
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2360 (class 2606 OID 101189)
-- Dependencies: 164 164 164
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2362 (class 2606 OID 101191)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2368 (class 2606 OID 101193)
-- Dependencies: 169 169
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2372 (class 2606 OID 101195)
-- Dependencies: 173 173
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2374 (class 2606 OID 101197)
-- Dependencies: 175 175
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2376 (class 2606 OID 101199)
-- Dependencies: 177 177
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2378 (class 2606 OID 101201)
-- Dependencies: 178 178
-- Name: si_choferes_ced_rif_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_ced_rif_key UNIQUE (ced_rif);


--
-- TOC entry 2380 (class 2606 OID 101203)
-- Dependencies: 178 178
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2382 (class 2606 OID 101205)
-- Dependencies: 181 181
-- Name: si_cliente_ced_rif_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_ced_rif_key UNIQUE (ced_rif);


--
-- TOC entry 2384 (class 2606 OID 101207)
-- Dependencies: 181 181
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2386 (class 2606 OID 101209)
-- Dependencies: 182 182
-- Name: si_contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_contrato
    ADD CONSTRAINT si_contrato_pkey PRIMARY KEY (id);


--
-- TOC entry 2388 (class 2606 OID 101211)
-- Dependencies: 185 185
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2390 (class 2606 OID 101213)
-- Dependencies: 187 187 187 187
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2392 (class 2606 OID 101215)
-- Dependencies: 187 187
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2394 (class 2606 OID 101217)
-- Dependencies: 189 189
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2396 (class 2606 OID 101219)
-- Dependencies: 191 191
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2398 (class 2606 OID 101221)
-- Dependencies: 194 194
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2400 (class 2606 OID 101223)
-- Dependencies: 195 195
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2402 (class 2606 OID 101225)
-- Dependencies: 198 198
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2404 (class 2606 OID 101227)
-- Dependencies: 199 199
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2406 (class 2606 OID 101229)
-- Dependencies: 202 202
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2408 (class 2606 OID 101231)
-- Dependencies: 204 204
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2410 (class 2606 OID 101233)
-- Dependencies: 205 205
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2412 (class 2606 OID 101235)
-- Dependencies: 207 207
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2414 (class 2606 OID 101237)
-- Dependencies: 209 209
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2416 (class 2606 OID 101239)
-- Dependencies: 210 210
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2418 (class 2606 OID 101241)
-- Dependencies: 213 213
-- Name: si_impresora_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_pkey PRIMARY KEY (id);


--
-- TOC entry 2422 (class 2606 OID 101243)
-- Dependencies: 218 218
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2424 (class 2606 OID 101245)
-- Dependencies: 220 220
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2426 (class 2606 OID 101247)
-- Dependencies: 221 221 221
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2428 (class 2606 OID 101249)
-- Dependencies: 223 223
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2432 (class 2606 OID 101251)
-- Dependencies: 226 226
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2430 (class 2606 OID 101253)
-- Dependencies: 225 225
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2434 (class 2606 OID 101255)
-- Dependencies: 229 229
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2436 (class 2606 OID 101257)
-- Dependencies: 231 231
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2438 (class 2606 OID 101259)
-- Dependencies: 233 233
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2440 (class 2606 OID 101261)
-- Dependencies: 235 235
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2442 (class 2606 OID 101263)
-- Dependencies: 236 236
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2444 (class 2606 OID 101265)
-- Dependencies: 238 238
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2446 (class 2606 OID 101267)
-- Dependencies: 241 241
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2448 (class 2606 OID 101269)
-- Dependencies: 243 243
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2450 (class 2606 OID 101271)
-- Dependencies: 244 244
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2452 (class 2606 OID 101273)
-- Dependencies: 246 246
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2456 (class 2606 OID 101275)
-- Dependencies: 249 249
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2454 (class 2606 OID 101277)
-- Dependencies: 248 248
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2460 (class 2606 OID 101279)
-- Dependencies: 253 253
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2458 (class 2606 OID 101281)
-- Dependencies: 252 252
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2462 (class 2606 OID 101283)
-- Dependencies: 257 257
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2464 (class 2606 OID 101285)
-- Dependencies: 259 259
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2466 (class 2606 OID 101287)
-- Dependencies: 260 260
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2468 (class 2606 OID 101289)
-- Dependencies: 263 263
-- Name: si_usuarios_cedula_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_cedula_key UNIQUE (cedula);


--
-- TOC entry 2474 (class 2606 OID 101291)
-- Dependencies: 265 265
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2470 (class 2606 OID 101293)
-- Dependencies: 263 263
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2472 (class 2606 OID 101295)
-- Dependencies: 263 263
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2476 (class 2606 OID 101297)
-- Dependencies: 266 266
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2478 (class 2606 OID 101299)
-- Dependencies: 266 266
-- Name: si_vehiculos_placa_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_placa_key UNIQUE (placa);


--
-- TOC entry 2479 (class 2606 OID 101300)
-- Dependencies: 162 177 2375
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2480 (class 2606 OID 101305)
-- Dependencies: 162 204 2407
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2481 (class 2606 OID 101310)
-- Dependencies: 162 223 2427
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2482 (class 2606 OID 101315)
-- Dependencies: 162 231 2435
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2484 (class 2606 OID 101320)
-- Dependencies: 165 164 2361
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2485 (class 2606 OID 101325)
-- Dependencies: 165 177 2375
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2486 (class 2606 OID 101330)
-- Dependencies: 167 164 2361
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2487 (class 2606 OID 101335)
-- Dependencies: 167 229 2433
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2483 (class 2606 OID 101340)
-- Dependencies: 164 2433 229
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2488 (class 2606 OID 101345)
-- Dependencies: 164 169 2361
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2489 (class 2606 OID 101350)
-- Dependencies: 199 2403 169
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2490 (class 2606 OID 101355)
-- Dependencies: 2453 169 248
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2491 (class 2606 OID 101360)
-- Dependencies: 2469 169 263
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2492 (class 2606 OID 101365)
-- Dependencies: 173 2357 162
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2493 (class 2606 OID 101370)
-- Dependencies: 2373 173 175
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2494 (class 2606 OID 101375)
-- Dependencies: 2469 173 263
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2495 (class 2606 OID 101380)
-- Dependencies: 2407 204 177
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2496 (class 2606 OID 101385)
-- Dependencies: 2427 177 223
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2497 (class 2606 OID 101390)
-- Dependencies: 177 2433 229
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2498 (class 2606 OID 101395)
-- Dependencies: 2435 231 177
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2499 (class 2606 OID 101400)
-- Dependencies: 2433 229 178
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2500 (class 2606 OID 101405)
-- Dependencies: 181 2433 229
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2501 (class 2606 OID 101410)
-- Dependencies: 182 177 2375
-- Name: si_contrato_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_contrato
    ADD CONSTRAINT si_contrato_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2502 (class 2606 OID 101415)
-- Dependencies: 182 185 2387
-- Name: si_contrato_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_contrato
    ADD CONSTRAINT si_contrato_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2503 (class 2606 OID 101420)
-- Dependencies: 241 182 2445
-- Name: si_contrato_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_contrato
    ADD CONSTRAINT si_contrato_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2504 (class 2606 OID 101425)
-- Dependencies: 185 194 2397
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2505 (class 2606 OID 101430)
-- Dependencies: 243 2447 185
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2506 (class 2606 OID 101435)
-- Dependencies: 2375 177 186
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2507 (class 2606 OID 101440)
-- Dependencies: 186 2387 185
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2508 (class 2606 OID 101445)
-- Dependencies: 241 186 2445
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2509 (class 2606 OID 101450)
-- Dependencies: 187 2387 185
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2510 (class 2606 OID 101455)
-- Dependencies: 2397 187 194
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2511 (class 2606 OID 101460)
-- Dependencies: 187 2461 257
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2512 (class 2606 OID 101465)
-- Dependencies: 189 2361 164
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2513 (class 2606 OID 101470)
-- Dependencies: 2375 177 189
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2514 (class 2606 OID 101475)
-- Dependencies: 2397 194 189
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2515 (class 2606 OID 101480)
-- Dependencies: 189 2453 248
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2516 (class 2606 OID 101485)
-- Dependencies: 2469 263 189
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2517 (class 2606 OID 101490)
-- Dependencies: 189 2393 191
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2518 (class 2606 OID 101495)
-- Dependencies: 229 194 2433
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2519 (class 2606 OID 101500)
-- Dependencies: 2361 195 164
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2520 (class 2606 OID 101505)
-- Dependencies: 195 2375 177
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2521 (class 2606 OID 101510)
-- Dependencies: 2397 194 195
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2522 (class 2606 OID 101515)
-- Dependencies: 2397 198 194
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2523 (class 2606 OID 101520)
-- Dependencies: 2433 198 229
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2524 (class 2606 OID 101525)
-- Dependencies: 2375 199 177
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2525 (class 2606 OID 101530)
-- Dependencies: 199 2383 181
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2526 (class 2606 OID 101535)
-- Dependencies: 2397 194 199
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2527 (class 2606 OID 101540)
-- Dependencies: 2429 225 199
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2528 (class 2606 OID 101545)
-- Dependencies: 199 246 2451
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2529 (class 2606 OID 101550)
-- Dependencies: 199 2461 257
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2530 (class 2606 OID 101555)
-- Dependencies: 2465 260 199
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2531 (class 2606 OID 101560)
-- Dependencies: 199 2469 263
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2532 (class 2606 OID 101565)
-- Dependencies: 199 2475 266
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2533 (class 2606 OID 101570)
-- Dependencies: 229 2433 202
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2534 (class 2606 OID 101575)
-- Dependencies: 204 2435 231
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2535 (class 2606 OID 101580)
-- Dependencies: 205 2407 204
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2536 (class 2606 OID 101585)
-- Dependencies: 223 205 2427
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2537 (class 2606 OID 101590)
-- Dependencies: 205 229 2433
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2538 (class 2606 OID 101595)
-- Dependencies: 205 2435 231
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2539 (class 2606 OID 101600)
-- Dependencies: 2445 205 241
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2540 (class 2606 OID 101605)
-- Dependencies: 2375 177 207
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2541 (class 2606 OID 101610)
-- Dependencies: 194 2397 207
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2542 (class 2606 OID 101615)
-- Dependencies: 207 2433 229
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2543 (class 2606 OID 101620)
-- Dependencies: 2469 263 209
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2545 (class 2606 OID 101625)
-- Dependencies: 210 209 2413
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2544 (class 2606 OID 101871)
-- Dependencies: 2375 177 209
-- Name: si_guiarec_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guiarec_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2546 (class 2606 OID 101630)
-- Dependencies: 177 213 2375
-- Name: si_impresora_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2547 (class 2606 OID 101635)
-- Dependencies: 218 216 2419
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2548 (class 2606 OID 101640)
-- Dependencies: 220 221 2423
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2549 (class 2606 OID 101645)
-- Dependencies: 221 263 2469
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2550 (class 2606 OID 101650)
-- Dependencies: 204 2407 223
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2555 (class 2606 OID 101655)
-- Dependencies: 2429 226 225
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2551 (class 2606 OID 101660)
-- Dependencies: 2375 177 225
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2552 (class 2606 OID 101665)
-- Dependencies: 181 2383 225
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2553 (class 2606 OID 101670)
-- Dependencies: 194 2397 225
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2554 (class 2606 OID 101675)
-- Dependencies: 225 2451 246
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2556 (class 2606 OID 101680)
-- Dependencies: 229 2407 204
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2557 (class 2606 OID 101685)
-- Dependencies: 223 229 2427
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2558 (class 2606 OID 101690)
-- Dependencies: 2435 229 231
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2559 (class 2606 OID 101695)
-- Dependencies: 229 2433 236
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2560 (class 2606 OID 101700)
-- Dependencies: 229 2433 238
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2561 (class 2606 OID 101705)
-- Dependencies: 2407 241 204
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2562 (class 2606 OID 101710)
-- Dependencies: 223 241 2427
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2563 (class 2606 OID 101715)
-- Dependencies: 229 241 2433
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2564 (class 2606 OID 101720)
-- Dependencies: 2435 231 241
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2565 (class 2606 OID 101725)
-- Dependencies: 2375 177 243
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2566 (class 2606 OID 101730)
-- Dependencies: 2407 204 244
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2567 (class 2606 OID 101735)
-- Dependencies: 2427 223 244
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2568 (class 2606 OID 101740)
-- Dependencies: 229 2433 244
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2569 (class 2606 OID 101745)
-- Dependencies: 2435 231 244
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2570 (class 2606 OID 101750)
-- Dependencies: 177 2375 246
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2571 (class 2606 OID 101755)
-- Dependencies: 2383 181 246
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2572 (class 2606 OID 101760)
-- Dependencies: 246 204 2407
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2573 (class 2606 OID 101765)
-- Dependencies: 2427 246 223
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2574 (class 2606 OID 101770)
-- Dependencies: 231 246 2435
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2582 (class 2606 OID 101775)
-- Dependencies: 177 249 2375
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2583 (class 2606 OID 101780)
-- Dependencies: 194 249 2397
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2584 (class 2606 OID 101785)
-- Dependencies: 248 249 2453
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2575 (class 2606 OID 101790)
-- Dependencies: 2375 248 177
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2576 (class 2606 OID 101795)
-- Dependencies: 248 2379 178
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2577 (class 2606 OID 101800)
-- Dependencies: 248 2387 185
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2578 (class 2606 OID 101805)
-- Dependencies: 209 2413 248
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2579 (class 2606 OID 101810)
-- Dependencies: 241 2445 248
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2580 (class 2606 OID 101815)
-- Dependencies: 2461 248 257
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2581 (class 2606 OID 101820)
-- Dependencies: 2469 248 263
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2585 (class 2606 OID 101825)
-- Dependencies: 2457 252 253
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2586 (class 2606 OID 101830)
-- Dependencies: 162 2357 257
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2587 (class 2606 OID 101835)
-- Dependencies: 257 2375 177
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2588 (class 2606 OID 101840)
-- Dependencies: 259 2375 177
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2589 (class 2606 OID 101845)
-- Dependencies: 260 177 2375
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2590 (class 2606 OID 101850)
-- Dependencies: 2357 265 162
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2591 (class 2606 OID 101855)
-- Dependencies: 265 235 2439
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2592 (class 2606 OID 101860)
-- Dependencies: 265 263 2469
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-08-10 16:25:26 VET

--
-- PostgreSQL database dump complete
--

