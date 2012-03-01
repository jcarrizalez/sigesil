--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-03-01 00:38:46

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 252 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 252
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 161 (class 1259 OID 38590)
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
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 38592)
-- Dependencies: 2133 6
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
-- TOC entry 163 (class 1259 OID 38599)
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
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- TOC entry 164 (class 1259 OID 38601)
-- Dependencies: 2134 2135 6
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
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 165 (class 1259 OID 38606)
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
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 166 (class 1259 OID 38609)
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
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 38611)
-- Dependencies: 2137 2138 2139 2140 2141 2142 6
-- Name: si_analisis_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_cultivo (
    id_org bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    laboratorio character(1) NOT NULL,
    reduccion_rec numeric(10,3) DEFAULT 0,
    reduccion_des numeric(10,3) DEFAULT 0,
    estatus boolean,
    id bigint NOT NULL,
    min_rec numeric(16,3) DEFAULT 0.0,
    max_rec numeric(16,3) DEFAULT 0.0,
    min_des numeric(16,3) DEFAULT 0.0,
    max_des numeric(16,3) DEFAULT 0.0
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- TOC entry 168 (class 1259 OID 38620)
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
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 63, true);


--
-- TOC entry 169 (class 1259 OID 38622)
-- Dependencies: 2144 6
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
-- TOC entry 170 (class 1259 OID 38626)
-- Dependencies: 169 6
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
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 38628)
-- Dependencies: 6
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
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 172 (class 1259 OID 38631)
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
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 1, true);


--
-- TOC entry 173 (class 1259 OID 38633)
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
-- TOC entry 174 (class 1259 OID 38639)
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
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 2, true);


--
-- TOC entry 175 (class 1259 OID 38641)
-- Dependencies: 2147 6
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
-- TOC entry 176 (class 1259 OID 38648)
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
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 38650)
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
-- TOC entry 178 (class 1259 OID 38654)
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
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 38656)
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
-- TOC entry 180 (class 1259 OID 38661)
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
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 181 (class 1259 OID 38663)
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
-- TOC entry 182 (class 1259 OID 38676)
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
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 38678)
-- Dependencies: 2158 6
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
-- TOC entry 184 (class 1259 OID 38685)
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
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 4, true);


--
-- TOC entry 185 (class 1259 OID 38687)
-- Dependencies: 2159 2160 2161 2162 2163 6
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
-- TOC entry 186 (class 1259 OID 38698)
-- Dependencies: 6
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
-- TOC entry 187 (class 1259 OID 38701)
-- Dependencies: 6 186
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_cosecha_productor_id_seq OWNER TO admin;

--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 3, true);


--
-- TOC entry 188 (class 1259 OID 38703)
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
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE si_cuarentena; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cuarentena IS 'Tabla de Cuarentena para Fumigacion de Cultivos';


--
-- TOC entry 189 (class 1259 OID 38706)
-- Dependencies: 6 188
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
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 190 (class 1259 OID 38708)
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
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 9, true);


--
-- TOC entry 191 (class 1259 OID 38710)
-- Dependencies: 2166 2167 2168 6
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
-- TOC entry 192 (class 1259 OID 38716)
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
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 38718)
-- Dependencies: 2169 6
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
-- TOC entry 194 (class 1259 OID 38722)
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
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción';


--
-- TOC entry 195 (class 1259 OID 38725)
-- Dependencies: 6 194
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
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 38727)
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
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 197 (class 1259 OID 38729)
-- Dependencies: 2171 2172 6
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
-- TOC entry 198 (class 1259 OID 38734)
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
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 199 (class 1259 OID 38736)
-- Dependencies: 2173 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 200 (class 1259 OID 38740)
-- Dependencies: 2174 6
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
-- TOC entry 201 (class 1259 OID 38747)
-- Dependencies: 6 200
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
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 202 (class 1259 OID 38749)
-- Dependencies: 2176 2178 6
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
    estatus character(1) DEFAULT 1,
    cedula_asociado character(16),
    contrato character varying(16),
    nombre_chofer character(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 203 (class 1259 OID 38754)
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
-- TOC entry 204 (class 1259 OID 38757)
-- Dependencies: 203 6
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
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 204
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 204
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 1, false);


--
-- TOC entry 205 (class 1259 OID 38759)
-- Dependencies: 202 6
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
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 4, true);


--
-- TOC entry 206 (class 1259 OID 38761)
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
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 207 (class 1259 OID 38763)
-- Dependencies: 2180 6
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
-- TOC entry 208 (class 1259 OID 38767)
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
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 865, true);


--
-- TOC entry 209 (class 1259 OID 38769)
-- Dependencies: 2181 6
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
-- TOC entry 210 (class 1259 OID 38776)
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
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 26, true);


--
-- TOC entry 211 (class 1259 OID 38778)
-- Dependencies: 2182 2183 6
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
-- TOC entry 212 (class 1259 OID 38783)
-- Dependencies: 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 38786)
-- Dependencies: 6 212
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_menu_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_menu_usuario_id_seq OWNER TO admin;

--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_usuario_id_seq', 34, true);


--
-- TOC entry 214 (class 1259 OID 38788)
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
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 215 (class 1259 OID 38790)
-- Dependencies: 2185 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 38794)
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
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 216
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- TOC entry 217 (class 1259 OID 38796)
-- Dependencies: 2186 2187 6
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
-- TOC entry 218 (class 1259 OID 38801)
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
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 219 (class 1259 OID 38803)
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
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 220 (class 1259 OID 38810)
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
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 221 (class 1259 OID 38812)
-- Dependencies: 2189 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 38816)
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
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 5, true);


--
-- TOC entry 223 (class 1259 OID 38818)
-- Dependencies: 2190 6
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
-- TOC entry 224 (class 1259 OID 38825)
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
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 225 (class 1259 OID 38827)
-- Dependencies: 2191 6
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
-- TOC entry 226 (class 1259 OID 38831)
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
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 227 (class 1259 OID 38834)
-- Dependencies: 6 226
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
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 1, false);


--
-- TOC entry 228 (class 1259 OID 38836)
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
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 229 (class 1259 OID 38839)
-- Dependencies: 228 6
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
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 1, false);


--
-- TOC entry 230 (class 1259 OID 38841)
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
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 3, true);


--
-- TOC entry 231 (class 1259 OID 38843)
-- Dependencies: 2194 6
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
-- TOC entry 232 (class 1259 OID 38850)
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
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 3, true);


--
-- TOC entry 233 (class 1259 OID 38852)
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
    codigo character varying(16) NOT NULL
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 38859)
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
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 235 (class 1259 OID 38865)
-- Dependencies: 234 6
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
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 236 (class 1259 OID 38867)
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
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 237 (class 1259 OID 38873)
-- Dependencies: 236 6
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
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- TOC entry 238 (class 1259 OID 38875)
-- Dependencies: 2198 6
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
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo
Estatus=''T''=>Transito
Estatus=''A''=>Activo
Estatus=''C''=>Curentena';


--
-- TOC entry 239 (class 1259 OID 38879)
-- Dependencies: 238 6
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
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 4, true);


--
-- TOC entry 240 (class 1259 OID 38881)
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
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 240
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 241 (class 1259 OID 38883)
-- Dependencies: 2200 2201 2202 6
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
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 242 (class 1259 OID 38892)
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
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- TOC entry 243 (class 1259 OID 38894)
-- Dependencies: 2203 2204 2205 6
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
-- TOC entry 244 (class 1259 OID 38900)
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
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 245 (class 1259 OID 38906)
-- Dependencies: 244 6
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
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
-- TOC entry 246 (class 1259 OID 38908)
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
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 247 (class 1259 OID 38910)
-- Dependencies: 2207 2208 2209 6
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
-- TOC entry 248 (class 1259 OID 38919)
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
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 248
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 249 (class 1259 OID 38921)
-- Dependencies: 2210 6
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
-- TOC entry 250 (class 1259 OID 38925)
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
    chuto boolean,
    placa_remolques character(16),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_vehiculos OWNER TO admin;

--
-- TOC entry 251 (class 1259 OID 38928)
-- Dependencies: 6 250
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 251
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 4, true);


--
-- TOC entry 2136 (class 2604 OID 38930)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2143 (class 2604 OID 38931)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2145 (class 2604 OID 38932)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 38933)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 38934)
-- Dependencies: 187 186
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 38935)
-- Dependencies: 189 188
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 38936)
-- Dependencies: 195 194
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2175 (class 2604 OID 38937)
-- Dependencies: 201 200
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 38938)
-- Dependencies: 205 202
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 38939)
-- Dependencies: 204 203
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 38940)
-- Dependencies: 213 212
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 38941)
-- Dependencies: 227 226
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 38942)
-- Dependencies: 229 228
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2196 (class 2604 OID 38943)
-- Dependencies: 235 234
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 38944)
-- Dependencies: 237 236
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2199 (class 2604 OID 38945)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 38946)
-- Dependencies: 245 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 38947)
-- Dependencies: 251 250
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2391 (class 0 OID 38592)
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
-- TOC entry 2392 (class 0 OID 38601)
-- Dependencies: 164
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1');
INSERT INTO si_analisis VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2');
INSERT INTO si_analisis VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8');
INSERT INTO si_analisis VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9');
INSERT INTO si_analisis VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10');
INSERT INTO si_analisis VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11');
INSERT INTO si_analisis VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12');
INSERT INTO si_analisis VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13');
INSERT INTO si_analisis VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14');
INSERT INTO si_analisis VALUES (19, 1, 'COLOR', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '22');
INSERT INTO si_analisis VALUES (18, 1, 'OLOR', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '21');
INSERT INTO si_analisis VALUES (4, 1, 'GRANOS DAÑADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4');
INSERT INTO si_analisis VALUES (5, 1, 'GRANOS DAÑADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5');
INSERT INTO si_analisis VALUES (6, 1, 'GRANOS DAÑADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6');
INSERT INTO si_analisis VALUES (7, 1, 'GRANOS DAÑADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7');
INSERT INTO si_analisis VALUES (15, 1, 'GRANO PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15');
INSERT INTO si_analisis VALUES (3, 1, 'GRANOS CON GERMEN DAÑADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3');
INSERT INTO si_analisis VALUES (16, 1, 'AFLATOXINA', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19');
INSERT INTO si_analisis VALUES (17, 1, 'ASPECTO', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20');
INSERT INTO si_analisis VALUES (20, 1, 'LIMPIEZA', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '23');
INSERT INTO si_analisis VALUES (21, 1, 'INSECTOS VIVOS', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24');


--
-- TOC entry 2393 (class 0 OID 38606)
-- Dependencies: 165
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2394 (class 0 OID 38611)
-- Dependencies: 167
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'A', 0.000, 0.000, true, 2, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'A', 0.000, 0.000, true, 3, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'A', 0.000, 0.000, true, 4, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'A', 0.000, 0.000, true, 5, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'A', 0.000, 0.000, true, 6, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'A', 0.000, 0.000, true, 7, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'A', 0.000, 0.000, true, 8, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'A', 0.000, 0.000, true, 9, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'A', 0.000, 0.000, true, 10, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'A', 0.000, 0.000, true, 11, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'A', 0.000, 0.000, true, 12, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'A', 0.000, 0.000, true, 13, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 5, 'A', 0.000, 0.000, true, 14, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'A', 0.000, 0.000, true, 15, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'A', 0.000, 0.000, true, 16, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'A', 0.000, 0.000, true, 17, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 5, 'A', 0.000, 0.000, true, 18, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 17, 5, 'A', 0.000, 0.000, true, 19, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 18, 5, 'A', 0.000, 0.000, true, 20, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, true, 21, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, true, 22, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, true, 23, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'A', 0.000, 0.000, true, 24, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'A', 0.000, 0.000, true, 25, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'A', 0.000, 0.000, true, 26, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'A', 0.000, 0.000, true, 27, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'A', 0.000, 0.000, true, 28, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'A', 0.000, 0.000, true, 29, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'A', 0.000, 0.000, true, 30, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'A', 0.000, 0.000, true, 31, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'A', 0.000, 0.000, true, 32, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'A', 0.000, 0.000, true, 33, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'A', 0.000, 0.000, true, 34, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'A', 0.000, 0.000, true, 35, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'A', 0.000, 0.000, true, 36, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'A', 0.000, 0.000, true, 37, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'A', 0.000, 0.000, true, 38, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 6, 'A', 0.000, 0.000, true, 39, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 17, 6, 'A', 0.000, 0.000, true, 40, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 18, 6, 'A', 0.000, 0.000, true, 41, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 6, 'A', 0.000, 0.000, true, 42, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 6, 'A', 0.000, 0.000, true, 43, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 6, 'A', 0.000, 0.000, true, 44, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'A', 0.000, 0.000, true, 45, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'A', 0.000, 0.000, true, 46, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'A', 0.000, 0.000, true, 47, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'A', 0.000, 0.000, true, 48, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'A', 0.000, 0.000, true, 49, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'A', 0.000, 0.000, true, 50, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'A', 0.000, 0.000, true, 51, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'A', 0.000, 0.000, true, 52, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'A', 0.000, 0.000, true, 53, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'A', 0.000, 0.000, true, 54, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'A', 0.000, 0.000, true, 55, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'A', 0.000, 0.000, true, 56, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'A', 0.000, 0.000, true, 57, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 1, 'A', 0.000, 0.000, true, 58, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 17, 1, 'A', 0.000, 0.000, true, 59, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 18, 1, 'A', 0.000, 0.000, true, 60, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, true, 61, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, true, 62, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, true, 63, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'A', 0.000, 0.000, true, 1, 1.000, 2.000, 0.000, 0.000);


--
-- TOC entry 2395 (class 0 OID 38622)
-- Dependencies: 169
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2396 (class 0 OID 38628)
-- Dependencies: 171
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2397 (class 0 OID 38633)
-- Dependencies: 173
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_app_error VALUES ('b9cb062f1d095df587', '2012-02-27 07:56:45.310681-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 07:56:45";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('bec43c27e79396ee31', '2012-02-27 07:59:27.12415-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 07:59:27";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('95c10ff495f5b72ff3', '2012-02-27 08:03:33.629411-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:03:33";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('00a73d024ef9e70af1', '2012-02-27 08:05:17.158226-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:77;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:05:17";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('d908f9d28967c42b58', '2012-02-27 08:06:30.726666-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:06:30";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('467549abcebeaa30d5', '2012-02-27 08:07:57.347577-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:76;s:5:"class";s:9:"Recepcion";s:8:"function";s:17:"asociadoRecepcion";s:11:"mysql_error";s:128:"ERROR:  no existe la columna aso.cedula
LINE 1: SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, a...
               ^";s:5:"query";s:221:"SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso <br />
                    FROM si_asociado aso<br />
                    WHERE aso.cedula = ''V123''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 08:07:57";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:60;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('361053801bba911f24', '2012-02-27 08:15:08.368579-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:11;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:179:"ERROR:  no existe la columna a.id_cultivo
LINE 8: ...                 WHERE "1" AND a.id_org = "1" AND a.id_culti...
                                                             ^";s:5:"query";s:397:"select <br />
                    a.id,<br />
                    ac.id_cultivo, <br />
                    a.codigo,<br />
                    a.nombre <br />
                    from si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND a.id_cultivo = ''1'' ORDER BY a.id";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-27 08:15:08";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:18;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('0907f2cd74309e3bc1', '2012-02-28 14:31:29.503704-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:11;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:175:"ERROR:  no existe la columna a.tipo_analaisis
LINE 1: SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_anala...
                                                        ^";s:5:"query";s:327:"SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analaisis <br />
                    FROM si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND ac.id_cultivo = ''1'' ORDER BY cast(a.codigo as int)";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-28 02:31:29";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:14;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('b56bb9d72575f2d56c', '2012-02-27 08:23:24.227169-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:15;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"listadoAnalisis";s:11:"mysql_error";s:185:"ERROR:  no existe la columna rec.estatus_guia
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
INSERT INTO si_app_error VALUES ('ef54a32d1849e20c94', '2012-02-27 10:36:33.820202-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:33;s:5:"class";s:8:"Analisis";s:8:"function";s:17:"guardarResultados";s:11:"mysql_error";s:207:"ERROR:  la sintaxis de entrada no es válida para tipo real: «»
LINE 1: ...a1, muestra2, muestra3) VALUES ("2", "1", "3", "2", "4", "")
                                                                    ^";s:5:"query";s:140:"INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''2'', ''4'', '''')";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-27 10:36:35";}i:1;a:4:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis.class.php<br>";s:4:"line";i:16;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('e8c6b3ebf481ed020d', '2012-02-27 13:28:21.172024-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:58:"/var/www/sigesi_agropatria/admin/productor_listado.php<br>";s:4:"line";i:9;s:5:"class";s:9:"Productor";s:8:"function";s:18:"listadoProductores";s:11:"mysql_error";s:185:"ERROR:  no existe la columna p.id_centro_acopio
LINE 4: ...        INNER JOIN si_centro_acopio ca ON ca.id = p.id_centr...
                                                             ^";s:5:"query";s:275:"SELECT p.id,p.*,<br />
                    ca.nombre AS nombre_ca<br />
                    FROM si_productor p<br />
                    INNER JOIN si_centro_acopio ca ON ca.id = p.id_centro_acopio<br />
                    WHERE ''1'' AND p.id_centro_acopio = 2 ORDER BY p.id";s:9:"user_name";s:32:"JSILVA                          ";s:4:"date";s:19:"2012-02-27 01:28:22";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/productor.class.php<br>";s:4:"line";i:15;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('c9f8693865ce9e0e6e', '2012-02-27 14:09:21.138266-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:180:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 3:                 WHERE id_cosecha = "" AND id_centro_acopio =...
                                           ^";s:5:"query";s:205:"SELECT *<br />
                FROM si_cosecha_productor<br />
                WHERE id_cosecha = '''' AND id_centro_acopio = ''2'' AND id_productor = ''V963852'' AND asociado = ''t''<br />
                LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:09:21";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:80;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('0e3bacf7f0a97e7990', '2012-02-27 14:11:53.031781-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE cp.id_cosecha = "" AND cp.id_centr...
                                                  ^";s:5:"query";s:310:"SELECT cp.*<br />
                    FROM si_cosecha_productor cp<br />
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor<br />
                    WHERE cp.id_cosecha = '''' AND cp.id_centro_acopio = ''2'' AND pr.ced_rif = ''V963852'' AND cp.asociado = ''t''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:11:53";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:81;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('169b05d1d04f83da98', '2012-02-27 14:21:15.326769-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:114;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE cp.id_cosecha = "" AND cp.id_centr...
                                                  ^";s:5:"query";s:310:"SELECT cp.*<br />
                    FROM si_cosecha_productor cp<br />
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor<br />
                    WHERE cp.id_cosecha = '''' AND cp.id_centro_acopio = ''2'' AND pr.ced_rif = ''V963852'' AND cp.asociado = ''t''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-27 02:21:15";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:81;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('1c6920640d097eed15', '2012-02-28 14:30:24.143506-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:11;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:175:"ERROR:  no existe la columna a.tipo_analaisis
LINE 1: SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_anala...
                                                        ^";s:5:"query";s:327:"SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analaisis <br />
                    FROM si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND ac.id_cultivo = ''1'' ORDER BY cast(a.codigo as int)";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-28 02:30:23";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:14;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('b3b05bd6d91ea4cdd2', '2012-02-29 13:49:27.124522-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:52;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"verificarProAso";s:11:"mysql_error";s:187:"ERROR:  la sintaxis de entrada no es válida para integer: «»
LINE 4:                     WHERE cp.id_cosecha = "" AND cp.id_centr...
                                                  ^";s:5:"query";s:312:"SELECT cp.*<br />
                    FROM si_cosecha_productor cp<br />
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor<br />
                    WHERE cp.id_cosecha = '''' AND cp.id_centro_acopio = ''2'' AND pr.ced_rif = ''V18264065'' AND cp.asociado = ''t''<br />
                    LIMIT 1";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-29 01:49:27";}i:1;a:4:{s:4:"file";s:60:"/var/www/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:85;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('a39ff8aca1fe751acd', '2012-02-29 14:25:52.587346-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:17;s:5:"class";s:9:"Recepcion";s:8:"function";s:15:"listadoAnalisis";s:11:"mysql_error";s:124:"ERROR:  no existe la columna cul.min_rec
LINE 3:                     cul.min_rec, cul.max_rec,
                            ^";s:5:"query";s:802:"SELECT ca.id AS id_ca, ca.codigo AS codigo_ca, ca.nombre AS nombre_ca, <br />
                    cul.id AS id_cultivo, cul.codigo AS codigo_cul, cul.nombre AS nombre_cul,<br />
                    cul.min_rec, cul.max_rec,<br />
                    rec.id AS id_rec, rec.numero, rec.estatus_rec, rec.fecha_recepcion, <br />
                    rec.cant_muestras, rec.carril <br />
                    FROM si_recepcion rec<br />
                    INNER JOIN si_centro_acopio ca ON rec.id_centro_acopio=ca.id<br />
                    INNER JOIN si_cosecha cos ON cos.id=rec.id_cosecha<br />
                    INNER JOIN si_cultivo cul ON cul.id=cos.id_cultivo<br />
                    WHERE ''1'' AND cul.id = ''1'' AND rec.id = ''3'' ORDER BY ca.codigo, cos.id, cul.id, rec.fecha_recepcion, rec.numero";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-29 02:25:54";}i:1;a:4:{s:4:"file";s:76:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/recepcion.class.php<br>";s:4:"line";i:36;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('f17491d701af2e974f', '2012-02-29 14:32:03.324208-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:15;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:135:"ERROR:  error de sintaxis en o cerca de «FROM»
LINE 3:                     FROM si_analisis_cultivo ac 
                            ^";s:5:"query";s:379:"SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analisis,<br />
                    cul.min_rec, cul.max_rec, <br />
                    FROM si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND ac.id_cultivo = ''1'' ORDER BY cast(a.codigo as int)";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-29 02:32:05";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:15;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('0d07f92a1d12893c45', '2012-02-29 14:33:08.497039-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:75:"/home/jtaborda/proyectos/sigesi_agropatria/admin/analisis_recepcion.php<br>";s:4:"line";i:15;s:5:"class";s:15:"AnalisisCultivo";s:8:"function";s:8:"buscarAC";s:11:"mysql_error";s:152:"ERROR:  falta una entrada para la tabla «cul» en la cláusula FROM
LINE 2:                     cul.min_rec, cul.max_rec 
                            ^";s:5:"query";s:378:"SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analisis,<br />
                    cul.min_rec, cul.max_rec <br />
                    FROM si_analisis_cultivo ac <br />
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org<br />
                    WHERE ''1'' AND a.id_org = ''1'' AND ac.id_cultivo = ''1'' ORDER BY cast(a.codigo as int)";s:9:"user_name";s:32:"JTABORDA                        ";s:4:"date";s:19:"2012-02-29 02:33:10";}i:1;a:4:{s:4:"file";s:83:"/home/jtaborda/proyectos/sigesi_agropatria/lib/class/analisis_cultivo.class.php<br>";s:4:"line";i:15;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('7d5b6adfa40a5b2d93', '2012-02-29 16:27:28.903616-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:57:"/var/www/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:8;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:183:"ERROR:  no existe la columna guia.estatus_rec
LINE 1: ... Guia where "1" AND Guia.numero_guia="12312"  AND Guia.estat...
                                                             ^";s:5:"query";s:94:"SELECT * FROM si_guiarec Guia where ''1'' AND Guia.numero_guia=''12312''  AND Guia.estatus_rec=''P''";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-29 04:27:28";}i:1;a:4:{s:4:"file";s:56:"/var/www/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('a35e77446d95229e88', '2012-02-29 23:15:43.296-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:65:"http://localhost/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:8;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:183:"ERROR:  no existe la columna guia.estatus_rec
LINE 1: ...ec Guia where "1" AND Guia.numero_guia="123"  AND Guia.estat...
                                                             ^";s:5:"query";s:92:"SELECT * FROM si_guiarec Guia where ''1'' AND Guia.numero_guia=''123''  AND Guia.estatus_rec=''P''";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-29 11:15:43";}i:1;a:4:{s:4:"file";s:64:"http://localhost/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');
INSERT INTO si_app_error VALUES ('781a35a1f1ebd349a7', '2012-02-29 23:17:21.738-04:30', 'a:2:{i:0;a:8:{s:4:"file";s:65:"http://localhost/sigesi_agropatria/ajax/recepcion_detalle.php<br>";s:4:"line";i:8;s:5:"class";s:5:"Model";s:8:"function";s:4:"find";s:11:"mysql_error";s:183:"ERROR:  no existe la columna guia.estatus_rec
LINE 1: ...ec Guia where "1" AND Guia.numero_guia="123"  AND Guia.estat...
                                                             ^";s:5:"query";s:92:"SELECT * FROM si_guiarec Guia where ''1'' AND Guia.numero_guia=''123''  AND Guia.estatus_rec=''P''";s:9:"user_name";s:32:"JRODRIGUEZ                      ";s:4:"date";s:19:"2012-02-29 11:17:21";}i:1;a:4:{s:4:"file";s:64:"http://localhost/sigesi_agropatria/lib/class/model.class.php<br>";s:4:"line";i:33;s:5:"class";s:11:"cls_dbtools";s:8:"function";s:9:"_SQL_tool";}}');


--
-- TOC entry 2398 (class 0 OID 38641)
-- Dependencies: 175
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_asociado VALUES (2, 3, 'V16872741       ', 'CARLOS PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);


--
-- TOC entry 2399 (class 0 OID 38650)
-- Dependencies: 177
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2400 (class 0 OID 38656)
-- Dependencies: 179
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2401 (class 0 OID 38663)
-- Dependencies: 181
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_centro_acopio VALUES (1, 1, '00', 'AGROPATRIA', NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, true, '2012-02-12 00:00:00-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (2, 1, '56', 'ARAURE', 'J-123123', NULL, NULL, NULL, 'GUARICO', 1, 18, 227, NULL, NULL, true, '2012-02-13 11:01:40.092295-04:30', '2012-02-19 15:03:36.599-04:30');
INSERT INTO si_centro_acopio VALUES (3, 1, '57', 'SABANA DE PARRA', 'J-123123', NULL, NULL, NULL, 'Algun Lugar', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:05:32.010896-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (4, 1, '58', 'CHAGUARAMAS', 'J-123123', NULL, NULL, NULL, 'Chaguaramas', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:06:27.30781-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (5, 1, '60', 'SABANETA', 'J-123123', NULL, NULL, NULL, 'Zulia', 1, 2, 2, NULL, NULL, true, '2012-02-13 11:12:33.305226-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (6, 1, '63', 'ZARAZA', 'J-123123', NULL, NULL, NULL, 'Guarico', 1, 1, 1, NULL, NULL, true, '2012-02-13 11:25:07.723533-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (7, 1, '67', 'MATURIN', NULL, NULL, NULL, NULL, NULL, 1, 16, 209, NULL, NULL, true, '2012-02-19 15:23:43.873-04:30', NULL);
INSERT INTO si_centro_acopio VALUES (8, 1, '69', 'CALABOZO', NULL, NULL, NULL, NULL, NULL, 1, 12, 137, NULL, NULL, true, '2012-02-19 15:35:00.425-04:30', '2012-02-19 15:39:43.266-04:30');
INSERT INTO si_centro_acopio VALUES (9, 1, '71', 'GUANARE', NULL, NULL, NULL, NULL, NULL, 1, 18, 229, NULL, NULL, true, '2012-02-19 15:39:25.134-04:30', NULL);


--
-- TOC entry 2402 (class 0 OID 38678)
-- Dependencies: 183
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2403 (class 0 OID 38687)
-- Dependencies: 185
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha VALUES (2, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201201');
INSERT INTO si_cosecha VALUES (3, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201202');
INSERT INTO si_cosecha VALUES (4, 3, 3, 'SEGUNDA COSECHA', NULL, NULL, NULL, '2012-02-27', '2012-09-28', true, '2012-02-27 13:32:56.323501-04:30', NULL, '201203');


--
-- TOC entry 2404 (class 0 OID 38698)
-- Dependencies: 186
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor VALUES (2, 2, 2, false, NULL, NULL, 2);
INSERT INTO si_cosecha_productor VALUES (2, 2, 3, true, NULL, NULL, 3);


--
-- TOC entry 2405 (class 0 OID 38703)
-- Dependencies: 188
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2406 (class 0 OID 38710)
-- Dependencies: 191
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
-- TOC entry 2407 (class 0 OID 38718)
-- Dependencies: 193
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2408 (class 0 OID 38722)
-- Dependencies: 194
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2409 (class 0 OID 38729)
-- Dependencies: 197
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2410 (class 0 OID 38736)
-- Dependencies: 199
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
-- TOC entry 2411 (class 0 OID 38740)
-- Dependencies: 200
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2412 (class 0 OID 38749)
-- Dependencies: 202
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec VALUES (2, NULL, NULL, 4, 12312, 180000, NULL, NULL, 'V15610226       ', '2012-02-20 00:00:00-04:30', 'P', NULL, NULL, 'PEDRO PEREZ                                                                                                                                                                                                                                                    ', '2012-02-29 16:12:27.158984-04:30', NULL);
INSERT INTO si_guiarec VALUES (3, NULL, NULL, 4, 1234214, 150000, NULL, NULL, 'V15610226       ', '2012-02-22 00:00:00-04:30', 'P', NULL, NULL, 'PEDRO PEREZ                                                                                                                                                                                                                                                    ', '2012-02-29 16:14:01.338074-04:30', NULL);
INSERT INTO si_guiarec VALUES (4, NULL, NULL, 4, 3452345, 15000, NULL, NULL, 'V13654987       ', '2012-02-29 00:00:00-04:30', 'N', NULL, NULL, 'MARTIN RODRIGUEZ                                                                                                                                                                                                                                               ', '2012-02-29 16:17:14.272529-04:30', NULL);


--
-- TOC entry 2413 (class 0 OID 38754)
-- Dependencies: 203
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2414 (class 0 OID 38763)
-- Dependencies: 207
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2415 (class 0 OID 38769)
-- Dependencies: 209
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_consultas VALUES (320, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (321, '2012-02-27', 202, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33''', '');
INSERT INTO si_log_consultas VALUES (322, '2012-02-27', 102, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33'' ', '');
INSERT INTO si_log_consultas VALUES (323, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (324, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''g25p34affrq63onj9negruph33''', '');
INSERT INTO si_log_consultas VALUES (325, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''g25p34affrq63onj9negruph33'' ', '');
INSERT INTO si_log_consultas VALUES (326, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', 'cilek7efdfsef4digtg68futj6', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 17.0.963.46<br />Engine: AppleWebKit v: 535.11</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''cilek7efdfsef4digtg68futj6''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''cilek7efdfsef4digtg68futj6'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (327, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (328, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''7985''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''180000''<br />cedula_chofer =  ''V18654321''<br />nombre_chofer =  ''CARLOS GUZMAN''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''7985'', ''27-02-2012'', null, ''180000'', ''V18654321'', ''CARLOS GUZMAN'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (329, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''12456789''<br />nombre =  ''PEDRO PEREZ''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''12456789'', ''PEDRO PEREZ'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (330, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  null<br />placa_remolques =  ''123-ASD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', null, ''123-ASD'',now())', '');
INSERT INTO si_log_consultas VALUES (439, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (331, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''7''<br />id_guia =  ''9''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, creado) VALUES  (''1'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''7'', ''9'',now())', '');
INSERT INTO si_log_consultas VALUES (332, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (333, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (334, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (335, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (336, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (337, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (338, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (339, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (340, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (341, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (342, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (343, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''1''<br />fecha_emision =  ''20-02-2012''<br />contrato =  null<br />kilogramos =  ''15000''<br />cedula_chofer =  ''V10112322''<br />nombre_chofer =  ''EVARISTO CAMPOS''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''1'', ''20-02-2012'', null, ''15000'', ''V10112322'', ''EVARISTO CAMPOS'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (344, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V11980123''<br />nombre =  ''JOSE PELUZZO''<br />telefono =  ''0414''<br />email =  ''JOSEPELUZZO@AGROPATRIA.O.VE''<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V11980123'', ''JOSE PELUZZO'', ''0414'', ''JOSEPELUZZO@AGROPATRIA.O.VE'',now())', '');
INSERT INTO si_log_consultas VALUES (345, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''AA22DD3''<br />marca =  ''MACK''<br />placa_remolques =  ''AA11DD44''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''AA22DD3'', ''MACK'', ''AA11DD44'',now())', '');
INSERT INTO si_log_consultas VALUES (346, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''1''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''8''<br />id_guia =  ''10''<br />id_vehiculo =  ''4''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''2'', ''2'', ''27-02-2012'', ''1'', ''1'', ''4'', ''A'', ''2'', ''2'', ''8'', ''10'', ''4'',now())', '');
INSERT INTO si_log_consultas VALUES (347, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (348, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (349, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (350, '2012-02-27', 202, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (351, '2012-02-27', 102, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (352, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (353, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (354, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (355, '2012-02-27', 101, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (356, '2012-02-27', 202, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''908j1ud3vfdfi1a8om140steg7''', '');
INSERT INTO si_log_consultas VALUES (357, '2012-02-27', 102, 1, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''908j1ud3vfdfi1a8om140steg7'' ', '');
INSERT INTO si_log_consultas VALUES (358, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''908j1ud3vfdfi1a8om140steg7'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (359, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (360, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (361, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (362, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''908j1ud3vfdfi1a8om140steg7''', '');
INSERT INTO si_log_consultas VALUES (363, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '908j1ud3vfdfi1a8om140steg7', '192.168.65.219', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''908j1ud3vfdfi1a8om140steg7'' ', '');
INSERT INTO si_log_consultas VALUES (364, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (371, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (372, '2012-02-27', 101, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''v0k2k4udo8khrtnn2bu6usn525''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''v0k2k4udo8khrtnn2bu6usn525'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (373, '2012-02-27', 201, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_programa', 'No data', 'codigo = ''PR2''<br />nombre =  ''SEGUNDO PROGRAMA''<br />estatus =  ''T''<br />observacion =  null<br />id_centro_acopio =  ''2''<br />creado = now()<br />', 'INSERT INTO si_programa  (codigo, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  (''PR2'', ''SEGUNDO PROGRAMA'', ''T'', null, ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (374, '2012-02-27', 201, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_cosecha', 'No data', 'codigo = ''201201''<br />nombre =  ''SEGUNDA COSECHA''<br />id_cultivo =  ''1''<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  ''27-02-2012''<br />fecha_fin =  ''28-09-2012''<br />id_programa =  ''3''<br />estatus =  ''T''<br />creado = now()<br />', 'INSERT INTO si_cosecha  (codigo, nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  (''201201'', ''SEGUNDA COSECHA'', ''1'', null, null, ''27-02-2012'', ''28-09-2012'', ''3'', ''T'',now())', '');
INSERT INTO si_log_consultas VALUES (375, '2012-02-27', 202, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''v0k2k4udo8khrtnn2bu6usn525''', '');
INSERT INTO si_log_consultas VALUES (376, '2012-02-27', 102, 2, 'N/A', 'N/A', 'N/A', 'v0k2k4udo8khrtnn2bu6usn525', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''2'' AND sesion = ''v0k2k4udo8khrtnn2bu6usn525'' ', '');
INSERT INTO si_log_consultas VALUES (377, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (378, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''741852''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''185000''<br />cedula_chofer =  ''V8975632''<br />nombre_chofer =  ''KASJDASKLDJ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''741852'', ''27-02-2012'', null, ''185000'', ''V8975632'', ''KASJDASKLDJ'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (379, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V963852''<br />nombre =  ''KALSJDKALSD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V963852'', ''KALSJDKALSD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (390, '2012-02-27', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (380, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_asociado', 'No data', 'ced_rif = ''V147258''<br />nombre =  ''AJSDHASJD''<br />telefono =  null<br />id_productor =  ''11''<br />creado = now()<br />', 'INSERT INTO si_asociado  (ced_rif, nombre, telefono, id_productor, creado) VALUES  (''V147258'', ''AJSDHASJD'', null, ''11'',now())', '');
INSERT INTO si_log_consultas VALUES (381, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''11''<br />asociado =  ''t''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''11'', ''t'')', '');
INSERT INTO si_log_consultas VALUES (382, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''DLSDAHD''<br />marca =  null<br />placa_remolques =  ''ASDHASKJD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''DLSDAHD'', null, ''ASDHASKJD'',now())', '');
INSERT INTO si_log_consultas VALUES (383, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''3''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''11''<br />id_guia =  ''13''<br />id_vehiculo =  ''5''<br />id_asociado =  ''6''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, id_asociado, creado) VALUES  (''3'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''11'', ''13'', ''5'', ''6'',now())', '');
INSERT INTO si_log_consultas VALUES (384, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''96513210''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''123123''<br />cedula_chofer =  ''V56324123''<br />nombre_chofer =  ''ASDASD''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''96513210'', ''27-02-2012'', null, ''123123'', ''V56324123'', ''ASDASD'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (385, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V89724165''<br />nombre =  ''ASDASD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V89724165'', ''ASDASD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (386, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''12''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''12'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (387, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASDASD''<br />marca =  null<br />placa_remolques =  ''ASDASD''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASDASD'', null, ''ASDASD'',now())', '');
INSERT INTO si_log_consultas VALUES (388, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''4''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''3''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''12''<br />id_guia =  ''14''<br />id_vehiculo =  ''6''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''4'', ''2'', ''27-02-2012'', ''1'', ''3'', ''4'', ''A'', ''2'', ''2'', ''12'', ''14'', ''6'',now())', '');
INSERT INTO si_log_consultas VALUES (389, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (391, '2012-02-27', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (392, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''66''<br />muestra2 =  ''66''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''66'', ''66'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (393, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''66''<br />muestra2 =  ''66''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''66'', ''66'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (394, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''33''<br />muestra2 =  ''22''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''33'', ''22'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (395, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''99''<br />muestra2 =  ''11''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''2'', ''3'', ''99'', ''11'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (398, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''1''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''2'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (399, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''7''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''2'', ''3'', ''5'', ''7'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (402, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''77''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''77'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (403, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''99''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''2'', ''3'', ''99'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (406, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''4''<br />muestra2 =  ''6''<br />muestra3 =  ''7''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''1'', ''3'', ''4'', ''6'', ''7'')', '');
INSERT INTO si_log_consultas VALUES (407, '2012-02-27', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''0''<br />muestra3 =  ''1''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''2'', ''3'', ''5'', ''0'', ''1'')', '');
INSERT INTO si_log_consultas VALUES (408, '2012-02-27', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''6''', '');
INSERT INTO si_log_consultas VALUES (409, '2012-02-27', 101, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''g25p34affrq63onj9negruph33'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (410, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''67''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''100000''<br />cedula_chofer =  ''V9668397''<br />nombre_chofer =  ''JESUS SILVA''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''67'', ''27-02-2012'', null, ''100000'', ''V9668397'', ''JESUS SILVA'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (411, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V9668397''<br />nombre =  ''JESUS SILVA''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V9668397'', ''JESUS SILVA'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (412, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''4''<br />id_centro_acopio =  ''2''<br />id_productor =  ''13''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''4'', ''2'', ''13'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (413, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''MCX 452''<br />marca =  ''CHEVROLET''<br />placa_remolques =  ''DAB 828''<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''MCX 452'', ''CHEVROLET'', ''DAB 828'',now())', '');
INSERT INTO si_log_consultas VALUES (414, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''4''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''13''<br />id_guia =  ''15''<br />id_vehiculo =  ''7''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''1'', ''4'', ''27-02-2012'', ''1'', ''2'', ''4'', ''1'', ''2'', ''2'', ''13'', ''15'', ''7'',now())', '');
INSERT INTO si_log_consultas VALUES (415, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''3123123''<br />fecha_emision =  ''27-02-2012''<br />contrato =  null<br />kilogramos =  ''1854564''<br />cedula_chofer =  ''V54987652''<br />nombre_chofer =  ''ASDASD''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, contrato, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''3123123'', ''27-02-2012'', null, ''1854564'', ''V54987652'', ''ASDASD'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (416, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V213123123''<br />nombre =  ''ASDASDASD''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V213123123'', ''ASDASDASD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (417, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''14''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''14'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (418, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASDASDAS''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASDASDAS'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (419, '2012-02-27', 201, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''5''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''27-02-2012''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''A''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''14''<br />id_guia =  ''16''<br />id_vehiculo =  ''8''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''5'', ''2'', ''27-02-2012'', ''1'', ''2'', ''4'', ''A'', ''2'', ''2'', ''14'', ''16'', ''8'',now())', '');
INSERT INTO si_log_consultas VALUES (420, '2012-02-27', 202, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33''', '');
INSERT INTO si_log_consultas VALUES (421, '2012-02-27', 102, 4, 'N/A', 'N/A', 'N/A', 'g25p34affrq63onj9negruph33', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''g25p34affrq63onj9negruph33'' ', '');
INSERT INTO si_log_consultas VALUES (422, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (423, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', 'rajud3c7vvpvs29999h21c4mm2', '192.168.65.77', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''rajud3c7vvpvs29999h21c4mm2''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''rajud3c7vvpvs29999h21c4mm2'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (424, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (425, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (426, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (427, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (428, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''7''<br />muestra2 =  ''7''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''1'', ''3'', ''7'', ''7'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (429, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''1''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''7''<br />muestra2 =  ''7''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''1'', ''2'', ''3'', ''7'', ''7'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (430, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''1''', '');
INSERT INTO si_log_consultas VALUES (431, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (432, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (433, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (434, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (435, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (436, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (437, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (438, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (440, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (441, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (442, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (443, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (444, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (445, '2012-02-28', 101, 1, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (446, '2012-02-28', 202, 1, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991''', '');
INSERT INTO si_log_consultas VALUES (447, '2012-02-28', 102, 1, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''1'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991'' ', '');
INSERT INTO si_log_consultas VALUES (448, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (449, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991''', '');
INSERT INTO si_log_consultas VALUES (450, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991'' ', '');
INSERT INTO si_log_consultas VALUES (451, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (452, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (453, '2012-02-28', 101, 2, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (454, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (455, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (456, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''7''', '');
INSERT INTO si_log_consultas VALUES (457, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991''', '');
INSERT INTO si_log_consultas VALUES (458, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991'' ', '');
INSERT INTO si_log_consultas VALUES (459, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''e868ng0dk3h84vkoo0q89j3991'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (460, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991''', '');
INSERT INTO si_log_consultas VALUES (461, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'e868ng0dk3h84vkoo0q89j3991', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.23<br />ProductSub: 20110921<br />Engine: Gecko RV: 1.9.2.23</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''e868ng0dk3h84vkoo0q89j3991'' ', '');
INSERT INTO si_log_consultas VALUES (462, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (463, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (464, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (465, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (466, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (467, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (468, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (469, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (470, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (471, '2012-02-28', 101, 1, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (472, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (473, '2012-02-28', 101, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''hnppj0ntpq2jgrsta1rarpek90'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (474, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (475, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (476, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (477, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (478, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363''', '');
INSERT INTO si_log_consultas VALUES (479, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''95apbrbn2fk35jqd3ag09eo363'' ', '');
INSERT INTO si_log_consultas VALUES (480, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''95apbrbn2fk35jqd3ag09eo363'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (481, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (482, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (483, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''3'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (484, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''4'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (485, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''5'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (486, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''6'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (487, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''7'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (488, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''8'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (489, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''9'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (490, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''10'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (491, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''11'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (492, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''12'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (493, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''13'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (494, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''14'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (495, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''15'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (496, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''16'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (497, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''17'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (498, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''18'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (499, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''19'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (500, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''20'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (501, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''1''<br />muestra2 =  ''1''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''21'', ''3'', ''1'', ''1'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (502, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '95apbrbn2fk35jqd3ag09eo363', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (503, '2012-02-28', 202, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90''', '');
INSERT INTO si_log_consultas VALUES (504, '2012-02-28', 102, 4, 'N/A', 'N/A', 'N/A', 'hnppj0ntpq2jgrsta1rarpek90', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''hnppj0ntpq2jgrsta1rarpek90'' ', '');
INSERT INTO si_log_consultas VALUES (505, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (506, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''76dli7hv7tv8q69dqauall1ld3''', '');
INSERT INTO si_log_consultas VALUES (507, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''76dli7hv7tv8q69dqauall1ld3'' ', '');
INSERT INTO si_log_consultas VALUES (508, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (509, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (510, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (511, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (512, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (513, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (514, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (515, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (516, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (517, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (518, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (519, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (520, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (521, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (522, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (523, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (524, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (525, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (526, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (527, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (528, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (529, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (530, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (531, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''3''', '');
INSERT INTO si_log_consultas VALUES (532, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (533, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (534, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (535, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (536, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (537, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (538, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (539, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (692, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (540, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (541, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (542, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (543, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (544, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (545, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (546, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (547, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (548, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (549, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (550, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (551, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (552, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (553, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (554, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (555, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (556, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (557, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (558, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (559, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (835, '2012-02-29', 101, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (560, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (561, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (562, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (563, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (564, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (565, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (566, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (567, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (568, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (569, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (570, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (571, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (572, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (573, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (574, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (575, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''8''', '');
INSERT INTO si_log_consultas VALUES (576, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''76dli7hv7tv8q69dqauall1ld3''', '');
INSERT INTO si_log_consultas VALUES (577, '2012-02-28', 102, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''76dli7hv7tv8q69dqauall1ld3'' ', '');
INSERT INTO si_log_consultas VALUES (578, '2012-02-28', 101, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''76dli7hv7tv8q69dqauall1ld3'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (579, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (580, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (581, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (582, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (583, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (584, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (585, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (586, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (587, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (588, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (589, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (590, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (591, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (592, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (593, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (594, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (595, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (596, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (597, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (598, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (599, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (600, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''5''', '');
INSERT INTO si_log_consultas VALUES (854, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-123''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-123'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (601, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (602, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (603, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (604, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (605, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (606, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (607, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (608, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (609, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (610, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (611, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (612, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (613, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (614, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (615, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (616, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (617, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (618, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (619, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (620, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (621, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (622, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''4''', '');
INSERT INTO si_log_consultas VALUES (623, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (624, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (625, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''3'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (626, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''4'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (627, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''5'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (628, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''6'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (629, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''7'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (630, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''8'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (865, '2012-03-01', 101, 2, 'N/A', 'N/A', 'N/A', 'd2dcpmk38i6rfk334g4364k783', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''d2dcpmk38i6rfk334g4364k783''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''d2dcpmk38i6rfk334g4364k783'' WHERE id=''2''', 'User Login');
INSERT INTO si_log_consultas VALUES (631, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''9'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (632, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''10'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (633, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''11'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (634, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''12'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (635, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''13'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (636, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''14'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (637, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''15'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (638, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''16'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (639, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''17'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (640, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''18'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (641, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''19'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (642, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''8''<br />muestra2 =  ''8''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''20'', ''3'', ''8'', ''8'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (643, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (644, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (645, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (646, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (647, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (648, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (649, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (650, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (651, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (652, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (653, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (654, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (655, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (656, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (657, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (658, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (659, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (660, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (661, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (662, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (663, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (664, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (665, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (666, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''3''', '');
INSERT INTO si_log_consultas VALUES (667, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''1'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (668, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''2'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (669, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''3'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (670, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''4'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (671, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''5'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (672, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''6'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (673, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''7'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (674, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''8'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (675, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''9'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (676, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''10'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (677, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''11'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (678, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''12'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (679, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''13'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (680, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''14'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (681, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''15'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (682, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (683, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (684, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (685, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (686, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (687, '2012-02-28', 201, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''6''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''6'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (688, '2012-02-28', 202, 3, 'N/A', 'N/A', 'N/A', '76dli7hv7tv8q69dqauall1ld3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''6''', '');
INSERT INTO si_log_consultas VALUES (689, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', '9donddegqnqfp6qhliqgqd90t3', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''9donddegqnqfp6qhliqgqd90t3''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''9donddegqnqfp6qhliqgqd90t3'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (690, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (691, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (693, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (694, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''22''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''22'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (695, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''3'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (696, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''4'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (697, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''5'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (698, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''6'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (699, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''7'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (700, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''8'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (701, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''9'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (702, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''10'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (703, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''11'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (704, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''12'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (705, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''13'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (706, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''14'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (707, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''15'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (708, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''16'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (709, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''17'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (710, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''18'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (711, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''19'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (712, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''20'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (713, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (714, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (715, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (716, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''2'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (717, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''3'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (718, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''4'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (719, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''5'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (720, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''6'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (721, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''7'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (722, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''8'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (723, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''9'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (724, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''10'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (725, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''11'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (726, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''12'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (727, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''13'', ''3'', ''2'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (728, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''14'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (729, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''15'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (730, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (731, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (732, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (733, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (734, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (735, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''3''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''1''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''3'', ''21'', ''3'', ''1'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (736, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''3''', '');
INSERT INTO si_log_consultas VALUES (737, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''1'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (738, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''2'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (739, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''3'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (740, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''4'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (741, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''5'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (742, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''6'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (743, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''7'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (744, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''8'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (745, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''9'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (746, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''10'', ''3'', ''6'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (747, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''3''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''11'', ''3'', ''3'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (748, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''12'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (749, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''13'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (750, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''14'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (751, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''15'', ''3'', ''2'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (752, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (753, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (754, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (755, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (756, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (757, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''4''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''4'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (758, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''4''', '');
INSERT INTO si_log_consultas VALUES (759, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''1'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (760, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''2'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (761, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''3'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (762, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''4'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (763, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''5'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (764, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''5''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''6'', ''3'', ''5'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (765, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''65''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''7'', ''3'', ''6'', ''65'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (766, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''65''<br />muestra2 =  ''5''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''8'', ''3'', ''65'', ''5'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (767, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''9'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (768, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''10'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (769, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''11'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (770, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''12'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (771, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''13'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (772, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''14'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (773, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''6''<br />muestra2 =  ''6''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''15'', ''3'', ''6'', ''6'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (774, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (775, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (776, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (777, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (778, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (779, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''5''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''5'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (780, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''5''', '');
INSERT INTO si_log_consultas VALUES (781, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''1'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (782, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''2'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (783, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''3'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (784, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''4'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (785, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''5'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (786, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''6'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (787, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''7'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (788, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''8'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (789, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''9'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (790, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''10'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (791, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''11'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (792, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''12'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (793, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''13'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (794, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''14'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (795, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''2''<br />muestra2 =  ''2''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''15'', ''3'', ''2'', ''2'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (796, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''16'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (797, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''17'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (798, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''18'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (799, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''19'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (800, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''20'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (801, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''8''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''0''<br />muestra2 =  ''0''<br />muestra3 =  ''0''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''8'', ''21'', ''3'', ''0'', ''0'', ''0'')', '');
INSERT INTO si_log_consultas VALUES (802, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''8''', '');
INSERT INTO si_log_consultas VALUES (803, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''1''<br />id_usuario =  ''3''<br />muestra1 =  ''2.9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''1'', ''3'', ''2.9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (804, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''2''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''2'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (805, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''3''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''3'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (806, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''4''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''4'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (807, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''5''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''5'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (808, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''6''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''6'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (809, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''7''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''7'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (810, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''8''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''8'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (811, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''9''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''9'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (812, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''10''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''10'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (813, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''11''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''11'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (814, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''12''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''12'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (815, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''13''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''13'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (816, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''14''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''14'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (817, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''15''<br />id_usuario =  ''3''<br />muestra1 =  ''9''<br />muestra2 =  ''9''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''15'', ''3'', ''9'', ''9'', '''')', '');
INSERT INTO si_log_consultas VALUES (818, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''16''<br />id_usuario =  ''3''<br />muestra1 =  ''A''<br />muestra2 =  ''A''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''16'', ''3'', ''A'', ''A'', '''')', '');
INSERT INTO si_log_consultas VALUES (819, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''17''<br />id_usuario =  ''3''<br />muestra1 =  ''B''<br />muestra2 =  ''B''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''17'', ''3'', ''B'', ''B'', '''')', '');
INSERT INTO si_log_consultas VALUES (820, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''18''<br />id_usuario =  ''3''<br />muestra1 =  ''C''<br />muestra2 =  ''C''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''18'', ''3'', ''C'', ''C'', '''')', '');
INSERT INTO si_log_consultas VALUES (821, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''19''<br />id_usuario =  ''3''<br />muestra1 =  ''D''<br />muestra2 =  ''D''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''19'', ''3'', ''D'', ''D'', '''')', '');
INSERT INTO si_log_consultas VALUES (822, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''20''<br />id_usuario =  ''3''<br />muestra1 =  ''B''<br />muestra2 =  ''B''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''20'', ''3'', ''B'', ''B'', '''')', '');
INSERT INTO si_log_consultas VALUES (823, '2012-02-29', 201, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_analisis_resultado', 'No data', 'id_recepcion = ''2''<br />id_analisis =  ''21''<br />id_usuario =  ''3''<br />muestra1 =  ''NO''<br />muestra2 =  ''SI''<br />muestra3 =  ''''<br />', 'INSERT INTO si_analisis_resultado (id_recepcion, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (''2'', ''21'', ''3'', ''NO'', ''SI'', '''')', '');
INSERT INTO si_log_consultas VALUES (824, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'estatus_rec = ''2''', 'UPDATE si_recepcion SET estatus_rec = ''2'' WHERE id = ''2''', '');
INSERT INTO si_log_consultas VALUES (825, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''5q9jp09f5e5mtfqva0erbo6k75''', '');
INSERT INTO si_log_consultas VALUES (826, '2012-02-29', 102, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''5q9jp09f5e5mtfqva0erbo6k75'' ', '');
INSERT INTO si_log_consultas VALUES (827, '2012-02-29', 101, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (828, '2012-02-29', 202, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''5q9jp09f5e5mtfqva0erbo6k75''', '');
INSERT INTO si_log_consultas VALUES (829, '2012-02-29', 102, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''3'' AND sesion = ''5q9jp09f5e5mtfqva0erbo6k75'' ', '');
INSERT INTO si_log_consultas VALUES (830, '2012-02-29', 101, 1, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (831, '2012-02-29', 101, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (832, '2012-02-29', 101, 1, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (833, '2012-02-29', 101, 3, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''3''', 'User Login');
INSERT INTO si_log_consultas VALUES (834, '2012-02-29', 101, 1, 'N/A', 'N/A', 'N/A', '5q9jp09f5e5mtfqva0erbo6k75', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''5q9jp09f5e5mtfqva0erbo6k75'' WHERE id=''1''', 'User Login');
INSERT INTO si_log_consultas VALUES (836, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''0123''<br />fecha_emision =  ''20-02-2012''<br />kilogramos =  ''180000''<br />cedula_chofer =  ''V12123456''<br />nombre_chofer =  ''CARLOS PEREZ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''0123'', ''20-02-2012'', ''180000'', ''V12123456'', ''CARLOS PEREZ'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (837, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V18264065''<br />nombre =  ''JESUS RODRIGUEZ''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V18264065'', ''JESUS RODRIGUEZ'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (838, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''2'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (839, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-123''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-123'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (840, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''2''<br />id_guia =  ''2''<br />id_vehiculo =  ''9''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''1'', ''2'', ''NOW()'', ''1'', ''2'', ''4'', ''1'', ''2'', ''2'', ''2'', ''2'', ''9'',now())', '');
INSERT INTO si_log_consultas VALUES (841, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''12312''<br />fecha_emision =  ''28-02-2012''<br />kilogramos =  ''123123''<br />cedula_chofer =  ''V12123456''<br />nombre_chofer =  ''CARLOS PEREZ                                                                                                                                                                                                                                                   ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''12312'', ''28-02-2012'', ''123123'', ''V12123456'', ''CARLOS PEREZ                                                                                                                                                                                                                                                   '', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (842, '2012-02-29', 202, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V18264065'', nombre = ''JESUS RODRIGUEZ'', telefono = null, email = null, id = ''2'', modificado=now()', 'UPDATE si_productor SET  ced_rif = ''V18264065'', nombre = ''JESUS RODRIGUEZ'', telefono = null, email = null, id = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas VALUES (843, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                      VALUES (''2'', ''2'', ''2'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (844, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (845, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''3''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''2''<br />id_guia =  ''3''<br />id_vehiculo =  ''10''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''2'', ''2'', ''NOW()'', ''1'', ''3'', ''4'', ''1'', ''2'', ''2'', ''2'', ''3'', ''10'',now())', '');
INSERT INTO si_log_consultas VALUES (846, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''4biloql4ia41fqij8udgqrri34'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (847, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''12312''<br />fecha_emision =  ''20-02-2012''<br />kilogramos =  ''180000''<br />cedula_chofer =  ''V15610226''<br />nombre_chofer =  ''PEDRO PEREZ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''12312'', ''20-02-2012'', ''180000'', ''V15610226'', ''PEDRO PEREZ'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (848, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V18264065''<br />nombre =  ''JESUS RODRIGUEZ''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V18264065'', ''JESUS RODRIGUEZ'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (849, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''2''<br />asociado =  ''f''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                          VALUES (''2'', ''2'', ''2'', ''f'')', '');
INSERT INTO si_log_consultas VALUES (850, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''ASD-ASD''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''ASD-ASD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (851, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''1''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''2''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''2''<br />id_guia =  ''2''<br />id_vehiculo =  ''2''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''1'', ''2'', ''NOW()'', ''1'', ''2'', ''4'', ''1'', ''2'', ''2'', ''2'', ''2'', ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (852, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''1234214''<br />fecha_emision =  ''22-02-2012''<br />kilogramos =  ''150000''<br />cedula_chofer =  ''V15610226''<br />nombre_chofer =  ''PEDRO PEREZ                                                                                                                                                                                                                                                    ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''1234214'', ''22-02-2012'', ''150000'', ''V15610226'', ''PEDRO PEREZ                                                                                                                                                                                                                                                    '', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (853, '2012-02-29', 202, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V18264065'', nombre = ''JESUS RODRIGUEZ'', telefono = null, email = null, id = ''2'', modificado=now()', 'UPDATE si_productor SET  ced_rif = ''V18264065'', nombre = ''JESUS RODRIGUEZ'', telefono = null, email = null, id = ''2'', modificado=now() WHERE id=2', '');
INSERT INTO si_log_consultas VALUES (855, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''2''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''3''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''2''<br />id_guia =  ''3''<br />id_vehiculo =  ''3''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, creado) VALUES  (''2'', ''2'', ''NOW()'', ''1'', ''3'', ''4'', ''1'', ''2'', ''2'', ''2'', ''3'', ''3'',now())', '');
INSERT INTO si_log_consultas VALUES (856, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_guiarec', 'No data', 'numero_guia = ''3452345''<br />fecha_emision =  ''29-02-2012''<br />kilogramos =  ''15000''<br />cedula_chofer =  ''V13654987''<br />nombre_chofer =  ''MARTIN RODRIGUEZ''<br />id_usuario =  ''4''<br />estatus =  ''A''<br />creado = now()<br />', 'INSERT INTO si_guiarec  (numero_guia, fecha_emision, kilogramos, cedula_chofer, nombre_chofer, id_usuario, estatus, creado) VALUES  (''3452345'', ''29-02-2012'', ''15000'', ''V13654987'', ''MARTIN RODRIGUEZ'', ''4'', ''A'',now())', '');
INSERT INTO si_log_consultas VALUES (857, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_productor', 'No data', 'ced_rif = ''V17247200''<br />nombre =  ''ENDER HIGUERA''<br />telefono =  null<br />email =  null<br />creado = now()<br />', 'INSERT INTO si_productor  (ced_rif, nombre, telefono, email, creado) VALUES  (''V17247200'', ''ENDER HIGUERA'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (858, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_asociado', 'No data', 'ced_rif = ''V16872741''<br />nombre =  ''CARLOS PEREZ''<br />telefono =  null<br />id_productor =  ''3''<br />creado = now()<br />', 'INSERT INTO si_asociado  (ced_rif, nombre, telefono, id_productor, creado) VALUES  (''V16872741'', ''CARLOS PEREZ'', null, ''3'',now())', '');
INSERT INTO si_log_consultas VALUES (859, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_cosecha_productor', 'No data', 'id_cosecha = ''2''<br />id_centro_acopio =  ''2''<br />id_productor =  ''3''<br />asociado =  ''t''<br />', 'INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado)                          VALUES (''2'', ''2'', ''3'', ''t'')', '');
INSERT INTO si_log_consultas VALUES (860, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_vehiculos', 'No data', 'placa = ''QWE-ASD''<br />marca =  null<br />placa_remolques =  null<br />creado = now()<br />', 'INSERT INTO si_vehiculos  (placa, marca, placa_remolques, creado) VALUES  (''QWE-ASD'', null, null,now())', '');
INSERT INTO si_log_consultas VALUES (861, '2012-02-29', 201, 4, 'N/A', 'N/A', 'N/A', '4biloql4ia41fqij8udgqrri34', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>	</div>
', 'si_recepcion', 'No data', 'numero = ''3''<br />id_cosecha =  ''2''<br />fecha_recepcion =  ''NOW()''<br />carril =  ''1''<br />cant_muestras =  ''3''<br />id_usuario =  ''4''<br />estatus_rec =  ''1''<br />id_centro_acopio =  ''2''<br />id_silo =  ''2''<br />id_productor =  ''3''<br />id_guia =  ''4''<br />id_vehiculo =  ''4''<br />id_asociado =  ''2''<br />creado = now()<br />', 'INSERT INTO si_recepcion  (numero, id_cosecha, fecha_recepcion, carril, cant_muestras, id_usuario, estatus_rec, id_centro_acopio, id_silo, id_productor, id_guia, id_vehiculo, id_asociado, creado) VALUES  (''3'', ''2'', ''NOW()'', ''1'', ''3'', ''4'', ''1'', ''2'', ''2'', ''3'', ''4'', ''4'', ''2'',now())', '');
INSERT INTO si_log_consultas VALUES (862, '2012-02-29', 101, 4, 'N/A', 'N/A', 'N/A', 'd2dcpmk38i6rfk334g4364k783', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'ultimo_acceso = NOW(), conectado = 1,                      sesion=''d2dcpmk38i6rfk334g4364k783''', 'UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion=''d2dcpmk38i6rfk334g4364k783'' WHERE id=''4''', 'User Login');
INSERT INTO si_log_consultas VALUES (863, '2012-03-01', 202, 4, 'N/A', 'N/A', 'N/A', 'd2dcpmk38i6rfk334g4364k783', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'si_usuarios', 'No data', 'conectado= 0 , sesion = NULL', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''d2dcpmk38i6rfk334g4364k783''', '');
INSERT INTO si_log_consultas VALUES (864, '2012-03-01', 102, 4, 'N/A', 'N/A', 'N/A', 'd2dcpmk38i6rfk334g4364k783', '127.0.0.1', '<div class="float-left-01">
		<h3 class="h-right-bar">User Computer</h3>
			<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>	</div>
', 'No data', 'No data', 'No data', 'UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id=''4'' AND sesion = ''d2dcpmk38i6rfk334g4364k783'' ', '');


--
-- TOC entry 2416 (class 0 OID 38778)
-- Dependencies: 211
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
INSERT INTO si_menu VALUES (27, 'Analisis Recepci&oacute;n', 2, 'admin/analisis_recepcion_listado.php?estatus=1', true, 3, NULL, NULL);


--
-- TOC entry 2417 (class 0 OID 38783)
-- Dependencies: 212
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (1, 1, 1);
INSERT INTO si_menu_usuario VALUES (3, 1, 2);
INSERT INTO si_menu_usuario VALUES (4, 1, 3);
INSERT INTO si_menu_usuario VALUES (5, 1, 4);
INSERT INTO si_menu_usuario VALUES (24, 1, 5);
INSERT INTO si_menu_usuario VALUES (6, 1, 6);
INSERT INTO si_menu_usuario VALUES (7, 1, 7);
INSERT INTO si_menu_usuario VALUES (8, 1, 8);
INSERT INTO si_menu_usuario VALUES (9, 1, 9);
INSERT INTO si_menu_usuario VALUES (13, 1, 10);
INSERT INTO si_menu_usuario VALUES (14, 1, 11);
INSERT INTO si_menu_usuario VALUES (15, 1, 12);
INSERT INTO si_menu_usuario VALUES (16, 1, 13);
INSERT INTO si_menu_usuario VALUES (17, 1, 14);
INSERT INTO si_menu_usuario VALUES (18, 1, 15);
INSERT INTO si_menu_usuario VALUES (19, 1, 16);
INSERT INTO si_menu_usuario VALUES (20, 1, 17);
INSERT INTO si_menu_usuario VALUES (21, 1, 18);
INSERT INTO si_menu_usuario VALUES (22, 1, 19);
INSERT INTO si_menu_usuario VALUES (23, 1, 20);
INSERT INTO si_menu_usuario VALUES (1, 2, 21);
INSERT INTO si_menu_usuario VALUES (7, 2, 22);
INSERT INTO si_menu_usuario VALUES (8, 2, 23);
INSERT INTO si_menu_usuario VALUES (9, 2, 24);
INSERT INTO si_menu_usuario VALUES (10, 2, 25);
INSERT INTO si_menu_usuario VALUES (25, 1, 26);
INSERT INTO si_menu_usuario VALUES (25, 2, 27);
INSERT INTO si_menu_usuario VALUES (26, 1, 28);
INSERT INTO si_menu_usuario VALUES (2, 3, 29);
INSERT INTO si_menu_usuario VALUES (27, 3, 30);
INSERT INTO si_menu_usuario VALUES (2, 4, 31);
INSERT INTO si_menu_usuario VALUES (11, 4, 32);
INSERT INTO si_menu_usuario VALUES (4, 2, 33);
INSERT INTO si_menu_usuario VALUES (21, 2, 34);


--
-- TOC entry 2418 (class 0 OID 38790)
-- Dependencies: 215
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
-- TOC entry 2419 (class 0 OID 38796)
-- Dependencies: 217
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2420 (class 0 OID 38803)
-- Dependencies: 219
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-02-19 14:45:27.722-04:30', true, 'AGR');


--
-- TOC entry 2421 (class 0 OID 38812)
-- Dependencies: 221
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'Venezuela');


--
-- TOC entry 2422 (class 0 OID 38818)
-- Dependencies: 223
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_parametros VALUES (2, 'MAX_RESULTS_PAG', '20', 'N&uacute;mero m&aacute;ximo de registos para paginar', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros VALUES (1, 'SYSTEM_NAME', 'SIGESIL', 'Nombre de la aplicaci&oacute;n', 1, '2012-02-07', '2012-02-07');
INSERT INTO si_parametros VALUES (3, 'LLAVE_PUBLICA', '6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD', 'Llave Publica del Recaptcha', 1, '2012-02-17', NULL);
INSERT INTO si_parametros VALUES (4, 'LLAVE_PRIVADA', '6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF', 'Llave Privada', 1, '2012-02-17', NULL);
INSERT INTO si_parametros VALUES (5, 'COSECHAS_PROGRAMA', '3', 'Cantidad de Cosechas por Programa', 1, '2012-02-20', NULL);


--
-- TOC entry 2423 (class 0 OID 38827)
-- Dependencies: 225
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
-- TOC entry 2424 (class 0 OID 38831)
-- Dependencies: 226
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2425 (class 0 OID 38836)
-- Dependencies: 228
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2426 (class 0 OID 38843)
-- Dependencies: 231
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor VALUES (2, NULL, NULL, 'V18264065       ', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', '2012-02-29 16:14:01.338074-04:30');
INSERT INTO si_productor VALUES (3, NULL, NULL, 'V17247200       ', NULL, 'ENDER HIGUERA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);


--
-- TOC entry 2427 (class 0 OID 38852)
-- Dependencies: 233
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa VALUES (2, 2, 'PRIMER PROGRAMA', NULL, '2012-02-23 13:13:17.94223-04:30', NULL, true, 'PR1');
INSERT INTO si_programa VALUES (3, 2, 'SEGUNDO PROGRAMA', NULL, '2012-02-27 13:32:56.323501-04:30', NULL, true, 'PR2');


--
-- TOC entry 2428 (class 0 OID 38859)
-- Dependencies: 234
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2429 (class 0 OID 38867)
-- Dependencies: 236
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2430 (class 0 OID 38875)
-- Dependencies: 238
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion VALUES (2, 2, 2, 2, 2, NULL, 2, 4, 1, '2012-02-29 16:12:27.158984-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', NULL, 2, 2);
INSERT INTO si_recepcion VALUES (3, 2, 2, 2, 2, NULL, 3, 4, 2, '2012-02-29 16:14:01.338074-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:14:01.338074-04:30', NULL, 3, 3);
INSERT INTO si_recepcion VALUES (4, 2, 2, 2, 3, 2, 4, 4, 3, '2012-02-29 16:17:14.272529-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL, 3, 4);


--
-- TOC entry 2431 (class 0 OID 38883)
-- Dependencies: 241
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
-- TOC entry 2432 (class 0 OID 38894)
-- Dependencies: 243
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2433 (class 0 OID 38900)
-- Dependencies: 244
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2434 (class 0 OID 38910)
-- Dependencies: 247
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12', NULL, true, 1, '5q9jp09f5e5mtfqva0erbo6k75', '2012-02-29 14:33:26.025429-04:30');
INSERT INTO si_usuarios VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'juantaborda@agropatria.co.ve', '2012-02-13', '2012-02-17', true, 1, '5q9jp09f5e5mtfqva0erbo6k75', '2012-02-29 14:34:36.42967-04:30');
INSERT INTO si_usuarios VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ                      ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 0, NULL, '2012-02-29 23:07:33.04-04:30');
INSERT INTO si_usuarios VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA                          ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, NULL, 'jesussilva@agropatria.co.ve', '2012-02-13', '2012-02-13', true, 1, 'd2dcpmk38i6rfk334g4364k783', '2012-03-01 00:03:29.108-04:30');


--
-- TOC entry 2435 (class 0 OID 38921)
-- Dependencies: 249
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', NULL);
INSERT INTO si_usuarios_perfiles VALUES (3, 3, 2, 4, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles VALUES (4, 4, 2, 6, '2012-02-13 16:15:23.105604-04:30', NULL);


--
-- TOC entry 2436 (class 0 OID 38925)
-- Dependencies: 250
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos VALUES (2, 'ASD-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', NULL);
INSERT INTO si_vehiculos VALUES (3, 'ASD-123         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:14:01.338074-04:30', NULL);
INSERT INTO si_vehiculos VALUES (4, 'QWE-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);


--
-- TOC entry 2223 (class 2606 OID 38949)
-- Dependencies: 173 173
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2255 (class 2606 OID 38951)
-- Dependencies: 207 207
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2213 (class 2606 OID 38953)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2217 (class 2606 OID 38955)
-- Dependencies: 165 165
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2219 (class 2606 OID 38957)
-- Dependencies: 167 167
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 38959)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2221 (class 2606 OID 38961)
-- Dependencies: 171 171
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2225 (class 2606 OID 38963)
-- Dependencies: 175 175
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2227 (class 2606 OID 38965)
-- Dependencies: 177 177
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2229 (class 2606 OID 38967)
-- Dependencies: 179 179
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2231 (class 2606 OID 38969)
-- Dependencies: 181 181
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2233 (class 2606 OID 38971)
-- Dependencies: 183 183
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2235 (class 2606 OID 38973)
-- Dependencies: 185 185
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2237 (class 2606 OID 38975)
-- Dependencies: 188 188
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2239 (class 2606 OID 38977)
-- Dependencies: 191 191
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2241 (class 2606 OID 38979)
-- Dependencies: 193 193
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2243 (class 2606 OID 38981)
-- Dependencies: 194 194
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 38983)
-- Dependencies: 197 197
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2247 (class 2606 OID 38985)
-- Dependencies: 199 199
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 38987)
-- Dependencies: 200 200
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2251 (class 2606 OID 38989)
-- Dependencies: 202 202
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 38991)
-- Dependencies: 203 203
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2257 (class 2606 OID 38993)
-- Dependencies: 209 209
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2259 (class 2606 OID 38995)
-- Dependencies: 211 211
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2261 (class 2606 OID 38997)
-- Dependencies: 212 212 212
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2263 (class 2606 OID 38999)
-- Dependencies: 215 215
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2265 (class 2606 OID 39001)
-- Dependencies: 217 217
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2267 (class 2606 OID 39003)
-- Dependencies: 219 219
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2269 (class 2606 OID 39005)
-- Dependencies: 221 221
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2271 (class 2606 OID 39007)
-- Dependencies: 223 223
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2273 (class 2606 OID 39009)
-- Dependencies: 225 225
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2275 (class 2606 OID 39011)
-- Dependencies: 226 226
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2277 (class 2606 OID 39013)
-- Dependencies: 228 228
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 39015)
-- Dependencies: 231 231
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2281 (class 2606 OID 39017)
-- Dependencies: 233 233
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2283 (class 2606 OID 39019)
-- Dependencies: 234 234
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2285 (class 2606 OID 39021)
-- Dependencies: 236 236
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 39023)
-- Dependencies: 238 238
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 39025)
-- Dependencies: 241 241
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2291 (class 2606 OID 39027)
-- Dependencies: 243 243
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2293 (class 2606 OID 39029)
-- Dependencies: 244 244
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 39031)
-- Dependencies: 249 249
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2295 (class 2606 OID 39033)
-- Dependencies: 247 247
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2297 (class 2606 OID 39035)
-- Dependencies: 247 247
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2301 (class 2606 OID 39037)
-- Dependencies: 250 250
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 39038)
-- Dependencies: 2230 181 162
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2303 (class 2606 OID 39043)
-- Dependencies: 199 2246 162
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2304 (class 2606 OID 39048)
-- Dependencies: 215 162 2262
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2305 (class 2606 OID 39053)
-- Dependencies: 2268 162 221
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2307 (class 2606 OID 39058)
-- Dependencies: 164 165 2214
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2308 (class 2606 OID 39063)
-- Dependencies: 181 165 2230
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2309 (class 2606 OID 39068)
-- Dependencies: 167 164 2214
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2310 (class 2606 OID 39073)
-- Dependencies: 167 219 2266
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2311 (class 2606 OID 39078)
-- Dependencies: 164 169 2214
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2312 (class 2606 OID 39083)
-- Dependencies: 2266 169 219
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2306 (class 2606 OID 39088)
-- Dependencies: 219 164 2266
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2313 (class 2606 OID 39093)
-- Dependencies: 171 164 2214
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2314 (class 2606 OID 39098)
-- Dependencies: 2242 171 194
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2315 (class 2606 OID 39103)
-- Dependencies: 238 171 2286
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2316 (class 2606 OID 39108)
-- Dependencies: 247 2294 171
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2317 (class 2606 OID 39113)
-- Dependencies: 2246 175 199
-- Name: si_asociado_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2318 (class 2606 OID 39118)
-- Dependencies: 2262 175 215
-- Name: si_asociado_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2319 (class 2606 OID 39123)
-- Dependencies: 221 175 2268
-- Name: si_asociado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2320 (class 2606 OID 39128)
-- Dependencies: 231 2278 175
-- Name: si_asociado_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2321 (class 2606 OID 39133)
-- Dependencies: 177 2212 162
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2322 (class 2606 OID 39138)
-- Dependencies: 2228 179 177
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2323 (class 2606 OID 39143)
-- Dependencies: 2294 177 247
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2324 (class 2606 OID 39148)
-- Dependencies: 199 2246 181
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2325 (class 2606 OID 39153)
-- Dependencies: 181 215 2262
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2326 (class 2606 OID 39158)
-- Dependencies: 2266 181 219
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2327 (class 2606 OID 39163)
-- Dependencies: 181 2268 221
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2328 (class 2606 OID 39168)
-- Dependencies: 219 2266 183
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2329 (class 2606 OID 39173)
-- Dependencies: 2238 191 185
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2330 (class 2606 OID 39178)
-- Dependencies: 233 185 2280
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2331 (class 2606 OID 39183)
-- Dependencies: 2230 186 181
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2332 (class 2606 OID 39188)
-- Dependencies: 185 186 2234
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2333 (class 2606 OID 39193)
-- Dependencies: 2278 186 231
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2334 (class 2606 OID 39198)
-- Dependencies: 2230 188 181
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2335 (class 2606 OID 39203)
-- Dependencies: 219 191 2266
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2336 (class 2606 OID 39208)
-- Dependencies: 2238 193 191
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2337 (class 2606 OID 39213)
-- Dependencies: 193 219 2266
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2338 (class 2606 OID 39218)
-- Dependencies: 181 2230 194
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2339 (class 2606 OID 39223)
-- Dependencies: 191 194 2238
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2340 (class 2606 OID 39228)
-- Dependencies: 2264 194 217
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2341 (class 2606 OID 39233)
-- Dependencies: 2278 231 194
-- Name: si_despacho_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2342 (class 2606 OID 39238)
-- Dependencies: 194 236 2284
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2343 (class 2606 OID 39243)
-- Dependencies: 241 194 2288
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2344 (class 2606 OID 39248)
-- Dependencies: 194 2292 244
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2345 (class 2606 OID 39253)
-- Dependencies: 2294 247 194
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2346 (class 2606 OID 39258)
-- Dependencies: 194 250 2300
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2347 (class 2606 OID 39263)
-- Dependencies: 197 2266 219
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2348 (class 2606 OID 39268)
-- Dependencies: 199 221 2268
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2349 (class 2606 OID 39273)
-- Dependencies: 200 199 2246
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2350 (class 2606 OID 39278)
-- Dependencies: 2262 215 200
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2351 (class 2606 OID 39283)
-- Dependencies: 2266 200 219
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2352 (class 2606 OID 39288)
-- Dependencies: 2268 221 200
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2353 (class 2606 OID 39293)
-- Dependencies: 200 2278 231
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2354 (class 2606 OID 39298)
-- Dependencies: 2294 247 202
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2355 (class 2606 OID 39303)
-- Dependencies: 203 202 2250
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2356 (class 2606 OID 39308)
-- Dependencies: 2254 209 207
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2357 (class 2606 OID 39313)
-- Dependencies: 211 212 2258
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2358 (class 2606 OID 39318)
-- Dependencies: 2294 212 247
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2359 (class 2606 OID 39323)
-- Dependencies: 2246 199 215
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2360 (class 2606 OID 39328)
-- Dependencies: 2230 181 217
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2361 (class 2606 OID 39333)
-- Dependencies: 2232 217 183
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2362 (class 2606 OID 39338)
-- Dependencies: 2238 217 191
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2363 (class 2606 OID 39343)
-- Dependencies: 2246 199 219
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2364 (class 2606 OID 39348)
-- Dependencies: 2262 215 219
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2365 (class 2606 OID 39353)
-- Dependencies: 221 219 2268
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2366 (class 2606 OID 39358)
-- Dependencies: 226 2266 219
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2367 (class 2606 OID 39363)
-- Dependencies: 228 219 2266
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2368 (class 2606 OID 39368)
-- Dependencies: 231 2246 199
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2369 (class 2606 OID 39373)
-- Dependencies: 215 231 2262
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2370 (class 2606 OID 39378)
-- Dependencies: 219 231 2266
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2371 (class 2606 OID 39383)
-- Dependencies: 231 2268 221
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2372 (class 2606 OID 39388)
-- Dependencies: 233 181 2230
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2373 (class 2606 OID 39393)
-- Dependencies: 236 183 2232
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2374 (class 2606 OID 39398)
-- Dependencies: 236 199 2246
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2375 (class 2606 OID 39403)
-- Dependencies: 236 2262 215
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2376 (class 2606 OID 39408)
-- Dependencies: 221 236 2268
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2377 (class 2606 OID 39413)
-- Dependencies: 238 2224 175
-- Name: si_recepcion_id_asociado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);


--
-- TOC entry 2378 (class 2606 OID 39418)
-- Dependencies: 2230 238 181
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2379 (class 2606 OID 39423)
-- Dependencies: 185 238 2234
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2380 (class 2606 OID 39428)
-- Dependencies: 2250 202 238
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2381 (class 2606 OID 39433)
-- Dependencies: 2278 238 231
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2382 (class 2606 OID 39438)
-- Dependencies: 238 2288 241
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2383 (class 2606 OID 39443)
-- Dependencies: 247 2294 238
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2384 (class 2606 OID 39448)
-- Dependencies: 241 2212 162
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2385 (class 2606 OID 39453)
-- Dependencies: 2230 181 241
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2386 (class 2606 OID 39458)
-- Dependencies: 2230 181 243
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2387 (class 2606 OID 39463)
-- Dependencies: 2230 244 181
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2388 (class 2606 OID 39468)
-- Dependencies: 249 162 2212
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2389 (class 2606 OID 39473)
-- Dependencies: 2272 225 249
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2390 (class 2606 OID 39478)
-- Dependencies: 249 2294 247
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-03-01 00:38:46

--
-- PostgreSQL database dump complete
--

