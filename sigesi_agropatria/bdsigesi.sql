--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-02-15 23:22:17

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 210 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 210
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 34350)
-- Dependencies: 6
-- Name: si_almacenes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_almacenes (
    id bigint NOT NULL,
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
-- TOC entry 162 (class 1259 OID 34356)
-- Dependencies: 6 161
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
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_almacenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_almacenes_id_seq OWNED BY si_almacenes.id;


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 6, true);


--
-- TOC entry 163 (class 1259 OID 34358)
-- Dependencies: 2013 2014 6
-- Name: si_analisis; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_analisis (
    id bigint NOT NULL,
    descrip character varying(255),
    max integer DEFAULT 0 NOT NULL,
    min integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_analisis OWNER TO admin;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'Tabla de los Análisis para los Cultivos';


--
-- TOC entry 164 (class 1259 OID 34363)
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
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla puente entre Analisis y Centros de Acopio';


--
-- TOC entry 165 (class 1259 OID 34366)
-- Dependencies: 2015 6
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
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 166 (class 1259 OID 34370)
-- Dependencies: 6
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_app_error_apperror_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_app_error_apperror_id_seq OWNER TO admin;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_app_error_apperror_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 34372)
-- Dependencies: 2016 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id bigint DEFAULT nextval('si_app_error_apperror_id_seq'::regclass) NOT NULL,
    apperror_time date NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 168 (class 1259 OID 34379)
-- Dependencies: 6
-- Name: si_cargo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo (
    id integer NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_cargo_tipo bigint NOT NULL,
    creado timestamp without time zone NOT NULL,
    modificado timestamp without time zone NOT NULL
);


ALTER TABLE public.si_cargo OWNER TO admin;

--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 168
-- Name: TABLE si_cargo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cargo IS 'Tabla de Cargos';


--
-- TOC entry 169 (class 1259 OID 34382)
-- Dependencies: 2017 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE si_cargo_tipo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cargo_tipo IS 'Tablas de Cargo Tipo';


--
-- TOC entry 170 (class 1259 OID 34386)
-- Dependencies: 2018 2019 2020 2021 2022 2023 6
-- Name: si_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_centro_acopio (
    id bigint NOT NULL,
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
-- TOC entry 171 (class 1259 OID 34398)
-- Dependencies: 6 170
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
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_centro_acopio_id_seq OWNED BY si_centro_acopio.id;


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 6, true);


--
-- TOC entry 172 (class 1259 OID 34400)
-- Dependencies: 6
-- Name: si_cliente; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cliente (
    id bigint NOT NULL,
    rif character(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    telefono character varying(32) NOT NULL,
    email character varying(255) NOT NULL,
    ubicacion character varying(255) NOT NULL
);


ALTER TABLE public.si_cliente OWNER TO admin;

--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE si_cliente; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cliente IS 'Tabla de Clientes';


--
-- TOC entry 173 (class 1259 OID 34406)
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
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 1, false);


--
-- TOC entry 174 (class 1259 OID 34408)
-- Dependencies: 2025 2026 2027 2028 6
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint DEFAULT nextval('si_cosecha_id_seq'::regclass) NOT NULL,
    id_programa bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    proyectado real DEFAULT 0.0,
    observacion character varying(255) DEFAULT NULL::character varying,
    fecha_inicio date,
    fecha_fin date,
    estado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.si_cosecha OWNER TO admin;

--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN si_cosecha.estado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_cosecha.estado IS 'False = Abierto
True = Cerrado';


--
-- TOC entry 175 (class 1259 OID 34418)
-- Dependencies: 2029 2030 6
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    codigo bigint NOT NULL,
    nombre character varying DEFAULT 255 NOT NULL,
    tipificado boolean DEFAULT false,
    ciclo bigint,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 176 (class 1259 OID 34426)
-- Dependencies: 175 6
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
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_id_seq OWNED BY si_cultivo.id;


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 3, true);


--
-- TOC entry 177 (class 1259 OID 34428)
-- Dependencies: 6
-- Name: si_denom_tip; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_denom_tip (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    nombre_tipo_clase character varying(255) NOT NULL,
    valor integer NOT NULL,
    estatus boolean
);


ALTER TABLE public.si_denom_tip OWNER TO admin;

--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN si_denom_tip.nombre_tipo_clase; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_denom_tip.nombre_tipo_clase IS 'tipo o clase del cultivo';


--
-- TOC entry 178 (class 1259 OID 34431)
-- Dependencies: 6 177
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
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_denom_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_denom_tip_id_seq OWNED BY si_denom_tip.id;


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 34433)
-- Dependencies: 2033 6
-- Name: si_ejes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_ejes (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    capacidad integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_ejes OWNER TO admin;

--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE si_ejes; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_ejes IS 'Tabla para el Control de Ejes en Calculo de Toneladas para despacho';


--
-- TOC entry 180 (class 1259 OID 34437)
-- Dependencies: 6 179
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
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_ejes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ejes_id_seq OWNED BY si_ejes.id;


--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 34439)
-- Dependencies: 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 182 (class 1259 OID 34442)
-- Dependencies: 181 6
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
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_estado_id_seq OWNED BY si_estado.id;


--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 34444)
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
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 184 (class 1259 OID 34446)
-- Dependencies: 2036 6
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
-- TOC entry 185 (class 1259 OID 34450)
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
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 403, true);


--
-- TOC entry 186 (class 1259 OID 34452)
-- Dependencies: 2037 6
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
-- TOC entry 209 (class 1259 OID 34759)
-- Dependencies: 2059 6
-- Name: si_menu; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu (
    id bigint NOT NULL,
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
-- TOC entry 208 (class 1259 OID 34757)
-- Dependencies: 209 6
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
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_id_seq OWNED BY si_menu.id;


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 1, false);


--
-- TOC entry 187 (class 1259 OID 34464)
-- Dependencies: 6
-- Name: si_menu_usuario; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL
);


ALTER TABLE public.si_menu_usuario OWNER TO admin;

--
-- TOC entry 188 (class 1259 OID 34467)
-- Dependencies: 2038 2039 2040 2041 2042 2043 6
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
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE si_movimiento; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_movimiento IS 'Tabla de Movimiento de Recepción y Despacho, el campo tipo_proceso si es valor (true) es recepcion y (false) es despacho
';


--
-- TOC entry 189 (class 1259 OID 34479)
-- Dependencies: 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 190 (class 1259 OID 34482)
-- Dependencies: 189 6
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
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_municipio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_municipio_id_seq OWNED BY si_municipio.id;


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 191 (class 1259 OID 34484)
-- Dependencies: 6
-- Name: si_organizacion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_organizacion (
    id bigint NOT NULL,
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
    estatus boolean
);


ALTER TABLE public.si_organizacion OWNER TO admin;

--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 192 (class 1259 OID 34490)
-- Dependencies: 6 191
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
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_organizacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_organizacion_id_seq OWNED BY si_organizacion.id;


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 193 (class 1259 OID 34492)
-- Dependencies: 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 194 (class 1259 OID 34495)
-- Dependencies: 193 6
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
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_pais_id_seq OWNED BY si_pais.id;


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 194
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 195 (class 1259 OID 34497)
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
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 3, true);


--
-- TOC entry 196 (class 1259 OID 34499)
-- Dependencies: 2047 6
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
-- TOC entry 197 (class 1259 OID 34506)
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
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 198 (class 1259 OID 34508)
-- Dependencies: 2048 6
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
-- TOC entry 199 (class 1259 OID 34512)
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
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 199
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 1, false);


--
-- TOC entry 200 (class 1259 OID 34514)
-- Dependencies: 2049 6
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint DEFAULT nextval('si_programa_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero integer,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 201 (class 1259 OID 34521)
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
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 202 (class 1259 OID 34527)
-- Dependencies: 2050 2051 2052 6
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint NOT NULL,
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
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 203 (class 1259 OID 34536)
-- Dependencies: 202 6
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
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_silos_id_seq OWNED BY si_silos.id;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 72, true);


--
-- TOC entry 204 (class 1259 OID 34538)
-- Dependencies: 2054 2055 6
-- Name: si_usuarios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios (
    id bigint NOT NULL,
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
-- TOC entry 205 (class 1259 OID 34546)
-- Dependencies: 6 204
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
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_id_seq OWNED BY si_usuarios.id;


--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 206 (class 1259 OID 34548)
-- Dependencies: 6
-- Name: si_usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios_perfiles (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_perfil bigint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_usuarios_perfiles OWNER TO admin;

--
-- TOC entry 207 (class 1259 OID 34551)
-- Dependencies: 6 206
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
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_perfiles_id_seq OWNED BY si_usuarios_perfiles.id;


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 2012 (class 2604 OID 34553)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_almacenes ALTER COLUMN id SET DEFAULT nextval('si_almacenes_id_seq'::regclass);


--
-- TOC entry 2024 (class 2604 OID 34554)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 34555)
-- Dependencies: 176 175
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_id_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 34556)
-- Dependencies: 178 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_denom_tip ALTER COLUMN id SET DEFAULT nextval('si_denom_tip_id_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 34557)
-- Dependencies: 180 179
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_ejes ALTER COLUMN id SET DEFAULT nextval('si_ejes_id_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 34558)
-- Dependencies: 182 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_estado ALTER COLUMN id SET DEFAULT nextval('si_estado_id_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 34762)
-- Dependencies: 208 209 209
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu ALTER COLUMN id SET DEFAULT nextval('si_menu_id_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 34560)
-- Dependencies: 190 189
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_municipio ALTER COLUMN id SET DEFAULT nextval('si_municipio_id_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 34561)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_organizacion ALTER COLUMN id SET DEFAULT nextval('si_organizacion_id_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 34562)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_pais ALTER COLUMN id SET DEFAULT nextval('si_pais_id_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 34563)
-- Dependencies: 203 202
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_silos ALTER COLUMN id SET DEFAULT nextval('si_silos_id_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 34564)
-- Dependencies: 205 204
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios ALTER COLUMN id SET DEFAULT nextval('si_usuarios_id_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 34565)
-- Dependencies: 207 206
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios_perfiles ALTER COLUMN id SET DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass);


--
-- TOC entry 2142 (class 0 OID 34350)
-- Dependencies: 161
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen) FROM stdin;
1	1	Todos	\N	1	1	1	\N	\N	\N	t	\N	\N	\N	1
3	3	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:05:32.030751	\N	1
4	4	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:06:27.331621	\N	1
5	5	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:12:33.325252	\N	1
6	6	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:25:07.74788	\N	1
2	2	Almacen - Silos	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:01:40.114191	\N	1
\.


--
-- TOC entry 2143 (class 0 OID 34358)
-- Dependencies: 163
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis (id, descrip, max, min) FROM stdin;
\.


--
-- TOC entry 2144 (class 0 OID 34363)
-- Dependencies: 164
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_centro_acopio (analisis_id, centro_acopio_id, id) FROM stdin;
\.


--
-- TOC entry 2145 (class 0 OID 34366)
-- Dependencies: 165
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_resultado (movimiento_id, analisis_id, observacion, valor, usuario_id, id_analsis_resultado, id) FROM stdin;
\.


--
-- TOC entry 2146 (class 0 OID 34372)
-- Dependencies: 167
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 2147 (class 0 OID 34379)
-- Dependencies: 168
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo (id, id_centro_acopio, id_almacen, id_usuario, id_cargo_tipo, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2148 (class 0 OID 34382)
-- Dependencies: 169
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo_tipo (id, nombre, nivel) FROM stdin;
\.


--
-- TOC entry 2149 (class 0 OID 34386)
-- Dependencies: 170
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) FROM stdin;
1	0	00	Agropatria	\N	\N	\N	\N	\N	1	1	1	\N	\N	t	2012-02-12 00:00:00-04:30	\N
3	1	57	Sabana de Parra	J-123123	\N	\N	\N	Algun Lugar	1	1	1	\N	\N	t	2012-02-13 11:05:32.010896-04:30	\N
4	1	58	Chaguaramas	J-123123	\N	\N	\N	Chaguaramas	1	1	1	\N	\N	t	2012-02-13 11:06:27.30781-04:30	\N
6	1	63	Zaraza	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:25:07.723533-04:30	\N
5	1	60	Sabaneta	J-123123	\N	\N	\N	Zulia	1	2	2	\N	\N	t	2012-02-13 11:12:33.305226-04:30	\N
2	1	56	Araure	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:01:40.092295-04:30	\N
\.


--
-- TOC entry 2150 (class 0 OID 34400)
-- Dependencies: 172
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cliente (id, rif, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2151 (class 0 OID 34408)
-- Dependencies: 174
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, nombre, proyectado, observacion, fecha_inicio, fecha_fin, estado) FROM stdin;
\.


--
-- TOC entry 2152 (class 0 OID 34418)
-- Dependencies: 175
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) FROM stdin;
3	1	3	Sorgo Humedo	f	\N	2012-02-15 09:45:23.982014-04:30	2012-02-15 09:45:40.66984-04:30
1	1	1	Maiz Blanco Húmedo	f	\N	2012-02-15 09:16:46.407175-04:30	2012-02-15 09:46:57.158351-04:30
2	1	2	Arroz Blanco Húmedo	t	\N	2012-02-15 09:33:29.683096-04:30	2012-02-15 09:47:03.409316-04:30
\.


--
-- TOC entry 2153 (class 0 OID 34428)
-- Dependencies: 177
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_denom_tip (id, id_org, id_cultivo, nombre_tipo_clase, valor, estatus) FROM stdin;
\.


--
-- TOC entry 2154 (class 0 OID 34433)
-- Dependencies: 179
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ejes (id, nombre, capacidad) FROM stdin;
\.


--
-- TOC entry 2155 (class 0 OID 34439)
-- Dependencies: 181
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
-- TOC entry 2156 (class 0 OID 34446)
-- Dependencies: 184
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
-- TOC entry 2157 (class 0 OID 34452)
-- Dependencies: 186
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) FROM stdin;
1	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
2	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
3	2012-02-07	202	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id='1', nombre='Chaguaramas', rif='J-1234567', telefono='04129876543', email='asd@asd.com', ubicacion='Guaricoooooo', id_sap='', coordenadas='', id_org='0', modificado=now()	UPDATE si_centro_acopio SET  id='1', nombre='Chaguaramas', rif='J-1234567', telefono='04129876543', email='asd@asd.com', ubicacion='Guaricoooooo', id_sap='', coordenadas='', id_org='0', modificado=now() WHERE id=1	
4	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 3	
5	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
6	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Chaguaramas'<br />rif =  'J-1237123'<br />telefono =  '0416-1234567'<br />email =  'asd@asd123.com'<br />ubicacion =  'la que sea'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Chaguaramas', 'J-1237123', '0416-1234567', 'asd@asd123.com', 'la que sea', null, null, null,now(),now())	
7	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
8	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '0416-1234567'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '0416-1234567', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
9	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '04129876543'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '04129876543', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
21	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 12	
10	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asd'<br />rif =  'asd'<br />telefono =  'asd'<br />email =  'asd'<br />ubicacion =  'asd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asd', 'asd', 'asd', 'asd', 'asd', null, null, null,now(),now())	
11	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '123'<br />rif =  '123'<br />telefono =  '123'<br />email =  '123'<br />ubicacion =  '123'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('123', '123', '123', '123', '123', null, null, null,now(),now())	
12	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asdasd'<br />rif =  'dasdasd'<br />telefono =  'dasdasd'<br />email =  'dasdasd'<br />ubicacion =  'dasdasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asdasd', 'dasdasd', 'dasdasd', 'dasdasd', 'dasdasd', null, null, null,now(),now())	
13	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'asdasd'<br />rif =  'dasdasd'<br />telefono =  'dasdasd'<br />email =  'dasdasd'<br />ubicacion =  'dasdasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('asdasd', 'dasdasd', 'dasdasd', 'dasdasd', 'dasdasd', null, null, null,now(),now())	
14	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'añlsjdalskd'<br />rif =  'kdjaslkdj'<br />telefono =  'ldkajskldj'<br />email =  'kdajslkdj'<br />ubicacion =  'lkdajskldjad'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('añlsjdalskd', 'kdjaslkdj', 'ldkajskldj', 'kdajslkdj', 'lkdajskldjad', null, null, null,now(),now())	
15	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 21	
16	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 7	
17	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 8	
18	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 9	
19	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 10	
20	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 11	
22	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 14	
23	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 17	
24	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 5	
25	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 18	
26	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 19	
27	2012-02-07	203	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 19	
28	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aksdajksldj'<br />rif =  'kldjaskldjasdkl'<br />telefono =  'djklasjdahlkdj'<br />email =  'lkdjklsdjaksldj'<br />ubicacion =  'djlkasjdaskldj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aksdajksldj', 'kldjaskldjasdkl', 'djklasjdahlkdj', 'lkdjklsdjaksldj', 'djlkasjdaskldj', null, null, null,now(),now())	
29	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'zzz'<br />rif =  'zzzz'<br />telefono =  'zzzz'<br />email =  'zzzz'<br />ubicacion =  'zzzz'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('zzz', 'zzzz', 'zzzz', 'zzzz', 'zzzz', null, null, null,now(),now())	
30	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
31	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
32	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aaa'<br />rif =  'aaa'<br />telefono =  'aaa'<br />email =  'aaa'<br />ubicacion =  'aaa'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aaa', 'aaa', 'aaa', 'aaa', 'aaa', null, null, null,now(),now())	
33	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '18902312n3'<br />rif =  '901273j1203'<br />telefono =  '8h129783h1'<br />email =  '8h127893h17829'<br />ubicacion =  'h78189h23791823'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('18902312n3', '901273j1203', '8h129783h1', '8h127893h17829', 'h78189h23791823', null, null, null,now(),now())	
34	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'alksdjaskl'<br />rif =  'jkldajsdkl'<br />telefono =  'jdaskldjl'<br />email =  'kdjaslkdjlk'<br />ubicacion =  'djlkasjd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('alksdjaskl', 'jkldajsdkl', 'jdaskldjl', 'kdjaslkdjlk', 'djlkasjd', null, null, null,now(),now())	
35	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '12390123'<br />rif =  'hj12kl3j12'<br />telefono =  'klj12kl3j12'<br />email =  'kl3j122l3k1j23lk'<br />ubicacion =  'lk3j12kl31j23'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('12390123', 'hj12kl3j12', 'klj12kl3j12', 'kl3j122l3k1j23lk', 'lk3j12kl31j23', null, null, null,now(),now())	
36	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'alskdjaskldj'<br />rif =  'kldjaskldj'<br />telefono =  'lkdjaskldj'<br />email =  'kldjskldj'<br />ubicacion =  'dklasjdlkasj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('alskdjaskldj', 'kldjaskldj', 'lkdjaskldj', 'kldjskldj', 'dklasjdlkasj', null, null, null,now(),now())	
37	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsdjaskldj'<br />rif =  'kdasjldkasjdkl'<br />telefono =  'djaskldjaskldj'<br />email =  'dklsajdkl'<br />ubicacion =  'jdklasjdklasdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsdjaskldj', 'kdasjldkasjdkl', 'djaskldjaskldj', 'dklsajdkl', 'jdklasjdklasdj', null, null, null,now(),now())	
38	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aksjdakldj'<br />rif =  'dklasjdkl'<br />telefono =  'djaklsdj'<br />email =  'lkdjskladj'<br />ubicacion =  'kldjaskldj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aksjdakldj', 'dklasjdkl', 'djaklsdj', 'lkdjskladj', 'kldjaskldj', null, null, null,now(),now())	
39	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjskldj'<br />rif =  'dklasjdkl'<br />telefono =  'jdklasjdkl'<br />email =  'djaskldj'<br />ubicacion =  'kldjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjskldj', 'dklasjdkl', 'jdklasjdkl', 'djaskldj', 'kldjaklsdj', null, null, null,now(),now())	
40	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsjdaklsdj'<br />rif =  'kdlsjalkd'<br />telefono =  'jdlkasjsdkl'<br />email =  'jdlksdjlkadj'<br />ubicacion =  'kdjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsjdaklsdj', 'kdlsjalkd', 'jdlkasjsdkl', 'jdlksdjlkadj', 'kdjaklsdj', null, null, null,now(),now())	
41	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askljdaskldj'<br />rif =  'dklasjdlk'<br />telefono =  'jdklasjdkl'<br />email =  'djaskldj'<br />ubicacion =  'lkjaksdjasd'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askljdaskldj', 'dklasjdlk', 'jdklasjdkl', 'djaskldj', 'lkjaksdjasd', null, null, null,now(),now())	
42	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'klasjdklasd'<br />rif =  'klasjdlkasjd'<br />telefono =  'dalksjdlkasdj'<br />email =  'kljadklsdjaslkd'<br />ubicacion =  'kasjdlaksdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('klasjdklasd', 'klasjdlkasjd', 'dalksjdlkasdj', 'kljadklsdjaslkd', 'kasjdlaksdj', null, null, null,now(),now())	
43	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjaskld'<br />rif =  'jdlkasjdklasjd'<br />telefono =  'kldjaskldjaskldj'<br />email =  'kldjaslkdjasdlk'<br />ubicacion =  'jdklasdjalkdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjaskld', 'jdlkasjdklasjd', 'kldjaskldjaskldj', 'kldjaslkdjasdlk', 'jdklasdjalkdj', null, null, null,now(),now())	
44	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'aklsdjakl'<br />rif =  'kasjdaslkd'<br />telefono =  'kjaskldjaskl'<br />email =  'askldjaklsd'<br />ubicacion =  'dklasjdlkaj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('aklsdjakl', 'kasjdaslkd', 'kjaskldjaskl', 'askldjaklsd', 'dklasjdlkaj', null, null, null,now(),now())	
45	2012-02-07	201	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askdjaksdj'<br />rif =  'kldjasdklasjdkl'<br />telefono =  'djaskldj'<br />email =  'kldjaskldjakldj'<br />ubicacion =  'ldjaklsdj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askdjaksdj', 'kldjasdklasjdkl', 'djaskldj', 'kldjaskldjakldj', 'ldjaklsdj', null, null, null,now(),now())	
46	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '1203871237'<br />rif =  '87w9812723'<br />telefono =  'lk12lk3jh'<br />email =  'jh12jk3h'<br />ubicacion =  'kjh123jk1h2'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('1203871237', '87w9812723', 'lk12lk3jh', 'jh12jk3h', 'kjh123jk1h2', null, null, null,now(),now())	
47	2012-02-07	203	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	No data	DELETE FROM si_centro_acopio where id = 23	
48	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = '38uiojkds'<br />rif =  '892iueowjk'<br />telefono =  '23ujhn'<br />email =  '12783uyjh'<br />ubicacion =  '1728hwjqn'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('38uiojkds', '892iueowjk', '23ujhn', '12783uyjh', '1728hwjqn', null, null, null,now(),now())	
67	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '6', nombre = 'Trigo', id_tipo_cultivo = '1', modificado=now()	UPDATE si_cultivo SET  id = '6', nombre = 'Trigo', id_tipo_cultivo = '1', modificado=now() WHERE id=6	
49	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'askldjaskldj'<br />rif =  'kldajsdkl'<br />telefono =  'jkdasjdlk'<br />email =  'jdklasjdkl'<br />ubicacion =  'jdlkasjdklaj'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('askldjaskldj', 'kldajsdkl', 'jkdasjdlk', 'jdklasjdkl', 'jdlkasjdklaj', null, null, null,now(),now())	
50	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Araure'<br />rif =  'J-1234567'<br />telefono =  '0416-1234567'<br />email =  'asd@asd.com'<br />ubicacion =  'Guarico'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Araure', 'J-1234567', '0416-1234567', 'asd@asd.com', 'Guarico', null, null, null,now(),now())	
51	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guaricoooooo', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guaricoooooo', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=2	
52	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = '123321', coordenadas = 'asdaasd', id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = '123321', coordenadas = 'asdaasd', id_org = null, modificado=now() WHERE id=2	
53	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '2', nombre = 'Araure', rif = 'J-1234567', telefono = '0416-1234567', email = 'asd@asd.com', ubicacion = 'Guarico', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=2	
54	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Chaguaramos'<br />rif =  'J-9876543'<br />telefono =  '0412-7418529'<br />email =  '123@asd.com'<br />ubicacion =  'Mcy'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Chaguaramos', 'J-9876543', '0412-7418529', '123@asd.com', 'Mcy', null, null, null,now(),now())	
55	2012-02-07	201	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'jesus silva'<br />rif =  'j-9668397'<br />telefono =  '0416-4383168'<br />email =  'jexuxal@hotmail.com'<br />ubicacion =  'zolia'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('jesus silva', 'j-9668397', '0416-4383168', 'jexuxal@hotmail.com', 'zolia', null, null, null,now(),now())	
56	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
57	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
58	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'larA', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
59	2012-02-07	202	1	N/A	jesuskateadio@hotmail.com	N/A	4nco3f3aocfseitnh61eibe786	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'guarilandia', id_sap = null, coordenadas = null, id_org = null, modificado=now()	UPDATE si_centro_acopio SET  id = '4', nombre = 'jesus silva', rif = 'j-9668397', telefono = '0416-4383168', email = 'jexuxal@hotmail.com', ubicacion = 'guarilandia', id_sap = null, coordenadas = null, id_org = null, modificado=now() WHERE id=4	
60	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'ASD'<br />rif =  'ASD'<br />telefono =  'ASD'<br />email =  'ASD'<br />ubicacion =  'ASD'<br />id_sap =  null<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('ASD', 'ASD', 'ASD', 'ASD', 'ASD', null, null, null,now(),now())	
61	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Arroz'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Arroz', '1',now(),now())	
62	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Trigo'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Trigo', '1',now(),now())	
63	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	nombre = 'Sorgo'<br />id_tipo_cultivo =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo  (nombre, id_tipo_cultivo, creado, modificado) VALUES  ('Sorgo', '1',now(),now())	
64	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '7', nombre = 'Sorgo', id_tipo_cultivo = '2', modificado=now()	UPDATE si_cultivo SET  id = '7', nombre = 'Sorgo', id_tipo_cultivo = '2', modificado=now() WHERE id=7	
65	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '5', nombre = 'Arroz', id_tipo_cultivo = '2', modificado=now()	UPDATE si_cultivo SET  id = '5', nombre = 'Arroz', id_tipo_cultivo = '2', modificado=now() WHERE id=5	
66	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo	No data	id = '5', nombre = 'Arroz', id_tipo_cultivo = '1', modificado=now()	UPDATE si_cultivo SET  id = '5', nombre = 'Arroz', id_tipo_cultivo = '1', modificado=now() WHERE id=5	
68	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	nombre = 'Arroz Tipo 1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo_tipo  (nombre, creado, modificado) VALUES  ('Arroz Tipo 1',now(),now())	
69	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	nombre = 'Arroz Tipo 2'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_cultivo_tipo  (nombre, creado, modificado) VALUES  ('Arroz Tipo 2',now(),now())	
70	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	id = '4', nombre = 'Arroz Tipo 3', modificado=now()	UPDATE si_cultivo_tipo SET  id = '4', nombre = 'Arroz Tipo 3', modificado=now() WHERE id=4	
71	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_cultivo_tipo	No data	id = '4', nombre = 'Arroz Tipo 2', modificado=now()	UPDATE si_cultivo_tipo SET  id = '4', nombre = 'Arroz Tipo 2', modificado=now() WHERE id=4	
72	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	nombre = 'Cagua'<br />rif =  'J-182731092'<br />telefono =  '0412-123456789'<br />email =  'ASD@asd.com'<br />ubicacion =  'Cagua'<br />id_sap =  '132465'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org, creado, modificado) VALUES  ('Cagua', 'J-182731092', '0412-123456789', 'ASD@asd.com', 'Cagua', '132465', null, null,now(),now())	
73	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_silos	No data	nombre = 'Silo B'<br />coordenada =  'la que sea'<br />numero =  '2'<br />capacidad =  '30000'<br />observacion =  null<br />id_centro_acopio =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (nombre, coordenada, numero, capacidad, observacion, id_centro_acopio, creado, modificado) VALUES  ('Silo B', 'la que sea', '2', '30000', null, '1',now(),now())	
74	2012-02-08	202	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_silos	No data	id = '2', nombre = 'Silo B', coordenada = 'Sur', numero = '2', capacidad = '30000', observacion = 'A', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '2', nombre = 'Silo B', coordenada = 'Sur', numero = '2', capacidad = '30000', observacion = 'A', id_centro_acopio = '1', modificado=now() WHERE id=2	
75	2012-02-08	105	0	N/A	N/A	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '1376934'	Login Incorrect=1376934
76	2012-02-08	105	0	N/A	N/A	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '1376934'	Login Incorrect=1376934
77	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', id_centro_acopio = '1', modificado=now() WHERE id=1	
78	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = 'AAAAA', id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = 'AAAAA', id_centro_acopio = '1', modificado=now() WHERE id=1	
79	2012-02-08	202	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = null, id_centro_acopio = '1', modificado=now()	UPDATE si_silos SET  id = '1', nombre = 'Silo A', coordenada = 'Norte', numero = '1', capacidad = '20000', observacion = null, id_centro_acopio = '1', modificado=now() WHERE id=1	
80	2012-02-08	201	2	N/A	juantaborda@agropatria.co.ve	N/A	08h0e22nccv5aahj5ijtd4usv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Smart Move!!!</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">User Agent: Chrome 16.0.912.75<br />Engine: AppleWebKit v: 535.7</p>\t</div>\r\n	si_silos	No data	nombre = 'Silo B'<br />coordenada =  'Sur'<br />numero =  '2'<br />capacidad =  '350000'<br />observacion =  'Ninguna'<br />id_centro_acopio =  '1'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (nombre, coordenada, numero, capacidad, observacion, id_centro_acopio, creado, modificado) VALUES  ('Silo B', 'Sur', '2', '350000', 'Ninguna', '1',now(),now())	
81	2012-02-08	201	1	N/A	jesuskateadio@hotmail.com	N/A	kve2a4mieihfn0jf7pmh10kqa0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	si_centro_acopio	No data	codigo = '63'<br />nombre =  'Zaraza'<br />rif =  'J-3456789'<br />telefono =  null<br />email =  null<br />ubicacion =  'Otra'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (codigo, nombre, rif, telefono, email, ubicacion, coordenadas, id_org, creado, modificado) VALUES  ('63', 'Zaraza', 'J-3456789', null, null, 'Otra', null, null,now(),now())	
82	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
83	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
84	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '182640'	Login Incorrect=182640
85	2012-02-12	105	0	N/A	N/A	N/A	pqhg5om5nakdip37ke2h57pfv0	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
86	2012-02-12	105	0	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE usuario = '18264065'	Login Incorrect=18264065
87	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Juan'<br />apellido =  'Taborda'<br />cedula =  '13741258'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  'Mcy'<br />telefono =  null<br />email =  null<br />usuario =  'jtaborda'<br />contrasena =  '123'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado, modificado) VALUES  ('Juan', 'Taborda', '13741258', null, 'M', 'Mcy', null, null, 'jtaborda', '123',now(),now())	
88	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '2'<br />id_perfil =  '3'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','2', '3', now())	
104	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
89	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Mariely'<br />apellido =  'Coronado'<br />cedula =  '17987654'<br />fecha_nacimiento =  null<br />sexo =  'F'<br />direccion =  'La Villa'<br />telefono =  null<br />email =  'marielycoronado@agropatria.co.ve'<br />usuario =  'mcoronado'<br />contrasena =  '123'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Mariely', 'Coronado', '17987654', null, 'F', 'La Villa', null, 'marielycoronado@agropatria.co.ve', 'mcoronado', '123',now())	
90	2012-02-13	201	2	N/A	N/A	N/A	5ovr4kgcipqoj7re3bpqd2jqm1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '2'<br />id_perfil =  '4'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','2', '4', now())	
91	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
92	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
93	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
94	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
95	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '56'<br />nombre =  'Araure'<br />rif =  'J-123123'<br />telefono =  null<br />email =  null<br />fax =  null<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, email, fax, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '56', 'Araure', 'J-123123', null, null, null, null, '1', '1', '1', null, null, 't',now())	
105	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
96	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '2'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('2', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
97	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
98	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
99	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
100	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
101	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '2'<br />id_almacen =  '2'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('2', '2', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
102	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '57'<br />nombre =  'Sabana de Parra'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Algun Lugar'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '57', 'Sabana de Parra', 'J-123123', null, null, null, 'Algun Lugar', '1', '1', '1', null, null, 't',now())	
103	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '3'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('3', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
185	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
106	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
107	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
108	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
109	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
110	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
111	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
112	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
113	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '3'<br />id_almacen =  '3'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('3', '3', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
114	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '58'<br />nombre =  'Chaguaramas'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Chaguaramas'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '58', 'Chaguaramas', 'J-123123', null, null, null, 'Chaguaramas', '1', '1', '1', null, null, 't',now())	
115	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '4'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('4', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
116	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
117	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
118	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
119	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
120	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
121	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
122	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
123	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
124	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
204	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
125	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
126	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
127	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
128	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 13'<br />coordenada =  'Norte'<br />numero =  '13'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 13', 'Norte', '13', '1000', 'A',now())	
129	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 14'<br />coordenada =  'Norte'<br />numero =  '14'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 14', 'Norte', '14', '1000', 'A',now())	
130	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 15'<br />coordenada =  'Norte'<br />numero =  '15'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 15', 'Norte', '15', '1000', 'A',now())	
131	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 16'<br />coordenada =  'Norte'<br />numero =  '16'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 16', 'Norte', '16', '1000', 'A',now())	
132	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 17'<br />coordenada =  'Norte'<br />numero =  '17'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 17', 'Norte', '17', '1000', 'A',now())	
133	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 18'<br />coordenada =  'Norte'<br />numero =  '18'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 18', 'Norte', '18', '1000', 'A',now())	
205	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 't'	UPDATE si_almacenes SET estatus = 't' WHERE id_centro_acopio = '2'	
134	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 19'<br />coordenada =  'Norte'<br />numero =  '19'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 19', 'Norte', '19', '1000', 'A',now())	
135	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 20'<br />coordenada =  'Norte'<br />numero =  '20'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 20', 'Norte', '20', '1000', 'A',now())	
136	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 21'<br />coordenada =  'Norte'<br />numero =  '21'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 21', 'Norte', '21', '1000', 'A',now())	
137	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 22'<br />coordenada =  'Norte'<br />numero =  '22'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 22', 'Norte', '22', '1000', 'A',now())	
138	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 23'<br />coordenada =  'Norte'<br />numero =  '23'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 23', 'Norte', '23', '1000', 'A',now())	
139	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '4'<br />id_almacen =  '4'<br />nombre =  'Silo 24'<br />coordenada =  'Norte'<br />numero =  '24'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('4', '4', 'Silo 24', 'Norte', '24', '1000', 'A',now())	
140	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '60'<br />nombre =  'Sabaneta'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Zulia'<br />id_pais =  '1'<br />id_estado =  '2'<br />id_municipio =  '2'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '60', 'Sabaneta', 'J-123123', null, null, null, 'Zulia', '1', '2', '2', null, null, 't',now())	
186	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
141	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
142	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
143	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
144	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
145	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
146	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
147	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
148	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
149	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
150	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
151	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
206	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 't'	UPDATE si_silos SET estatus = 't' WHERE id_centro_acopio = '2'	
152	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
153	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
154	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 13'<br />coordenada =  'Norte'<br />numero =  '13'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 13', 'Norte', '13', '1000', 'A',now())	
155	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 14'<br />coordenada =  'Norte'<br />numero =  '14'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 14', 'Norte', '14', '1000', 'A',now())	
156	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 15'<br />coordenada =  'Norte'<br />numero =  '15'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 15', 'Norte', '15', '1000', 'A',now())	
157	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 16'<br />coordenada =  'Norte'<br />numero =  '16'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 16', 'Norte', '16', '1000', 'A',now())	
158	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 17'<br />coordenada =  'Norte'<br />numero =  '17'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 17', 'Norte', '17', '1000', 'A',now())	
159	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 18'<br />coordenada =  'Norte'<br />numero =  '18'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 18', 'Norte', '18', '1000', 'A',now())	
160	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 19'<br />coordenada =  'Norte'<br />numero =  '19'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 19', 'Norte', '19', '1000', 'A',now())	
207	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id IN (2,3)	
161	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '5'<br />id_almacen =  '5'<br />nombre =  'Silo 20'<br />coordenada =  'Norte'<br />numero =  '20'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('5', '5', 'Silo 20', 'Norte', '20', '1000', 'A',now())	
162	2012-02-13	202	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta222', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia - Maracaibo', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now()	UPDATE si_centro_acopio SET  id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta222', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia - Maracaibo', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now() WHERE id=5	
163	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
164	2012-02-13	202	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now()	UPDATE si_centro_acopio SET  id = '5', id_org = '1', codigo = '60', nombre = 'Sabaneta', rif = 'J-123123', telefono = null, fax = null, email = null, direccion = 'Zulia', id_pais = '1', id_estado = '2', id_municipio = '2', id_codigo_postal = null, coordenadas_utm = null, estatus = 't', modificado=now() WHERE id=5	
165	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '5'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('5', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
187	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
166	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	id_org = '1'<br />codigo =  '63'<br />nombre =  'Zaraza'<br />rif =  'J-123123'<br />telefono =  null<br />fax =  null<br />email =  null<br />direccion =  'Guarico'<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />id_codigo_postal =  null<br />coordenadas_utm =  null<br />estatus =  't'<br />creado = now()<br />	INSERT INTO si_centro_acopio  (id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado) VALUES  ('1', '63', 'Zaraza', 'J-123123', null, null, null, 'Guarico', '1', '1', '1', null, null, 't',now())	
167	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	id_centro_acopio = '6'<br />nombre =  'Almacen - Silos'<br />direccion =  null<br />id_pais =  '1'<br />id_estado =  '1'<br />id_municipio =  '1'<br />telefono =  null<br />fax =  null<br />email =  null<br />estatus =  '1'<br />coordenadas_utm =  null<br />id_tipo_almacen =  '1'<br />creado = now()<br />	INSERT INTO si_almacenes  (id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, id_tipo_almacen, creado) VALUES  ('6', 'Almacen - Silos', null, '1', '1', '1', null, null, null, '1', null, '1',now())	
168	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 1', 'Norte', '1', '1000', 'A',now())	
169	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 2', 'Norte', '2', '1000', 'A',now())	
170	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 3', 'Norte', '3', '1000', 'A',now())	
171	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 4', 'Norte', '4', '1000', 'A',now())	
172	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 5'<br />coordenada =  'Norte'<br />numero =  '5'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 5', 'Norte', '5', '1000', 'A',now())	
173	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 6'<br />coordenada =  'Norte'<br />numero =  '6'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 6', 'Norte', '6', '1000', 'A',now())	
174	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 7'<br />coordenada =  'Norte'<br />numero =  '7'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 7', 'Norte', '7', '1000', 'A',now())	
175	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 8'<br />coordenada =  'Norte'<br />numero =  '8'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 8', 'Norte', '8', '1000', 'A',now())	
176	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 9'<br />coordenada =  'Norte'<br />numero =  '9'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 9', 'Norte', '9', '1000', 'A',now())	
177	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 10'<br />coordenada =  'Norte'<br />numero =  '10'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 10', 'Norte', '10', '1000', 'A',now())	
208	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
178	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 11'<br />coordenada =  'Norte'<br />numero =  '11'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 11', 'Norte', '11', '1000', 'A',now())	
179	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />id_almacen =  '6'<br />nombre =  'Silo 12'<br />coordenada =  'Norte'<br />numero =  '12'<br />capacidad =  '1000'<br />modulo =  'A'<br />creado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, modulo, creado) VALUES  ('6', '6', 'Silo 12', 'Norte', '12', '1000', 'A',now())	
180	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Jesus'<br />apellido =  'Silva'<br />cedula =  '9668397'<br />fecha_nacimiento =  '1970-09-01'<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jsilva'<br />contrasena =  '123'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Jesus', 'Silva', '9668397', '1970-09-01', 'M', null, null, null, 'jsilva', '123',now())	
181	2012-02-13	201	1	N/A	N/A	N/A	d88eai06tsck6ja6d3c1c9n6l1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '6'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','6', '2', now())	
182	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
183	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
184	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
188	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
189	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
190	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
191	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Juan'<br />apellido =  'Taborda'<br />cedula =  '13769341'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jtaborda'<br />contrasena =  '40bd001563085fc35165329ea1ff5c5ecbdbbeef'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Juan', 'Taborda', '13769341', null, 'M', null, null, null, 'jtaborda', '40bd001563085fc35165329ea1ff5c5ecbdbbeef',now())	
192	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '3'<br />id_almacen = '3'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('3','3', '2', now())	
193	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
194	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
195	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
196	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
197	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
198	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
199	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
200	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
201	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
202	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = 'f'	UPDATE si_silos SET estatus = 'f' WHERE id_centro_acopio = '2'	
203	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
209	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
210	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '0'	UPDATE si_silos SET estatus = '0' WHERE id_centro_acopio = '2'	
211	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
212	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
213	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 't'	UPDATE si_almacenes SET estatus = 't' WHERE id_centro_acopio = '2'	
214	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '1'	UPDATE si_silos SET estatus = '1' WHERE id_centro_acopio = '2'	
215	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id IN (2,3)	
216	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	nombre = 'Jesus'<br />apellido =  'Rodriguez'<br />cedula =  '18264065'<br />fecha_nacimiento =  null<br />sexo =  'M'<br />direccion =  null<br />telefono =  null<br />email =  null<br />usuario =  'jrodriguez'<br />contrasena =  '40bd001563085fc35165329ea1ff5c5ecbdbbeef'<br />creado = now()<br />	INSERT INTO si_usuarios  (nombre, apellido, cedula, fecha_nacimiento, sexo, direccion, telefono, email, usuario, contrasena, creado) VALUES  ('Jesus', 'Rodriguez', '18264065', null, 'M', null, null, null, 'jrodriguez', '40bd001563085fc35165329ea1ff5c5ecbdbbeef',now())	
217	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '4'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','4', '2', now())	
229	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_organizacion	No data	id = '1', nombre = 'Agropatria', rif = null, telefono = null, email = null, fax = null, direccion = null, id_pais = '1', id_estado = '1', id_municipio = '1', estatus = 't', modificado=now()	UPDATE si_organizacion SET  id = '1', nombre = 'Agropatria', rif = null, telefono = null, email = null, fax = null, direccion = null, id_pais = '1', id_estado = '1', id_municipio = '1', estatus = 't', modificado=now() WHERE id=1	
218	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '4', nombre = 'Jesus', apellido = 'Rodriguez', cedula = '18264065', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'jesusrodriguez@agropatria.co.ve', usuario = 'jrodriguez                      ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '4', nombre = 'Jesus', apellido = 'Rodriguez', cedula = '18264065', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'jesusrodriguez@agropatria.co.ve', usuario = 'jrodriguez                      ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=4	
219	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '4'<br />id_almacen = '4'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('4','4', '2', now())	
220	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '2'	
221	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '2'	
222	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '2'	
223	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '2'	
224	2012-02-13	202	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '2', nombre = 'Jesus', apellido = 'Silva', cedula = '9668397', fecha_nacimiento = '1970-09-01', sexo = 'M', direccion = null, telefono = null, email = 'jesussilva@agropatria.co.ve', usuario = 'jsilva                          ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '2', nombre = 'Jesus', apellido = 'Silva', cedula = '9668397', fecha_nacimiento = '1970-09-01', sexo = 'M', direccion = null, telefono = null, email = 'jesussilva@agropatria.co.ve', usuario = 'jsilva                          ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=2	
225	2012-02-13	201	1	N/A	N/A	N/A	5d1ei3h1qlggk6ddb3n1jn7d70	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '2'<br />id_almacen = '2'<br />id_perfil =  '2'<br />creado =  now()<br />	INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('2','2', '2', now())	
226	2012-02-14	202	1	N/A	N/A	N/A	j1lt85olskf5psta3vomkoh2h4	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '2'	
227	2012-02-14	202	1	N/A	N/A	N/A	j1lt85olskf5psta3vomkoh2h4	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '2'	
228	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_organizacion	No data	id = '1', nombre = 'Agropatriaaaa', rif = null, telefono = null, email = null, fax = null, direccion = null, id_pais = '1', id_estado = '1', id_municipio = '1', estatus = 't', modificado=now()	UPDATE si_organizacion SET  id = '1', nombre = 'Agropatriaaaa', rif = null, telefono = null, email = null, fax = null, direccion = null, id_pais = '1', id_estado = '1', id_municipio = '1', estatus = 't', modificado=now() WHERE id=1	
230	2012-02-15	201	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id_org = '1'<br />codigo =  '1'<br />nombre =  'Maiz'<br />tipificado =  null<br />ciclo =  null<br />creado = now()<br />	INSERT INTO si_cultivo  (id_org, codigo, nombre, tipificado, ciclo, creado) VALUES  ('1', '1', 'Maiz', null, null,now())	
231	2012-02-15	201	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id_org = '1'<br />codigo =  '2'<br />nombre =  'Arroz Blanco'<br />tipificado =  'f'<br />ciclo =  null<br />creado = now()<br />	INSERT INTO si_cultivo  (id_org, codigo, nombre, tipificado, ciclo, creado) VALUES  ('1', '2', 'Arroz Blanco', 'f', null,now())	
232	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blancoooo', tipificado = 'f', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blancoooo', tipificado = 'f', ciclo = null, modificado=now() WHERE id=2	
233	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco', tipificado = 'f', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco', tipificado = 'f', ciclo = null, modificado=now() WHERE id=2	
234	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco', tipificado = 't', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco', tipificado = 't', ciclo = null, modificado=now() WHERE id=2	
235	2012-02-15	201	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id_org = '1'<br />codigo =  '3'<br />nombre =  'Sorgo Húmeño'<br />tipificado =  'f'<br />ciclo =  null<br />creado = now()<br />	INSERT INTO si_cultivo  (id_org, codigo, nombre, tipificado, ciclo, creado) VALUES  ('1', '3', 'Sorgo Húmeño', 'f', null,now())	
236	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '3', id_org = '1', codigo = '3', nombre = 'Sorgo Humedo', tipificado = 'f', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '3', id_org = '1', codigo = '3', nombre = 'Sorgo Humedo', tipificado = 'f', ciclo = null, modificado=now() WHERE id=3	
237	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '1', id_org = '1', codigo = '1', nombre = 'Maiz Blanco Húmedo', tipificado = 'f', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '1', id_org = '1', codigo = '1', nombre = 'Maiz Blanco Húmedo', tipificado = 'f', ciclo = null, modificado=now() WHERE id=1	
238	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_cultivo	No data	id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco Húmedo', tipificado = 't', ciclo = null, modificado=now()	UPDATE si_cultivo SET  id = '2', id_org = '1', codigo = '2', nombre = 'Arroz Blanco Húmedo', tipificado = 't', ciclo = null, modificado=now() WHERE id=2	
239	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
240	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
261	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
241	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
242	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
243	2012-02-15	201	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id_usuario = '3'<br />id_almacen =  '2'<br />id_perfil =  '3'<br />creado = now()<br />	INSERT INTO si_usuarios_perfiles  (id_usuario, id_almacen, id_perfil, creado) VALUES  ('3', '2', '3',now())	
244	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
245	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
246	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
247	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
248	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id = '3', id_usuario = '3', id_almacen = '2', id_perfil = '4', modificado=now()	UPDATE si_usuarios_perfiles SET  id = '3', id_usuario = '3', id_almacen = '2', id_perfil = '4', modificado=now() WHERE id=3	
249	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now()	UPDATE si_usuarios SET  id = '3', nombre = 'Juan', apellido = 'Taborda', cedula = '13769341', fecha_nacimiento = null, sexo = 'M', direccion = null, telefono = null, email = 'juantaborda@agropatria.co.ve', usuario = 'jtaborda                        ', contrasena = '40bd001563085fc35165329ea1ff5c5ecbdbbeef', modificado=now() WHERE id=3	
250	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios_perfiles	No data	id = '3', id_usuario = '3', id_almacen = '2', id_perfil = '3', modificado=now()	UPDATE si_usuarios_perfiles SET  id = '3', id_usuario = '3', id_almacen = '2', id_perfil = '3', modificado=now() WHERE id=3	
251	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id = '3'	
252	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id = '3'	
253	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
254	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
255	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
256	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
257	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
258	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
259	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
260	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = ''	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
262	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
263	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
264	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = ''	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
265	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
266	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
267	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
268	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = ''	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = ''	
269	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = ''              WHERE id='1' AND sesion = '' 	
270	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
271	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
272	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = 0 , sesion = ''	UPDATE si_usuarios SET conectado = 0 , sesion = ''              WHERE id='1' AND sesion = NULL	
273	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado = 0 , sesion = ''              WHERE id='1' AND sesion = NULL 	
274	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
275	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
276	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
277	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
278	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
279	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
280	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
281	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
282	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
283	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
284	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
285	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
286	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
384	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 't'	UPDATE si_centro_acopio SET estatus = 't' WHERE id = '2'	
287	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
288	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
289	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
290	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
291	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
292	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
293	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
294	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
295	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
296	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
297	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
298	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
299	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
300	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
301	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
302	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
303	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
304	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
305	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
306	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
307	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
308	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
309	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
310	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
311	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
312	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
313	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
314	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
315	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
316	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
317	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
318	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
319	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
320	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
321	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
322	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
385	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 't'	UPDATE si_almacenes SET estatus = 't' WHERE id_centro_acopio = '2'	
323	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
324	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
325	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
326	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
327	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
328	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
329	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
330	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
331	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
332	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
333	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
334	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
386	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '1'	UPDATE si_silos SET estatus = '1' WHERE id_centro_acopio = '2'	
335	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
336	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
337	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
338	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
339	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
340	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
341	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
342	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
343	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
344	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
345	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
346	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
387	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 't'	UPDATE si_usuarios SET estatus = 't' WHERE id IN (2,3)	
347	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
348	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
349	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
350	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
392	2012-02-15	202	0	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
351	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
352	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
353	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
354	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
355	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
356	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
357	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
358	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
359	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
360	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
361	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
362	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
363	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
364	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
365	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
366	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
367	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
368	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
369	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
370	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
371	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
372	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
373	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
374	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
375	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
376	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7'	
377	2012-02-15	102	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = 'uqv7butekhl0rj3flqcjvj2gj7' 	
378	2012-02-15	202	0	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
379	2012-02-15	101	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='uqv7butekhl0rj3flqcjvj2gj7' WHERE id='1'	User Login
380	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	estatus = 'f'	UPDATE si_centro_acopio SET estatus = 'f' WHERE id = '2'	
381	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_almacenes	No data	estatus = 'f'	UPDATE si_almacenes SET estatus = 'f' WHERE id_centro_acopio = '2'	
382	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	estatus = '0'	UPDATE si_silos SET estatus = '0' WHERE id_centro_acopio = '2'	
383	2012-02-15	202	1	N/A	N/A	N/A	uqv7butekhl0rj3flqcjvj2gj7	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_usuarios	No data	estatus = 'f'	UPDATE si_usuarios SET estatus = 'f' WHERE id IN (2,3)	
388	2012-02-15	202	0	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
389	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
390	2012-02-15	202	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado= 0 , sesion = NULL	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = '3faoe246mjuanq1v78tvfpgec5'	
391	2012-02-15	102	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	No data	No data	No data	UPDATE si_usuarios SET conectado= 0 , sesion = NULL              WHERE id='1' AND sesion = '3faoe246mjuanq1v78tvfpgec5' 	
393	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
394	2012-02-15	202	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
395	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
396	2012-02-15	202	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
397	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
398	2012-02-15	202	0	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
399	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
400	2012-02-15	202	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
401	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
402	2012-02-15	202	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	conectado = '0', sesion = NULL	UPDATE si_usuarios SET conectado = '0', sesion = NULL     WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)	
403	2012-02-15	101	1	N/A	N/A	N/A	3faoe246mjuanq1v78tvfpgec5	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0.1<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0.1</p>\t</div>\r\n	si_usuarios	No data	ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5'	UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,                      sesion='3faoe246mjuanq1v78tvfpgec5' WHERE id='1'	User Login
\.


--
-- TOC entry 2170 (class 0 OID 34759)
-- Dependencies: 209
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) FROM stdin;
1	Maestros	0	\N	t	1	\N	\N
2	Procesos	0	\N	t	2	\N	\N
3	Reportes	0	\N	t	3	\N	\N
4	Panel de Control	0	\N	t	4	\N	\N
5	Cuenta	0	\N	t	5	\N	\N
6	Centros de Acopio	1	admin/centros_acopio_listado.php	t	2	\N	\N
7	Cultivo	1	admin/cultivo_listado.php	t	3	\N	\N
8	Programa	1	admin/programa_listado.php	t	4	\N	\N
9	Silos	1	admin/silos_listado.php	t	5	\N	\N
10	Productor	1	admin/productor_listado.php	t	6	\N	\N
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
\.


--
-- TOC entry 2158 (class 0 OID 34464)
-- Dependencies: 187
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
\.


--
-- TOC entry 2159 (class 0 OID 34467)
-- Dependencies: 188
-- Data for Name: si_movimiento; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_movimiento (silo_id, cosecha_id, numero, fecha_inicio, fecha_fin, cantidad_muestra, peso_bruto, placa_vehiculo, cedula_conductor, descuento_humedad, descuento_impuresas, sada_id, observacion, sap_id, peso_vacio, estado_id, nombre, id, programa_id, contrato, tipo_proceso) FROM stdin;
\.


--
-- TOC entry 2160 (class 0 OID 34479)
-- Dependencies: 189
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
155	13	Simón Planas (Sarare)
156	13	Torres (Carora)
157	13	Urdaneta (Siquisique) 
158	14	Alberto Adriani (El Vigía)
159	14	Andrés Bello (La Azulita)
160	14	Antonio Pinto Salinas (Santa Cruz de Mora)
161	14	Aricagua (Aricagua)
162	14	Arzobispo Chacón (Canaguá)
163	14	Campo Elías (Ejido)
164	14	Caracciolo Parra Olmedo (Tucaní)
165	14	Cardenal Quintero (Santo Domingo)
166	14	Guaraque (Guaraque)
167	14	Julio César Salas (Arapuey)
168	14	Justo Briceño (Torondoy)
169	14	Libertador (Mérida)
170	14	Miranda (Timotes)
171	14	Obispo Ramos de Lora (Santa Elena de Arenales)
172	14	Padre Noguera (Santa María de Caparo)
173	14	Pueblo Llano (Pueblo Llano)
174	14	Rangel (Mucuchíes)
175	14	Rivas Dávila (Bailadores)
176	14	Santos Marquina (Tabay)
177	14	Sucre (Lagunillas)
178	14	Tovar (Tovar)
179	14	Tulio Febres Cordero (Nueva Bolivia)
180	14	Zea (Zea) 
181	15	Acevedo (Caucagua)
182	15	Andrés Bello (San José de Barlovento)
183	15	Baruta (Baruta)
184	15	Brión (Higuerote)
185	15	Buroz (Mamporal)
186	15	Carrizal (Carrizal)
187	15	Chacao (Chacao)
188	15	Cristóbal Rojas (Charallave)
189	15	El Hatillo (Santa Rosalía de Palermo)
190	15	Guaicaipuro (Los Teques)
191	15	Independencia (Santa Teresa del Tuy)
192	15	Lander (Ocumare del Tuy)
193	15	Los Salias (San Antonio de los Altos)
194	15	Páez (Río Chico)
195	15	Paz Castillo (Santa Lucía)
196	15	Pedro Gual (Cúpira)
197	15	Plaza (Guarenas)
198	15	Simón Bolívar (San Francisco de Yare)
199	15	Sucre (Petare)
200	15	Urdaneta (Cúa)
201	15	Zamora (Guatire) 
202	16	Acosta (San Antonio de Capayacuar)
203	16	Aguasay (Aguasay)
204	16	Bolívar (Caripito)
205	16	Caripe (Caripe)
206	16	Cedeño (Caicara)
207	16	Ezequiel Zamora (Punta de Mata)
208	16	Libertador (Temblador)
209	16	Maturín (Maturín)
210	16	Piar (Aragua de Maturín)
211	16	Punceres (Quiriquire)
212	16	Santa Bárbara (Santa Bárbara)
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
\.


--
-- TOC entry 2161 (class 0 OID 34484)
-- Dependencies: 191
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus) FROM stdin;
1	Agropatria	\N	\N	\N	\N	\N	\N	1	1	1	2012-02-12 00:00:00-04:30	2012-02-15 08:31:14.425802-04:30	t
\.


--
-- TOC entry 2162 (class 0 OID 34492)
-- Dependencies: 193
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_pais (id, nombre) FROM stdin;
1	Venezuela
\.


--
-- TOC entry 2163 (class 0 OID 34499)
-- Dependencies: 196
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
1	SYSTEM_NAME	SIGESI	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
2	MAX_RESULTS_PAG	20	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
\.


--
-- TOC entry 2164 (class 0 OID 34508)
-- Dependencies: 198
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
-- TOC entry 2165 (class 0 OID 34514)
-- Dependencies: 200
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, numero, nombre, observacion, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2166 (class 0 OID 34521)
-- Dependencies: 201
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_proveedor (id, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2167 (class 0 OID 34527)
-- Dependencies: 202
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, numero, capacidad, observacion, estatus, modulo, creado, modificado) FROM stdin;
7	3	3	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:05:32.047308-04:30	\N
8	3	3	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:05:32.064005-04:30	\N
9	3	3	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:05:32.080546-04:30	\N
10	3	3	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:05:32.097424-04:30	\N
11	3	3	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:05:32.114005-04:30	\N
12	3	3	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:05:32.130658-04:30	\N
13	3	3	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:05:32.147097-04:30	\N
14	3	3	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:05:32.164022-04:30	\N
15	3	3	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:05:32.180592-04:30	\N
16	3	3	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:05:32.197159-04:30	\N
17	4	4	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:06:27.348165-04:30	\N
18	4	4	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:06:27.365003-04:30	\N
19	4	4	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:06:27.381487-04:30	\N
20	4	4	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:06:27.39829-04:30	\N
21	4	4	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:06:27.414956-04:30	\N
22	4	4	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:06:27.431423-04:30	\N
23	4	4	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:06:27.448256-04:30	\N
24	4	4	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:06:27.464898-04:30	\N
25	4	4	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:06:27.481472-04:30	\N
26	4	4	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:06:27.498121-04:30	\N
27	4	4	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:06:27.514982-04:30	\N
28	4	4	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:06:27.531417-04:30	\N
29	4	4	Silo 13	Norte	13	1000	\N	1	A 	2012-02-13 11:06:27.548043-04:30	\N
30	4	4	Silo 14	Norte	14	1000	\N	1	A 	2012-02-13 11:06:27.565593-04:30	\N
31	4	4	Silo 15	Norte	15	1000	\N	1	A 	2012-02-13 11:06:27.585406-04:30	\N
32	4	4	Silo 16	Norte	16	1000	\N	1	A 	2012-02-13 11:06:27.598079-04:30	\N
33	4	4	Silo 17	Norte	17	1000	\N	1	A 	2012-02-13 11:06:27.614882-04:30	\N
34	4	4	Silo 18	Norte	18	1000	\N	1	A 	2012-02-13 11:06:27.631368-04:30	\N
35	4	4	Silo 19	Norte	19	1000	\N	1	A 	2012-02-13 11:06:27.64816-04:30	\N
36	4	4	Silo 20	Norte	20	1000	\N	1	A 	2012-02-13 11:06:27.664683-04:30	\N
37	4	4	Silo 21	Norte	21	1000	\N	1	A 	2012-02-13 11:06:27.681424-04:30	\N
38	4	4	Silo 22	Norte	22	1000	\N	1	A 	2012-02-13 11:06:27.698087-04:30	\N
39	4	4	Silo 23	Norte	23	1000	\N	1	A 	2012-02-13 11:06:27.714699-04:30	\N
40	4	4	Silo 24	Norte	24	1000	\N	1	A 	2012-02-13 11:06:27.731507-04:30	\N
41	5	5	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:12:33.341886-04:30	\N
42	5	5	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:12:33.358622-04:30	\N
43	5	5	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:12:33.375377-04:30	\N
44	5	5	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:12:33.39185-04:30	\N
45	5	5	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:12:33.408492-04:30	\N
46	5	5	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:12:33.425069-04:30	\N
47	5	5	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:12:33.442001-04:30	\N
48	5	5	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:12:33.458509-04:30	\N
49	5	5	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:12:33.475215-04:30	\N
50	5	5	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:12:33.491855-04:30	\N
51	5	5	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:12:33.508602-04:30	\N
52	5	5	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:12:33.525128-04:30	\N
53	5	5	Silo 13	Norte	13	1000	\N	1	A 	2012-02-13 11:12:33.541914-04:30	\N
54	5	5	Silo 14	Norte	14	1000	\N	1	A 	2012-02-13 11:12:33.561376-04:30	\N
55	5	5	Silo 15	Norte	15	1000	\N	1	A 	2012-02-13 11:12:33.575171-04:30	\N
56	5	5	Silo 16	Norte	16	1000	\N	1	A 	2012-02-13 11:12:33.59178-04:30	\N
57	5	5	Silo 17	Norte	17	1000	\N	1	A 	2012-02-13 11:12:33.60849-04:30	\N
58	5	5	Silo 18	Norte	18	1000	\N	1	A 	2012-02-13 11:12:33.625125-04:30	\N
59	5	5	Silo 19	Norte	19	1000	\N	1	A 	2012-02-13 11:12:33.64196-04:30	\N
60	5	5	Silo 20	Norte	20	1000	\N	1	A 	2012-02-13 11:12:33.658508-04:30	\N
61	6	6	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:25:07.764398-04:30	\N
62	6	6	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:25:07.781128-04:30	\N
63	6	6	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:25:07.797725-04:30	\N
64	6	6	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:25:07.814551-04:30	\N
65	6	6	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:25:07.831087-04:30	\N
66	6	6	Silo 6	Norte	6	1000	\N	1	A 	2012-02-13 11:25:07.847859-04:30	\N
67	6	6	Silo 7	Norte	7	1000	\N	1	A 	2012-02-13 11:25:07.864434-04:30	\N
68	6	6	Silo 8	Norte	8	1000	\N	1	A 	2012-02-13 11:25:07.880988-04:30	\N
69	6	6	Silo 9	Norte	9	1000	\N	1	A 	2012-02-13 11:25:07.897561-04:30	\N
70	6	6	Silo 10	Norte	10	1000	\N	1	A 	2012-02-13 11:25:07.914479-04:30	\N
71	6	6	Silo 11	Norte	11	1000	\N	1	A 	2012-02-13 11:25:07.931073-04:30	\N
72	6	6	Silo 12	Norte	12	1000	\N	1	A 	2012-02-13 11:25:07.947754-04:30	\N
2	2	2	Silo 1	Norte	1	1000	\N	1	A 	2012-02-13 11:01:40.130888-04:30	\N
3	2	2	Silo 2	Norte	2	1000	\N	1	A 	2012-02-13 11:01:40.147421-04:30	\N
4	2	2	Silo 3	Norte	3	1000	\N	1	A 	2012-02-13 11:01:40.164032-04:30	\N
5	2	2	Silo 4	Norte	4	1000	\N	1	A 	2012-02-13 11:01:40.180896-04:30	\N
6	2	2	Silo 5	Norte	5	1000	\N	1	A 	2012-02-13 11:01:40.197353-04:30	\N
\.


--
-- TOC entry 2168 (class 0 OID 34538)
-- Dependencies: 204
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) FROM stdin;
4	Jesus	Rodriguez	18264065	\N	M	jrodriguez                      	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesusrodriguez@agropatria.co.ve	2012-02-13	2012-02-13	t	0	\N	\N
2	Jesus	Silva	9668397	1970-09-01	M	jsilva                          	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesussilva@agropatria.co.ve	2012-02-13	2012-02-13	t	0	\N	\N
3	Juan	Taborda	13769341	\N	M	jtaborda                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	juantaborda@agropatria.co.ve	2012-02-13	2012-02-15	t	0	\N	\N
1	Jose	Peluzzo	1234567	2012-02-12	M	jpeluzzo                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	Maracay	\N	josepeluzzo@agropatria.co.ve	2012-02-12	\N	t	1	3faoe246mjuanq1v78tvfpgec5	2012-02-15 22:39:07.182-04:30
\.


--
-- TOC entry 2169 (class 0 OID 34548)
-- Dependencies: 206
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) FROM stdin;
1	1	1	1	2012-02-13 00:00:00-04:30	\N
2	2	2	2	2012-02-13 11:34:56.142546-04:30	\N
4	4	4	2	2012-02-13 16:15:23.105604-04:30	\N
3	3	2	3	2012-02-13 15:00:02.192211-04:30	\N
\.


--
-- TOC entry 2069 (class 2606 OID 34567)
-- Dependencies: 167 167
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2089 (class 2606 OID 34569)
-- Dependencies: 184 184
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2061 (class 2606 OID 34571)
-- Dependencies: 161 161
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2065 (class 2606 OID 34573)
-- Dependencies: 164 164
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2063 (class 2606 OID 34575)
-- Dependencies: 163 163
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2067 (class 2606 OID 34577)
-- Dependencies: 165 165
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2071 (class 2606 OID 34579)
-- Dependencies: 168 168
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2073 (class 2606 OID 34581)
-- Dependencies: 169 169
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2075 (class 2606 OID 34583)
-- Dependencies: 170 170
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2077 (class 2606 OID 34585)
-- Dependencies: 172 172
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2079 (class 2606 OID 34587)
-- Dependencies: 174 174
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2081 (class 2606 OID 34589)
-- Dependencies: 175 175
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2083 (class 2606 OID 34591)
-- Dependencies: 177 177
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2085 (class 2606 OID 34593)
-- Dependencies: 179 179
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2087 (class 2606 OID 34695)
-- Dependencies: 181 181
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2091 (class 2606 OID 34595)
-- Dependencies: 186 186
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2117 (class 2606 OID 34765)
-- Dependencies: 209 209
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2095 (class 2606 OID 34702)
-- Dependencies: 189 189
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2097 (class 2606 OID 34599)
-- Dependencies: 191 191
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2099 (class 2606 OID 34601)
-- Dependencies: 193 193
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2101 (class 2606 OID 34603)
-- Dependencies: 196 196
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2103 (class 2606 OID 34605)
-- Dependencies: 198 198
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2105 (class 2606 OID 34607)
-- Dependencies: 200 200
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2107 (class 2606 OID 34609)
-- Dependencies: 201 201
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2093 (class 2606 OID 34611)
-- Dependencies: 188 188
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_movimiento
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2109 (class 2606 OID 34613)
-- Dependencies: 202 202
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2115 (class 2606 OID 34615)
-- Dependencies: 206 206
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2111 (class 2606 OID 34617)
-- Dependencies: 204 204
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2113 (class 2606 OID 34619)
-- Dependencies: 204 204
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2118 (class 2606 OID 34620)
-- Dependencies: 161 170 2074
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2120 (class 2606 OID 34743)
-- Dependencies: 161 181 2086
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2121 (class 2606 OID 34748)
-- Dependencies: 161 189 2094
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2119 (class 2606 OID 34738)
-- Dependencies: 161 193 2098
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2123 (class 2606 OID 34728)
-- Dependencies: 2086 170 181
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2124 (class 2606 OID 34733)
-- Dependencies: 170 189 2094
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2122 (class 2606 OID 34723)
-- Dependencies: 170 193 2098
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2125 (class 2606 OID 34625)
-- Dependencies: 2104 174 200
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2126 (class 2606 OID 34630)
-- Dependencies: 175 2096 191
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2127 (class 2606 OID 34635)
-- Dependencies: 2080 175 177
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2128 (class 2606 OID 34640)
-- Dependencies: 177 2096 191
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2129 (class 2606 OID 34696)
-- Dependencies: 181 193 2098
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2130 (class 2606 OID 34645)
-- Dependencies: 2088 184 186
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2131 (class 2606 OID 34655)
-- Dependencies: 2110 204 187
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2132 (class 2606 OID 34703)
-- Dependencies: 189 181 2086
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2134 (class 2606 OID 34713)
-- Dependencies: 191 181 2086
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2135 (class 2606 OID 34718)
-- Dependencies: 191 189 2094
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2133 (class 2606 OID 34708)
-- Dependencies: 191 193 2098
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2136 (class 2606 OID 34660)
-- Dependencies: 2074 170 200
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2137 (class 2606 OID 34665)
-- Dependencies: 2060 161 202
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2138 (class 2606 OID 34670)
-- Dependencies: 170 2074 202
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2139 (class 2606 OID 34675)
-- Dependencies: 206 161 2060
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2140 (class 2606 OID 34680)
-- Dependencies: 206 198 2102
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2141 (class 2606 OID 34685)
-- Dependencies: 206 204 2110
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-15 23:22:18

--
-- PostgreSQL database dump complete
--

