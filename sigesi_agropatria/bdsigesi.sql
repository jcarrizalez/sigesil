--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-02-21 19:51:21

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 243 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 243
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 161 (class 1259 OID 35177)
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
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 35179)
-- Dependencies: 2118 6
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
    id_tipo_almacen bigint NOT NULL
);


ALTER TABLE public.si_almacenes OWNER TO admin;

--
-- TOC entry 163 (class 1259 OID 35186)
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
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- TOC entry 164 (class 1259 OID 35188)
-- Dependencies: 2119 2120 6
-- Name: si_analisis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis (
    id bigint DEFAULT nextval('si_analisis_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo_analisis smallint DEFAULT 1,
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_analisis OWNER TO admin;

--
-- TOC entry 165 (class 1259 OID 35193)
-- Dependencies: 6
-- Name: si_analisis_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_centro_acopio (
    analisis_id bigint NOT NULL,
    centro_acopio_id bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_centro_acopio OWNER TO admin;

--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla Vehiculos';


--
-- TOC entry 166 (class 1259 OID 35196)
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
-- TOC entry 167 (class 1259 OID 35199)
-- Dependencies: 2121 6
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
-- TOC entry 168 (class 1259 OID 35203)
-- Dependencies: 2122 6
-- Name: si_analisis_resultado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis_resultado (
    movimiento_id bigint NOT NULL,
    analisis_id bigint NOT NULL,
    observacion character varying(255),
    valor real DEFAULT 0.0 NOT NULL,
    usuario_id bigint NOT NULL,
    id_analsis_resultado bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 168
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 242 (class 1259 OID 35894)
-- Dependencies: 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id character varying(255) NOT NULL,
    apperror_time date NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 169 (class 1259 OID 35216)
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
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 170 (class 1259 OID 35218)
-- Dependencies: 2123 6
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
-- TOC entry 171 (class 1259 OID 35225)
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
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 172 (class 1259 OID 35227)
-- Dependencies: 2124 6
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
-- TOC entry 173 (class 1259 OID 35231)
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
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 174 (class 1259 OID 35233)
-- Dependencies: 2125 2126 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 175 (class 1259 OID 35238)
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
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 176 (class 1259 OID 35240)
-- Dependencies: 2127 2128 2129 2130 2131 2132 2133 6
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
-- TOC entry 177 (class 1259 OID 35253)
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
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 177
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- TOC entry 178 (class 1259 OID 35255)
-- Dependencies: 2134 6
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
-- TOC entry 179 (class 1259 OID 35262)
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
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 1, true);


--
-- TOC entry 180 (class 1259 OID 35264)
-- Dependencies: 2135 2136 2137 2138 2139 6
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint DEFAULT nextval('si_cosecha_id_seq'::regclass) NOT NULL,
    id_programa bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    proyectado real DEFAULT 0.0,
    observacion character varying(255) DEFAULT NULL::character varying,
    area_siembra real DEFAULT 0.0,
    fecha_inicio date,
    fecha_fin date,
    estatus boolean DEFAULT false NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cosecha OWNER TO admin;

--
-- TOC entry 181 (class 1259 OID 35275)
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
-- TOC entry 182 (class 1259 OID 35278)
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
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE si_cuarentena; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cuarentena IS 'Tabla de Cuarentena para Fumigacion de Cultivos';


--
-- TOC entry 183 (class 1259 OID 35281)
-- Dependencies: 182 6
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
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 184 (class 1259 OID 35283)
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
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 9, true);


--
-- TOC entry 185 (class 1259 OID 35285)
-- Dependencies: 2141 2142 2143 6
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
-- TOC entry 186 (class 1259 OID 35291)
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
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 187 (class 1259 OID 35293)
-- Dependencies: 2144 6
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
-- TOC entry 188 (class 1259 OID 35297)
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
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción de Cultivo';


--
-- TOC entry 189 (class 1259 OID 35300)
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
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 190 (class 1259 OID 35302)
-- Dependencies: 2145 2146 6
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
-- TOC entry 191 (class 1259 OID 35307)
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
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 191
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 192 (class 1259 OID 35309)
-- Dependencies: 2147 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 193 (class 1259 OID 35313)
-- Dependencies: 2148 6
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
-- TOC entry 194 (class 1259 OID 35320)
-- Dependencies: 193 6
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
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 195 (class 1259 OID 35322)
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
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_guia_rec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guia_rec_id_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 35324)
-- Dependencies: 2150 2151 6
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
    fecha_rec timestamp with time zone
);


ALTER TABLE public.si_guiarec OWNER TO admin;

--
-- TOC entry 197 (class 1259 OID 35329)
-- Dependencies: 6
-- Name: si_guiasrec_det; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_guiasrec_det (
    id_guiarec bigint NOT NULL,
    id_rec bigint NOT NULL,
    subguia character(16),
    fecha timestamp with time zone,
    descripcion character varying(255)
);


ALTER TABLE public.si_guiasrec_det OWNER TO admin;

--
-- TOC entry 198 (class 1259 OID 35332)
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
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 199 (class 1259 OID 35334)
-- Dependencies: 2152 6
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
-- TOC entry 200 (class 1259 OID 35338)
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
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 42, true);


--
-- TOC entry 201 (class 1259 OID 35340)
-- Dependencies: 2153 6
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
-- TOC entry 202 (class 1259 OID 35347)
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
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 26, true);


--
-- TOC entry 203 (class 1259 OID 35349)
-- Dependencies: 2154 2155 6
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
-- TOC entry 204 (class 1259 OID 35354)
-- Dependencies: 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 205 (class 1259 OID 35357)
-- Dependencies: 2156 2157 2158 2159 2160 2161 6
-- Name: si_movimiento; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_movimiento (
    silo_id bigint NOT NULL,
    cosecha_id bigint NOT NULL,
    numero integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    cantidad_muestra real DEFAULT 0.0 NOT NULL,
    peso_bruto real DEFAULT 0.0 NOT NULL,
    placa_vehiculo date NOT NULL,
    cedula_conductor character(16) NOT NULL,
    descuento_humedad real DEFAULT 0.0 NOT NULL,
    descuento_impuresas real DEFAULT 0.0 NOT NULL,
    sada_id character(32) NOT NULL,
    observacion character varying(255) NOT NULL,
    sap_id character(32),
    peso_vacio real DEFAULT 0.0 NOT NULL,
    estado_id integer NOT NULL,
    nombre character varying(255),
    id bigint NOT NULL,
    programa_id bigint,
    contrato character(32) NOT NULL,
    tipo_proceso boolean DEFAULT true NOT NULL
);


ALTER TABLE public.si_movimiento OWNER TO admin;

--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE si_movimiento; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_movimiento IS 'Tabla de Movimiento de Recepción y Despacho, el campo tipo_proceso si es valor (true) es recepcion y (false) es despacho
';


--
-- TOC entry 206 (class 1259 OID 35369)
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
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 207 (class 1259 OID 35371)
-- Dependencies: 2162 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 208 (class 1259 OID 35375)
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
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 35377)
-- Dependencies: 2163 2164 6
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
-- TOC entry 210 (class 1259 OID 35382)
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
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 2, true);


--
-- TOC entry 211 (class 1259 OID 35384)
-- Dependencies: 2165 6
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
    codigo character varying(10)
);


ALTER TABLE public.si_organizacion OWNER TO admin;

--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 212 (class 1259 OID 35391)
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
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 213 (class 1259 OID 35393)
-- Dependencies: 2166 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 214 (class 1259 OID 35397)
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
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 5, true);


--
-- TOC entry 215 (class 1259 OID 35399)
-- Dependencies: 2167 6
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
-- TOC entry 216 (class 1259 OID 35406)
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
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 216
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 217 (class 1259 OID 35408)
-- Dependencies: 2168 6
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
-- TOC entry 218 (class 1259 OID 35412)
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
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 219 (class 1259 OID 35415)
-- Dependencies: 218 6
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
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 1, false);


--
-- TOC entry 220 (class 1259 OID 35417)
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
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 221 (class 1259 OID 35420)
-- Dependencies: 220 6
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
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 1, false);


--
-- TOC entry 222 (class 1259 OID 35422)
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
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 1, false);


--
-- TOC entry 223 (class 1259 OID 35424)
-- Dependencies: 2171 6
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
-- TOC entry 224 (class 1259 OID 35431)
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
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 1, true);


--
-- TOC entry 225 (class 1259 OID 35433)
-- Dependencies: 2172 6
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint DEFAULT nextval('si_programa_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero integer NOT NULL,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean NOT NULL
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 35440)
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
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 227 (class 1259 OID 35446)
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
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 228 (class 1259 OID 35452)
-- Dependencies: 6 227
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
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- TOC entry 229 (class 1259 OID 35454)
-- Dependencies: 6
-- Name: si_recepcion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recepcion (
    id bigint NOT NULL,
    id_programa bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_silo bigint NOT NULL,
    id_productor bigint NOT NULL,
    id_asociado bigint NOT NULL,
    id_guia bigint NOT NULL,
    id_chofer bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_agencia bigint NOT NULL,
    numero integer NOT NULL,
    contrato character(16),
    kgr_guia real,
    placa_vehiculo character(16),
    placa_remolque character(16),
    fecha_emision timestamp with time zone,
    fecha_recepcion timestamp with time zone,
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
    impuresa_des real
);


ALTER TABLE public.si_recepcion OWNER TO admin;

--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo';


--
-- TOC entry 230 (class 1259 OID 35457)
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
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 231 (class 1259 OID 35459)
-- Dependencies: 2174 2175 2176 2177 6
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint DEFAULT nextval('si_silos_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_almacen bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    coordenada character varying(255),
    numero integer DEFAULT 0 NOT NULL,
    capacidad integer DEFAULT 0,
    observacion character varying(255),
    estatus character(1) DEFAULT 1 NOT NULL,
    modulo character(2),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_silos OWNER TO admin;

--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 232 (class 1259 OID 35469)
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
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- TOC entry 233 (class 1259 OID 35471)
-- Dependencies: 2178 2179 2180 6
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
-- TOC entry 234 (class 1259 OID 35477)
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
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 235 (class 1259 OID 35483)
-- Dependencies: 234 6
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
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
-- TOC entry 236 (class 1259 OID 35485)
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
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 237 (class 1259 OID 35487)
-- Dependencies: 2182 2183 2184 6
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
-- TOC entry 238 (class 1259 OID 35496)
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
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 238
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 239 (class 1259 OID 35498)
-- Dependencies: 2185 6
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
-- TOC entry 240 (class 1259 OID 35502)
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
-- TOC entry 241 (class 1259 OID 35505)
-- Dependencies: 6 240
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
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 1, false);


--
-- TOC entry 2140 (class 2604 OID 35507)
-- Dependencies: 183 182
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2149 (class 2604 OID 35508)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 35509)
-- Dependencies: 219 218
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 35510)
-- Dependencies: 221 220
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 35511)
-- Dependencies: 228 227
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 35512)
-- Dependencies: 235 234
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 35513)
-- Dependencies: 241 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2315 (class 0 OID 35179)
-- Dependencies: 162
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen) FROM stdin;
8	8	ALMACEN - SILOS	\N	1	12	137	\N	\N	\N	t	\N	2012-02-19 15:35:00.454	\N	1
9	9	ALMACEN - SILOS	\N	1	18	229	\N	\N	\N	t	\N	2012-02-19 15:39:25.17	\N	1
7	7	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-19 15:26:29	\N	1
6	6	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:25:07.74788	\N	1
5	5	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:12:33.325252	\N	1
4	4	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:06:27.331621	\N	1
3	3	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:05:32.030751	\N	1
1	1	TODOS	\N	1	1	1	\N	\N	\N	t	\N	\N	\N	1
10	2	HERRAMIENTAS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-19 20:29:24.769	\N	2
11	2	PRODUCTOS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-20 11:06:41.92	\N	2
2	2	ALMACEN - SILOS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-13 11:01:40.114191	2012-02-20 11:07:46.604	2
\.


--
-- TOC entry 2316 (class 0 OID 35188)
-- Dependencies: 164
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2317 (class 0 OID 35193)
-- Dependencies: 165
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_centro_acopio (analisis_id, centro_acopio_id, id) FROM stdin;
\.


--
-- TOC entry 2318 (class 0 OID 35196)
-- Dependencies: 166
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, min_rec, max_rec, min_des, max_des, reduccion_rec, reduccion_des, estatus) FROM stdin;
\.


--
-- TOC entry 2319 (class 0 OID 35199)
-- Dependencies: 167
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_des (id_org, id_analisis, id_cultivo, min_rec, max_rec, min_des, max_des, descuento_rec, descuento_des, estatus) FROM stdin;
\.


--
-- TOC entry 2320 (class 0 OID 35203)
-- Dependencies: 168
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_resultado (movimiento_id, analisis_id, observacion, valor, usuario_id, id_analsis_resultado, id) FROM stdin;
\.


--
-- TOC entry 2361 (class 0 OID 35894)
-- Dependencies: 242
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 2321 (class 0 OID 35218)
-- Dependencies: 170
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_asociado (id, id_cosecha, id_productor, cedula, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha) FROM stdin;
\.


--
-- TOC entry 2322 (class 0 OID 35227)
-- Dependencies: 172
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo (id, id_almacen, id_usuario, id_cargo_tipo, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2323 (class 0 OID 35233)
-- Dependencies: 174
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo_tipo (id, nombre, nivel) FROM stdin;
\.


--
-- TOC entry 2324 (class 0 OID 35240)
-- Dependencies: 176
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) FROM stdin;
2	2	56	ARAURE	J-123123	\N	\N	\N	GUARICO	1	18	227	\N	\N	t	2012-02-13 11:01:40.092295-04:30	2012-02-19 15:03:36.599-04:30
7	2	67	MATURIN	\N	\N	\N	\N	\N	1	16	209	\N	\N	t	2012-02-19 15:23:43.873-04:30	\N
9	2	71	GUANARE	\N	\N	\N	\N	\N	1	18	229	\N	\N	t	2012-02-19 15:39:25.134-04:30	\N
8	2	69	CALABOZO	\N	\N	\N	\N	\N	1	12	137	\N	\N	t	2012-02-19 15:35:00.425-04:30	2012-02-19 15:39:43.266-04:30
3	2	57	SABANA DE PARRA	J-123123	\N	\N	\N	Algun Lugar	1	1	1	\N	\N	t	2012-02-13 11:05:32.010896-04:30	\N
4	2	58	CHAGUARAMAS	J-123123	\N	\N	\N	Chaguaramas	1	1	1	\N	\N	t	2012-02-13 11:06:27.30781-04:30	\N
5	2	60	SABANETA	J-123123	\N	\N	\N	Zulia	1	2	2	\N	\N	t	2012-02-13 11:12:33.305226-04:30	\N
6	2	63	ZARAZA	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:25:07.723533-04:30	\N
1	1	00	AGROPATRIA	\N	\N	\N	\N	\N	1	1	1	\N	\N	t	2012-02-12 00:00:00-04:30	\N
\.


--
-- TOC entry 2325 (class 0 OID 35255)
-- Dependencies: 178
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cliente (id, id_org, id_sap, rif, ref, nombre, telefono, fax, email_org, edo_civil, nacionalidad, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2326 (class 0 OID 35264)
-- Dependencies: 180
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado) FROM stdin;
1	1	1	1ERA COSECHA	\N	\N	\N	\N	\N	t	2012-02-21 19:47:18.696-04:30	\N
\.


--
-- TOC entry 2327 (class 0 OID 35275)
-- Dependencies: 181
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2328 (class 0 OID 35278)
-- Dependencies: 182
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cuarentena (id, id_centro_acopio, numero_mov, tipo_mov, codigo_cultivo, fecha_mov, fecha_cultivo, grado_infestacion, laboratorio, id_producto, toneladas, cant_producto, id_plaga, hora_trab, fecha_lib, hora_lib, id_analisis, estatus) FROM stdin;
\.


--
-- TOC entry 2329 (class 0 OID 35285)
-- Dependencies: 185
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) FROM stdin;
1	1	1               	MAÍZ BLANCO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:10.224543-04:30	\N
2	1	2               	ARROZ BLANCO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:30.631661-04:30	\N
3	1	3               	SORGO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:49.981169-04:30	\N
4	1	4               	SOYA HÚMEDA NACIONAL	f	\N	2012-02-18 15:23:05.361573-04:30	\N
7	1	7               	ARROZ BLANCO TOTAL	f	\N	2012-02-18 15:26:43.873325-04:30	\N
5	1	5               	MAÍZ AMARILLO HÚMEDO NACIONAL	f	\N	2012-02-18 15:23:20.129438-04:30	\N
6	1	6               	MAÍZ BLANCO SECO NACIONAL	f	\N	2012-02-18 15:23:55.551313-04:30	\N
8	1	8               	ARROZ PADDY ACONDICIONADO	f	\N	2012-02-18 15:27:07.455848-04:30	\N
9	1	9               	TOMATE NACIONAL	f	\N	2012-02-18 15:28:36.609786-04:30	\N
\.


--
-- TOC entry 2330 (class 0 OID 35293)
-- Dependencies: 187
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_denom_tip (id, id_org, id_cultivo, nombre_tipo_clase, valor, estatus) FROM stdin;
\.


--
-- TOC entry 2331 (class 0 OID 35297)
-- Dependencies: 188
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_productor, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, num_oca, kgr_oca, nu1_oca, kg1_oca, romana_vacia, fecha_vacia, peso01_vacio, peso02_vacio, romana_llena, fecha_liq, peso01_liq, peso02_liq, hum01_des, hum02_des, imp01_des, imp02_des, khu_01d, khu_02d, kim_01d, kim_02d, kac_des, estatus) FROM stdin;
\.


--
-- TOC entry 2332 (class 0 OID 35302)
-- Dependencies: 190
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ejes (id, id_org, nombre, capacidad) FROM stdin;
\.


--
-- TOC entry 2333 (class 0 OID 35309)
-- Dependencies: 192
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_estado (id, id_pais, nombre) FROM stdin;
1	1	Distrito Capital
2	1	Amazonas
3	1	Anzoategui
4	1	Apure
5	1	Aragua
6	1	Barinas
7	1	Bolivar
8	1	Carabobo
9	1	Cojedes
10	1	Delta Amacuro
11	1	Falcon
12	1	Guarico
13	1	Lara
14	1	Merida
15	1	Miranda
16	1	Monagas
17	1	Nueva Esparta
18	1	Portuguesa
19	1	Sucre
20	1	Tachira
21	1	Trujillo
22	1	Vargas
23	1	Yaracuy
24	1	Zulia
\.


--
-- TOC entry 2334 (class 0 OID 35313)
-- Dependencies: 193
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_finca (id, id_org, id_productor, id_pais, id_estado, id_municipio, id_agencia, nombre, direccion, area_siembra, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2335 (class 0 OID 35324)
-- Dependencies: 196
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_guiarec (id, id_agencia, id_centro_acopio, id_cosecha, id_productor, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, hora_emision, estatus, cedula_asociado, fecha_rec) FROM stdin;
\.


--
-- TOC entry 2336 (class 0 OID 35329)
-- Dependencies: 197
-- Data for Name: si_guiasrec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_guiasrec_det (id_guiarec, id_rec, subguia, fecha, descripcion) FROM stdin;
\.


--
-- TOC entry 2337 (class 0 OID 35334)
-- Dependencies: 199
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) FROM stdin;
101	Inicio de Sesion	0	OK
102	Cierre de Sesion	0	OK
105	Acceso Denegado	0	ERR
201	Data Nueva	0	OK
202	Data Actualizada	0	OK
203	Data Eliminada	0	OK
\.


--
-- TOC entry 2338 (class 0 OID 35340)
-- Dependencies: 201
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) FROM stdin;
38	2012-02-21	202	1	N/A	N/A	N/A	5f0dg3t1f4vma97eirjpggh0m5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = '5f0dg3t1f4vma97eirjpggh0m5'	
39	2012-02-21	102	1	N/A	N/A	N/A	5f0dg3t1f4vma97eirjpggh0m5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = '5f0dg3t1f4vma97eirjpggh0m5' 	
40	2012-02-21	101	2	N/A	N/A	N/A	5f0dg3t1f4vma97eirjpggh0m5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='5f0dg3t1f4vma97eirjpggh0m5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='5f0dg3t1f4vma97eirjpggh0m5' WHERE id='2'	User Login
41	2012-02-21	201	2	N/A	N/A	N/A	5f0dg3t1f4vma97eirjpggh0m5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>\t</div>\r\n	si_programa	No data	numero = '1'<br />nombre =  'PRIMER PROGRAMA'<br />estatus =  'T'<br />observacion =  null<br />id_centro_acopio =  '2'<br />creado = now()<br />	INSERT INTO si_programa  (numero, nombre, estatus, observacion, id_centro_acopio, creado) VALUES  ('1', 'PRIMER PROGRAMA', 'T', null, '2',now())	
42	2012-02-21	201	2	N/A	N/A	N/A	5f0dg3t1f4vma97eirjpggh0m5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.2<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.2</p>\t</div>\r\n	si_cosecha	No data	nombre = '1ERA COSECHA'<br />id_cultivo =  '1'<br />proyectado =  null<br />area_siembra =  null<br />fecha_inicio =  null<br />fecha_fin =  null<br />id_programa =  '1'<br />estatus =  'T'<br />creado = now()<br />	INSERT INTO si_cosecha  (nombre, id_cultivo, proyectado, area_siembra, fecha_inicio, fecha_fin, id_programa, estatus, creado) VALUES  ('1ERA COSECHA', '1', null, null, null, null, '1', 'T',now())	
\.


--
-- TOC entry 2339 (class 0 OID 35349)
-- Dependencies: 203
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) FROM stdin;
3	Reportes	0	\N	t	3	\N	\N
5	Cuenta	0	\N	t	5	\N	\N
6	Centros de Acopio	1	admin/centros_acopio_listado.php	t	2	\N	\N
11	Recepci&oacute;n	2	\N	t	1	\N	\N
12	Despacho	2	\N	t	2	\N	\N
13	Programas	3	\N	t	1	\N	\N
14	Cosecha	3	\N	t	2	\N	\N
15	Cultivos	3	\N	t	3	\N	\N
16	Productores	3	\N	t	4	\N	\N
17	Recepciones	3	\N	t	5	\N	\N
18	Despacho	3	\N	t	6	\N	\N
19	Silos	4	\N	t	1	\N	\N
20	Usuarios	4	admin/usuarios_listado.php	t	2	\N	\N
21	Formulas	4	\N	t	3	\N	\N
22	Configuracion	4	\N	t	4	\N	\N
23	Config. Cuenta	5	\N	t	1	\N	\N
24	Organizaciones	1	admin/organizacion_listado.php	t	1	\N	\N
4	Ctrol de Procesos	0	\N	t	4	\N	\N
1	Maestros	0	\N	t	1	\N	\N
2	Procesos	0	\N	t	2	\N	\N
25	Almacenes	1	admin/almacen_listado.php	t	3	\N	\N
9	Silos	1	admin/silos_listado.php	t	4	\N	\N
8	Programa	1	admin/programa_listado.php	t	5	\N	\N
7	Cultivo	1	admin/cultivo_listado.php	t	6	\N	\N
10	Productor	1	admin/productor_listado.php	t	7	\N	\N
26	Menu - Usuario	4	admin/menu_usuario.php	t	5	\N	\N
\.


--
-- TOC entry 2340 (class 0 OID 35354)
-- Dependencies: 204
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu_usuario (id_menu, id_usuario) FROM stdin;
1	1
3	1
4	1
5	1
24	1
6	1
7	1
8	1
9	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	1
1	2
7	2
8	2
9	2
10	2
25	1
25	2
26	1
\.


--
-- TOC entry 2341 (class 0 OID 35357)
-- Dependencies: 205
-- Data for Name: si_movimiento; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_movimiento (silo_id, cosecha_id, numero, fecha_inicio, fecha_fin, cantidad_muestra, peso_bruto, placa_vehiculo, cedula_conductor, descuento_humedad, descuento_impuresas, sada_id, observacion, sap_id, peso_vacio, estado_id, nombre, id, programa_id, contrato, tipo_proceso) FROM stdin;
\.


--
-- TOC entry 2342 (class 0 OID 35371)
-- Dependencies: 207
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_municipio (id, id_estado, nombre) FROM stdin;
1	1	Libertador
2	2	Alto Orinoco         
3	2	Atabapo
4	2	Atures
5	2	Autana
6	2	Manapiare
7	2	Maroa
8	2	Rio Negro
9	3	Anaco
10	3	Aragua
11	3	Bolivar
12	3	Bruzual
13	3	Cajigal
14	3	Carvajal
15	3	Diego Bautista Urbaneja
16	3	Freites
17	3	Guanipa
18	3	Guanta
19	3	Independencia
20	3	Libertad
21	3	McGregor
22	3	Miranda
23	3	Monagas
24	3	Penalver
25	3	Piritu
26	3	San Juan de Capistrano
27	3	Santa Ana
28	3	Simon Rodriguez
29	3	Sotillo
30	4	Achaguas
31	4	Biruaca
32	4	Munoz
33	4	Paez
34	4	Pedro Camejo
35	4	Romulo Gallegos
36	4	San Fernando
37	5	Bolívar
38	5	Camatagua
39	5	Francisco Linares Alcántara
40	5	Girardot
41	5	José Angel Lamas
42	5	José Félix Ribas
43	5	José Rafael Revenga
44	5	Libertador
45	5	Mario Briceño Iragorry
46	5	Ocumare de la Costa de Oro
47	5	San Casimiro
48	5	San Sebastián
49	5	Santiago Mariño
50	5	Santos Michelena
51	5	Sucre
52	5	Tovar
53	5	Urdaneta
54	5	Zamora
55	6	Alberto Arvelo Torrealba
56	6	Andrés Eloy Blanco
57	6	Antonio José de Sucre
58	6	Arismendi
59	6	Barinas
60	6	Bolívar
61	6	Cruz Paredes
62	6	Ezequiel Zamora
63	6	Obispos
64	6	Pedraza
65	6	Rojas
66	6	Sosa
67	7	Caroní
68	7	Cedeño
69	7	El Callao
70	7	Gran Sabana
71	7	Heres
72	7	Piar
73	7	Raúl Leoni
74	7	Roscio
75	7	Sifontes
76	7	Sucre
77	7	Padre Pedro Chien
78	8	Bejuma
79	8	Carlos Arvelo
80	8	Diego Ibarra
81	8	Guacara
82	8	Juan José Mora
83	8	Libertador
84	8	Los Guayos
85	8	Miranda
86	8	Montalbán
87	8	Naguanagua
88	8	Puerto Cabello
89	8	San Diego
90	8	San Joaquín
91	8	Valencia
92	9	Anzoátegui
93	9	Falcón
94	9	Girardot
95	9	Lima Blanco
96	9	Pao de San Juan Bautista
97	9	Ricaurte
98	9	Rómulo Gallegos
99	9	San Carlos
100	9	Tinaco
101	10	Antonio Díaz
102	10	Casacoima
103	10	Pedernales
104	10	Tucupita
105	10	Antonio Diaz
106	10	Casacoima
107	10	Pedernales
108	10	Tucupita
109	11	Acosta
110	11	Bolívar
111	11	Buchivacoa
112	11	Cacique Manaure
113	11	Carirubana
114	11	Colina
115	11	Dabajuro
116	11	Democracia
117	11	Falcón
118	11	Federación
119	11	Jacura
120	11	Los Taques
121	11	Mauroa
122	11	Miranda
123	11	Monseñor Iturriza
124	11	Palmasola
125	11	Petit
126	11	Píritu
127	11	San Francisco
128	11	Silva
129	11	Sucre
130	11	Tocópero
131	11	Unión
132	11	Urumaco
133	11	Zamora
134	12	Camaguán
135	12	Chaguaramas
136	12	El Socorro
137	12	Sebastian Francisco de Miranda
138	12	José Félix Ribas
139	12	José Tadeo Monagas
140	12	Juan Germán Roscio
141	12	Julián Mellado
142	12	Las Mercedes
143	12	Leonardo Infante
144	12	Pedro Zaraza
145	12	Ortiz
146	12	San Gerónimo de Guayabal
147	12	San José de Guaribe
148	12	Santa María de Ipire
149	13	Andrés Eloy Blanco
150	13	Crespo
151	13	Iribarren
152	13	Jiménez
153	13	Morán
154	13	Palavecino
213	16	Sotillo
214	16	Uracoa
215	17	Antolín del Campo
216	17	Arismendi 
217	17	Díaz
218	17	García
219	17	Gómez
220	17	Maneiro
221	17	Marcano 
222	17	Mariño 
223	17	Península de Macanao 
224	17	Tubores 
225	17	Villalba
226	18	Agua Blanca
227	18	Araure 
228	18	Esteller 
229	18	Guanare 
230	18	Guanarito
231	18	Monseñor José Vicente de Unda 
232	18	Ospino 
233	18	Páez 
234	18	Papelón 
235	18	San Genaro de Boconoíto
236	18	San Rafael de Onoto
237	18	Santa Rosalía 
238	18	Sucre
239	18	Turén
240	19	Andrés Eloy Blanco 
241	19	Andrés Mata
242	19	Arismendi 
243	19	Benítez 
244	19	Bermúdez
245	19	Bolívar
246	19	Cajigal 
247	19	Cruz Salmerón Acosta
248	19	Libertador
249	19	Mariño 
250	19	Mejía 
251	19	Montes
252	19	Ribero
253	19	Sucre
254	19	Valdez 
255	20	Andrés Bello 
256	20	Antonio Rómulo Costa
257	20	Ayacucho 
258	20	Bolívar
259	20	Cárdenas 
260	20	Córdoba (Santa Ana de Táchira)
261	20	Fernández Feo
262	20	Francisco de Miranda
156	13	Torres
157	13	Urdaneta
158	14	Alberto Adriani
159	14	Andrés Bello
160	14	Antonio Pinto Salinas
161	14	Aricagua
162	14	Arzobispo Chacón
163	14	Campo Elías
164	14	Caracciolo Parra Olmedo
165	14	Cardenal Quintero
166	14	Guaraque
167	14	Julio César Salas
168	14	Justo Briceño
169	14	Libertador
170	14	Miranda
171	14	Obispo Ramos de Lora
172	14	Padre Noguera
173	14	Pueblo Llano
174	14	Rangel
175	14	Rivas Dávila
176	14	Santos Marquina
177	14	Sucre
178	14	Tovar
179	14	Tulio Febres Cordero
180	14	Zea
181	15	Acevedo
182	15	Andrés Bello
183	15	Baruta
184	15	Brión
185	15	Buroz
186	15	Carrizal
187	15	Chacao
188	15	Cristóbal Rojas
189	15	El Hatillo
190	15	Guaicaipuro
191	15	Independencia
192	15	Lander
193	15	Los Salias
194	15	Páez
195	15	Paz Castillo
196	15	Pedro Gual
197	15	Plaza
198	15	Simón Bolívar
199	15	Sucre
200	15	Urdaneta
201	15	Zamora
202	16	Acosta
203	16	Aguasay
204	16	Bolívar
205	16	Caripe
206	16	Cedeño
207	16	Ezequiel Zamora
208	16	Libertador
209	16	Maturín
210	16	Piar
211	16	Punceres
212	16	Santa Bárbara
263	20	García de Hevia
264	20	Guásimos
265	20	Independencia
266	20	Jáuregui 
267	20	José María Vargas
268	20	Junín 
269	20	Libertad (Capacho Viejo)
270	20	Libertador
271	20	Lobatera 
272	20	Michelena
273	20	Panamericano
274	20	Pedro María Ureña
275	20	Rafael Urdaneta
276	20	Samuel Darío Maldonado
277	20	San Cristóbal
278	20	Seboruco
279	20	Simón Rodríguez
280	20	Sucre
281	20	Torbes 
282	20	Uribante
283	20	San Judas Tadeo
284	21	Andrés Bello
285	21	Boconó
286	21	Bolívar
287	21	Candelaria
288	21	Carache
289	21	Escuque
290	21	José Felipe Márquez Cañizalez 
291	21	Juan Vicente Campos Elías
292	21	La Ceiba
293	21	Miranda
294	21	Monte Carmelo 
295	21	Motatán 
296	21	Pampán
297	21	Pampanito 
298	21	Rafael Rangel
299	21	San Rafael de Carvajal
300	21	Sucre
301	21	Trujillo
302	21	Urdaneta
303	21	Valera
304	22	Vargas
305	23	Arístides Bastidas
306	23	Bolívar
307	23	Bruzual
308	23	Cocorote
309	23	Independencia
310	23	José Antonio Páez 
311	23	La Trinidad
312	23	Manuel Monge
313	23	Nirgua
314	23	Peña
315	23	San Felipe
316	23	Sucre
317	23	Urachiche
318	23	Veroes
319	24	Almirante Padilla
320	24	Baralt
321	24	Cabimas
322	24	Catatumbo
323	24	Colón
324	24	Francisco Javier Pulgar
325	24	Jesús Enrique Losada 
326	24	Jesús María Semprún 
327	24	Cañada de Urdaneta
328	24	Lagunillas
329	24	Machiques de Perijá
330	24	Mara
331	24	Maracaibo
332	24	Miranda
333	24	Páez
334	24	Rosario de Perijá
335	24	San Francisco 
336	24	Santa Rita 
337	24	Simón Bolívar 
338	24	Sucre 
339	24	Valmore Rodríguez 
155	13	Simón Planas
\.


--
-- TOC entry 2343 (class 0 OID 35377)
-- Dependencies: 209
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, tipo, fecha_emision, numero_contrato, toneladas, descuento, estatus) FROM stdin;
\.


--
-- TOC entry 2344 (class 0 OID 35384)
-- Dependencies: 211
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) FROM stdin;
1	TODOS	\N	J13769341	\N	\N	\N	\N	1	1	1	2012-02-12 00:00:00-04:30	2012-02-19 14:45:27.722-04:30	t	TOD
2	AGROPATRIA	\N	J13769431	\N	\N	\N	\N	1	5	51	2012-02-12 00:00:00-04:30	2012-02-19 14:51:33.417-04:30	t	AGR
\.


--
-- TOC entry 2345 (class 0 OID 35393)
-- Dependencies: 213
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_pais (id, nombre) FROM stdin;
1	Venezuela
\.


--
-- TOC entry 2346 (class 0 OID 35399)
-- Dependencies: 215
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
2	MAX_RESULTS_PAG	20	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
1	SYSTEM_NAME	SIGESIL	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
3	LLAVE_PUBLICA	6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD	Llave Publica del Recaptcha	1	2012-02-17	\N
4	LLAVE_PRIVADA	6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF	Llave Privada	1	2012-02-17	\N
5	COSECHAS_PROGRAMA	3	Cantidad de Cosechas por Programa	1	2012-02-20	\N
\.


--
-- TOC entry 2347 (class 0 OID 35408)
-- Dependencies: 217
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_perfiles (id, nombre_perfil, creado, modificado) FROM stdin;
2	Gerente	2012-02-07	\N
1	Gerente General	2012-02-07	\N
7	Despacho	2012-02-07	\N
6	Recepcion	2012-02-07	\N
5	Romanero	2012-02-07	\N
4	Calidad	2012-02-07	\N
3	Administrador	2012-02-07	\N
\.


--
-- TOC entry 2348 (class 0 OID 35412)
-- Dependencies: 218
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_plaga (id, id_org, nombre, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2349 (class 0 OID 35417)
-- Dependencies: 220
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_producto (id, id_org, numero, nombre, presentacion, dosis, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2350 (class 0 OID 35424)
-- Dependencies: 223
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_productor (id, id_org, id_sap, cod_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2351 (class 0 OID 35433)
-- Dependencies: 225
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, numero, nombre, observacion, creado, modificado, estatus) FROM stdin;
1	2	1	PRIMER PROGRAMA	\N	2012-02-21 19:47:18.696-04:30	\N	t
\.


--
-- TOC entry 2352 (class 0 OID 35440)
-- Dependencies: 226
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_proveedor (id, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2353 (class 0 OID 35446)
-- Dependencies: 227
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2354 (class 0 OID 35454)
-- Dependencies: 229
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_recepcion (id, id_programa, id_centro_acopio, id_cosecha, id_cultivo, id_silo, id_productor, id_asociado, id_guia, id_chofer, id_usuario, id_agencia, numero, contrato, kgr_guia, placa_vehiculo, placa_remolque, fecha_emision, fecha_recepcion, carril, estatus_rec, estatus_guia, romana_llena, fecha_pel, peso01_liq, peso02_liq, tolva, fecha_des, romana_vac, fecha_venta, peso01_ven, peso02_ven, humedad, impuresa, humedad_des, impuresa_des) FROM stdin;
\.


--
-- TOC entry 2355 (class 0 OID 35459)
-- Dependencies: 231
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, observacion, estatus, modulo, creado, modificado) FROM stdin;
7	3	3	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-13 11:05:32.047308-04:30	\N
8	3	3	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-13 11:05:32.064005-04:30	\N
29	4	4	SILO 13	MODULO A	13	1000	\N	1	A 	2012-02-13 11:06:27.548043-04:30	\N
53	5	5	SILO 13	MODULO A	13	1000	\N	1	A 	2012-02-13 11:12:33.541914-04:30	\N
30	4	4	SILO 14	MODULO A	14	1000	\N	1	A 	2012-02-13 11:06:27.565593-04:30	\N
54	5	5	SILO 14	MODULO A	14	1000	\N	1	A 	2012-02-13 11:12:33.561376-04:30	\N
77	8	8	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-19 15:35:00.481-04:30	\N
76	8	8	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-19 15:35:00.478-04:30	\N
75	8	8	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-19 15:35:00.46-04:30	\N
83	9	9	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-19 15:39:25.175-04:30	\N
84	9	9	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-19 15:39:25.182-04:30	\N
85	9	9	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-19 15:39:25.185-04:30	\N
17	4	4	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-13 11:06:27.348165-04:30	\N
41	5	5	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-13 11:12:33.341886-04:30	\N
18	4	4	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-13 11:06:27.365003-04:30	\N
42	5	5	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-13 11:12:33.358622-04:30	\N
62	6	6	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-13 11:25:07.781128-04:30	\N
3	2	2	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-13 11:01:40.147421-04:30	\N
74	7	7	SILO 2	MODULO A	2	1000	\N	1	A 	2012-02-19 15:27:55-04:30	\N
9	3	3	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-13 11:05:32.080546-04:30	\N
19	4	4	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-13 11:06:27.381487-04:30	\N
43	5	5	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-13 11:12:33.375377-04:30	\N
63	6	6	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-13 11:25:07.797725-04:30	\N
10	3	3	SILO 4	MODULO A	4	1000	\N	1	A 	2012-02-13 11:05:32.097424-04:30	\N
20	4	4	SILO 4	MODULO A	4	1000	\N	1	A 	2012-02-13 11:06:27.39829-04:30	\N
44	5	5	SILO 4	MODULO A	4	1000	\N	1	A 	2012-02-13 11:12:33.39185-04:30	\N
64	6	6	SILO 4	MODULO A	4	1000	\N	1	A 	2012-02-13 11:25:07.814551-04:30	\N
5	2	2	SILO 4	MODULO A	4	1000	\N	1	A 	2012-02-13 11:01:40.180896-04:30	\N
11	3	3	SILO 5	MODULO A	5	1000	\N	1	A 	2012-02-13 11:05:32.114005-04:30	\N
21	4	4	SILO 5	MODULO A	5	1000	\N	1	A 	2012-02-13 11:06:27.414956-04:30	\N
45	5	5	SILO 5	MODULO A	5	1000	\N	1	A 	2012-02-13 11:12:33.408492-04:30	\N
65	6	6	SILO 5	MODULO A	5	1000	\N	1	A 	2012-02-13 11:25:07.831087-04:30	\N
6	2	2	SILO 5	MODULO A	5	1000	\N	1	A 	2012-02-13 11:01:40.197353-04:30	\N
12	3	3	SILO 6	MODULO A	6	1000	\N	1	A 	2012-02-13 11:05:32.130658-04:30	\N
22	4	4	SILO 6	MODULO A	6	1000	\N	1	A 	2012-02-13 11:06:27.431423-04:30	\N
46	5	5	SILO 6	MODULO A	6	1000	\N	1	A 	2012-02-13 11:12:33.425069-04:30	\N
66	6	6	SILO 6	MODULO A	6	1000	\N	1	A 	2012-02-13 11:25:07.847859-04:30	\N
13	3	3	SILO 7	MODULO A	7	1000	\N	1	A 	2012-02-13 11:05:32.147097-04:30	\N
23	4	4	SILO 7	MODULO A	7	1000	\N	1	A 	2012-02-13 11:06:27.448256-04:30	\N
47	5	5	SILO 7	MODULO A	7	1000	\N	1	A 	2012-02-13 11:12:33.442001-04:30	\N
67	6	6	SILO 7	MODULO A	7	1000	\N	1	A 	2012-02-13 11:25:07.864434-04:30	\N
14	3	3	SILO 8	MODULO A	8	1000	\N	1	A 	2012-02-13 11:05:32.164022-04:30	\N
24	4	4	SILO 8	MODULO A	8	1000	\N	1	A 	2012-02-13 11:06:27.464898-04:30	\N
48	5	5	SILO 8	MODULO A	8	1000	\N	1	A 	2012-02-13 11:12:33.458509-04:30	\N
68	6	6	SILO 8	MODULO A	8	1000	\N	1	A 	2012-02-13 11:25:07.880988-04:30	\N
15	3	3	SILO 9	MODULO A	9	1000	\N	1	A 	2012-02-13 11:05:32.180592-04:30	\N
25	4	4	SILO 9	MODULO A	9	1000	\N	1	A 	2012-02-13 11:06:27.481472-04:30	\N
49	5	5	SILO 9	MODULO A	9	1000	\N	1	A 	2012-02-13 11:12:33.475215-04:30	\N
69	6	6	SILO 9	MODULO A	9	1000	\N	1	A 	2012-02-13 11:25:07.897561-04:30	\N
16	3	3	SILO 10	MODULO A	10	1000	\N	1	A 	2012-02-13 11:05:32.197159-04:30	\N
26	4	4	SILO 10	MODULO A	10	1000	\N	1	A 	2012-02-13 11:06:27.498121-04:30	\N
50	5	5	SILO 10	MODULO A	10	1000	\N	1	A 	2012-02-13 11:12:33.491855-04:30	\N
70	6	6	SILO 10	MODULO A	10	1000	\N	1	A 	2012-02-13 11:25:07.914479-04:30	\N
27	4	4	SILO 11	MODULO A	11	1000	\N	1	A 	2012-02-13 11:06:27.514982-04:30	\N
51	5	5	SILO 11	MODULO A	11	1000	\N	1	A 	2012-02-13 11:12:33.508602-04:30	\N
71	6	6	SILO 11	MODULO A	11	1000	\N	1	A 	2012-02-13 11:25:07.931073-04:30	\N
28	4	4	SILO 12	MODULO A	12	1000	\N	1	A 	2012-02-13 11:06:27.531417-04:30	\N
52	5	5	SILO 12	MODULO A	12	1000	\N	1	A 	2012-02-13 11:12:33.525128-04:30	\N
72	6	6	SILO 12	MODULO A	12	1000	\N	1	A 	2012-02-13 11:25:07.947754-04:30	\N
31	4	4	SILO 15	MODULO A	15	1000	\N	1	A 	2012-02-13 11:06:27.585406-04:30	\N
55	5	5	SILO 15	MODULO A	15	1000	\N	1	A 	2012-02-13 11:12:33.575171-04:30	\N
32	4	4	SILO 16	MODULO A	16	1000	\N	1	A 	2012-02-13 11:06:27.598079-04:30	\N
56	5	5	SILO 16	MODULO A	16	1000	\N	1	A 	2012-02-13 11:12:33.59178-04:30	\N
33	4	4	SILO 17	MODULO A	17	1000	\N	1	A 	2012-02-13 11:06:27.614882-04:30	\N
57	5	5	SILO 17	MODULO A	17	1000	\N	1	A 	2012-02-13 11:12:33.60849-04:30	\N
34	4	4	SILO 18	MODULO A	18	1000	\N	1	A 	2012-02-13 11:06:27.631368-04:30	\N
58	5	5	SILO 18	MODULO A	18	1000	\N	1	A 	2012-02-13 11:12:33.625125-04:30	\N
35	4	4	SILO 19	MODULO A	19	1000	\N	1	A 	2012-02-13 11:06:27.64816-04:30	\N
59	5	5	SILO 19	MODULO A	19	1000	\N	1	A 	2012-02-13 11:12:33.64196-04:30	\N
36	4	4	SILO 20	MODULO A	20	1000	\N	1	A 	2012-02-13 11:06:27.664683-04:30	\N
60	5	5	SILO 20	MODULO A	20	1000	\N	1	A 	2012-02-13 11:12:33.658508-04:30	\N
37	4	4	SILO 21	MODULO A	21	1000	\N	1	A 	2012-02-13 11:06:27.681424-04:30	\N
38	4	4	SILO 22	MODULO A	22	1000	\N	1	A 	2012-02-13 11:06:27.698087-04:30	\N
39	4	4	SILO 23	MODULO A	23	1000	\N	1	A 	2012-02-13 11:06:27.714699-04:30	\N
40	4	4	SILO 24	MODULO A	24	1000	\N	1	A 	2012-02-13 11:06:27.731507-04:30	\N
61	6	6	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-13 11:25:07.764398-04:30	\N
73	7	7	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-19 15:27:38-04:30	\N
4	2	2	SILO 3	MODULO A	3	1000	\N	1	A 	2012-02-13 11:01:40.164032-04:30	\N
2	2	2	SILO 1	MODULO A	1	1000	\N	1	A 	2012-02-13 11:01:40.130888-04:30	2012-02-19 19:46:46.671-04:30
\.


--
-- TOC entry 2356 (class 0 OID 35471)
-- Dependencies: 233
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) FROM stdin;
\.


--
-- TOC entry 2357 (class 0 OID 35477)
-- Dependencies: 234
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_transporte (id, id_centro_acopio, rif, nombre, contacto, direccion, telefono1, telefono2, fax, email, id_pais, id_estado, id_municipio) FROM stdin;
\.


--
-- TOC entry 2358 (class 0 OID 35487)
-- Dependencies: 237
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) FROM stdin;
3	Juan	Taborda	13769341	\N	M	jtaborda                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	juantaborda@agropatria.co.ve	2012-02-13	2012-02-17	t	0	\N	\N
4	Jesus	Rodriguez	18264065	\N	M	jrodriguez                      	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesusrodriguez@agropatria.co.ve	2012-02-13	2012-02-13	t	0	\N	\N
1	Jose	Peluzzo	1234567	2012-02-12	M	jpeluzzo                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	Maracay	\N	josepeluzzo@agropatria.co.ve	2012-02-12	\N	t	0	\N	2012-02-21 17:59:17.728-04:30
2	Jesus	Silva	9668397	1970-09-01	M	jsilva                          	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesussilva@agropatria.co.ve	2012-02-13	2012-02-13	t	1	5f0dg3t1f4vma97eirjpggh0m5	2012-02-21 19:45:36.99-04:30
\.


--
-- TOC entry 2359 (class 0 OID 35498)
-- Dependencies: 239
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) FROM stdin;
1	1	1	1	2012-02-13 00:00:00-04:30	\N
2	2	2	2	2012-02-13 11:34:56.142546-04:30	\N
4	4	4	2	2012-02-13 16:15:23.105604-04:30	\N
3	3	1	1	2012-02-13 15:00:02.192211-04:30	2012-02-17 11:06:46.723921-04:30
\.


--
-- TOC entry 2360 (class 0 OID 35502)
-- Dependencies: 240
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto) FROM stdin;
\.


--
-- TOC entry 2262 (class 2606 OID 35901)
-- Dependencies: 242 242
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2220 (class 2606 OID 35517)
-- Dependencies: 199 199
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2188 (class 2606 OID 35519)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2192 (class 2606 OID 35521)
-- Dependencies: 165 165
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2190 (class 2606 OID 35523)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2194 (class 2606 OID 35525)
-- Dependencies: 168 168
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2196 (class 2606 OID 35527)
-- Dependencies: 170 170
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2198 (class 2606 OID 35529)
-- Dependencies: 172 172
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2200 (class 2606 OID 35531)
-- Dependencies: 174 174
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2202 (class 2606 OID 35533)
-- Dependencies: 176 176
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2204 (class 2606 OID 35535)
-- Dependencies: 178 178
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2206 (class 2606 OID 35537)
-- Dependencies: 180 180
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2208 (class 2606 OID 35539)
-- Dependencies: 182 182
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 2606 OID 35541)
-- Dependencies: 185 185
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 35543)
-- Dependencies: 187 187
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 35545)
-- Dependencies: 190 190
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 35547)
-- Dependencies: 192 192
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 35549)
-- Dependencies: 196 196
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 35551)
-- Dependencies: 201 201
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2224 (class 2606 OID 35553)
-- Dependencies: 203 203
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 35555)
-- Dependencies: 207 207
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 35557)
-- Dependencies: 209 209
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 35559)
-- Dependencies: 211 211
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 35561)
-- Dependencies: 213 213
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 35563)
-- Dependencies: 215 215
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 35565)
-- Dependencies: 217 217
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 35567)
-- Dependencies: 218 218
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 35569)
-- Dependencies: 223 223
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 35571)
-- Dependencies: 225 225
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 35573)
-- Dependencies: 226 226
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2606 OID 35575)
-- Dependencies: 205 205
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_movimiento
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 35577)
-- Dependencies: 229 229
-- Name: si_recepcion_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 35579)
-- Dependencies: 231 231
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 35581)
-- Dependencies: 233 233
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 35583)
-- Dependencies: 234 234
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 35585)
-- Dependencies: 239 239
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 35587)
-- Dependencies: 237 237
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 35589)
-- Dependencies: 237 237
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2266 (class 2606 OID 35884)
-- Dependencies: 162 176 2201
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2263 (class 2606 OID 35595)
-- Dependencies: 162 192 2215
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2264 (class 2606 OID 35600)
-- Dependencies: 207 162 2227
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2265 (class 2606 OID 35605)
-- Dependencies: 213 162 2233
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2268 (class 2606 OID 35610)
-- Dependencies: 164 166 2189
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2269 (class 2606 OID 35615)
-- Dependencies: 211 166 2231
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2270 (class 2606 OID 35620)
-- Dependencies: 164 167 2189
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2271 (class 2606 OID 35625)
-- Dependencies: 211 167 2231
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2267 (class 2606 OID 35630)
-- Dependencies: 211 164 2231
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2272 (class 2606 OID 35635)
-- Dependencies: 162 172 2187
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2273 (class 2606 OID 35640)
-- Dependencies: 174 172 2199
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2274 (class 2606 OID 35645)
-- Dependencies: 237 172 2255
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2277 (class 2606 OID 35874)
-- Dependencies: 176 192 2215
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2278 (class 2606 OID 35879)
-- Dependencies: 2227 207 176
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2275 (class 2606 OID 35864)
-- Dependencies: 176 2231 211
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2276 (class 2606 OID 35869)
-- Dependencies: 176 2233 213
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2279 (class 2606 OID 35665)
-- Dependencies: 2231 178 211
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2280 (class 2606 OID 35670)
-- Dependencies: 185 180 2209
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2281 (class 2606 OID 35889)
-- Dependencies: 225 2243 180
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2282 (class 2606 OID 35680)
-- Dependencies: 2201 181 176
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2283 (class 2606 OID 35685)
-- Dependencies: 180 181 2205
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2284 (class 2606 OID 35690)
-- Dependencies: 223 181 2241
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2285 (class 2606 OID 35695)
-- Dependencies: 211 185 2231
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2286 (class 2606 OID 35700)
-- Dependencies: 2209 187 185
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2287 (class 2606 OID 35705)
-- Dependencies: 211 2231 187
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2288 (class 2606 OID 35710)
-- Dependencies: 190 2231 211
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2289 (class 2606 OID 35715)
-- Dependencies: 213 192 2233
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2290 (class 2606 OID 35720)
-- Dependencies: 176 2201 196
-- Name: si_guia_rec_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2291 (class 2606 OID 35725)
-- Dependencies: 196 2205 180
-- Name: si_guia_rec_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2292 (class 2606 OID 35730)
-- Dependencies: 2209 196 185
-- Name: si_guia_rec_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2293 (class 2606 OID 35735)
-- Dependencies: 2255 237 196
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2294 (class 2606 OID 35740)
-- Dependencies: 201 199 2219
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2295 (class 2606 OID 35745)
-- Dependencies: 203 204 2223
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2296 (class 2606 OID 35750)
-- Dependencies: 204 2255 237
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2297 (class 2606 OID 35755)
-- Dependencies: 207 2215 192
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2298 (class 2606 OID 35760)
-- Dependencies: 209 2201 176
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2299 (class 2606 OID 35765)
-- Dependencies: 2203 178 209
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2300 (class 2606 OID 35770)
-- Dependencies: 209 2209 185
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2301 (class 2606 OID 35775)
-- Dependencies: 192 2215 211
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2302 (class 2606 OID 35780)
-- Dependencies: 2227 211 207
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2303 (class 2606 OID 35785)
-- Dependencies: 213 2233 211
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2304 (class 2606 OID 35790)
-- Dependencies: 223 2215 192
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2305 (class 2606 OID 35795)
-- Dependencies: 223 2227 207
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2306 (class 2606 OID 35800)
-- Dependencies: 223 2231 211
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2307 (class 2606 OID 35805)
-- Dependencies: 213 223 2233
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2308 (class 2606 OID 35810)
-- Dependencies: 176 2201 225
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2309 (class 2606 OID 35815)
-- Dependencies: 231 162 2187
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2310 (class 2606 OID 35820)
-- Dependencies: 2201 176 231
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2311 (class 2606 OID 35825)
-- Dependencies: 233 176 2201
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2312 (class 2606 OID 35830)
-- Dependencies: 2187 239 162
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2313 (class 2606 OID 35835)
-- Dependencies: 2237 239 217
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2314 (class 2606 OID 35840)
-- Dependencies: 239 237 2255
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-21 19:51:21

--
-- PostgreSQL database dump complete
--

