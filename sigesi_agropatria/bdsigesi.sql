--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-02-24 01:15:21

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 247 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 247
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 161 (class 1259 OID 36611)
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
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 36613)
-- Dependencies: 2123 6
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
-- TOC entry 163 (class 1259 OID 36620)
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
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- TOC entry 164 (class 1259 OID 36622)
-- Dependencies: 2124 2125 6
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
-- TOC entry 240 (class 1259 OID 37274)
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
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 239 (class 1259 OID 37272)
-- Dependencies: 240 6
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
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 165 (class 1259 OID 36630)
-- Dependencies: 6
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
-- TOC entry 166 (class 1259 OID 36633)
-- Dependencies: 2126 6
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
-- TOC entry 242 (class 1259 OID 37309)
-- Dependencies: 2187 2188 2189 6
-- Name: si_analisis_resultado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_resultado (
    id bigint NOT NULL,
    id_recepcion bigint,
    id_despacho bigint,
    id_analisis bigint NOT NULL,
    id_usuario bigint NOT NULL,
    observacion character varying(255),
    muestra1 real DEFAULT 0.0,
    muestra2 real DEFAULT 0.0,
    muestra3 real DEFAULT 0.0
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 241 (class 1259 OID 37307)
-- Dependencies: 6 242
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
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 36641)
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
-- TOC entry 168 (class 1259 OID 36647)
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
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 36649)
-- Dependencies: 2127 6
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
-- TOC entry 170 (class 1259 OID 36656)
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
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 36658)
-- Dependencies: 2128 6
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
-- TOC entry 172 (class 1259 OID 36662)
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
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 36664)
-- Dependencies: 2129 2130 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 174 (class 1259 OID 36669)
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
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 175 (class 1259 OID 36671)
-- Dependencies: 2131 2132 2133 2134 2135 2136 2137 6
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
-- TOC entry 176 (class 1259 OID 36684)
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
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 36686)
-- Dependencies: 2138 6
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
-- TOC entry 178 (class 1259 OID 36693)
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
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 3, true);


--
-- TOC entry 179 (class 1259 OID 36695)
-- Dependencies: 2139 2140 2141 2142 2143 6
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
-- TOC entry 180 (class 1259 OID 36706)
-- Dependencies: 6
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
-- TOC entry 181 (class 1259 OID 36709)
-- Dependencies: 6
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
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE si_cuarentena; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cuarentena IS 'Tabla de Cuarentena para Fumigacion de Cultivos';


--
-- TOC entry 182 (class 1259 OID 36712)
-- Dependencies: 181 6
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
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 36714)
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
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 9, true);


--
-- TOC entry 184 (class 1259 OID 36716)
-- Dependencies: 2145 2146 2147 6
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
-- TOC entry 185 (class 1259 OID 36722)
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
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 186 (class 1259 OID 36724)
-- Dependencies: 2148 6
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
-- TOC entry 244 (class 1259 OID 37323)
-- Dependencies: 6
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
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción';


--
-- TOC entry 243 (class 1259 OID 37321)
-- Dependencies: 244 6
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
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);


--
-- TOC entry 187 (class 1259 OID 36731)
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
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 188 (class 1259 OID 36733)
-- Dependencies: 2149 2150 6
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
-- TOC entry 189 (class 1259 OID 36738)
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
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 190 (class 1259 OID 36740)
-- Dependencies: 2151 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 191 (class 1259 OID 36744)
-- Dependencies: 2152 6
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
-- TOC entry 192 (class 1259 OID 36751)
-- Dependencies: 6 191
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
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 36753)
-- Dependencies: 6
-- Name: si_guia_rec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guia_rec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_guia_rec_id_seq OWNER TO admin;

--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_guia_rec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guia_rec_id_seq', 1, false);


--
-- TOC entry 194 (class 1259 OID 36755)
-- Dependencies: 2154 2155 6
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
    fecha_rec timestamp with time zone,
    contrato character varying(16)
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- TOC entry 246 (class 1259 OID 37408)
-- Dependencies: 6
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
-- TOC entry 245 (class 1259 OID 37406)
-- Dependencies: 6 246
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
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 1, false);


--
-- TOC entry 195 (class 1259 OID 36763)
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
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 36765)
-- Dependencies: 2156 6
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
-- TOC entry 197 (class 1259 OID 36769)
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
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 255, true);


--
-- TOC entry 198 (class 1259 OID 36771)
-- Dependencies: 2157 6
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
-- TOC entry 199 (class 1259 OID 36778)
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
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 199
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 26, true);


--
-- TOC entry 200 (class 1259 OID 36780)
-- Dependencies: 2158 2159 6
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
-- TOC entry 201 (class 1259 OID 36785)
-- Dependencies: 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 202 (class 1259 OID 36788)
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
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 203 (class 1259 OID 36790)
-- Dependencies: 2160 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 204 (class 1259 OID 36794)
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
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 204
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- TOC entry 205 (class 1259 OID 36796)
-- Dependencies: 2161 2162 6
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
-- TOC entry 206 (class 1259 OID 36801)
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
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 2, true);


--
-- TOC entry 207 (class 1259 OID 36803)
-- Dependencies: 2163 6
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
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 208 (class 1259 OID 36810)
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
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 36812)
-- Dependencies: 2164 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 210 (class 1259 OID 36816)
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
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 5, true);


--
-- TOC entry 211 (class 1259 OID 36818)
-- Dependencies: 2165 6
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
-- TOC entry 212 (class 1259 OID 36825)
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
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 213 (class 1259 OID 36827)
-- Dependencies: 2166 6
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
-- TOC entry 214 (class 1259 OID 36831)
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
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 215 (class 1259 OID 36834)
-- Dependencies: 214 6
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
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 1, false);


--
-- TOC entry 216 (class 1259 OID 36836)
-- Dependencies: 6
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
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 217 (class 1259 OID 36839)
-- Dependencies: 216 6
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
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 1, false);


--
-- TOC entry 218 (class 1259 OID 36841)
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
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 1, true);


--
-- TOC entry 219 (class 1259 OID 36843)
-- Dependencies: 2169 6
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
-- TOC entry 220 (class 1259 OID 36850)
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
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 2, true);


--
-- TOC entry 221 (class 1259 OID 36852)
-- Dependencies: 2170 6
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
-- TOC entry 222 (class 1259 OID 36859)
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
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 223 (class 1259 OID 36865)
-- Dependencies: 6
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
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 224 (class 1259 OID 36871)
-- Dependencies: 223 6
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
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- TOC entry 225 (class 1259 OID 36873)
-- Dependencies: 6
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
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo';


--
-- TOC entry 226 (class 1259 OID 36876)
-- Dependencies: 225 6
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
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 1, true);


--
-- TOC entry 227 (class 1259 OID 36878)
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
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 228 (class 1259 OID 36880)
-- Dependencies: 2173 2174 2175 6
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
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 229 (class 1259 OID 36889)
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
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- TOC entry 230 (class 1259 OID 36891)
-- Dependencies: 2176 2177 2178 6
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
-- TOC entry 231 (class 1259 OID 36897)
-- Dependencies: 6
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
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 232 (class 1259 OID 36903)
-- Dependencies: 6 231
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
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
-- TOC entry 233 (class 1259 OID 36905)
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
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 234 (class 1259 OID 36907)
-- Dependencies: 2180 2181 2182 6
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
-- TOC entry 235 (class 1259 OID 36916)
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
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 236 (class 1259 OID 36918)
-- Dependencies: 2183 6
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
-- TOC entry 237 (class 1259 OID 36922)
-- Dependencies: 6
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
-- TOC entry 238 (class 1259 OID 36925)
-- Dependencies: 6 237
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
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 1, false);


--
-- TOC entry 2185 (class 2604 OID 37277)
-- Dependencies: 240 239 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 37312)
-- Dependencies: 241 242 242
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2144 (class 2604 OID 36927)
-- Dependencies: 182 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 37326)
-- Dependencies: 243 244 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2153 (class 2604 OID 36928)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 37411)
-- Dependencies: 245 246 246
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 36929)
-- Dependencies: 215 214
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 36930)
-- Dependencies: 217 216
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 36931)
-- Dependencies: 224 223
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2172 (class 2604 OID 36932)
-- Dependencies: 226 225
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 36933)
-- Dependencies: 232 231
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 36934)
-- Dependencies: 238 237
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2374 (class 0 OID 36613)
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
INSERT INTO si_almacenes VALUES (11, 2, 'PRODUCTOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-20 11:06:41.92', NULL, 2, '3');
INSERT INTO si_almacenes VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '2');


--
-- TOC entry 2375 (class 0 OID 36622)
-- Dependencies: 164
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1');
INSERT INTO si_analisis VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2');
INSERT INTO si_analisis VALUES (3, 1, 'GRANOS CON GERMEN DANADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3');
INSERT INTO si_analisis VALUES (4, 1, 'GRANOS DANADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4');
INSERT INTO si_analisis VALUES (5, 1, 'GRANOS DANADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5');
INSERT INTO si_analisis VALUES (6, 1, 'GRANOS DANADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6');
INSERT INTO si_analisis VALUES (7, 1, 'GRANOS DANADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7');
INSERT INTO si_analisis VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8');
INSERT INTO si_analisis VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9');
INSERT INTO si_analisis VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10');
INSERT INTO si_analisis VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11');
INSERT INTO si_analisis VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12');
INSERT INTO si_analisis VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13');
INSERT INTO si_analisis VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14');
INSERT INTO si_analisis VALUES (15, 1, 'GRANO PARTIDO PEQUENO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15');
INSERT INTO si_analisis VALUES (16, 1, 'AFLATOXINA', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19');
INSERT INTO si_analisis VALUES (17, 1, 'ASPECTO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20');
INSERT INTO si_analisis VALUES (18, 1, 'OLOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '21');
INSERT INTO si_analisis VALUES (19, 1, 'COLOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '22');
INSERT INTO si_analisis VALUES (20, 1, 'LIMPIEZA', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '23');
INSERT INTO si_analisis VALUES (21, 1, 'INSECTOS VIVOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24');


--
-- TOC entry 2416 (class 0 OID 37274)
-- Dependencies: 240
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2376 (class 0 OID 36630)
-- Dependencies: 165
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 0, 0, 0, 0, 0, 0, true);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0, 0, 0, 0, 0, 0, true);


--
-- TOC entry 2377 (class 0 OID 36633)
-- Dependencies: 166
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2417 (class 0 OID 37309)
-- Dependencies: 242
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2378 (class 0 OID 36641)
-- Dependencies: 167
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error VALUES ('fd14117a0fa30c38c7', '2012-02-22 11:27:43.735437-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:26;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:84:"ERROR:  el valor null para la columna «id_programa» viola la restricción not null";s:5:"query";s:209:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''COS6'', ''COSECHA 6'', ''1'', null, null, null, null, null, ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-22 11:27:43";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('c297d7a186dad9c8bd', '2012-02-22 11:36:20.305538-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:26;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:84:"ERROR:  el valor null para la columna «id_programa» viola la restricción not null";s:5:"query";s:225:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''AKLSD'', ''AKLSDJAS'', ''1'', null, null, ''22-02-2012'', ''24-05-2012'', null, ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-22 11:36:20";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('cd5ace240347c35c50', '2012-02-23 13:12:14.414756-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:49:"/var/www/sigesi_agropatria/admin/programa.php<br>";s:4:"line";i:24;s:5:"class";s:5:"Model";s:8:"function";s:4:"save";s:11:"mysql_error";s:79:"ERROR:  el valor null para la columna «nombre» viola la restricción not null";s:5:"query";s:203:"INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''012012'', null, ''1'', null, null, null, null, ''2'', ''T'',now())";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-23 01:12:14";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:93;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('7d72db40107670511e', '2012-02-23 16:32:26.285782-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:56:"/var/www/sigesi_agropatria/ajax/cosecha_programa.php<br>";s:4:"line";i:21;s:5:"class";s:9:"Recepcion";s:8:"function";s:14:"recepcionesDia";s:11:"mysql_error";s:186:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_centro_acopio = "" AND id_cosecha =...
                                                 ^";s:5:"query";s:163:"SELECT COUNT(*) AS total<br />
                FROM si_recepcion<br />
                WHERE id_centro_acopio = '''' AND id_cosecha = ''2'' AND fecha_recepcion = now()";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-23 04:32:26";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:11;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('4b06905c18ac3475cd', '2012-02-23 16:34:50.860537-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:56:"/var/www/sigesi_agropatria/ajax/cosecha_programa.php<br>";s:4:"line";i:21;s:5:"class";s:9:"Recepcion";s:8:"function";s:14:"recepcionesDia";s:11:"mysql_error";s:186:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_centro_acopio = "" AND id_cosecha =...
                                                 ^";s:5:"query";s:168:"SELECT COUNT(*) AS total<br />
                FROM si_recepcion<br />
                WHERE id_centro_acopio = '''' AND id_cosecha = ''2idCA='' AND fecha_recepcion = now()";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-23 04:34:50";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:11;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- TOC entry 2379 (class 0 OID 36649)
-- Dependencies: 169
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2380 (class 0 OID 36658)
-- Dependencies: 171
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2381 (class 0 OID 36664)
-- Dependencies: 173
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2382 (class 0 OID 36671)
-- Dependencies: 175
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_centro_acopio VALUES (7, 2, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (9, 2, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (8, 2, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio VALUES (3, 2, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (4, 2, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (5, 2, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (6, 2, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (2, 2, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-02-19 15:03:36.599-04:30');


--
-- TOC entry 2383 (class 0 OID 36686)
-- Dependencies: 177
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2384 (class 0 OID 36695)
-- Dependencies: 179
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha VALUES (2, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201201');
INSERT INTO si_cosecha VALUES (3, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201202');


--
-- TOC entry 2385 (class 0 OID 36706)
-- Dependencies: 180
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2386 (class 0 OID 36709)
-- Dependencies: 181
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2387 (class 0 OID 36716)
-- Dependencies: 184
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo VALUES (2, 1, '2               ', 'ARROZ BLANCO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:30.631661-04:30', NULL);
INSERT INTO si_cultivo VALUES (3, 1, '3               ', 'SORGO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:49.981169-04:30', NULL);
INSERT INTO si_cultivo VALUES (4, 1, '4               ', 'SOYA HÚMEDA NACIONAL', false, NULL, '2012-02-18 15:23:05.361573-04:30', NULL);
INSERT INTO si_cultivo VALUES (7, 1, '7               ', 'ARROZ BLANCO TOTAL', false, NULL, '2012-02-18 15:26:43.873325-04:30', NULL);
INSERT INTO si_cultivo VALUES (5, 1, '5               ', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:23:20.129438-04:30', NULL);
INSERT INTO si_cultivo VALUES (6, 1, '6               ', 'MAÍZ BLANCO SECO NACIONAL', false, NULL, '2012-02-18 15:23:55.551313-04:30', NULL);
INSERT INTO si_cultivo VALUES (8, 1, '8               ', 'ARROZ PADDY ACONDICIONADO', false, NULL, '2012-02-18 15:27:07.455848-04:30', NULL);
INSERT INTO si_cultivo VALUES (9, 1, '9               ', 'TOMATE NACIONAL', false, NULL, '2012-02-18 15:28:36.609786-04:30', NULL);
INSERT INTO si_cultivo VALUES (1, 1, '1               ', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, NULL, '2012-02-18 15:22:10.224543-04:30', '2012-02-22 09:02:31.725667-04:30');


--
-- TOC entry 2388 (class 0 OID 36724)
-- Dependencies: 186
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2418 (class 0 OID 37323)
-- Dependencies: 244
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2389 (class 0 OID 36733)
-- Dependencies: 188
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2390 (class 0 OID 36740)
-- Dependencies: 190
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_estado VALUES (1, 1, 'Distrito Capital');
INSERT INTO si_estado VALUES (2, 1, 'Amazonas');
INSERT INTO si_estado VALUES (3, 1, 'Anzoategui');
INSERT INTO si_estado VALUES (4, 1, 'Apure');
INSERT INTO si_estado VALUES (5, 1, 'Aragua');
INSERT INTO si_estado VALUES (6, 1, 'Barinas');
INSERT INTO si_estado VALUES (7, 1, 'Bolivar');
INSERT INTO si_estado VALUES (8, 1, 'Carabobo');
INSERT INTO si_estado VALUES (9, 1, 'Cojedes');
INSERT INTO si_estado VALUES (10, 1, 'Delta Amacuro');
INSERT INTO si_estado VALUES (11, 1, 'Falcon');
INSERT INTO si_estado VALUES (12, 1, 'Guarico');
INSERT INTO si_estado VALUES (13, 1, 'Lara');
INSERT INTO si_estado VALUES (14, 1, 'Merida');
INSERT INTO si_estado VALUES (15, 1, 'Miranda');
INSERT INTO si_estado VALUES (16, 1, 'Monagas');
INSERT INTO si_estado VALUES (17, 1, 'Nueva Esparta');
INSERT INTO si_estado VALUES (18, 1, 'Portuguesa');
INSERT INTO si_estado VALUES (19, 1, 'Sucre');
INSERT INTO si_estado VALUES (20, 1, 'Tachira');
INSERT INTO si_estado VALUES (21, 1, 'Trujillo');
INSERT INTO si_estado VALUES (22, 1, 'Vargas');
INSERT INTO si_estado VALUES (23, 1, 'Yaracuy');
INSERT INTO si_estado VALUES (24, 1, 'Zulia');


--
-- TOC entry 2391 (class 0 OID 36744)
-- Dependencies: 191
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2392 (class 0 OID 36755)
-- Dependencies: 194
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2419 (class 0 OID 37408)
-- Dependencies: 246
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2393 (class 0 OID 36765)
-- Dependencies: 196
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2394 (class 0 OID 36771)
-- Dependencies: 198
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas VALUES (38, '2012-02-21', 202, 1, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''5f0dg3t1f4vma97eirjpggh0m5''', '');
INSERT INTO si_log_consultas VALUES (39, '2012-02-21', 102, 1, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''5f0dg3t1f4vma97eirjpggh0m5'' ', '');
INSERT INTO si_log_consultas VALUES (40, '2012-02-21', 101, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5f0dg3t1f4vma97eirjpggh0m5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5f0dg3t1f4vma97eirjpggh0m5'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (41, '2012-02-21', 201, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_programa', 'No data', 'numero = ''1''<br />nombre =  ''PRIMER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (numero, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''1'', ''PRIMER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (42, '2012-02-21', 201, 2, 'N/A', 'N/A', 'N/A', '5f0dg3t1f4vma97eirjpggh0m5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_cosecha', 'No data', 'nombre = ''1ERA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''1''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''1ERA COSECHA'', ''1'', null, null, null, null, ''1'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (43, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (44, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (45, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (46, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (47, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (48, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (61, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (49, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (50, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (51, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (52, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (53, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (54, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (55, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (56, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''dicn64qmp89t4g5l8gjhfss6f3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''dicn64qmp89t4g5l8gjhfss6f3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (57, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''dicn64qmp89t4g5l8gjhfss6f3''', '');
INSERT INTO si_log_consultas VALUES (58, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', 'dicn64qmp89t4g5l8gjhfss6f3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''dicn64qmp89t4g5l8gjhfss6f3'' ', '');
INSERT INTO si_log_consultas VALUES (59, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (60, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (62, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (63, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (64, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (65, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (66, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cultivo', 'No data', 'id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now()', 'UPDATE si_cultivo SET  id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas VALUES (67, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cultivo', 'No data', 'id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍZ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now()', 'UPDATE si_cultivo SET  id = ''1'', id_org = ''1'', codigo = ''1               '', nombre = ''MAÍZ BLANCO HÚMEDO NACIONAL'', tipificado = ''F'', ciclo = null, modificado=now() WHERE id=1', '');
INSERT INTO si_log_consultas VALUES (68, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''n9lo312ik4dc25a8bi9ea9anu2''', '');
INSERT INTO si_log_consultas VALUES (69, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''n9lo312ik4dc25a8bi9ea9anu2'' ', '');
INSERT INTO si_log_consultas VALUES (70, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'n9lo312ik4dc25a8bi9ea9anu2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''n9lo312ik4dc25a8bi9ea9anu2'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (71, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (73, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (74, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (75, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (76, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (77, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (78, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (79, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (80, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (81, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (82, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (83, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (84, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (85, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (86, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (87, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (88, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (89, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (90, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (91, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (92, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (93, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (94, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (95, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (96, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (97, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (98, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (99, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (102, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (103, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (104, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (105, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (106, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (107, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jsilvA''', 'Login Incorrect=jsilvA');
INSERT INTO si_log_consultas VALUES (108, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jSilvA''', 'Login Incorrect=jSilvA');
INSERT INTO si_log_consultas VALUES (109, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (110, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (111, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (112, '2012-02-22', 105, 0, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'SELECT * FROM si_usuarios WHERE usuario = ''jpeluzzo''', 'Login Incorrect=jpeluzzo');
INSERT INTO si_log_consultas VALUES (113, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (114, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (115, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (116, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (117, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (118, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (119, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (120, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'numero = ''2''<br />nombre =  ''SEGUNDO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (numero, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''2'', ''SEGUNDO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (121, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''1''<br />nombre =  ''COSECHA N1''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''4''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''1'', ''COSECHA N1'', ''1'', null, null, null, null, ''4'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (122, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PRO3''<br />nombre =  ''TERCER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PRO3'', ''TERCER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (123, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''3''<br />nombre =  ''TERCERA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''5''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''3'', ''TERCERA COSECHA'', ''1'', null, null, null, null, ''5'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (124, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''4TO''<br />nombre =  ''CUARTO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''4TO'', ''CUARTO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (125, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''C1''<br />nombre =  ''COS1''<br />id_cultivo =  ''2''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''6''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''C1'', ''COS1'', ''2'', null, null, null, null, ''6'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (126, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''C2''<br />nombre =  ''COS2''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''6''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''C2'', ''COS2'', ''3'', null, null, null, null, ''6'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (127, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''5TO''<br />nombre =  ''QUINTO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''5TO'', ''QUINTO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (128, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO1''<br />nombre =  ''COS1''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO1'', ''COS1'', ''3'', null, null, null, null, ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (129, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO2''<br />nombre =  ''COS2''<br />id_cultivo =  ''5''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO2'', ''COS2'', ''5'', null, null, null, null, ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (130, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''CO3''<br />nombre =  ''COS3''<br />id_cultivo =  ''9''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''22-02-2012''<br />fecha_fin =  ''31-05-2012''<br />id_programa =  ''7''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''CO3'', ''COS3'', ''9'', null, null, ''22-02-2012'', ''31-05-2012'', ''7'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (132, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (133, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (134, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (135, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (136, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (137, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (138, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (139, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (140, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (141, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (143, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''AKLSJDAS''<br />nombre =  ''ASKDJASLKD''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''AKLSJDAS'', ''ASKDJASLKD'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (144, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''ASDASD''<br />nombre =  ''ASDASD''<br />id_cultivo =  ''4''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''22-02-2012''<br />fecha_fin =  ''22-04-2012''<br />id_programa =  ''10''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''ASDASD'', ''ASDASD'', ''4'', null, null, ''22-02-2012'', ''22-04-2012'', ''10'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (145, '2012-02-22', 201, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''ASLKDJASD''<br />nombre =  ''ASDASD''<br />id_cultivo =  ''3''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''10''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''ASLKDJASD'', ''ASDASD'', ''3'', null, null, null, null, ''10'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (146, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0''', '');
INSERT INTO si_log_consultas VALUES (147, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''35r3c74u2qu94ur2d5f0p55ad0'' ', '');
INSERT INTO si_log_consultas VALUES (148, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '35r3c74u2qu94ur2d5f0p55ad0', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''35r3c74u2qu94ur2d5f0p55ad0'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (149, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (150, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952''', '');
INSERT INTO si_log_consultas VALUES (151, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952'' ', '');
INSERT INTO si_log_consultas VALUES (152, '2012-02-22', 101, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (153, '2012-02-22', 202, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952''', '');
INSERT INTO si_log_consultas VALUES (154, '2012-02-22', 102, 1, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''7tm04h99le8f0bqusqhvdi9952'' ', '');
INSERT INTO si_log_consultas VALUES (155, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (156, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (157, '2012-02-22', 101, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (158, '2012-02-22', 202, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6''', '');
INSERT INTO si_log_consultas VALUES (159, '2012-02-22', 102, 2, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6'' ', '');
INSERT INTO si_log_consultas VALUES (160, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''aha2potic6u2t6pgnacdvgudj6'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (161, '2012-02-22', 202, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6''', '');
INSERT INTO si_log_consultas VALUES (162, '2012-02-22', 102, 3, 'N/A', 'N/A', 'N/A', 'aha2potic6u2t6pgnacdvgudj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''aha2potic6u2t6pgnacdvgudj6'' ', '');
INSERT INTO si_log_consultas VALUES (163, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (164, '2012-02-22', 101, 3, 'N/A', 'N/A', 'N/A', '7tm04h99le8f0bqusqhvdi9952', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''7tm04h99le8f0bqusqhvdi9952'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (165, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (166, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (167, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (168, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (169, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '911igj8tj63pl5r18ghah9lqj2', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (170, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (171, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (172, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (173, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '911igj8tj63pl5r18ghah9lqj2', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''911igj8tj63pl5r18ghah9lqj2'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (174, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (175, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (176, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (177, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (178, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (179, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (180, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (181, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (182, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (183, '2012-02-23', 202, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''1bh788d9itn4emslv6qhiebnq5''', '');
INSERT INTO si_log_consultas VALUES (184, '2012-02-23', 102, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''1bh788d9itn4emslv6qhiebnq5'' ', '');
INSERT INTO si_log_consultas VALUES (185, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '1bh788d9itn4emslv6qhiebnq5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''1bh788d9itn4emslv6qhiebnq5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (186, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (187, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''9rpgatihnkm0c9ud670jevtlf1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''9rpgatihnkm0c9ud670jevtlf1'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (188, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''9rpgatihnkm0c9ud670jevtlf1''', '');
INSERT INTO si_log_consultas VALUES (189, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '9rpgatihnkm0c9ud670jevtlf1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''9rpgatihnkm0c9ud670jevtlf1'' ', '');
INSERT INTO si_log_consultas VALUES (190, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (191, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (192, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (193, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (194, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (195, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (196, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (197, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (198, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (199, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (200, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (222, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (201, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (202, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (203, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (204, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (205, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (206, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (207, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (208, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (209, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas VALUES (210, '2012-02-23', 102, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');
INSERT INTO si_log_consultas VALUES (211, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (223, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (212, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_almacenes', 'No data', 'id = ''2'', codigo = ''2'', nombre = ''ALMACEN - SILOS'', direccion = null, id_pais = ''1'', telefono = null, fax = null, email = null, estatus = ''T'', coordenadas_utm = null, id_centro_acopio = ''2'', id_estado = ''18'', id_municipio = ''227'', id_tipo_almacen = ''2'', modificado=now()', 'UPDATE si_almacenes SET  id = ''2'', codigo = ''2'', nombre = ''ALMACEN - SILOS'', direccion = null, id_pais = ''1'', telefono = null, fax = null, email = null, estatus = ''T'', coordenadas_utm = null, id_centro_acopio = ''2'', id_estado = ''18'', id_municipio = ''227'', id_tipo_almacen = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas VALUES (213, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (214, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (215, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (216, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (218, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PR1''<br />nombre =  ''PRIMER PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PR1'', ''PRIMER PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (219, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''012012''<br />nombre =  null<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''2''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''012012'', null, ''1'', null, null, null, null, ''2'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (220, '2012-02-23', 201, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''022012''<br />nombre =  null<br />id_cultivo =  ''2''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  ''2''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''022012'', null, ''2'', null, null, null, null, ''2'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (221, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (224, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (225, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (226, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (227, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '2rm0ac1q4vn6lqvo290m1ish65', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 18.0.996.0<br />Engine: AppleWebKit v: 535.15</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''2rm0ac1q4vn6lqvo290m1ish65''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''2rm0ac1q4vn6lqvo290m1ish65'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (228, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (229, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (230, '2012-02-23', 101, 3, 'N/A', 'N/A', 'N/A', '8h1ur4m9775blsrhfgoe3gimb5', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''8h1ur4m9775blsrhfgoe3gimb5''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''8h1ur4m9775blsrhfgoe3gimb5'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (231, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (232, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (233, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (234, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (235, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (236, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (237, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (238, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (239, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (240, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (241, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (242, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (243, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas VALUES (244, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');
INSERT INTO si_log_consultas VALUES (245, '2012-02-23', 101, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (246, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_centro_acopio', 'No data', 'estatus = ''f''', 'UPDATE si_centro_acopio SET estatus = ''f'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (247, '2012-02-23', 202, 1, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_centro_acopio', 'No data', 'estatus = ''t''', 'UPDATE si_centro_acopio SET estatus = ''t'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (248, '2012-02-23', 101, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''kli5vtsln4vne4gk0j11ok3kr7'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (249, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (250, '2012-02-23', 202, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3''', '');
INSERT INTO si_log_consultas VALUES (251, '2012-02-23', 102, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''4fvkt2dqh61g5vbcvohspinqk3'' ', '');
INSERT INTO si_log_consultas VALUES (252, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', '4fvkt2dqh61g5vbcvohspinqk3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4fvkt2dqh61g5vbcvohspinqk3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (253, '2012-02-23', 202, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7''', '');
INSERT INTO si_log_consultas VALUES (254, '2012-02-23', 102, 2, 'N/A', 'N/A', 'N/A', 'kli5vtsln4vne4gk0j11ok3kr7', '192.168.65.240', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''kli5vtsln4vne4gk0j11ok3kr7'' ', '');
INSERT INTO si_log_consultas VALUES (255, '2012-02-23', 101, 4, 'N/A', 'N/A', 'N/A', 'ls6hmge8lbrgoe9r85dpbhj0u1', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''ls6hmge8lbrgoe9r85dpbhj0u1''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''ls6hmge8lbrgoe9r85dpbhj0u1'' WHERE id=''4''', 'User Login');


--
-- TOC entry 2395 (class 0 OID 36780)
-- Dependencies: 200
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu VALUES (3, 'Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (5, 'Cuenta', 0, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (6, 'Centros de Acopio', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (12, 'Despacho', 2, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (13, 'Programas', 3, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (14, 'Cosecha', 3, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (15, 'Cultivos', 3, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (16, 'Productores', 3, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (17, 'Recepciones', 3, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (18, 'Despacho', 3, NULL, true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (19, 'Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (20, 'Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (21, 'Formulas', 4, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (22, 'Configuracion', 4, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (23, 'Config. Cuenta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (24, 'Organizaciones', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (4, 'Ctrol de Procesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (1, 'Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (2, 'Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (25, 'Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (9, 'Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (7, 'Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (10, 'Productor', 1, 'admin/productor_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (26, 'Menu - Usuario', 4, 'admin/menu_usuario.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (11, 'Recepci&oacute;n', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (8, 'Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (27, 'Analisis Recepci&oacute;n', 2, 'admin/analisis_recepcion.php', true, 3, NULL, NULL);


--
-- TOC entry 2396 (class 0 OID 36785)
-- Dependencies: 201
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (1, 1);
INSERT INTO si_menu_usuario VALUES (3, 1);
INSERT INTO si_menu_usuario VALUES (4, 1);
INSERT INTO si_menu_usuario VALUES (5, 1);
INSERT INTO si_menu_usuario VALUES (24, 1);
INSERT INTO si_menu_usuario VALUES (6, 1);
INSERT INTO si_menu_usuario VALUES (7, 1);
INSERT INTO si_menu_usuario VALUES (8, 1);
INSERT INTO si_menu_usuario VALUES (9, 1);
INSERT INTO si_menu_usuario VALUES (13, 1);
INSERT INTO si_menu_usuario VALUES (14, 1);
INSERT INTO si_menu_usuario VALUES (15, 1);
INSERT INTO si_menu_usuario VALUES (16, 1);
INSERT INTO si_menu_usuario VALUES (17, 1);
INSERT INTO si_menu_usuario VALUES (18, 1);
INSERT INTO si_menu_usuario VALUES (19, 1);
INSERT INTO si_menu_usuario VALUES (20, 1);
INSERT INTO si_menu_usuario VALUES (21, 1);
INSERT INTO si_menu_usuario VALUES (22, 1);
INSERT INTO si_menu_usuario VALUES (23, 1);
INSERT INTO si_menu_usuario VALUES (1, 2);
INSERT INTO si_menu_usuario VALUES (7, 2);
INSERT INTO si_menu_usuario VALUES (8, 2);
INSERT INTO si_menu_usuario VALUES (9, 2);
INSERT INTO si_menu_usuario VALUES (10, 2);
INSERT INTO si_menu_usuario VALUES (25, 1);
INSERT INTO si_menu_usuario VALUES (25, 2);
INSERT INTO si_menu_usuario VALUES (26, 1);
INSERT INTO si_menu_usuario VALUES (2, 3);
INSERT INTO si_menu_usuario VALUES (27, 3);
INSERT INTO si_menu_usuario VALUES (2, 4);
INSERT INTO si_menu_usuario VALUES (11, 4);


--
-- TOC entry 2397 (class 0 OID 36790)
-- Dependencies: 203
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_municipio VALUES (1, 1, 'Libertador');
INSERT INTO si_municipio VALUES (2, 2, 'Alto Orinoco         ');
INSERT INTO si_municipio VALUES (3, 2, 'Atabapo');
INSERT INTO si_municipio VALUES (4, 2, 'Atures');
INSERT INTO si_municipio VALUES (5, 2, 'Autana');
INSERT INTO si_municipio VALUES (6, 2, 'Manapiare');
INSERT INTO si_municipio VALUES (7, 2, 'Maroa');
INSERT INTO si_municipio VALUES (8, 2, 'Rio Negro');
INSERT INTO si_municipio VALUES (9, 3, 'Anaco');
INSERT INTO si_municipio VALUES (10, 3, 'Aragua');
INSERT INTO si_municipio VALUES (11, 3, 'Bolivar');
INSERT INTO si_municipio VALUES (12, 3, 'Bruzual');
INSERT INTO si_municipio VALUES (13, 3, 'Cajigal');
INSERT INTO si_municipio VALUES (14, 3, 'Carvajal');
INSERT INTO si_municipio VALUES (15, 3, 'Diego Bautista Urbaneja');
INSERT INTO si_municipio VALUES (16, 3, 'Freites');
INSERT INTO si_municipio VALUES (17, 3, 'Guanipa');
INSERT INTO si_municipio VALUES (18, 3, 'Guanta');
INSERT INTO si_municipio VALUES (19, 3, 'Independencia');
INSERT INTO si_municipio VALUES (20, 3, 'Libertad');
INSERT INTO si_municipio VALUES (21, 3, 'McGregor');
INSERT INTO si_municipio VALUES (22, 3, 'Miranda');
INSERT INTO si_municipio VALUES (23, 3, 'Monagas');
INSERT INTO si_municipio VALUES (24, 3, 'Penalver');
INSERT INTO si_municipio VALUES (25, 3, 'Piritu');
INSERT INTO si_municipio VALUES (26, 3, 'San Juan de Capistrano');
INSERT INTO si_municipio VALUES (27, 3, 'Santa Ana');
INSERT INTO si_municipio VALUES (28, 3, 'Simon Rodriguez');
INSERT INTO si_municipio VALUES (29, 3, 'Sotillo');
INSERT INTO si_municipio VALUES (30, 4, 'Achaguas');
INSERT INTO si_municipio VALUES (31, 4, 'Biruaca');
INSERT INTO si_municipio VALUES (32, 4, 'Munoz');
INSERT INTO si_municipio VALUES (33, 4, 'Paez');
INSERT INTO si_municipio VALUES (34, 4, 'Pedro Camejo');
INSERT INTO si_municipio VALUES (35, 4, 'Romulo Gallegos');
INSERT INTO si_municipio VALUES (36, 4, 'San Fernando');
INSERT INTO si_municipio VALUES (37, 5, 'Bolívar');
INSERT INTO si_municipio VALUES (38, 5, 'Camatagua');
INSERT INTO si_municipio VALUES (39, 5, 'Francisco Linares Alcántara');
INSERT INTO si_municipio VALUES (40, 5, 'Girardot');
INSERT INTO si_municipio VALUES (41, 5, 'José Angel Lamas');
INSERT INTO si_municipio VALUES (42, 5, 'José Félix Ribas');
INSERT INTO si_municipio VALUES (43, 5, 'José Rafael Revenga');
INSERT INTO si_municipio VALUES (44, 5, 'Libertador');
INSERT INTO si_municipio VALUES (45, 5, 'Mario Briceño Iragorry');
INSERT INTO si_municipio VALUES (46, 5, 'Ocumare de la Costa de Oro');
INSERT INTO si_municipio VALUES (47, 5, 'San Casimiro');
INSERT INTO si_municipio VALUES (48, 5, 'San Sebastián');
INSERT INTO si_municipio VALUES (49, 5, 'Santiago Mariño');
INSERT INTO si_municipio VALUES (50, 5, 'Santos Michelena');
INSERT INTO si_municipio VALUES (51, 5, 'Sucre');
INSERT INTO si_municipio VALUES (52, 5, 'Tovar');
INSERT INTO si_municipio VALUES (53, 5, 'Urdaneta');
INSERT INTO si_municipio VALUES (54, 5, 'Zamora');
INSERT INTO si_municipio VALUES (55, 6, 'Alberto Arvelo Torrealba');
INSERT INTO si_municipio VALUES (56, 6, 'Andrés Eloy Blanco');
INSERT INTO si_municipio VALUES (57, 6, 'Antonio José de Sucre');
INSERT INTO si_municipio VALUES (58, 6, 'Arismendi');
INSERT INTO si_municipio VALUES (59, 6, 'Barinas');
INSERT INTO si_municipio VALUES (60, 6, 'Bolívar');
INSERT INTO si_municipio VALUES (61, 6, 'Cruz Paredes');
INSERT INTO si_municipio VALUES (62, 6, 'Ezequiel Zamora');
INSERT INTO si_municipio VALUES (63, 6, 'Obispos');
INSERT INTO si_municipio VALUES (64, 6, 'Pedraza');
INSERT INTO si_municipio VALUES (65, 6, 'Rojas');
INSERT INTO si_municipio VALUES (66, 6, 'Sosa');
INSERT INTO si_municipio VALUES (67, 7, 'Caroní');
INSERT INTO si_municipio VALUES (68, 7, 'Cedeño');
INSERT INTO si_municipio VALUES (69, 7, 'El Callao');
INSERT INTO si_municipio VALUES (70, 7, 'Gran Sabana');
INSERT INTO si_municipio VALUES (71, 7, 'Heres');
INSERT INTO si_municipio VALUES (72, 7, 'Piar');
INSERT INTO si_municipio VALUES (73, 7, 'Raúl Leoni');
INSERT INTO si_municipio VALUES (74, 7, 'Roscio');
INSERT INTO si_municipio VALUES (75, 7, 'Sifontes');
INSERT INTO si_municipio VALUES (76, 7, 'Sucre');
INSERT INTO si_municipio VALUES (77, 7, 'Padre Pedro Chien');
INSERT INTO si_municipio VALUES (78, 8, 'Bejuma');
INSERT INTO si_municipio VALUES (79, 8, 'Carlos Arvelo');
INSERT INTO si_municipio VALUES (80, 8, 'Diego Ibarra');
INSERT INTO si_municipio VALUES (81, 8, 'Guacara');
INSERT INTO si_municipio VALUES (82, 8, 'Juan José Mora');
INSERT INTO si_municipio VALUES (83, 8, 'Libertador');
INSERT INTO si_municipio VALUES (84, 8, 'Los Guayos');
INSERT INTO si_municipio VALUES (85, 8, 'Miranda');
INSERT INTO si_municipio VALUES (86, 8, 'Montalbán');
INSERT INTO si_municipio VALUES (87, 8, 'Naguanagua');
INSERT INTO si_municipio VALUES (88, 8, 'Puerto Cabello');
INSERT INTO si_municipio VALUES (89, 8, 'San Diego');
INSERT INTO si_municipio VALUES (90, 8, 'San Joaquín');
INSERT INTO si_municipio VALUES (91, 8, 'Valencia');
INSERT INTO si_municipio VALUES (92, 9, 'Anzoátegui');
INSERT INTO si_municipio VALUES (93, 9, 'Falcón');
INSERT INTO si_municipio VALUES (94, 9, 'Girardot');
INSERT INTO si_municipio VALUES (95, 9, 'Lima Blanco');
INSERT INTO si_municipio VALUES (96, 9, 'Pao de San Juan Bautista');
INSERT INTO si_municipio VALUES (97, 9, 'Ricaurte');
INSERT INTO si_municipio VALUES (98, 9, 'Rómulo Gallegos');
INSERT INTO si_municipio VALUES (99, 9, 'San Carlos');
INSERT INTO si_municipio VALUES (100, 9, 'Tinaco');
INSERT INTO si_municipio VALUES (101, 10, 'Antonio Díaz');
INSERT INTO si_municipio VALUES (102, 10, 'Casacoima');
INSERT INTO si_municipio VALUES (103, 10, 'Pedernales');
INSERT INTO si_municipio VALUES (104, 10, 'Tucupita');
INSERT INTO si_municipio VALUES (105, 10, 'Antonio Diaz');
INSERT INTO si_municipio VALUES (106, 10, 'Casacoima');
INSERT INTO si_municipio VALUES (107, 10, 'Pedernales');
INSERT INTO si_municipio VALUES (108, 10, 'Tucupita');
INSERT INTO si_municipio VALUES (109, 11, 'Acosta');
INSERT INTO si_municipio VALUES (110, 11, 'Bolívar');
INSERT INTO si_municipio VALUES (111, 11, 'Buchivacoa');
INSERT INTO si_municipio VALUES (112, 11, 'Cacique Manaure');
INSERT INTO si_municipio VALUES (113, 11, 'Carirubana');
INSERT INTO si_municipio VALUES (114, 11, 'Colina');
INSERT INTO si_municipio VALUES (115, 11, 'Dabajuro');
INSERT INTO si_municipio VALUES (116, 11, 'Democracia');
INSERT INTO si_municipio VALUES (117, 11, 'Falcón');
INSERT INTO si_municipio VALUES (118, 11, 'Federación');
INSERT INTO si_municipio VALUES (119, 11, 'Jacura');
INSERT INTO si_municipio VALUES (120, 11, 'Los Taques');
INSERT INTO si_municipio VALUES (121, 11, 'Mauroa');
INSERT INTO si_municipio VALUES (122, 11, 'Miranda');
INSERT INTO si_municipio VALUES (123, 11, 'Monseñor Iturriza');
INSERT INTO si_municipio VALUES (124, 11, 'Palmasola');
INSERT INTO si_municipio VALUES (125, 11, 'Petit');
INSERT INTO si_municipio VALUES (126, 11, 'Píritu');
INSERT INTO si_municipio VALUES (127, 11, 'San Francisco');
INSERT INTO si_municipio VALUES (128, 11, 'Silva');
INSERT INTO si_municipio VALUES (129, 11, 'Sucre');
INSERT INTO si_municipio VALUES (130, 11, 'Tocópero');
INSERT INTO si_municipio VALUES (131, 11, 'Unión');
INSERT INTO si_municipio VALUES (132, 11, 'Urumaco');
INSERT INTO si_municipio VALUES (133, 11, 'Zamora');
INSERT INTO si_municipio VALUES (134, 12, 'Camaguán');
INSERT INTO si_municipio VALUES (135, 12, 'Chaguaramas');
INSERT INTO si_municipio VALUES (136, 12, 'El Socorro');
INSERT INTO si_municipio VALUES (137, 12, 'Sebastian Francisco de Miranda');
INSERT INTO si_municipio VALUES (138, 12, 'José Félix Ribas');
INSERT INTO si_municipio VALUES (139, 12, 'José Tadeo Monagas');
INSERT INTO si_municipio VALUES (140, 12, 'Juan Germán Roscio');
INSERT INTO si_municipio VALUES (141, 12, 'Julián Mellado');
INSERT INTO si_municipio VALUES (142, 12, 'Las Mercedes');
INSERT INTO si_municipio VALUES (143, 12, 'Leonardo Infante');
INSERT INTO si_municipio VALUES (144, 12, 'Pedro Zaraza');
INSERT INTO si_municipio VALUES (145, 12, 'Ortiz');
INSERT INTO si_municipio VALUES (146, 12, 'San Gerónimo de Guayabal');
INSERT INTO si_municipio VALUES (147, 12, 'San José de Guaribe');
INSERT INTO si_municipio VALUES (148, 12, 'Santa María de Ipire');
INSERT INTO si_municipio VALUES (149, 13, 'Andrés Eloy Blanco');
INSERT INTO si_municipio VALUES (150, 13, 'Crespo');
INSERT INTO si_municipio VALUES (151, 13, 'Iribarren');
INSERT INTO si_municipio VALUES (152, 13, 'Jiménez');
INSERT INTO si_municipio VALUES (153, 13, 'Morán');
INSERT INTO si_municipio VALUES (154, 13, 'Palavecino');
INSERT INTO si_municipio VALUES (213, 16, 'Sotillo');
INSERT INTO si_municipio VALUES (214, 16, 'Uracoa');
INSERT INTO si_municipio VALUES (215, 17, 'Antolín del Campo');
INSERT INTO si_municipio VALUES (216, 17, 'Arismendi ');
INSERT INTO si_municipio VALUES (217, 17, 'Díaz');
INSERT INTO si_municipio VALUES (218, 17, 'García');
INSERT INTO si_municipio VALUES (219, 17, 'Gómez');
INSERT INTO si_municipio VALUES (220, 17, 'Maneiro');
INSERT INTO si_municipio VALUES (221, 17, 'Marcano ');
INSERT INTO si_municipio VALUES (222, 17, 'Mariño ');
INSERT INTO si_municipio VALUES (223, 17, 'Península de Macanao ');
INSERT INTO si_municipio VALUES (224, 17, 'Tubores ');
INSERT INTO si_municipio VALUES (225, 17, 'Villalba');
INSERT INTO si_municipio VALUES (226, 18, 'Agua Blanca');
INSERT INTO si_municipio VALUES (227, 18, 'Araure ');
INSERT INTO si_municipio VALUES (228, 18, 'Esteller ');
INSERT INTO si_municipio VALUES (229, 18, 'Guanare ');
INSERT INTO si_municipio VALUES (230, 18, 'Guanarito');
INSERT INTO si_municipio VALUES (231, 18, 'Monseñor José Vicente de Unda ');
INSERT INTO si_municipio VALUES (232, 18, 'Ospino ');
INSERT INTO si_municipio VALUES (233, 18, 'Páez ');
INSERT INTO si_municipio VALUES (234, 18, 'Papelón ');
INSERT INTO si_municipio VALUES (235, 18, 'San Genaro de Boconoíto');
INSERT INTO si_municipio VALUES (236, 18, 'San Rafael de Onoto');
INSERT INTO si_municipio VALUES (237, 18, 'Santa Rosalía ');
INSERT INTO si_municipio VALUES (238, 18, 'Sucre');
INSERT INTO si_municipio VALUES (239, 18, 'Turén');
INSERT INTO si_municipio VALUES (240, 19, 'Andrés Eloy Blanco ');
INSERT INTO si_municipio VALUES (241, 19, 'Andrés Mata');
INSERT INTO si_municipio VALUES (242, 19, 'Arismendi ');
INSERT INTO si_municipio VALUES (243, 19, 'Benítez ');
INSERT INTO si_municipio VALUES (244, 19, 'Bermúdez');
INSERT INTO si_municipio VALUES (245, 19, 'Bolívar');
INSERT INTO si_municipio VALUES (246, 19, 'Cajigal ');
INSERT INTO si_municipio VALUES (247, 19, 'Cruz Salmerón Acosta');
INSERT INTO si_municipio VALUES (248, 19, 'Libertador');
INSERT INTO si_municipio VALUES (249, 19, 'Mariño ');
INSERT INTO si_municipio VALUES (250, 19, 'Mejía ');
INSERT INTO si_municipio VALUES (251, 19, 'Montes');
INSERT INTO si_municipio VALUES (252, 19, 'Ribero');
INSERT INTO si_municipio VALUES (253, 19, 'Sucre');
INSERT INTO si_municipio VALUES (254, 19, 'Valdez ');
INSERT INTO si_municipio VALUES (255, 20, 'Andrés Bello ');
INSERT INTO si_municipio VALUES (256, 20, 'Antonio Rómulo Costa');
INSERT INTO si_municipio VALUES (257, 20, 'Ayacucho ');
INSERT INTO si_municipio VALUES (258, 20, 'Bolívar');
INSERT INTO si_municipio VALUES (259, 20, 'Cárdenas ');
INSERT INTO si_municipio VALUES (260, 20, 'Córdoba (Santa Ana de Táchira)');
INSERT INTO si_municipio VALUES (261, 20, 'Fernández Feo');
INSERT INTO si_municipio VALUES (262, 20, 'Francisco de Miranda');
INSERT INTO si_municipio VALUES (156, 13, 'Torres');
INSERT INTO si_municipio VALUES (157, 13, 'Urdaneta');
INSERT INTO si_municipio VALUES (158, 14, 'Alberto Adriani');
INSERT INTO si_municipio VALUES (159, 14, 'Andrés Bello');
INSERT INTO si_municipio VALUES (160, 14, 'Antonio Pinto Salinas');
INSERT INTO si_municipio VALUES (161, 14, 'Aricagua');
INSERT INTO si_municipio VALUES (162, 14, 'Arzobispo Chacón');
INSERT INTO si_municipio VALUES (163, 14, 'Campo Elías');
INSERT INTO si_municipio VALUES (164, 14, 'Caracciolo Parra Olmedo');
INSERT INTO si_municipio VALUES (165, 14, 'Cardenal Quintero');
INSERT INTO si_municipio VALUES (166, 14, 'Guaraque');
INSERT INTO si_municipio VALUES (167, 14, 'Julio César Salas');
INSERT INTO si_municipio VALUES (168, 14, 'Justo Briceño');
INSERT INTO si_municipio VALUES (169, 14, 'Libertador');
INSERT INTO si_municipio VALUES (170, 14, 'Miranda');
INSERT INTO si_municipio VALUES (171, 14, 'Obispo Ramos de Lora');
INSERT INTO si_municipio VALUES (172, 14, 'Padre Noguera');
INSERT INTO si_municipio VALUES (173, 14, 'Pueblo Llano');
INSERT INTO si_municipio VALUES (174, 14, 'Rangel');
INSERT INTO si_municipio VALUES (175, 14, 'Rivas Dávila');
INSERT INTO si_municipio VALUES (176, 14, 'Santos Marquina');
INSERT INTO si_municipio VALUES (177, 14, 'Sucre');
INSERT INTO si_municipio VALUES (178, 14, 'Tovar');
INSERT INTO si_municipio VALUES (179, 14, 'Tulio Febres Cordero');
INSERT INTO si_municipio VALUES (180, 14, 'Zea');
INSERT INTO si_municipio VALUES (181, 15, 'Acevedo');
INSERT INTO si_municipio VALUES (182, 15, 'Andrés Bello');
INSERT INTO si_municipio VALUES (183, 15, 'Baruta');
INSERT INTO si_municipio VALUES (184, 15, 'Brión');
INSERT INTO si_municipio VALUES (185, 15, 'Buroz');
INSERT INTO si_municipio VALUES (186, 15, 'Carrizal');
INSERT INTO si_municipio VALUES (187, 15, 'Chacao');
INSERT INTO si_municipio VALUES (188, 15, 'Cristóbal Rojas');
INSERT INTO si_municipio VALUES (189, 15, 'El Hatillo');
INSERT INTO si_municipio VALUES (190, 15, 'Guaicaipuro');
INSERT INTO si_municipio VALUES (191, 15, 'Independencia');
INSERT INTO si_municipio VALUES (192, 15, 'Lander');
INSERT INTO si_municipio VALUES (193, 15, 'Los Salias');
INSERT INTO si_municipio VALUES (194, 15, 'Páez');
INSERT INTO si_municipio VALUES (195, 15, 'Paz Castillo');
INSERT INTO si_municipio VALUES (196, 15, 'Pedro Gual');
INSERT INTO si_municipio VALUES (197, 15, 'Plaza');
INSERT INTO si_municipio VALUES (198, 15, 'Simón Bolívar');
INSERT INTO si_municipio VALUES (199, 15, 'Sucre');
INSERT INTO si_municipio VALUES (200, 15, 'Urdaneta');
INSERT INTO si_municipio VALUES (201, 15, 'Zamora');
INSERT INTO si_municipio VALUES (202, 16, 'Acosta');
INSERT INTO si_municipio VALUES (203, 16, 'Aguasay');
INSERT INTO si_municipio VALUES (204, 16, 'Bolívar');
INSERT INTO si_municipio VALUES (205, 16, 'Caripe');
INSERT INTO si_municipio VALUES (206, 16, 'Cedeño');
INSERT INTO si_municipio VALUES (207, 16, 'Ezequiel Zamora');
INSERT INTO si_municipio VALUES (208, 16, 'Libertador');
INSERT INTO si_municipio VALUES (209, 16, 'Maturín');
INSERT INTO si_municipio VALUES (210, 16, 'Piar');
INSERT INTO si_municipio VALUES (211, 16, 'Punceres');
INSERT INTO si_municipio VALUES (212, 16, 'Santa Bárbara');
INSERT INTO si_municipio VALUES (263, 20, 'García de Hevia');
INSERT INTO si_municipio VALUES (264, 20, 'Guásimos');
INSERT INTO si_municipio VALUES (265, 20, 'Independencia');
INSERT INTO si_municipio VALUES (266, 20, 'Jáuregui ');
INSERT INTO si_municipio VALUES (267, 20, 'José María Vargas');
INSERT INTO si_municipio VALUES (268, 20, 'Junín ');
INSERT INTO si_municipio VALUES (269, 20, 'Libertad (Capacho Viejo)');
INSERT INTO si_municipio VALUES (270, 20, 'Libertador');
INSERT INTO si_municipio VALUES (271, 20, 'Lobatera ');
INSERT INTO si_municipio VALUES (272, 20, 'Michelena');
INSERT INTO si_municipio VALUES (273, 20, 'Panamericano');
INSERT INTO si_municipio VALUES (274, 20, 'Pedro María Ureña');
INSERT INTO si_municipio VALUES (275, 20, 'Rafael Urdaneta');
INSERT INTO si_municipio VALUES (276, 20, 'Samuel Darío Maldonado');
INSERT INTO si_municipio VALUES (277, 20, 'San Cristóbal');
INSERT INTO si_municipio VALUES (278, 20, 'Seboruco');
INSERT INTO si_municipio VALUES (279, 20, 'Simón Rodríguez');
INSERT INTO si_municipio VALUES (280, 20, 'Sucre');
INSERT INTO si_municipio VALUES (281, 20, 'Torbes ');
INSERT INTO si_municipio VALUES (282, 20, 'Uribante');
INSERT INTO si_municipio VALUES (283, 20, 'San Judas Tadeo');
INSERT INTO si_municipio VALUES (284, 21, 'Andrés Bello');
INSERT INTO si_municipio VALUES (285, 21, 'Boconó');
INSERT INTO si_municipio VALUES (286, 21, 'Bolívar');
INSERT INTO si_municipio VALUES (287, 21, 'Candelaria');
INSERT INTO si_municipio VALUES (288, 21, 'Carache');
INSERT INTO si_municipio VALUES (289, 21, 'Escuque');
INSERT INTO si_municipio VALUES (290, 21, 'José Felipe Márquez Cañizalez ');
INSERT INTO si_municipio VALUES (291, 21, 'Juan Vicente Campos Elías');
INSERT INTO si_municipio VALUES (292, 21, 'La Ceiba');
INSERT INTO si_municipio VALUES (293, 21, 'Miranda');
INSERT INTO si_municipio VALUES (294, 21, 'Monte Carmelo ');
INSERT INTO si_municipio VALUES (295, 21, 'Motatán ');
INSERT INTO si_municipio VALUES (296, 21, 'Pampán');
INSERT INTO si_municipio VALUES (297, 21, 'Pampanito ');
INSERT INTO si_municipio VALUES (298, 21, 'Rafael Rangel');
INSERT INTO si_municipio VALUES (299, 21, 'San Rafael de Carvajal');
INSERT INTO si_municipio VALUES (300, 21, 'Sucre');
INSERT INTO si_municipio VALUES (301, 21, 'Trujillo');
INSERT INTO si_municipio VALUES (302, 21, 'Urdaneta');
INSERT INTO si_municipio VALUES (303, 21, 'Valera');
INSERT INTO si_municipio VALUES (304, 22, 'Vargas');
INSERT INTO si_municipio VALUES (305, 23, 'Arístides Bastidas');
INSERT INTO si_municipio VALUES (306, 23, 'Bolívar');
INSERT INTO si_municipio VALUES (307, 23, 'Bruzual');
INSERT INTO si_municipio VALUES (308, 23, 'Cocorote');
INSERT INTO si_municipio VALUES (309, 23, 'Independencia');
INSERT INTO si_municipio VALUES (310, 23, 'José Antonio Páez ');
INSERT INTO si_municipio VALUES (311, 23, 'La Trinidad');
INSERT INTO si_municipio VALUES (312, 23, 'Manuel Monge');
INSERT INTO si_municipio VALUES (313, 23, 'Nirgua');
INSERT INTO si_municipio VALUES (314, 23, 'Peña');
INSERT INTO si_municipio VALUES (315, 23, 'San Felipe');
INSERT INTO si_municipio VALUES (316, 23, 'Sucre');
INSERT INTO si_municipio VALUES (317, 23, 'Urachiche');
INSERT INTO si_municipio VALUES (318, 23, 'Veroes');
INSERT INTO si_municipio VALUES (319, 24, 'Almirante Padilla');
INSERT INTO si_municipio VALUES (320, 24, 'Baralt');
INSERT INTO si_municipio VALUES (321, 24, 'Cabimas');
INSERT INTO si_municipio VALUES (322, 24, 'Catatumbo');
INSERT INTO si_municipio VALUES (323, 24, 'Colón');
INSERT INTO si_municipio VALUES (324, 24, 'Francisco Javier Pulgar');
INSERT INTO si_municipio VALUES (325, 24, 'Jesús Enrique Losada ');
INSERT INTO si_municipio VALUES (326, 24, 'Jesús María Semprún ');
INSERT INTO si_municipio VALUES (327, 24, 'Cañada de Urdaneta');
INSERT INTO si_municipio VALUES (328, 24, 'Lagunillas');
INSERT INTO si_municipio VALUES (329, 24, 'Machiques de Perijá');
INSERT INTO si_municipio VALUES (330, 24, 'Mara');
INSERT INTO si_municipio VALUES (331, 24, 'Maracaibo');
INSERT INTO si_municipio VALUES (332, 24, 'Miranda');
INSERT INTO si_municipio VALUES (333, 24, 'Páez');
INSERT INTO si_municipio VALUES (334, 24, 'Rosario de Perijá');
INSERT INTO si_municipio VALUES (335, 24, 'San Francisco ');
INSERT INTO si_municipio VALUES (336, 24, 'Santa Rita ');
INSERT INTO si_municipio VALUES (337, 24, 'Simón Bolívar ');
INSERT INTO si_municipio VALUES (338, 24, 'Sucre ');
INSERT INTO si_municipio VALUES (339, 24, 'Valmore Rodríguez ');
INSERT INTO si_municipio VALUES (155, 13, 'Simón Planas');


--
-- TOC entry 2398 (class 0 OID 36796)
-- Dependencies: 205
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2399 (class 0 OID 36803)
-- Dependencies: 207
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (2, 'AGROPATRIA', NULL, 'J13769431', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-02-19 14:51:33.417-04:30', true, 'AGR');
INSERT INTO si_organizacion VALUES (1, 'TODOS', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 1, 1, '2012-02-12 00:00:00-04:30', '2012-02-19 14:45:27.722-04:30', true, 'TOD');


--
-- TOC entry 2400 (class 0 OID 36812)
-- Dependencies: 209
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'Venezuela');


--
-- TOC entry 2401 (class 0 OID 36818)
-- Dependencies: 211
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17', NULL);
INSERT INTO si_parametros VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17', NULL);
INSERT INTO si_parametros VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20', NULL);


--
-- TOC entry 2402 (class 0 OID 36827)
-- Dependencies: 213
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles VALUES (1, 'GERENTE GENERAL', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (2, 'GERENTE', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (3, 'ADMINISTRADOR', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (4, 'CALIDAD', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (5, 'ROMANERO', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (6, 'RECEPCION', '2012-02-07', NULL);
INSERT INTO si_perfiles VALUES (7, 'DESPACHO', '2012-02-07', NULL);


--
-- TOC entry 2403 (class 0 OID 36831)
-- Dependencies: 214
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2404 (class 0 OID 36836)
-- Dependencies: 216
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2405 (class 0 OID 36843)
-- Dependencies: 219
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor VALUES (1, 1, '01              ', 'V013769341      ', 'V0137693417     ', 'JUAN TABORDA', '04269333866', 'N/A', 'tabordajuan@gmail.com', 'C  ', 'V  ', 'MARACAY', 1, 2, 1, 'NORTE', true, '                ', 'N/A', 'MARACAY         ', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '2011-02-22 00:00:00-04:30', '2011-02-22 00:00:00-04:30');


--
-- TOC entry 2406 (class 0 OID 36852)
-- Dependencies: 221
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa VALUES (2, 2, 'PRIMER PROGRAMA', NULL, '2012-02-23 13:13:17.94223-04:30', NULL, true, 'PR1');


--
-- TOC entry 2407 (class 0 OID 36859)
-- Dependencies: 222
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2408 (class 0 OID 36865)
-- Dependencies: 223
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2409 (class 0 OID 36873)
-- Dependencies: 225
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2410 (class 0 OID 36880)
-- Dependencies: 228
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_silos VALUES (7, 3, 3, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.047308-04:30', NULL);
INSERT INTO si_silos VALUES (8, 3, 3, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.064005-04:30', NULL);
INSERT INTO si_silos VALUES (29, 4, 4, 'SILO 13', 'MODULO A', 13, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.548043-04:30', NULL);
INSERT INTO si_silos VALUES (53, 5, 5, 'SILO 13', 'MODULO A', 13, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.541914-04:30', NULL);
INSERT INTO si_silos VALUES (30, 4, 4, 'SILO 14', 'MODULO A', 14, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.565593-04:30', NULL);
INSERT INTO si_silos VALUES (54, 5, 5, 'SILO 14', 'MODULO A', 14, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.561376-04:30', NULL);
INSERT INTO si_silos VALUES (77, 8, 8, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.481-04:30', NULL);
INSERT INTO si_silos VALUES (76, 8, 8, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.478-04:30', NULL);
INSERT INTO si_silos VALUES (75, 8, 8, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:35:00.46-04:30', NULL);
INSERT INTO si_silos VALUES (83, 9, 9, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.175-04:30', NULL);
INSERT INTO si_silos VALUES (84, 9, 9, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.182-04:30', NULL);
INSERT INTO si_silos VALUES (85, 9, 9, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-19 15:39:25.185-04:30', NULL);
INSERT INTO si_silos VALUES (17, 4, 4, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.348165-04:30', NULL);
INSERT INTO si_silos VALUES (41, 5, 5, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.341886-04:30', NULL);
INSERT INTO si_silos VALUES (18, 4, 4, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.365003-04:30', NULL);
INSERT INTO si_silos VALUES (42, 5, 5, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.358622-04:30', NULL);
INSERT INTO si_silos VALUES (62, 6, 6, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.781128-04:30', NULL);
INSERT INTO si_silos VALUES (3, 2, 2, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.147421-04:30', NULL);
INSERT INTO si_silos VALUES (74, 7, 7, 'SILO 2', 'MODULO A', 2, 1000, NULL, '1', 'A ', '2012-02-19 15:27:55-04:30', NULL);
INSERT INTO si_silos VALUES (9, 3, 3, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.080546-04:30', NULL);
INSERT INTO si_silos VALUES (19, 4, 4, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.381487-04:30', NULL);
INSERT INTO si_silos VALUES (43, 5, 5, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.375377-04:30', NULL);
INSERT INTO si_silos VALUES (63, 6, 6, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.797725-04:30', NULL);
INSERT INTO si_silos VALUES (10, 3, 3, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.097424-04:30', NULL);
INSERT INTO si_silos VALUES (20, 4, 4, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.39829-04:30', NULL);
INSERT INTO si_silos VALUES (44, 5, 5, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.39185-04:30', NULL);
INSERT INTO si_silos VALUES (64, 6, 6, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.814551-04:30', NULL);
INSERT INTO si_silos VALUES (5, 2, 2, 'SILO 4', 'MODULO A', 4, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.180896-04:30', NULL);
INSERT INTO si_silos VALUES (11, 3, 3, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.114005-04:30', NULL);
INSERT INTO si_silos VALUES (21, 4, 4, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.414956-04:30', NULL);
INSERT INTO si_silos VALUES (45, 5, 5, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.408492-04:30', NULL);
INSERT INTO si_silos VALUES (65, 6, 6, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.831087-04:30', NULL);
INSERT INTO si_silos VALUES (6, 2, 2, 'SILO 5', 'MODULO A', 5, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.197353-04:30', NULL);
INSERT INTO si_silos VALUES (12, 3, 3, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.130658-04:30', NULL);
INSERT INTO si_silos VALUES (22, 4, 4, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.431423-04:30', NULL);
INSERT INTO si_silos VALUES (46, 5, 5, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.425069-04:30', NULL);
INSERT INTO si_silos VALUES (66, 6, 6, 'SILO 6', 'MODULO A', 6, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.847859-04:30', NULL);
INSERT INTO si_silos VALUES (13, 3, 3, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.147097-04:30', NULL);
INSERT INTO si_silos VALUES (23, 4, 4, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.448256-04:30', NULL);
INSERT INTO si_silos VALUES (47, 5, 5, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.442001-04:30', NULL);
INSERT INTO si_silos VALUES (67, 6, 6, 'SILO 7', 'MODULO A', 7, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.864434-04:30', NULL);
INSERT INTO si_silos VALUES (14, 3, 3, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.164022-04:30', NULL);
INSERT INTO si_silos VALUES (24, 4, 4, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.464898-04:30', NULL);
INSERT INTO si_silos VALUES (48, 5, 5, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.458509-04:30', NULL);
INSERT INTO si_silos VALUES (68, 6, 6, 'SILO 8', 'MODULO A', 8, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.880988-04:30', NULL);
INSERT INTO si_silos VALUES (15, 3, 3, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.180592-04:30', NULL);
INSERT INTO si_silos VALUES (25, 4, 4, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.481472-04:30', NULL);
INSERT INTO si_silos VALUES (49, 5, 5, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.475215-04:30', NULL);
INSERT INTO si_silos VALUES (69, 6, 6, 'SILO 9', 'MODULO A', 9, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.897561-04:30', NULL);
INSERT INTO si_silos VALUES (16, 3, 3, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:05:32.197159-04:30', NULL);
INSERT INTO si_silos VALUES (26, 4, 4, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.498121-04:30', NULL);
INSERT INTO si_silos VALUES (50, 5, 5, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.491855-04:30', NULL);
INSERT INTO si_silos VALUES (70, 6, 6, 'SILO 10', 'MODULO A', 10, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.914479-04:30', NULL);
INSERT INTO si_silos VALUES (27, 4, 4, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.514982-04:30', NULL);
INSERT INTO si_silos VALUES (51, 5, 5, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.508602-04:30', NULL);
INSERT INTO si_silos VALUES (71, 6, 6, 'SILO 11', 'MODULO A', 11, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.931073-04:30', NULL);
INSERT INTO si_silos VALUES (28, 4, 4, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.531417-04:30', NULL);
INSERT INTO si_silos VALUES (52, 5, 5, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.525128-04:30', NULL);
INSERT INTO si_silos VALUES (72, 6, 6, 'SILO 12', 'MODULO A', 12, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.947754-04:30', NULL);
INSERT INTO si_silos VALUES (31, 4, 4, 'SILO 15', 'MODULO A', 15, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.585406-04:30', NULL);
INSERT INTO si_silos VALUES (55, 5, 5, 'SILO 15', 'MODULO A', 15, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.575171-04:30', NULL);
INSERT INTO si_silos VALUES (32, 4, 4, 'SILO 16', 'MODULO A', 16, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.598079-04:30', NULL);
INSERT INTO si_silos VALUES (56, 5, 5, 'SILO 16', 'MODULO A', 16, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.59178-04:30', NULL);
INSERT INTO si_silos VALUES (33, 4, 4, 'SILO 17', 'MODULO A', 17, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.614882-04:30', NULL);
INSERT INTO si_silos VALUES (57, 5, 5, 'SILO 17', 'MODULO A', 17, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.60849-04:30', NULL);
INSERT INTO si_silos VALUES (34, 4, 4, 'SILO 18', 'MODULO A', 18, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.631368-04:30', NULL);
INSERT INTO si_silos VALUES (58, 5, 5, 'SILO 18', 'MODULO A', 18, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.625125-04:30', NULL);
INSERT INTO si_silos VALUES (35, 4, 4, 'SILO 19', 'MODULO A', 19, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.64816-04:30', NULL);
INSERT INTO si_silos VALUES (59, 5, 5, 'SILO 19', 'MODULO A', 19, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.64196-04:30', NULL);
INSERT INTO si_silos VALUES (36, 4, 4, 'SILO 20', 'MODULO A', 20, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.664683-04:30', NULL);
INSERT INTO si_silos VALUES (60, 5, 5, 'SILO 20', 'MODULO A', 20, 1000, NULL, '1', 'A ', '2012-02-13 11:12:33.658508-04:30', NULL);
INSERT INTO si_silos VALUES (37, 4, 4, 'SILO 21', 'MODULO A', 21, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.681424-04:30', NULL);
INSERT INTO si_silos VALUES (38, 4, 4, 'SILO 22', 'MODULO A', 22, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.698087-04:30', NULL);
INSERT INTO si_silos VALUES (39, 4, 4, 'SILO 23', 'MODULO A', 23, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.714699-04:30', NULL);
INSERT INTO si_silos VALUES (40, 4, 4, 'SILO 24', 'MODULO A', 24, 1000, NULL, '1', 'A ', '2012-02-13 11:06:27.731507-04:30', NULL);
INSERT INTO si_silos VALUES (61, 6, 6, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:25:07.764398-04:30', NULL);
INSERT INTO si_silos VALUES (73, 7, 7, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-19 15:27:38-04:30', NULL);
INSERT INTO si_silos VALUES (4, 2, 2, 'SILO 3', 'MODULO A', 3, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.164032-04:30', NULL);
INSERT INTO si_silos VALUES (2, 2, 2, 'SILO 1', 'MODULO A', 1, 1000, NULL, '1', 'A ', '2012-02-13 11:01:40.130888-04:30', '2012-02-19 19:46:46.671-04:30');


--
-- TOC entry 2411 (class 0 OID 36891)
-- Dependencies: 230
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2412 (class 0 OID 36897)
-- Dependencies: 231
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2413 (class 0 OID 36907)
-- Dependencies: 234
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12', NULL, true, 1, 'kli5vtsln4vne4gk0j11ok3kr7', '2012-02-23 13:56:20.722241-04:30');
INSERT INTO si_usuarios VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA                          ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesussilva@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 0, NULL, '2012-02-23 16:13:22.630331-04:30');
INSERT INTO si_usuarios VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'juantaborda@agropatria.co.ve', '2012-02-13', '2012-02-17', true, 1, '8h1ur4m9775blsrhfgoe3gimb5', '2012-02-23 13:51:36.837066-04:30');
INSERT INTO si_usuarios VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ                      ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 1, 'ls6hmge8lbrgoe9r85dpbhj0u1', '2012-02-23 21:24:01.376-04:30');


--
-- TOC entry 2414 (class 0 OID 36918)
-- Dependencies: 236
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (3, 3, 2, 4, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles VALUES (4, 4, 2, 6, '2012-02-13 16:15:23.105604-04:30', NULL);


--
-- TOC entry 2415 (class 0 OID 36922)
-- Dependencies: 237
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2197 (class 2606 OID 36936)
-- Dependencies: 167 167
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2225 (class 2606 OID 36938)
-- Dependencies: 196 196
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2193 (class 2606 OID 36940)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2273 (class 2606 OID 37279)
-- Dependencies: 240 240
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2195 (class 2606 OID 36944)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2275 (class 2606 OID 37315)
-- Dependencies: 242 242
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2199 (class 2606 OID 36948)
-- Dependencies: 169 169
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2201 (class 2606 OID 36950)
-- Dependencies: 171 171
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2203 (class 2606 OID 36952)
-- Dependencies: 173 173
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2205 (class 2606 OID 36954)
-- Dependencies: 175 175
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2207 (class 2606 OID 36956)
-- Dependencies: 177 177
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2209 (class 2606 OID 36958)
-- Dependencies: 179 179
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2211 (class 2606 OID 36960)
-- Dependencies: 181 181
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2213 (class 2606 OID 36962)
-- Dependencies: 184 184
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 36964)
-- Dependencies: 186 186
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2277 (class 2606 OID 37328)
-- Dependencies: 244 244
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2217 (class 2606 OID 36966)
-- Dependencies: 188 188
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2219 (class 2606 OID 36968)
-- Dependencies: 190 190
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2221 (class 2606 OID 37375)
-- Dependencies: 191 191
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2223 (class 2606 OID 36970)
-- Dependencies: 194 194
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 37413)
-- Dependencies: 246 246
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2227 (class 2606 OID 36972)
-- Dependencies: 198 198
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2229 (class 2606 OID 36974)
-- Dependencies: 200 200
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2231 (class 2606 OID 36976)
-- Dependencies: 201 201 201
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2233 (class 2606 OID 36978)
-- Dependencies: 203 203
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2235 (class 2606 OID 36980)
-- Dependencies: 205 205
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2237 (class 2606 OID 36982)
-- Dependencies: 207 207
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2239 (class 2606 OID 36984)
-- Dependencies: 209 209
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2241 (class 2606 OID 36986)
-- Dependencies: 211 211
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2243 (class 2606 OID 36988)
-- Dependencies: 213 213
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 36990)
-- Dependencies: 214 214
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2247 (class 2606 OID 37301)
-- Dependencies: 216 216
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 36992)
-- Dependencies: 219 219
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2251 (class 2606 OID 36994)
-- Dependencies: 221 221
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 36996)
-- Dependencies: 222 222
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2255 (class 2606 OID 37450)
-- Dependencies: 223 223
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2257 (class 2606 OID 36998)
-- Dependencies: 225 225
-- Name: si_recepcion_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2259 (class 2606 OID 37000)
-- Dependencies: 228 228
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2261 (class 2606 OID 37002)
-- Dependencies: 230 230
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2263 (class 2606 OID 37004)
-- Dependencies: 231 231
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2269 (class 2606 OID 37006)
-- Dependencies: 236 236
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2265 (class 2606 OID 37008)
-- Dependencies: 234 234
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2267 (class 2606 OID 37010)
-- Dependencies: 234 234
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2271 (class 2606 OID 37583)
-- Dependencies: 237 237
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 37011)
-- Dependencies: 175 162 2204
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2281 (class 2606 OID 37016)
-- Dependencies: 190 2218 162
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2282 (class 2606 OID 37021)
-- Dependencies: 162 2232 203
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2283 (class 2606 OID 37026)
-- Dependencies: 162 209 2238
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2357 (class 2606 OID 37280)
-- Dependencies: 164 2194 240
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2358 (class 2606 OID 37285)
-- Dependencies: 175 2204 240
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2285 (class 2606 OID 37031)
-- Dependencies: 164 165 2194
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2286 (class 2606 OID 37036)
-- Dependencies: 207 165 2236
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2287 (class 2606 OID 37041)
-- Dependencies: 2194 166 164
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2288 (class 2606 OID 37046)
-- Dependencies: 207 166 2236
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2284 (class 2606 OID 37051)
-- Dependencies: 164 207 2236
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2361 (class 2606 OID 37364)
-- Dependencies: 2194 242 164
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2360 (class 2606 OID 37359)
-- Dependencies: 244 242 2276
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2359 (class 2606 OID 37316)
-- Dependencies: 225 2256 242
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2362 (class 2606 OID 37369)
-- Dependencies: 234 2264 242
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2289 (class 2606 OID 37424)
-- Dependencies: 2208 179 169
-- Name: si_asociado_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2292 (class 2606 OID 37439)
-- Dependencies: 190 169 2218
-- Name: si_asociado_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2293 (class 2606 OID 37444)
-- Dependencies: 169 2232 203
-- Name: si_asociado_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2291 (class 2606 OID 37434)
-- Dependencies: 209 2238 169
-- Name: si_asociado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2290 (class 2606 OID 37429)
-- Dependencies: 169 2248 219
-- Name: si_asociado_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2294 (class 2606 OID 37056)
-- Dependencies: 171 162 2192
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2295 (class 2606 OID 37061)
-- Dependencies: 2202 171 173
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2296 (class 2606 OID 37066)
-- Dependencies: 2264 234 171
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2297 (class 2606 OID 37071)
-- Dependencies: 190 175 2218
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2298 (class 2606 OID 37076)
-- Dependencies: 203 175 2232
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2299 (class 2606 OID 37081)
-- Dependencies: 207 175 2236
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2300 (class 2606 OID 37086)
-- Dependencies: 209 175 2238
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2301 (class 2606 OID 37091)
-- Dependencies: 2236 207 177
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2302 (class 2606 OID 37096)
-- Dependencies: 184 2212 179
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2303 (class 2606 OID 37101)
-- Dependencies: 221 2250 179
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2304 (class 2606 OID 37106)
-- Dependencies: 2204 180 175
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2305 (class 2606 OID 37111)
-- Dependencies: 179 2208 180
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2306 (class 2606 OID 37116)
-- Dependencies: 219 180 2248
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2307 (class 2606 OID 37295)
-- Dependencies: 181 175 2204
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2308 (class 2606 OID 37121)
-- Dependencies: 207 184 2236
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2309 (class 2606 OID 37126)
-- Dependencies: 2212 184 186
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2310 (class 2606 OID 37131)
-- Dependencies: 186 2236 207
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2363 (class 2606 OID 37329)
-- Dependencies: 2204 175 244
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2364 (class 2606 OID 37334)
-- Dependencies: 2212 184 244
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2365 (class 2606 OID 37339)
-- Dependencies: 205 2234 244
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2366 (class 2606 OID 37344)
-- Dependencies: 2248 219 244
-- Name: si_despacho_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2370 (class 2606 OID 37599)
-- Dependencies: 244 2254 223
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2371 (class 2606 OID 37604)
-- Dependencies: 244 2258 228
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2369 (class 2606 OID 37594)
-- Dependencies: 2262 244 231
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2368 (class 2606 OID 37589)
-- Dependencies: 2264 234 244
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2367 (class 2606 OID 37584)
-- Dependencies: 244 2270 237
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2311 (class 2606 OID 37136)
-- Dependencies: 2236 207 188
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2312 (class 2606 OID 37141)
-- Dependencies: 209 190 2238
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2316 (class 2606 OID 37391)
-- Dependencies: 191 190 2218
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2317 (class 2606 OID 37396)
-- Dependencies: 191 203 2232
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2313 (class 2606 OID 37376)
-- Dependencies: 191 207 2236
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2315 (class 2606 OID 37386)
-- Dependencies: 191 2238 209
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2314 (class 2606 OID 37381)
-- Dependencies: 2248 191 219
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2318 (class 2606 OID 37146)
-- Dependencies: 194 175 2204
-- Name: si_guia_rec_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2319 (class 2606 OID 37151)
-- Dependencies: 194 2208 179
-- Name: si_guia_rec_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2320 (class 2606 OID 37156)
-- Dependencies: 184 194 2212
-- Name: si_guia_rec_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2321 (class 2606 OID 37161)
-- Dependencies: 2264 234 194
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2372 (class 2606 OID 37414)
-- Dependencies: 194 2222 246
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2373 (class 2606 OID 37419)
-- Dependencies: 246 2256 225
-- Name: si_guiarec_det_id_rec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_rec_fkey FOREIGN KEY (id_rec) REFERENCES si_recepcion(id);


--
-- TOC entry 2322 (class 2606 OID 37166)
-- Dependencies: 198 2224 196
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2323 (class 2606 OID 37171)
-- Dependencies: 201 2228 200
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2324 (class 2606 OID 37176)
-- Dependencies: 201 2264 234
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2325 (class 2606 OID 37181)
-- Dependencies: 190 2218 203
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2326 (class 2606 OID 37186)
-- Dependencies: 205 2204 175
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2327 (class 2606 OID 37191)
-- Dependencies: 2206 177 205
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2328 (class 2606 OID 37196)
-- Dependencies: 205 2212 184
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2329 (class 2606 OID 37201)
-- Dependencies: 190 207 2218
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2330 (class 2606 OID 37206)
-- Dependencies: 2232 207 203
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2331 (class 2606 OID 37211)
-- Dependencies: 2238 207 209
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2332 (class 2606 OID 37401)
-- Dependencies: 207 2236 214
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2333 (class 2606 OID 37302)
-- Dependencies: 207 2236 216
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2334 (class 2606 OID 37216)
-- Dependencies: 2218 219 190
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2335 (class 2606 OID 37221)
-- Dependencies: 219 203 2232
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2336 (class 2606 OID 37226)
-- Dependencies: 2236 219 207
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2337 (class 2606 OID 37231)
-- Dependencies: 2238 209 219
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2338 (class 2606 OID 37236)
-- Dependencies: 2204 221 175
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2339 (class 2606 OID 37451)
-- Dependencies: 2206 223 177
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2341 (class 2606 OID 37461)
-- Dependencies: 2218 190 223
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2342 (class 2606 OID 37466)
-- Dependencies: 2232 203 223
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2340 (class 2606 OID 37456)
-- Dependencies: 2238 209 223
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2347 (class 2606 OID 37567)
-- Dependencies: 169 225 2198
-- Name: si_recepcion_id_asociado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);


--
-- TOC entry 2343 (class 2606 OID 37526)
-- Dependencies: 2204 225 175
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2344 (class 2606 OID 37531)
-- Dependencies: 2208 225 179
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2348 (class 2606 OID 37572)
-- Dependencies: 194 2222 225
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2346 (class 2606 OID 37562)
-- Dependencies: 2248 225 219
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2345 (class 2606 OID 37557)
-- Dependencies: 2258 228 225
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2349 (class 2606 OID 37577)
-- Dependencies: 225 2264 234
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2350 (class 2606 OID 37241)
-- Dependencies: 2192 228 162
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2351 (class 2606 OID 37246)
-- Dependencies: 2204 228 175
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2352 (class 2606 OID 37251)
-- Dependencies: 2204 230 175
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2353 (class 2606 OID 37290)
-- Dependencies: 2204 231 175
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2354 (class 2606 OID 37256)
-- Dependencies: 2192 236 162
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2355 (class 2606 OID 37261)
-- Dependencies: 2242 213 236
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2356 (class 2606 OID 37266)
-- Dependencies: 2264 236 234
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-24 01:15:22

--
-- PostgreSQL database dump complete
--

