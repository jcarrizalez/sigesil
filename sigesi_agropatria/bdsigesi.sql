--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-03-12 00:57:30

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 260 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 260
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 161 (class 1259 OID 42404)
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
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 42406)
-- Dependencies: 2159 6
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
-- TOC entry 163 (class 1259 OID 42413)
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
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- TOC entry 164 (class 1259 OID 42415)
-- Dependencies: 2160 2161 2162 6
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
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 165 (class 1259 OID 42421)
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
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 166 (class 1259 OID 42424)
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
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 42426)
-- Dependencies: 2164 2165 2166 2167 2168 2169 6
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
    max_des numeric(16,3) DEFAULT 0.0
);


ALTER TABLE public.si_analisis_cultivo OWNER TO admin;

--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 168 (class 1259 OID 42435)
-- Dependencies: 6 167
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
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 63, true);


--
-- TOC entry 169 (class 1259 OID 42437)
-- Dependencies: 2171 6
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
-- TOC entry 170 (class 1259 OID 42441)
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
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 42443)
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
    muestra3 character(16)
);


ALTER TABLE public.si_analisis_resultado OWNER TO admin;

--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 172 (class 1259 OID 42446)
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
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 2416, true);


--
-- TOC entry 173 (class 1259 OID 42448)
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
-- TOC entry 174 (class 1259 OID 42454)
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
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 2, true);


--
-- TOC entry 175 (class 1259 OID 42456)
-- Dependencies: 2174 6
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
-- TOC entry 176 (class 1259 OID 42463)
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
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 42465)
-- Dependencies: 2175 6
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
-- TOC entry 178 (class 1259 OID 42469)
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
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 42471)
-- Dependencies: 2176 2177 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 180 (class 1259 OID 42476)
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
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 181 (class 1259 OID 42478)
-- Dependencies: 2178 2179 2180 2181 2182 2183 2184 6
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
-- TOC entry 182 (class 1259 OID 42491)
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
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 42493)
-- Dependencies: 2185 6
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
-- TOC entry 184 (class 1259 OID 42500)
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
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 4, true);


--
-- TOC entry 185 (class 1259 OID 42502)
-- Dependencies: 2186 2187 2188 2189 2190 6
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
-- TOC entry 186 (class 1259 OID 42513)
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
-- TOC entry 187 (class 1259 OID 42516)
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
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 4, true);


--
-- TOC entry 188 (class 1259 OID 42518)
-- Dependencies: 6
-- Name: si_cuarentena; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cuarentena (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_cultivo bigint,
    id_recepcion bigint,
    id_despacho bigint,
    tipo_mov character(1) NOT NULL,
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
    estatus boolean
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- TOC entry 189 (class 1259 OID 42521)
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
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 17, true);


--
-- TOC entry 190 (class 1259 OID 42523)
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
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 9, true);


--
-- TOC entry 191 (class 1259 OID 42525)
-- Dependencies: 2193 2194 2195 6
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
-- TOC entry 192 (class 1259 OID 42531)
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
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 42533)
-- Dependencies: 2196 6
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
-- TOC entry 194 (class 1259 OID 42537)
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción';


--
-- TOC entry 195 (class 1259 OID 42540)
-- Dependencies: 194 6
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
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 42542)
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
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 196
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 197 (class 1259 OID 42544)
-- Dependencies: 2198 2199 6
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
-- TOC entry 198 (class 1259 OID 42549)
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
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 198
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 199 (class 1259 OID 42551)
-- Dependencies: 2200 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 200 (class 1259 OID 42555)
-- Dependencies: 2201 6
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
-- TOC entry 201 (class 1259 OID 42562)
-- Dependencies: 200 6
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
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 202 (class 1259 OID 42564)
-- Dependencies: 6
-- Name: si_formulas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_formulas (
    id bigint NOT NULL,
    id_org bigint,
    id_centro_acopio bigint,
    id_cultivo bigint NOT NULL,
    formula character varying(255) NOT NULL,
    codigo character varying(4) NOT NULL,
    id_mov bigint NOT NULL,
    tipo_for bigint NOT NULL,
    condicion character varying(20),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    id_analisis bigint
);


ALTER TABLE public.si_formulas OWNER TO admin;

--
-- TOC entry 203 (class 1259 OID 42567)
-- Dependencies: 6 202
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
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 3, true);


--
-- TOC entry 204 (class 1259 OID 42569)
-- Dependencies: 2204 2205 6
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
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 205 (class 1259 OID 42574)
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
-- TOC entry 206 (class 1259 OID 42577)
-- Dependencies: 205 6
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
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 1, false);


--
-- TOC entry 207 (class 1259 OID 42579)
-- Dependencies: 6 204
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
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 7, true);


--
-- TOC entry 208 (class 1259 OID 42581)
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
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 42583)
-- Dependencies: 2208 6
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
-- TOC entry 210 (class 1259 OID 42587)
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
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 1, true);


--
-- TOC entry 211 (class 1259 OID 42589)
-- Dependencies: 2209 6
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
-- TOC entry 212 (class 1259 OID 42596)
-- Dependencies: 2210 6
-- Name: si_mensajes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_mensajes (
    id bigint NOT NULL,
    msg character varying(255) NOT NULL,
    tipo character(1) DEFAULT 'P'::bpchar
);


ALTER TABLE public.si_mensajes OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 42600)
-- Dependencies: 212 6
-- Name: si_mensajes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_mensajes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.si_mensajes_id_seq OWNER TO admin;

--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_mensajes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_mensajes_id_seq OWNED BY si_mensajes.id;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 213
-- Name: si_mensajes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_mensajes_id_seq', 1, false);


--
-- TOC entry 214 (class 1259 OID 42602)
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
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 28, true);


--
-- TOC entry 215 (class 1259 OID 42604)
-- Dependencies: 2212 2213 6
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
-- TOC entry 216 (class 1259 OID 42609)
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
-- TOC entry 217 (class 1259 OID 42612)
-- Dependencies: 216 6
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
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;


--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_usuario_id_seq', 35, true);


--
-- TOC entry 218 (class 1259 OID 42614)
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
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 219 (class 1259 OID 42616)
-- Dependencies: 2215 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 42620)
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
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- TOC entry 221 (class 1259 OID 42622)
-- Dependencies: 2216 2217 6
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
-- TOC entry 222 (class 1259 OID 42627)
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
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 222
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 223 (class 1259 OID 42629)
-- Dependencies: 2218 6
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
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 224 (class 1259 OID 42636)
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 225 (class 1259 OID 42638)
-- Dependencies: 2219 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 42642)
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
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 226
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 227 (class 1259 OID 42644)
-- Dependencies: 2220 6
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
-- TOC entry 228 (class 1259 OID 42651)
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
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 229 (class 1259 OID 42653)
-- Dependencies: 2221 6
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
-- TOC entry 230 (class 1259 OID 42657)
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
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 231 (class 1259 OID 42660)
-- Dependencies: 230 6
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
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 1, false);


--
-- TOC entry 232 (class 1259 OID 42662)
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
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 233 (class 1259 OID 42665)
-- Dependencies: 232 6
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
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 1, false);


--
-- TOC entry 234 (class 1259 OID 42667)
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
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 4, true);


--
-- TOC entry 235 (class 1259 OID 42669)
-- Dependencies: 2224 6
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
-- TOC entry 236 (class 1259 OID 42676)
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
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 3, true);


--
-- TOC entry 237 (class 1259 OID 42678)
-- Dependencies: 2225 6
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
-- TOC entry 238 (class 1259 OID 42685)
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_proveedor; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_proveedor IS 'Tabla de los Proveedores';


--
-- TOC entry 239 (class 1259 OID 42691)
-- Dependencies: 238 6
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
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 240 (class 1259 OID 42693)
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
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 241 (class 1259 OID 42699)
-- Dependencies: 240 6
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- TOC entry 242 (class 1259 OID 42701)
-- Dependencies: 2228 6
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
    fecha_pel timestamp with time zone,
    peso_01l real,
    peso_02l real,
    tolva integer,
    fecha_v timestamp with time zone,
    peso_01v real,
    peso_02v real,
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
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE si_recepcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo
Estatus=''T''=>Transito
Estatus=''A''=>Activo
Estatus=''C''=>Curentena

Estatus=3';


--
-- TOC entry 243 (class 1259 OID 42705)
-- Dependencies: 242 6
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
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 7, true);


--
-- TOC entry 244 (class 1259 OID 42707)
-- Dependencies: 2230 6
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
-- TOC entry 245 (class 1259 OID 42714)
-- Dependencies: 2232 6
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
-- TOC entry 246 (class 1259 OID 42721)
-- Dependencies: 6 245
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
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 246
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 40, true);


--
-- TOC entry 247 (class 1259 OID 42723)
-- Dependencies: 6 244
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 247
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 3, true);


--
-- TOC entry 248 (class 1259 OID 42725)
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
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 248
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 249 (class 1259 OID 42727)
-- Dependencies: 2234 2235 2236 6
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
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 250 (class 1259 OID 42736)
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
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 250
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- TOC entry 251 (class 1259 OID 42738)
-- Dependencies: 2237 2238 2239 6
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
-- TOC entry 252 (class 1259 OID 42744)
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
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 253 (class 1259 OID 42750)
-- Dependencies: 252 6
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
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 253
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 253
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
-- TOC entry 254 (class 1259 OID 42752)
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
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 254
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 4, true);


--
-- TOC entry 255 (class 1259 OID 42754)
-- Dependencies: 2241 2242 2243 6
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
-- TOC entry 256 (class 1259 OID 42763)
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
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 256
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 4, true);


--
-- TOC entry 257 (class 1259 OID 42765)
-- Dependencies: 2244 6
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
-- TOC entry 258 (class 1259 OID 42769)
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
-- TOC entry 259 (class 1259 OID 42772)
-- Dependencies: 6 258
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
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 259
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 259
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 6, true);


--
-- TOC entry 2163 (class 2604 OID 42774)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 42775)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2172 (class 2604 OID 42776)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 42777)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 42778)
-- Dependencies: 187 186
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 42779)
-- Dependencies: 189 188
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 42780)
-- Dependencies: 195 194
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 42781)
-- Dependencies: 201 200
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2203 (class 2604 OID 42782)
-- Dependencies: 203 202
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 42783)
-- Dependencies: 207 204
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 42784)
-- Dependencies: 206 205
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 42785)
-- Dependencies: 213 212
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_mensajes ALTER COLUMN id SET DEFAULT nextval('si_mensajes_id_seq'::regclass);


--
-- TOC entry 2214 (class 2604 OID 42786)
-- Dependencies: 217 216
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);


--
-- TOC entry 2222 (class 2604 OID 42787)
-- Dependencies: 231 230
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2223 (class 2604 OID 42788)
-- Dependencies: 233 232
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2226 (class 2604 OID 42789)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2227 (class 2604 OID 42790)
-- Dependencies: 241 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2229 (class 2604 OID 42791)
-- Dependencies: 243 242
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2231 (class 2604 OID 42792)
-- Dependencies: 247 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 42793)
-- Dependencies: 246 245
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2240 (class 2604 OID 42794)
-- Dependencies: 253 252
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2245 (class 2604 OID 42795)
-- Dependencies: 259 258
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2436 (class 0 OID 42406)
-- Dependencies: 162
-- Data for Name: si_almacenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) FROM stdin;
8	8	ALMACEN - SILOS	\N	1	12	137	\N	\N	\N	t	\N	2012-02-19 15:35:00.454	\N	1	1
9	9	ALMACEN - SILOS	\N	1	18	229	\N	\N	\N	t	\N	2012-02-19 15:39:25.17	\N	1	1
7	7	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-19 15:26:29	\N	1	1
6	6	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:25:07.74788	\N	1	1
5	5	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:12:33.325252	\N	1	1
4	4	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:06:27.331621	\N	1	1
3	3	ALMACEN - SILOS	\N	1	1	1	\N	\N	\N	t	\N	2012-02-13 11:05:32.030751	\N	1	1
1	1	TODOS	\N	1	1	1	\N	\N	\N	t	\N	\N	\N	1	1
10	2	HERRAMIENTAS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-19 20:29:24.769	\N	2	2
11	2	PRODUCTOS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-20 11:06:41.92	\N	2	3
2	2	ALMACEN - SILOS	\N	1	18	227	\N	\N	\N	t	\N	2012-02-13 11:01:40.114191	2012-02-23 11:49:10.809611	2	2
\.


--
-- TOC entry 2437 (class 0 OID 42415)
-- Dependencies: 164
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) FROM stdin;
8	1	GRANOS PARTIDOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	8	f
9	1	GRANOS CRISTALIZADOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	9	f
10	1	GRANOS QUEMADOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	10	f
11	1	GRANOS AMILACEOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	11	f
12	1	MEZCLA DE COLOR EN BLANCO	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	12	f
13	1	PESO ESPECIFICO	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	13	f
14	1	SEMILLAS OBJETABLES	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	14	f
19	1	COLOR	2	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	22	f
18	1	OLOR	2	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	21	f
4	1	GRANOS DAÑADO POR HONGOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	4	f
5	1	GRANOS DAÑADO POR CALOR	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	5	f
6	1	GRANOS DAÑADO POR INSECTOS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	6	f
7	1	GRANOS DAÑADO TOTALES	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	7	f
15	1	GRANO PARTIDO PEQUEÑO	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	15	f
3	1	GRANOS CON GERMEN DAÑADO	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	3	f
17	1	ASPECTO	2	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	20	f
20	1	LIMPIEZA	2	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	23	f
1	1	HUMEDAD	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	1	t
2	1	IMPUREZAS	1	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	2	t
16	1	AFLATOXINA	3	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	19	f
21	1	INSECTOS VIVOS	3	t	2012-02-22 00:00:00-04:30	2012-02-22 00:00:00-04:30	24	f
\.


--
-- TOC entry 2438 (class 0 OID 42421)
-- Dependencies: 165
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_centro_acopio (id, id_analisis, id_centro_acopio) FROM stdin;
\.


--
-- TOC entry 2439 (class 0 OID 42426)
-- Dependencies: 167
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) FROM stdin;
1	12	5	C	0.000	0.000	R	14	0.000	0.000	0.000	0.000
1	1	1	C	0.000	0.000	R	1	1.000	2.000	0.000	0.000
1	2	1	C	0.000	0.000	R	2	2.000	5.000	0.000	0.000
1	1	5	C	0.000	0.000	R	3	0.000	0.000	0.000	0.000
1	2	5	C	0.000	0.000	R	4	0.000	0.000	0.000	0.000
1	3	5	C	0.000	0.000	R	5	0.000	0.000	0.000	0.000
1	4	5	C	0.000	0.000	R	6	0.000	0.000	0.000	0.000
1	5	5	C	0.000	0.000	R	7	0.000	0.000	0.000	0.000
1	6	5	C	0.000	0.000	R	8	0.000	0.000	0.000	0.000
1	7	5	C	0.000	0.000	R	9	0.000	0.000	0.000	0.000
1	8	5	C	0.000	0.000	R	10	0.000	0.000	0.000	0.000
1	9	5	C	0.000	0.000	R	11	0.000	0.000	0.000	0.000
1	10	5	C	0.000	0.000	R	12	0.000	0.000	0.000	0.000
1	11	5	C	0.000	0.000	R	13	0.000	0.000	0.000	0.000
1	13	5	C	0.000	0.000	R	15	0.000	0.000	0.000	0.000
1	14	5	C	0.000	0.000	R	16	0.000	0.000	0.000	0.000
1	15	5	C	0.000	0.000	R	17	0.000	0.000	0.000	0.000
1	16	5	C	0.000	0.000	R	18	0.000	0.000	0.000	0.000
1	17	5	C	0.000	0.000	R	19	0.000	0.000	0.000	0.000
1	18	5	C	0.000	0.000	R	20	0.000	0.000	0.000	0.000
1	19	5	C	0.000	0.000	R	21	0.000	0.000	0.000	0.000
1	20	5	C	0.000	0.000	R	22	0.000	0.000	0.000	0.000
1	21	5	C	0.000	0.000	R	23	0.000	0.000	0.000	0.000
1	2	6	C	0.000	0.000	R	24	0.000	0.000	0.000	0.000
1	2	6	C	0.000	0.000	R	25	0.000	0.000	0.000	0.000
1	3	6	C	0.000	0.000	R	26	0.000	0.000	0.000	0.000
1	4	6	C	0.000	0.000	R	27	0.000	0.000	0.000	0.000
1	5	6	C	0.000	0.000	R	28	0.000	0.000	0.000	0.000
1	6	6	C	0.000	0.000	R	29	0.000	0.000	0.000	0.000
1	7	6	C	0.000	0.000	R	30	0.000	0.000	0.000	0.000
1	8	6	C	0.000	0.000	R	31	0.000	0.000	0.000	0.000
1	9	6	C	0.000	0.000	R	32	0.000	0.000	0.000	0.000
1	10	6	C	0.000	0.000	R	33	0.000	0.000	0.000	0.000
1	11	6	C	0.000	0.000	R	34	0.000	0.000	0.000	0.000
1	12	6	C	0.000	0.000	R	35	0.000	0.000	0.000	0.000
1	13	6	C	0.000	0.000	R	36	0.000	0.000	0.000	0.000
1	14	6	C	0.000	0.000	R	37	0.000	0.000	0.000	0.000
1	15	6	C	0.000	0.000	R	38	0.000	0.000	0.000	0.000
1	16	6	C	0.000	0.000	R	39	0.000	0.000	0.000	0.000
1	17	6	C	0.000	0.000	R	40	0.000	0.000	0.000	0.000
1	18	6	C	0.000	0.000	R	41	0.000	0.000	0.000	0.000
1	19	6	C	0.000	0.000	R	42	0.000	0.000	0.000	0.000
1	20	6	C	0.000	0.000	R	43	0.000	0.000	0.000	0.000
1	21	6	C	0.000	0.000	R	44	0.000	0.000	0.000	0.000
1	3	1	C	0.000	0.000	R	45	0.000	0.000	0.000	0.000
1	4	1	C	0.000	0.000	R	46	0.000	0.000	0.000	0.000
1	5	1	C	0.000	0.000	R	47	0.000	0.000	0.000	0.000
1	6	1	C	0.000	0.000	R	48	0.000	0.000	0.000	0.000
1	7	1	C	0.000	0.000	R	49	0.000	0.000	0.000	0.000
1	8	1	C	0.000	0.000	R	50	0.000	0.000	0.000	0.000
1	9	1	C	0.000	0.000	R	51	0.000	0.000	0.000	0.000
1	10	1	C	0.000	0.000	R	52	0.000	0.000	0.000	0.000
1	11	1	C	0.000	0.000	R	53	0.000	0.000	0.000	0.000
1	12	1	C	0.000	0.000	R	54	0.000	0.000	0.000	0.000
1	13	1	C	0.000	0.000	R	55	0.000	0.000	0.000	0.000
1	14	1	C	0.000	0.000	R	56	0.000	0.000	0.000	0.000
1	15	1	C	0.000	0.000	R	57	0.000	0.000	0.000	0.000
1	16	1	C	0.000	0.000	R	58	0.000	0.000	0.000	0.000
1	17	1	C	0.000	0.000	R	59	0.000	0.000	0.000	0.000
1	18	1	C	0.000	0.000	R	60	0.000	0.000	0.000	0.000
1	19	1	C	0.000	0.000	R	61	0.000	0.000	0.000	0.000
1	20	1	C	0.000	0.000	R	62	0.000	0.000	0.000	0.000
1	21	1	C	0.000	0.000	C	63	0.000	0.000	0.000	0.000
\.


--
-- TOC entry 2440 (class 0 OID 42437)
-- Dependencies: 169
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_des (id_org, id_analisis, id_cultivo, min_rec, max_rec, min_des, max_des, descuento_rec, descuento_des, estatus, id) FROM stdin;
\.


--
-- TOC entry 2441 (class 0 OID 42443)
-- Dependencies: 171
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) FROM stdin;
2396	2	\N	1	3	2.000           	2.000           	                
2397	2	\N	2	3	2.000           	2.000           	                
2398	2	\N	3	3	0.000           	0.000           	                
2399	2	\N	4	3	0.000           	0.000           	                
2400	2	\N	5	3	0.000           	0.000           	                
2401	2	\N	6	3	0.000           	0.000           	                
2402	2	\N	7	3	0.000           	0.000           	                
2403	2	\N	8	3	0.000           	0.000           	                
2404	2	\N	9	3	0.000           	0.000           	                
2405	2	\N	10	3	0.000           	0.000           	                
2406	2	\N	11	3	0.000           	0.000           	                
2407	2	\N	12	3	0.000           	0.000           	                
2408	2	\N	13	3	0.000           	0.000           	                
2409	2	\N	14	3	0.000           	0.000           	                
2410	2	\N	15	3	0.000           	0.000           	                
2411	2	\N	16	3	SI              	NO              	                
2412	2	\N	17	3	A               	A               	                
2413	2	\N	18	3	A               	A               	                
2414	2	\N	19	3	A               	A               	                
2415	2	\N	20	3	A               	A               	                
2416	2	\N	21	3	NO              	NO              	                
\.


--
-- TOC entry 2442 (class 0 OID 42448)
-- Dependencies: 173
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 2443 (class 0 OID 42456)
-- Dependencies: 175
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) FROM stdin;
2	3	V16872741       	CARLOS PEREZ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:17:14.272529-04:30	\N
\.


--
-- TOC entry 2444 (class 0 OID 42465)
-- Dependencies: 177
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo (id, id_almacen, id_usuario, id_cargo_tipo, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2445 (class 0 OID 42471)
-- Dependencies: 179
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cargo_tipo (id, nombre, nivel) FROM stdin;
\.


--
-- TOC entry 2446 (class 0 OID 42478)
-- Dependencies: 181
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, id_org, codigo, nombre, rif, telefono, fax, email, direccion, id_pais, id_estado, id_municipio, id_codigo_postal, coordenadas_utm, estatus, creado, modificado) FROM stdin;
1	1	00	AGROPATRIA	\N	\N	\N	\N	\N	1	1	1	\N	\N	t	2012-02-12 00:00:00-04:30	\N
2	1	56	ARAURE	J-123123	\N	\N	\N	GUARICO	1	18	227	\N	\N	t	2012-02-13 11:01:40.092295-04:30	2012-02-19 15:03:36.599-04:30
3	1	57	SABANA DE PARRA	J-123123	\N	\N	\N	Algun Lugar	1	1	1	\N	\N	t	2012-02-13 11:05:32.010896-04:30	\N
4	1	58	CHAGUARAMAS	J-123123	\N	\N	\N	Chaguaramas	1	1	1	\N	\N	t	2012-02-13 11:06:27.30781-04:30	\N
5	1	60	SABANETA	J-123123	\N	\N	\N	Zulia	1	2	2	\N	\N	t	2012-02-13 11:12:33.305226-04:30	\N
6	1	63	ZARAZA	J-123123	\N	\N	\N	Guarico	1	1	1	\N	\N	t	2012-02-13 11:25:07.723533-04:30	\N
7	1	67	MATURIN	\N	\N	\N	\N	\N	1	16	209	\N	\N	t	2012-02-19 15:23:43.873-04:30	\N
8	1	69	CALABOZO	\N	\N	\N	\N	\N	1	12	137	\N	\N	t	2012-02-19 15:35:00.425-04:30	2012-02-19 15:39:43.266-04:30
9	1	71	GUANARE	\N	\N	\N	\N	\N	1	18	229	\N	\N	t	2012-02-19 15:39:25.134-04:30	\N
\.


--
-- TOC entry 2447 (class 0 OID 42493)
-- Dependencies: 183
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cliente (id, id_org, id_sap, rif, ref, nombre, telefono, fax, email_org, edo_civil, nacionalidad, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, id_pais, id_estado, id_municipio, direccion, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2448 (class 0 OID 42502)
-- Dependencies: 185
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) FROM stdin;
2	2	1	\N	\N	\N	\N	\N	\N	t	2012-02-23 13:13:17.94223-04:30	\N	201201
3	2	2	\N	\N	\N	\N	\N	\N	t	2012-02-23 13:13:17.94223-04:30	\N	201202
4	3	3	SEGUNDA COSECHA	\N	\N	\N	2012-02-27	2012-09-28	t	2012-02-27 13:32:56.323501-04:30	\N	201203
\.


--
-- TOC entry 2449 (class 0 OID 42513)
-- Dependencies: 186
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) FROM stdin;
2	2	2	f	\N	\N	2
2	2	3	t	\N	\N	3
2	2	4	f	\N	\N	4
\.


--
-- TOC entry 2450 (class 0 OID 42518)
-- Dependencies: 188
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cuarentena (id, id_centro_acopio, id_analisis, id_cultivo, id_recepcion, id_despacho, tipo_mov, fecha_mov, fecha_cultivo, grado_infestacion, laboratorio, id_producto, toneladas, cant_producto, id_plaga, hora_trab, fecha_lib, hora_lib, estatus) FROM stdin;
17	2	0	1	2	\N	R	2012-03-09 10:55:40.62125-04:30	2012-03-09 10:55:40.62125-04:30	\N	C 	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 2451 (class 0 OID 42525)
-- Dependencies: 191
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) FROM stdin;
2	1	2               	ARROZ BLANCO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:30.631661-04:30	\N
3	1	3               	SORGO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:49.981169-04:30	\N
4	1	4               	SOYA HÚMEDA NACIONAL	f	\N	2012-02-18 15:23:05.361573-04:30	\N
7	1	7               	ARROZ BLANCO TOTAL	f	\N	2012-02-18 15:26:43.873325-04:30	\N
5	1	5               	MAÍZ AMARILLO HÚMEDO NACIONAL	f	\N	2012-02-18 15:23:20.129438-04:30	\N
6	1	6               	MAÍZ BLANCO SECO NACIONAL	f	\N	2012-02-18 15:23:55.551313-04:30	\N
8	1	8               	ARROZ PADDY ACONDICIONADO	f	\N	2012-02-18 15:27:07.455848-04:30	\N
1	1	1               	MAÍZ BLANCO HÚMEDO NACIONAL	f	\N	2012-02-18 15:22:10.224543-04:30	2012-02-22 09:02:31.725667-04:30
9	1	9               	GIRASOL	f	\N	2012-02-18 15:28:36.609786-04:30	\N
\.


--
-- TOC entry 2452 (class 0 OID 42533)
-- Dependencies: 193
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_denom_tip (id, id_org, id_cultivo, nombre_tipo_clase, valor, estatus) FROM stdin;
\.


--
-- TOC entry 2453 (class 0 OID 42537)
-- Dependencies: 194
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_despacho (id, id_centro_acopio, id_cultivo, id_orden, id_productor, id_chofer, id_vehiculo, id_usuario, id_transporte, id_punto_entrega, id_silo, fecha_des, numero, num_oca, kgr_oca, nu1_oca, kg1_oca, romana_vacia, fecha_vacia, peso01_vacio, peso02_vacio, romana_llena, fecha_liq, peso01_liq, peso02_liq, hum01_des, hum02_des, imp01_des, imp02_des, khu_01d, khu_02d, kim_01d, kim_02d, kac_des, estatus) FROM stdin;
\.


--
-- TOC entry 2454 (class 0 OID 42544)
-- Dependencies: 197
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ejes (id, id_org, nombre, capacidad) FROM stdin;
\.


--
-- TOC entry 2455 (class 0 OID 42551)
-- Dependencies: 199
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
-- TOC entry 2456 (class 0 OID 42555)
-- Dependencies: 200
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_finca (id, id_org, id_productor, id_pais, id_estado, id_municipio, id_agencia, nombre, direccion, area_siembra, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2457 (class 0 OID 42564)
-- Dependencies: 202
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) FROM stdin;
1	1	2	2	(PL1+PL2)	PL12	0	2	\N	\N	\N	\N
2	1	2	2	(PV1+PV2)	PV12	0	2	\N	\N	\N	\N
3	1	2	2	((PL1+PL2)-(PV1+PV2))	PN	0	2	\N	\N	\N	\N
\.


--
-- TOC entry 2458 (class 0 OID 42569)
-- Dependencies: 204
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) FROM stdin;
3	\N	\N	4	1234214	150000	\N	\N	V15610226       	2012-02-22 00:00:00-04:30	P	\N	\N	PEDRO PEREZ                                                                                                                                                                                                                                                    	2012-02-29 16:14:01.338074-04:30	\N
4	\N	\N	4	3452345	15000	\N	\N	V13654987       	2012-02-29 00:00:00-04:30	N	\N	\N	MARTIN RODRIGUEZ                                                                                                                                                                                                                                               	2012-02-29 16:17:14.272529-04:30	\N
5	\N	\N	4	987654	110000	\N	\N	V13852963       	2012-03-22 00:00:00-04:30	P	\N	\N	MARCOS PEREZ                                                                                                                                                                                                                                                   	2012-03-01 08:08:37.409028-04:30	\N
6	\N	\N	4	963852	20000	\N	\N	V13852963       	2012-03-15 00:00:00-04:30	P	\N	\N	MARCOS PEREZ                                                                                                                                                                                                                                                   	2012-03-01 08:10:00.987249-04:30	\N
2	\N	\N	4	12312	180000	\N	\N	V15610226       	2012-02-20 00:00:00-04:30	`	\N	\N	PEDRO PEREZ                                                                                                                                                                                                                                                    	2012-02-29 16:12:27.158984-04:30	\N
\.


--
-- TOC entry 2459 (class 0 OID 42574)
-- Dependencies: 205
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_guiarec_det (id, id_guiarec, id_rec, subguia, fecha, descripcion) FROM stdin;
\.


--
-- TOC entry 2460 (class 0 OID 42583)
-- Dependencies: 209
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
-- TOC entry 2461 (class 0 OID 42589)
-- Dependencies: 211
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) FROM stdin;
\.


--
-- TOC entry 2462 (class 0 OID 42596)
-- Dependencies: 212
-- Data for Name: si_mensajes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_mensajes (id, msg, tipo) FROM stdin;
\.


--
-- TOC entry 2463 (class 0 OID 42604)
-- Dependencies: 215
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) FROM stdin;
2	M_Procesos	0	\N	t	2	\N	\N
1	M_Maestros	0	\N	t	1	\N	\N
4	M_CtrolProcesos	0	\N	t	4	\N	\N
3	M_Reportes	0	\N	t	3	\N	\N
5	M_Cuenta	0	\N	t	5	\N	\N
11	M_Recepcion	2	admin/recepcion.php	t	1	\N	\N
12	M_Despacho	2	\N	t	2	\N	\N
6	M_CentrosA	1	admin/centros_acopio_listado.php	t	2	\N	\N
7	M_Cultivo	1	admin/cultivo_listado.php	t	6	\N	\N
8	M_Programas	1	admin/programa_listado.php	t	5	\N	\N
9	M_Silos	1	admin/silos_listado.php	t	4	\N	\N
10	M_Productor	1	admin/productor_listado.php	t	7	\N	\N
14	M_Cosecha	3	\N	t	2	\N	\N
15	M_Cultivo	3	\N	t	3	\N	\N
16	M_Productores	3	\N	t	4	\N	\N
13	M_Programas	3	\N	t	1	\N	\N
17	M_Recepciones	3	\N	t	5	\N	\N
18	M_Despacho	3	\N	t	6	\N	\N
19	M_Silos	4	\N	t	1	\N	\N
20	M_Usuarios	4	admin/usuarios_listado.php	t	2	\N	\N
21	M_Formulas	4	admin/formulacion.php	t	3	\N	\N
22	M_Configuracion	4	\N	t	4	\N	\N
23	M_ConfigCta	5	\N	t	1	\N	\N
24	M_Organizacion	1	admin/organizacion_listado.php	t	1	\N	\N
25	M_Almacenes	1	admin/almacen_listado.php	t	3	\N	\N
26	M_MenuUsuario	4	admin/menu_usuario.php	t	5	\N	\N
27	M_AnalisisRec	2	admin/analisis_recepcion_listado.php?estatus=1	t	3	\N	\N
28	M_Cuarentenas	2	admin/cuarentena_listado.php	t	\N	\N	\N
\.


--
-- TOC entry 2464 (class 0 OID 42609)
-- Dependencies: 216
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_menu_usuario (id_menu, id_usuario, id) FROM stdin;
1	1	1
3	1	2
4	1	3
5	1	4
24	1	5
6	1	6
7	1	7
8	1	8
9	1	9
13	1	10
14	1	11
15	1	12
16	1	13
17	1	14
18	1	15
19	1	16
20	1	17
21	1	18
22	1	19
23	1	20
1	2	21
7	2	22
8	2	23
9	2	24
10	2	25
25	1	26
25	2	27
26	1	28
2	3	29
27	3	30
2	4	31
11	4	32
4	2	33
21	2	34
28	3	35
\.


--
-- TOC entry 2465 (class 0 OID 42616)
-- Dependencies: 219
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
-- TOC entry 2466 (class 0 OID 42622)
-- Dependencies: 221
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_ordenes (id, id_centro_acopio, id_cliente, id_cultivo, numero_orden, tipo, fecha_emision, numero_contrato, toneladas, descuento, estatus) FROM stdin;
\.


--
-- TOC entry 2467 (class 0 OID 42629)
-- Dependencies: 223
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) FROM stdin;
1	AGROPATRIA	\N	J13769342	\N	\N	\N	\N	1	5	51	2012-02-12 00:00:00-04:30	2012-02-19 14:45:27.722-04:30	t	AGR
\.


--
-- TOC entry 2468 (class 0 OID 42638)
-- Dependencies: 225
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_pais (id, nombre) FROM stdin;
1	Venezuela
\.


--
-- TOC entry 2469 (class 0 OID 42644)
-- Dependencies: 227
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
2	MAX_RESULTS_PAG	20	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
1	SYSTEM_NAME	SIGESIL	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
3	LLAVE_PUBLICA	6LcExc0SAAAAAJQg0dDLm-g8_ckox0vYbS0l5xTD	Llave Publica del Recaptcha	1	2012-02-17	\N
4	LLAVE_PRIVADA	6LcExc0SAAAAAMz3zsKrd6QqHIqhh53z_U5kHdeF	Llave Privada	1	2012-02-17	\N
5	COSECHAS_PROGRAMA	3	Cantidad de Cosechas por Programa	1	2012-02-20	\N
6	PL1	Peso Lleno 1	Peso de la Muestra 1	1	2012-03-01	\N
7	PL2	Peso Lleno 2	Peso de la Muestra 2	1	2012-03-01	\N
8	PV1	Peso Vacio 1	Peso Vac&iacute;o de la Muestra 1	1	2012-03-01	\N
9	PV2	Peso Vacio 2	Peso Vac&iacute;o de la Muestra 2	1	2012-03-01	\N
10	IMPL	Impurezas de Laboratorio	Impurezas de Laboratorio	1	2012-03-01	\N
11	HUML	Humedad de Laboratorio	Humedad de Laboratorio	1	2012-03-01	\N
\.


--
-- TOC entry 2470 (class 0 OID 42653)
-- Dependencies: 229
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_perfiles (id, nombre_perfil, creado, modificado) FROM stdin;
1	GERENTE GENERAL	2012-02-07	\N
2	GERENTE	2012-02-07	\N
3	ADMINISTRADOR	2012-02-07	\N
4	CALIDAD	2012-02-07	\N
5	ROMANERO	2012-02-07	\N
6	RECEPCION	2012-02-07	\N
7	DESPACHO	2012-02-07	\N
\.


--
-- TOC entry 2471 (class 0 OID 42657)
-- Dependencies: 230
-- Data for Name: si_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_plaga (id, id_org, nombre, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2472 (class 0 OID 42662)
-- Dependencies: 232
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_producto (id, id_org, numero, nombre, presentacion, dosis, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2473 (class 0 OID 42669)
-- Dependencies: 235
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) FROM stdin;
2	\N	\N	V18264065       	\N	JESUS RODRIGUEZ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:12:27.158984-04:30	2012-02-29 16:14:01.338074-04:30
3	\N	\N	V17247200       	\N	ENDER HIGUERA	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:17:14.272529-04:30	\N
4	\N	\N	V15610226       	\N	RONALD BANCO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-03-01 08:08:37.409028-04:30	2012-03-01 08:10:00.987249-04:30
\.


--
-- TOC entry 2474 (class 0 OID 42678)
-- Dependencies: 237
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo) FROM stdin;
2	2	PRIMER PROGRAMA	\N	2012-02-23 13:13:17.94223-04:30	\N	t	PR1
3	2	SEGUNDO PROGRAMA	\N	2012-02-27 13:32:56.323501-04:30	\N	t	PR2
\.


--
-- TOC entry 2475 (class 0 OID 42685)
-- Dependencies: 238
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_proveedor (id, nombre, telefono, email, ubicacion) FROM stdin;
\.


--
-- TOC entry 2476 (class 0 OID 42693)
-- Dependencies: 240
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_punto_entrega (id, id_cliente, id_pais, id_estado, id_municipio, numero, nombre, telefono, direccion, estatus, creado, modificado) FROM stdin;
\.


--
-- TOC entry 2477 (class 0 OID 42701)
-- Dependencies: 242
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) FROM stdin;
3	2	2	2	2	\N	3	4	2	2012-02-29 16:14:01.338074-04:30	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:14:01.338074-04:30	2012-03-09 13:34:51.560415	2	3
4	2	2	2	3	2	4	4	3	2012-02-29 16:17:14.272529-04:30	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:17:14.272529-04:30	2012-03-09 15:09:42.098226	2	4
5	2	2	2	4	\N	5	4	4	2012-03-01 08:08:37.409028-04:30	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-03-01 08:08:37.409028-04:30	2012-03-09 15:19:00.35981	2	5
6	2	2	2	4	\N	6	4	5	2012-03-01 08:10:00.987249-04:30	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-03-01 08:10:00.987249-04:30	2012-03-09 15:29:44.661086	2	6
2	2	2	2	2	\N	2	4	1	2012-02-29 16:12:27.158984-04:30	1	7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012-02-29 16:12:27.158984-04:30	2012-03-10 10:04:05.026462	2	2
\.


--
-- TOC entry 2478 (class 0 OID 42707)
-- Dependencies: 244
-- Data for Name: si_recursos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) FROM stdin;
2	Index	pages	index.php	0	2012-03-06 09:37:24.898959-04:30	\N
1	Global	\N	\N	0	2012-03-06 09:19:38.843861-04:30	\N
3	Analisis de Resultados	admin	analisis_recepcion.php	1	2012-03-06 00:00:00-04:30	\N
\.


--
-- TOC entry 2479 (class 0 OID 42714)
-- Dependencies: 245
-- Data for Name: si_recursos_etiquetas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) FROM stdin;
1	1	txtUsuario	Usuario	1	2012-03-06 09:37:56.586579-04:30	\N
2	1	txtContrasena	Contrase&ntilde;a	1	2012-03-06 09:37:56.586579-04:30	\N
3	1	txtEntrar	Entrar	1	2012-03-06 09:42:42.170218-04:30	\N
4	1	txtCancelar	Cancelar	1	2012-03-06 09:42:42.170218-04:30	\N
5	1	txtPiePagina	Sistema de Gesti&oacute;n de Silos - SIGESIL<br/>&copy; 2012 Todos los Derechos Reservados.<br/><br/>	1	2012-03-06 09:52:09.440852-04:30	\N
6	2	loginerror	Usuario y/o Contrase&ntilde;a Inv&aacute;lidos	0	2012-03-06 09:57:57.901245-04:30	\N
7	2	auth_requerida	Debe Iniciar Sesi&oacute;n	0	2012-03-06 09:57:57.901245-04:30	\N
8	2	usuario_inactivo	Usuario y/o Centro de Acopio Inactivo	0	2012-03-06 09:57:57.901245-04:30	\N
9	2	captcha_invalido	Captcha Inv&aacute;lido	0	2012-03-06 09:57:57.901245-04:30	\N
10	2	captcha_vacio	Debe introducir el Captcha	0	2012-03-06 09:57:57.901245-04:30	\N
11	1	E_NO40TNA	Existen analisis fuera de norma la muestra sera rechazada , NO SE ENVIARA A CUARENTENA	1	2012-03-06 00:00:00-04:30	\N
12	1	M_Maestros	Maestros	1	2012-03-06 00:00:00-04:30	\N
13	1	M_Procesos	Procesos	1	2012-03-06 00:00:00-04:30	\N
14	1	M_Reportes	Reportes	1	2012-03-06 10:24:33.951075-04:30	\N
15	1	M_CtrolProcesos	Ctrol de Procesos	1	2012-03-06 10:43:26.712496-04:30	\N
16	1	M_Cuenta	Cuenta	1	2012-03-06 10:43:26.712496-04:30	\N
17	1	M_CentrosA	Centros de Acopio	1	2012-03-06 10:43:26.712496-04:30	\N
18	1	M_Cultivo	Cultivo	1	2012-03-06 10:43:26.712496-04:30	\N
19	1	M_Programas	Programas	1	2012-03-06 10:43:26.712496-04:30	\N
20	1	M_Silos	Silos	1	2012-03-06 10:43:26.712496-04:30	\N
21	1	M_Productor	Productor	1	2012-03-06 10:43:26.712496-04:30	\N
22	1	M_Recepcion	Recepci&oacute;n	1	2012-03-06 10:43:26.712496-04:30	\N
23	1	M_Despacho	Despacho	1	2012-03-06 10:43:26.712496-04:30	\N
24	1	M_Programa	Programas	1	2012-03-06 10:43:26.712496-04:30	\N
25	1	M_Cosecha	Cosechas	1	2012-03-06 10:43:26.712496-04:30	\N
26	1	M_Cultivo	Cultivos	1	2012-03-06 10:43:26.712496-04:30	\N
27	1	M_Productores	Productores	1	2012-03-06 10:43:26.712496-04:30	\N
28	1	M_Recepciones	Recepciones	1	2012-03-06 10:43:26.712496-04:30	\N
29	1	M_Despacho	Despacho	1	2012-03-06 10:43:26.712496-04:30	\N
30	1	M_Silos	Silos	1	2012-03-06 10:43:26.712496-04:30	\N
31	1	M_Usuarios	Usuarios	1	2012-03-06 10:43:26.712496-04:30	\N
33	1	M_Configuracion	Configuraci&oacute;n	1	2012-03-06 10:43:26.712496-04:30	\N
34	1	M_ConfigCta	Config. Cuenta	1	2012-03-06 10:43:26.712496-04:30	\N
35	1	M_Organizacion	Organizaciones	1	2012-03-06 10:43:26.712496-04:30	\N
36	1	M_Almacenes	Almacenes	1	2012-03-06 10:43:26.712496-04:30	\N
37	1	M_MenuUsuario	Menu - Usuario	1	2012-03-06 10:43:26.712496-04:30	\N
39	1	M_Cuarentenas	Cuarentenas	1	2012-03-06 10:43:26.712496-04:30	\N
32	1	M_Formulas	F&oacute;rmulas	1	2012-03-06 10:43:26.712496-04:30	\N
40	3	E_FueraNorma	El valor indicado está fuera de norma.!!!	0	2012-03-06 00:00:00-04:30	\N
38	1	M_AnalisisRec	Resultados de Lab.	1	2012-03-06 10:43:26.712496-04:30	\N
\.


--
-- TOC entry 2480 (class 0 OID 42727)
-- Dependencies: 249
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, id_almacen, nombre, coordenada, codigo, capacidad, observacion, estatus, modulo, creado, modificado) FROM stdin;
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
-- TOC entry 2481 (class 0 OID 42738)
-- Dependencies: 251
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_tolcarom (id, id_centro_acopio, nombre, numero, tipo, estatus, creado, modificiado) FROM stdin;
\.


--
-- TOC entry 2482 (class 0 OID 42744)
-- Dependencies: 252
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_transporte (id, id_centro_acopio, rif, nombre, contacto, direccion, telefono1, telefono2, fax, email, id_pais, id_estado, id_municipio) FROM stdin;
\.


--
-- TOC entry 2483 (class 0 OID 42754)
-- Dependencies: 255
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) FROM stdin;
3	JUAN	TABORDA	13769341	\N	M	JTABORDA                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	juantaborda@agropatria.co.ve	2012-02-13	2012-02-17	t	1	2jjfrd1d6kop9dgde5j1mk3hb3	2012-03-10 11:46:10.620144-04:30
4	JESUS	RODRIGUEZ	18264065	\N	M	JRODRIGUEZ                      	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesusrodriguez@agropatria.co.ve	2012-02-13	2012-02-13	t	0	\N	2012-03-09 12:13:53.934538-04:30
1	JOSE	PELUZZO	1234567	2012-02-12	M	JPELUZZO                        	40bd001563085fc35165329ea1ff5c5ecbdbbeef	Maracay	\N	josepeluzzo@agropatria.co.ve	2012-02-12	\N	t	1	jujj3c73vjeqo9rpsr1d6q4gu1	2012-03-09 15:28:13.132038-04:30
2	JESUS	SILVA	9668397	1970-09-01	M	JSILVA                          	40bd001563085fc35165329ea1ff5c5ecbdbbeef	\N	\N	jesussilva@agropatria.co.ve	2012-02-13	2012-02-13	t	1	66i2o67s9601mdsestnci82np5	2012-03-12 00:23:27.503-04:30
\.


--
-- TOC entry 2484 (class 0 OID 42765)
-- Dependencies: 257
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) FROM stdin;
1	1	1	1	2012-02-13 00:00:00-04:30	\N
2	2	2	2	2012-02-13 11:34:56.142546-04:30	\N
3	3	2	4	2012-02-13 15:00:02.192211-04:30	2012-02-17 11:06:46.723921-04:30
4	4	2	6	2012-02-13 16:15:23.105604-04:30	\N
\.


--
-- TOC entry 2485 (class 0 OID 42769)
-- Dependencies: 258
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) FROM stdin;
2	ASD-ASD         	\N	\N	\N	\N	\N	\N	2012-02-29 16:12:27.158984-04:30	\N
3	ASD-123         	\N	\N	\N	\N	\N	\N	2012-02-29 16:14:01.338074-04:30	\N
4	QWE-ASD         	\N	\N	\N	\N	\N	\N	2012-02-29 16:17:14.272529-04:30	\N
5	QWE-ASD         	\N	\N	\N	\N	\N	\N	2012-03-01 08:08:37.409028-04:30	\N
6	ASD-ASD         	\N	\N	\N	\N	\N	\N	2012-03-01 08:10:00.987249-04:30	\N
\.


--
-- TOC entry 2259 (class 2606 OID 42797)
-- Dependencies: 173 173
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2293 (class 2606 OID 42799)
-- Dependencies: 209 209
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2247 (class 2606 OID 42801)
-- Dependencies: 162 162
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 42803)
-- Dependencies: 165 165
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2255 (class 2606 OID 42805)
-- Dependencies: 167 167
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 42807)
-- Dependencies: 164 164 164
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2251 (class 2606 OID 42809)
-- Dependencies: 164 164
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2257 (class 2606 OID 42811)
-- Dependencies: 171 171
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2261 (class 2606 OID 42813)
-- Dependencies: 175 175
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2263 (class 2606 OID 42815)
-- Dependencies: 177 177
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2265 (class 2606 OID 42817)
-- Dependencies: 179 179
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2267 (class 2606 OID 42819)
-- Dependencies: 181 181
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2269 (class 2606 OID 42821)
-- Dependencies: 183 183
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2271 (class 2606 OID 42823)
-- Dependencies: 185 185
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2273 (class 2606 OID 42825)
-- Dependencies: 188 188
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2275 (class 2606 OID 42827)
-- Dependencies: 191 191
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2277 (class 2606 OID 42829)
-- Dependencies: 193 193
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 42831)
-- Dependencies: 194 194
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2281 (class 2606 OID 42833)
-- Dependencies: 197 197
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2283 (class 2606 OID 42835)
-- Dependencies: 199 199
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2285 (class 2606 OID 42837)
-- Dependencies: 200 200
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 42839)
-- Dependencies: 202 202
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 42841)
-- Dependencies: 204 204
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2291 (class 2606 OID 42843)
-- Dependencies: 205 205
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2295 (class 2606 OID 42845)
-- Dependencies: 211 211
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2297 (class 2606 OID 42847)
-- Dependencies: 215 215
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 42849)
-- Dependencies: 216 216 216
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2301 (class 2606 OID 42851)
-- Dependencies: 219 219
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2303 (class 2606 OID 42853)
-- Dependencies: 221 221
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2305 (class 2606 OID 42855)
-- Dependencies: 223 223
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2307 (class 2606 OID 42857)
-- Dependencies: 225 225
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2309 (class 2606 OID 42859)
-- Dependencies: 227 227
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2311 (class 2606 OID 42861)
-- Dependencies: 229 229
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2313 (class 2606 OID 42863)
-- Dependencies: 230 230
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2315 (class 2606 OID 42865)
-- Dependencies: 232 232
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 42867)
-- Dependencies: 235 235
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2319 (class 2606 OID 42869)
-- Dependencies: 237 237
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2321 (class 2606 OID 42871)
-- Dependencies: 238 238
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2323 (class 2606 OID 42873)
-- Dependencies: 240 240
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2325 (class 2606 OID 42875)
-- Dependencies: 242 242
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2329 (class 2606 OID 42877)
-- Dependencies: 245 245
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2327 (class 2606 OID 42879)
-- Dependencies: 244 244
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2331 (class 2606 OID 42881)
-- Dependencies: 249 249
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2333 (class 2606 OID 42883)
-- Dependencies: 251 251
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2335 (class 2606 OID 42885)
-- Dependencies: 252 252
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2341 (class 2606 OID 42887)
-- Dependencies: 257 257
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2337 (class 2606 OID 42889)
-- Dependencies: 255 255
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2339 (class 2606 OID 42891)
-- Dependencies: 255 255
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2343 (class 2606 OID 42893)
-- Dependencies: 258 258
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2344 (class 2606 OID 42894)
-- Dependencies: 181 2266 162
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2345 (class 2606 OID 42899)
-- Dependencies: 199 162 2282
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2346 (class 2606 OID 42904)
-- Dependencies: 2300 219 162
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2347 (class 2606 OID 42909)
-- Dependencies: 162 225 2306
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2349 (class 2606 OID 42914)
-- Dependencies: 165 2250 164
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2350 (class 2606 OID 42919)
-- Dependencies: 2266 181 165
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2351 (class 2606 OID 42924)
-- Dependencies: 164 2250 167
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2352 (class 2606 OID 42929)
-- Dependencies: 167 2304 223
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2353 (class 2606 OID 42934)
-- Dependencies: 2250 169 164
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2354 (class 2606 OID 42939)
-- Dependencies: 169 223 2304
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2348 (class 2606 OID 42944)
-- Dependencies: 164 223 2304
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2355 (class 2606 OID 42949)
-- Dependencies: 2250 171 164
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2356 (class 2606 OID 42954)
-- Dependencies: 2278 171 194
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2357 (class 2606 OID 42959)
-- Dependencies: 242 171 2324
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2358 (class 2606 OID 42964)
-- Dependencies: 255 2336 171
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2359 (class 2606 OID 42969)
-- Dependencies: 199 2282 175
-- Name: si_asociado_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2360 (class 2606 OID 42974)
-- Dependencies: 219 2300 175
-- Name: si_asociado_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2361 (class 2606 OID 42979)
-- Dependencies: 175 225 2306
-- Name: si_asociado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2362 (class 2606 OID 42984)
-- Dependencies: 2316 175 235
-- Name: si_asociado_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2363 (class 2606 OID 42989)
-- Dependencies: 177 2246 162
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2364 (class 2606 OID 42994)
-- Dependencies: 2264 179 177
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2365 (class 2606 OID 42999)
-- Dependencies: 255 2336 177
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2366 (class 2606 OID 43004)
-- Dependencies: 181 2282 199
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2367 (class 2606 OID 43009)
-- Dependencies: 219 2300 181
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2368 (class 2606 OID 43014)
-- Dependencies: 181 223 2304
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2369 (class 2606 OID 43019)
-- Dependencies: 2306 181 225
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2370 (class 2606 OID 43024)
-- Dependencies: 223 183 2304
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2371 (class 2606 OID 43029)
-- Dependencies: 191 185 2274
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2372 (class 2606 OID 43034)
-- Dependencies: 237 185 2318
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2373 (class 2606 OID 43039)
-- Dependencies: 181 2266 186
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2374 (class 2606 OID 43044)
-- Dependencies: 2270 186 185
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2375 (class 2606 OID 43049)
-- Dependencies: 235 186 2316
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2376 (class 2606 OID 43054)
-- Dependencies: 2304 223 191
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2377 (class 2606 OID 43059)
-- Dependencies: 2274 191 193
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2378 (class 2606 OID 43064)
-- Dependencies: 193 2304 223
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2379 (class 2606 OID 43069)
-- Dependencies: 194 2266 181
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2380 (class 2606 OID 43074)
-- Dependencies: 194 2274 191
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2381 (class 2606 OID 43079)
-- Dependencies: 194 221 2302
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2382 (class 2606 OID 43084)
-- Dependencies: 2316 194 235
-- Name: si_despacho_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2383 (class 2606 OID 43089)
-- Dependencies: 194 2322 240
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2384 (class 2606 OID 43094)
-- Dependencies: 249 2330 194
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2385 (class 2606 OID 43099)
-- Dependencies: 2334 194 252
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2386 (class 2606 OID 43104)
-- Dependencies: 255 194 2336
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2387 (class 2606 OID 43109)
-- Dependencies: 258 2342 194
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2388 (class 2606 OID 43114)
-- Dependencies: 2304 197 223
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2389 (class 2606 OID 43119)
-- Dependencies: 2306 225 199
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2390 (class 2606 OID 43124)
-- Dependencies: 199 2282 200
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2391 (class 2606 OID 43129)
-- Dependencies: 219 200 2300
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2392 (class 2606 OID 43134)
-- Dependencies: 200 2304 223
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2393 (class 2606 OID 43139)
-- Dependencies: 200 2306 225
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2394 (class 2606 OID 43144)
-- Dependencies: 200 2316 235
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2395 (class 2606 OID 43149)
-- Dependencies: 181 2266 202
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2396 (class 2606 OID 43154)
-- Dependencies: 202 2274 191
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2397 (class 2606 OID 43159)
-- Dependencies: 223 2304 202
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2398 (class 2606 OID 43164)
-- Dependencies: 204 255 2336
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2399 (class 2606 OID 43169)
-- Dependencies: 2288 204 205
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2400 (class 2606 OID 43174)
-- Dependencies: 211 2292 209
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2401 (class 2606 OID 43179)
-- Dependencies: 216 215 2296
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2402 (class 2606 OID 43184)
-- Dependencies: 2336 216 255
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2403 (class 2606 OID 43189)
-- Dependencies: 219 2282 199
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2404 (class 2606 OID 43194)
-- Dependencies: 221 2266 181
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2405 (class 2606 OID 43199)
-- Dependencies: 183 2268 221
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2406 (class 2606 OID 43204)
-- Dependencies: 221 191 2274
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2407 (class 2606 OID 43209)
-- Dependencies: 199 223 2282
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2408 (class 2606 OID 43214)
-- Dependencies: 2300 219 223
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2409 (class 2606 OID 43219)
-- Dependencies: 2306 223 225
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2410 (class 2606 OID 43224)
-- Dependencies: 230 223 2304
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2411 (class 2606 OID 43229)
-- Dependencies: 232 223 2304
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2412 (class 2606 OID 43234)
-- Dependencies: 2282 199 235
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2413 (class 2606 OID 43239)
-- Dependencies: 2300 235 219
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2414 (class 2606 OID 43244)
-- Dependencies: 235 223 2304
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2415 (class 2606 OID 43249)
-- Dependencies: 235 225 2306
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2416 (class 2606 OID 43254)
-- Dependencies: 237 181 2266
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2417 (class 2606 OID 43259)
-- Dependencies: 240 183 2268
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2418 (class 2606 OID 43264)
-- Dependencies: 2282 199 240
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2419 (class 2606 OID 43269)
-- Dependencies: 240 219 2300
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2420 (class 2606 OID 43274)
-- Dependencies: 2306 240 225
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2421 (class 2606 OID 43279)
-- Dependencies: 175 242 2260
-- Name: si_recepcion_id_asociado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);


--
-- TOC entry 2422 (class 2606 OID 43284)
-- Dependencies: 181 2266 242
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2423 (class 2606 OID 43289)
-- Dependencies: 185 242 2270
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2424 (class 2606 OID 43294)
-- Dependencies: 242 2288 204
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2425 (class 2606 OID 43299)
-- Dependencies: 235 242 2316
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2426 (class 2606 OID 43304)
-- Dependencies: 242 249 2330
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2427 (class 2606 OID 43309)
-- Dependencies: 242 2336 255
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2428 (class 2606 OID 43314)
-- Dependencies: 244 2326 245
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2429 (class 2606 OID 43319)
-- Dependencies: 249 162 2246
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2430 (class 2606 OID 43324)
-- Dependencies: 2266 181 249
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2431 (class 2606 OID 43329)
-- Dependencies: 251 181 2266
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2432 (class 2606 OID 43334)
-- Dependencies: 252 181 2266
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2433 (class 2606 OID 43339)
-- Dependencies: 257 2246 162
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2434 (class 2606 OID 43344)
-- Dependencies: 2310 229 257
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2435 (class 2606 OID 43349)
-- Dependencies: 257 2336 255
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-03-12 00:57:31

--
-- PostgreSQL database dump complete
--

