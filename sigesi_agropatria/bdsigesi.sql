--
-- PostgreSQL database dump
--

-- Started on 2012-03-16 11:05:54 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 140 (class 1259 OID 26210)
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
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 140
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 141 (class 1259 OID 26212)
-- Dependencies: 2100 6
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
-- TOC entry 142 (class 1259 OID 26219)
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
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 142
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);


--
-- TOC entry 143 (class 1259 OID 26221)
-- Dependencies: 2101 2102 2103 6
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
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 143
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 144 (class 1259 OID 26227)
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
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 145 (class 1259 OID 26230)
-- Dependencies: 144 6
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
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 146 (class 1259 OID 26232)
-- Dependencies: 2105 2106 2107 2108 2109 2110 6
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
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 147 (class 1259 OID 26241)
-- Dependencies: 146 6
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
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 63, true);


--
-- TOC entry 148 (class 1259 OID 26243)
-- Dependencies: 2112 6
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
-- TOC entry 149 (class 1259 OID 26247)
-- Dependencies: 6 148
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
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_des_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_des_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);


--
-- TOC entry 150 (class 1259 OID 26249)
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
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 151 (class 1259 OID 26252)
-- Dependencies: 6 150
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
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 2668, true);


--
-- TOC entry 152 (class 1259 OID 26254)
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
-- TOC entry 153 (class 1259 OID 26260)
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
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 153
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 3, true);


--
-- TOC entry 154 (class 1259 OID 26262)
-- Dependencies: 2115 6
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
-- TOC entry 155 (class 1259 OID 26269)
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
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 155
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);


--
-- TOC entry 156 (class 1259 OID 26271)
-- Dependencies: 2116 6
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
-- TOC entry 157 (class 1259 OID 26275)
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
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 157
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);


--
-- TOC entry 158 (class 1259 OID 26277)
-- Dependencies: 2117 2118 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 159 (class 1259 OID 26282)
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
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 160 (class 1259 OID 26284)
-- Dependencies: 2119 2120 2121 2122 2123 2124 2125 6
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
-- TOC entry 238 (class 1259 OID 27360)
-- Dependencies: 6
-- Name: si_choferes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_choferes (
    id bigint NOT NULL,
    id_org bigint,
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    cedula character(16) NOT NULL,
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
-- TOC entry 237 (class 1259 OID 27358)
-- Dependencies: 238 6
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
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 237
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 1, false);


--
-- TOC entry 161 (class 1259 OID 26297)
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
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 161
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);


--
-- TOC entry 162 (class 1259 OID 26299)
-- Dependencies: 2126 6
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
-- TOC entry 163 (class 1259 OID 26306)
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
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 163
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 10, true);


--
-- TOC entry 164 (class 1259 OID 26308)
-- Dependencies: 2127 2128 2129 2130 2131 6
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
-- TOC entry 165 (class 1259 OID 26319)
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
-- TOC entry 166 (class 1259 OID 26322)
-- Dependencies: 165 6
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
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 5, true);


--
-- TOC entry 232 (class 1259 OID 27169)
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
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 231 (class 1259 OID 27167)
-- Dependencies: 6 232
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
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 231
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);


--
-- TOC entry 236 (class 1259 OID 27327)
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
    estatus character(2),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cuarentena OWNER TO admin;

--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 236
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
-- TOC entry 235 (class 1259 OID 27325)
-- Dependencies: 236 6
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
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 235
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 26329)
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
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 167
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 168 (class 1259 OID 26331)
-- Dependencies: 2133 2134 2135 6
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
-- TOC entry 240 (class 1259 OID 27366)
-- Dependencies: 2187 2188 6
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
-- TOC entry 239 (class 1259 OID 27364)
-- Dependencies: 240 6
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
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 26337)
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
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 169
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);


--
-- TOC entry 170 (class 1259 OID 26339)
-- Dependencies: 2136 6
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
-- TOC entry 171 (class 1259 OID 26343)
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
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE si_despacho; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_despacho IS 'Tabla de Recepción

Estatus:
1.- Romana
2.- Lab
3.- Romana Vacio
4.- Rechazado
5.- Despachado';


--
-- TOC entry 172 (class 1259 OID 26346)
-- Dependencies: 171 6
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
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 26348)
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
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 173
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);


--
-- TOC entry 174 (class 1259 OID 26350)
-- Dependencies: 2138 2139 6
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
-- TOC entry 175 (class 1259 OID 26355)
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
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 176 (class 1259 OID 26357)
-- Dependencies: 2140 6
-- Name: si_estado; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_estado OWNER TO admin;

--
-- TOC entry 177 (class 1259 OID 26361)
-- Dependencies: 2141 6
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
-- TOC entry 178 (class 1259 OID 26368)
-- Dependencies: 6 177
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
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 26370)
-- Dependencies: 6
-- Name: si_formulas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_formulas (
    id bigint NOT NULL,
    id_org bigint,
    id_centro_acopio bigint,
    id_cultivo bigint NOT NULL,
    formula character varying(255) NOT NULL,
    codigo character varying(11) NOT NULL,
    id_mov bigint NOT NULL,
    tipo_for bigint NOT NULL,
    condicion character varying(20),
    creado timestamp with time zone,
    modificado timestamp with time zone,
    id_analisis bigint
);


ALTER TABLE public.si_formulas OWNER TO admin;

--
-- TOC entry 180 (class 1259 OID 26373)
-- Dependencies: 6 179
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
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 9, true);


--
-- TOC entry 181 (class 1259 OID 26375)
-- Dependencies: 2144 2145 6
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
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 182 (class 1259 OID 26380)
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
-- TOC entry 183 (class 1259 OID 26383)
-- Dependencies: 6 182
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
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 183
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 9, true);


--
-- TOC entry 184 (class 1259 OID 26385)
-- Dependencies: 181 6
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
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 13, true);


--
-- TOC entry 185 (class 1259 OID 26387)
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
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 185
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 186 (class 1259 OID 26389)
-- Dependencies: 2148 6
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
-- TOC entry 187 (class 1259 OID 26393)
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 187
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 1, true);


--
-- TOC entry 188 (class 1259 OID 26395)
-- Dependencies: 2149 6
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
-- TOC entry 189 (class 1259 OID 26408)
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
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 28, true);


--
-- TOC entry 190 (class 1259 OID 26410)
-- Dependencies: 2150 2151 6
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
-- TOC entry 191 (class 1259 OID 26415)
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
-- TOC entry 192 (class 1259 OID 26418)
-- Dependencies: 191 6
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
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_menu_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_usuario_id_seq', 35, true);


--
-- TOC entry 193 (class 1259 OID 26420)
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
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 194 (class 1259 OID 26422)
-- Dependencies: 2153 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 195 (class 1259 OID 26426)
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
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 26428)
-- Dependencies: 2154 2155 6
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
-- TOC entry 197 (class 1259 OID 26433)
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
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 198 (class 1259 OID 26435)
-- Dependencies: 2156 6
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
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 199 (class 1259 OID 26442)
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
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 199
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 200 (class 1259 OID 26444)
-- Dependencies: 2157 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 201 (class 1259 OID 26448)
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
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 201
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 202 (class 1259 OID 26450)
-- Dependencies: 2158 6
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
-- TOC entry 203 (class 1259 OID 26457)
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
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 203
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 204 (class 1259 OID 26459)
-- Dependencies: 2159 6
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
-- TOC entry 205 (class 1259 OID 26463)
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
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 206 (class 1259 OID 26466)
-- Dependencies: 6 205
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
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 234 (class 1259 OID 27194)
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
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 233 (class 1259 OID 27192)
-- Dependencies: 234 6
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
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 207 (class 1259 OID 26473)
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
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 207
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 5, true);


--
-- TOC entry 208 (class 1259 OID 26475)
-- Dependencies: 2161 6
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
-- TOC entry 209 (class 1259 OID 26482)
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
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 209
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 8, true);


--
-- TOC entry 210 (class 1259 OID 26484)
-- Dependencies: 2162 6
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
-- TOC entry 244 (class 1259 OID 27387)
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
-- TOC entry 243 (class 1259 OID 27385)
-- Dependencies: 6 244
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
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 243
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);


--
-- TOC entry 211 (class 1259 OID 26499)
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
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 212 (class 1259 OID 26505)
-- Dependencies: 6 211
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
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);


--
-- TOC entry 213 (class 1259 OID 26507)
-- Dependencies: 2164 6
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
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 213
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
9.- Acondicionado';


--
-- TOC entry 242 (class 1259 OID 27374)
-- Dependencies: 6
-- Name: si_recepcion_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_recepcion_cultivo_tipo (
    id bigint NOT NULL,
    id_recepcion bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    laboratorio character(2) NOT NULL,
    tipo character(2) NOT NULL
);


ALTER TABLE public.si_recepcion_cultivo_tipo OWNER TO admin;

--
-- TOC entry 241 (class 1259 OID 27372)
-- Dependencies: 6 242
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 241
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 214 (class 1259 OID 26511)
-- Dependencies: 6 213
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
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 214
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 10, true);


--
-- TOC entry 215 (class 1259 OID 26513)
-- Dependencies: 2166 6
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
-- TOC entry 216 (class 1259 OID 26520)
-- Dependencies: 2168 6
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
-- TOC entry 217 (class 1259 OID 26527)
-- Dependencies: 6 216
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
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 43, true);


--
-- TOC entry 218 (class 1259 OID 26529)
-- Dependencies: 6 215
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
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 3, true);


--
-- TOC entry 219 (class 1259 OID 26531)
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
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 219
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 85, true);


--
-- TOC entry 220 (class 1259 OID 26533)
-- Dependencies: 2170 2171 2172 6
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
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 221 (class 1259 OID 26542)
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
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 221
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 1, false);


--
-- TOC entry 222 (class 1259 OID 26544)
-- Dependencies: 2173 2174 2175 6
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
-- TOC entry 223 (class 1259 OID 26550)
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 224 (class 1259 OID 26556)
-- Dependencies: 223 6
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
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 224
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);


--
-- TOC entry 225 (class 1259 OID 26558)
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
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 225
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 6, true);


--
-- TOC entry 226 (class 1259 OID 26560)
-- Dependencies: 2177 2178 2179 6
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
    creado timestamp with time zone,
    modificado timestamp with time zone,
    estatus boolean DEFAULT true NOT NULL,
    conectado smallint DEFAULT 0 NOT NULL,
    sesion character varying(255),
    ultimo_acceso timestamp with time zone
);


ALTER TABLE public.si_usuarios OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 26569)
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 227
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 6, true);


--
-- TOC entry 228 (class 1259 OID 26571)
-- Dependencies: 2180 6
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
-- TOC entry 229 (class 1259 OID 26575)
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
-- TOC entry 230 (class 1259 OID 26578)
-- Dependencies: 6 229
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
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 230
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 9, true);


--
-- TOC entry 2104 (class 2604 OID 26580)
-- Dependencies: 145 144
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2111 (class 2604 OID 26581)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2113 (class 2604 OID 26582)
-- Dependencies: 149 148
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);


--
-- TOC entry 2114 (class 2604 OID 26583)
-- Dependencies: 151 150
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 27363)
-- Dependencies: 237 238 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2132 (class 2604 OID 26584)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 27172)
-- Dependencies: 231 232 232
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 27330)
-- Dependencies: 235 236 236
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 27369)
-- Dependencies: 240 239 240
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2137 (class 2604 OID 26586)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2142 (class 2604 OID 26587)
-- Dependencies: 178 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2143 (class 2604 OID 26588)
-- Dependencies: 180 179
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 26589)
-- Dependencies: 184 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2147 (class 2604 OID 26590)
-- Dependencies: 183 182
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2152 (class 2604 OID 26592)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);


--
-- TOC entry 2160 (class 2604 OID 26593)
-- Dependencies: 206 205
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 27197)
-- Dependencies: 233 234 234
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 27390)
-- Dependencies: 243 244 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2163 (class 2604 OID 26596)
-- Dependencies: 212 211
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 26597)
-- Dependencies: 214 213
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2189 (class 2604 OID 27377)
-- Dependencies: 242 241 242
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 26598)
-- Dependencies: 218 215
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 26599)
-- Dependencies: 217 216
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2176 (class 2604 OID 26600)
-- Dependencies: 224 223
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 26601)
-- Dependencies: 230 229
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2410 (class 0 OID 26212)
-- Dependencies: 141
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
INSERT INTO si_almacenes (id, id_centro_acopio, nombre, direccion, id_pais, id_estado, id_municipio, telefono, fax, email, estatus, coordenadas_utm, creado, modificado, id_tipo_almacen, codigo) VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '2');


--
-- TOC entry 2411 (class 0 OID 26221)
-- Dependencies: 143
-- Data for Name: si_analisis; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (8, 1, 'GRANOS PARTIDOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '8', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (9, 1, 'GRANOS CRISTALIZADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '9', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (10, 1, 'GRANOS QUEMADOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '10', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (11, 1, 'GRANOS AMILACEOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '11', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (12, 1, 'MEZCLA DE COLOR EN BLANCO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '12', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (13, 1, 'PESO ESPECIFICO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '13', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (14, 1, 'SEMILLAS OBJETABLES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '14', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (19, 1, 'COLOR', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '22', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (18, 1, 'OLOR', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '21', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (4, 1, 'GRANOS DAÑADO POR HONGOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '4', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (5, 1, 'GRANOS DAÑADO POR CALOR', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '5', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (6, 1, 'GRANOS DAÑADO POR INSECTOS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '6', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (7, 1, 'GRANOS DAÑADO TOTALES', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '7', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (15, 1, 'GRANO PARTIDO PEQUEÑO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '15', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (3, 1, 'GRANOS CON GERMEN DAÑADO', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '3', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (17, 1, 'ASPECTO', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '20', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (20, 1, 'LIMPIEZA', 2, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '23', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (1, 1, 'HUMEDAD', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '1', true);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (2, 1, 'IMPUREZAS', 1, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '2', true);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (16, 1, 'AFLATOXINA', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '19', false);
INSERT INTO si_analisis (id, id_org, nombre, tipo_analisis, estatus, creado, modificado, codigo, formula) VALUES (21, 1, 'INSECTOS VIVOS', 3, true, '2012-02-22 00:00:00-04:30', '2012-02-22 00:00:00-04:30', '24', false);


--
-- TOC entry 2412 (class 0 OID 26227)
-- Dependencies: 144
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2413 (class 0 OID 26232)
-- Dependencies: 146
-- Data for Name: si_analisis_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 12, 5, 'C', 0.000, 0.000, 'R', 14, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 1, 1, 'C', 0.000, 0.000, 'R', 1, 1.000, 2.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 2, 2.000, 5.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 1, 5, 'C', 0.000, 0.000, 'R', 3, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 4, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 5, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 6, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 7, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 8, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 9, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 10, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 11, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 12, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 13, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 15, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 16, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 17, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 16, 5, 'C', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 17, 5, 'C', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 18, 5, 'C', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 19, 5, 'C', 0.000, 0.000, 'R', 21, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 20, 5, 'C', 0.000, 0.000, 'R', 22, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 21, 5, 'C', 0.000, 0.000, 'R', 23, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 24, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 25, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 28, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 29, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 30, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 31, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 32, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 33, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 34, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 35, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 36, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 37, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 38, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 16, 6, 'C', 0.000, 0.000, 'R', 39, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 17, 6, 'C', 0.000, 0.000, 'R', 40, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 18, 6, 'C', 0.000, 0.000, 'R', 41, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 19, 6, 'C', 0.000, 0.000, 'R', 42, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 20, 6, 'C', 0.000, 0.000, 'R', 43, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 21, 6, 'C', 0.000, 0.000, 'R', 44, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 45, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 47, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 50, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 51, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 52, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 53, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 54, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 55, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 56, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 57, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 16, 1, 'C', 0.000, 0.000, 'R', 58, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 17, 1, 'C', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 18, 1, 'C', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 19, 1, 'C', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 20, 1, 'C', 0.000, 0.000, 'R', 62, 0.000, 0.000, 0.000, 0.000);
INSERT INTO si_analisis_cultivo (id_org, id_analisis, id_cultivo, laboratorio, reduccion_rec, reduccion_des, estatus, id, min_rec, max_rec, min_des, max_des) VALUES (1, 21, 1, 'C', 0.000, 0.000, 'C', 63, 0.000, 0.000, 0.000, 0.000);


--
-- TOC entry 2414 (class 0 OID 26243)
-- Dependencies: 148
-- Data for Name: si_analisis_des; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2415 (class 0 OID 26249)
-- Dependencies: 150
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2396, 2, NULL, 1, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2397, 2, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2398, 2, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2399, 2, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2400, 2, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2401, 2, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2402, 2, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2403, 2, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2404, 2, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2405, 2, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2406, 2, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2407, 2, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2408, 2, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2409, 2, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2410, 2, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2411, 2, NULL, 16, 3, 'SI              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2412, 2, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2413, 2, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2414, 2, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2415, 2, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2416, 2, NULL, 21, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2417, 3, NULL, 1, 3, '2.000           ', '1.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2418, 3, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2419, 3, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2420, 3, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2421, 3, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2422, 3, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2423, 3, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2424, 3, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2425, 3, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2426, 3, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2427, 3, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2428, 3, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2429, 3, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2430, 3, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2431, 3, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2432, 3, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2433, 3, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2434, 3, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2435, 3, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2436, 3, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2437, 3, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2480, 3, NULL, 1, 3, '1.900           ', '1.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2481, 3, NULL, 2, 3, '4.900           ', '4.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2482, 3, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2483, 3, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2484, 3, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2485, 3, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2486, 3, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2487, 3, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2488, 3, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2489, 3, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2490, 3, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2491, 3, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2492, 3, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2493, 3, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2494, 3, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2495, 3, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2496, 3, NULL, 17, 3, 'A               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2497, 3, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2498, 3, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2499, 3, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2500, 3, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2501, 2, NULL, 1, 3, '1.000           ', '1.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2502, 2, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2503, 2, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2504, 2, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2505, 2, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2506, 2, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2507, 2, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2508, 2, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2509, 2, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2510, 2, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2511, 2, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2512, 2, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2513, 2, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2514, 2, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2515, 2, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2516, 2, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2517, 2, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2518, 2, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2519, 2, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2520, 2, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2521, 2, NULL, 21, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2522, 3, NULL, 1, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2523, 3, NULL, 2, 3, '5.000           ', '5.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2524, 3, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2525, 3, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2526, 3, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2527, 3, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2528, 3, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2529, 3, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2530, 3, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2531, 3, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2532, 3, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2533, 3, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2534, 3, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2535, 3, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2536, 3, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2537, 3, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2538, 3, NULL, 17, 3, 'C               ', 'C               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2539, 3, NULL, 18, 3, 'C               ', 'C               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2540, 3, NULL, 19, 3, 'C               ', 'C               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2541, 3, NULL, 20, 3, 'C               ', 'C               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2542, 3, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2543, 4, NULL, 1, 3, '1.000           ', '1.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2544, 4, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2545, 4, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2546, 4, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2547, 4, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2548, 4, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2549, 4, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2550, 4, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2551, 4, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2552, 4, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2553, 4, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2554, 4, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2555, 4, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2556, 4, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2557, 4, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2558, 4, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2559, 4, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2560, 4, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2561, 4, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2562, 4, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2563, 4, NULL, 21, 3, 'SI              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2564, 5, NULL, 1, 3, '1.900           ', '1.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2565, 5, NULL, 2, 3, '4.900           ', '4.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2566, 5, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2567, 5, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2568, 5, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2569, 5, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2570, 5, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2571, 5, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2572, 5, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2573, 5, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2574, 5, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2575, 5, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2576, 5, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2577, 5, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2578, 5, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2579, 5, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2580, 5, NULL, 17, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2581, 5, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2582, 5, NULL, 19, 3, 'C               ', 'C               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2583, 5, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2584, 5, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2585, 6, NULL, 1, 3, '1.000           ', '1.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2586, 6, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2587, 6, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2588, 6, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2589, 6, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2590, 6, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2591, 6, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2592, 6, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2593, 6, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2594, 6, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2595, 6, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2596, 6, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2597, 6, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2598, 6, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2599, 6, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2600, 6, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2601, 6, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2602, 6, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2603, 6, NULL, 19, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2604, 6, NULL, 20, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2605, 6, NULL, 21, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2606, 2, NULL, 1, 3, '1.900           ', '1.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2607, 2, NULL, 2, 3, '2.000           ', '5.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2608, 2, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2609, 2, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2610, 2, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2611, 2, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2612, 2, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2613, 2, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2614, 2, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2615, 2, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2616, 2, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2617, 2, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2618, 2, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2619, 2, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2620, 2, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2621, 2, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2622, 2, NULL, 17, 3, 'A               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2623, 2, NULL, 18, 3, 'B               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2624, 2, NULL, 19, 3, 'C               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2625, 2, NULL, 20, 3, 'A               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2626, 2, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2627, 2, NULL, 1, 3, '1.900           ', '1.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2628, 2, NULL, 2, 3, '4.900           ', '4.900           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2629, 2, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2630, 2, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2631, 2, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2632, 2, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2633, 2, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2634, 2, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2635, 2, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2636, 2, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2637, 2, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2638, 2, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2639, 2, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2640, 2, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2641, 2, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2642, 2, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2643, 2, NULL, 17, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2644, 2, NULL, 18, 3, 'A               ', 'A               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2645, 2, NULL, 19, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2646, 2, NULL, 20, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2647, 2, NULL, 21, 3, 'NO              ', 'SI              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2648, 10, NULL, 1, 3, '1.000           ', '1.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2649, 10, NULL, 2, 3, '2.000           ', '2.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2650, 10, NULL, 3, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2651, 10, NULL, 4, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2652, 10, NULL, 5, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2653, 10, NULL, 6, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2654, 10, NULL, 7, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2655, 10, NULL, 8, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2656, 10, NULL, 9, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2657, 10, NULL, 10, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2658, 10, NULL, 11, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2659, 10, NULL, 12, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2660, 10, NULL, 13, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2661, 10, NULL, 14, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2662, 10, NULL, 15, 3, '0.000           ', '0.000           ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2663, 10, NULL, 16, 3, 'NO              ', 'NO              ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2664, 10, NULL, 17, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2665, 10, NULL, 18, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2666, 10, NULL, 19, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2667, 10, NULL, 20, 3, 'B               ', 'B               ', '                ');
INSERT INTO si_analisis_resultado (id, id_recepcion, id_despacho, id_analisis, id_usuario, muestra1, muestra2, muestra3) VALUES (2668, 10, NULL, 21, 3, 'SI              ', 'NO              ', '                ');


--
-- TOC entry 2416 (class 0 OID 26254)
-- Dependencies: 152
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2417 (class 0 OID 26262)
-- Dependencies: 154
-- Data for Name: si_asociado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) VALUES (2, 3, 'V16872741       ', 'CARLOS PEREZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);
INSERT INTO si_asociado (id, id_productor, ced_rif, nombre, direccion, telefono, celular, id_pais, id_estado, id_municipio, estatus, direccion_finca, area_finca, ton_cosecha, creado, modificado) VALUES (3, 5, 'V10999888       ', 'PRODUCTOR PRUEBA', NULL, '0414555666', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-14 08:33:15.16074-04:30', NULL);


--
-- TOC entry 2418 (class 0 OID 26271)
-- Dependencies: 156
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2419 (class 0 OID 26277)
-- Dependencies: 158
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2420 (class 0 OID 26284)
-- Dependencies: 160
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
-- TOC entry 2459 (class 0 OID 27360)
-- Dependencies: 238
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2421 (class 0 OID 26299)
-- Dependencies: 162
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2422 (class 0 OID 26308)
-- Dependencies: 164
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (2, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201201');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (3, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, true, '2012-02-23 13:13:17.94223-04:30', NULL, '201202');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (4, 3, 3, 'SEGUNDA COSECHA', NULL, NULL, NULL, '2012-02-27', '2012-09-28', true, '2012-02-27 13:32:56.323501-04:30', NULL, '201203');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (5, 4, 9, 'COSECHA UNO DE GIRASOL', 100000, NULL, 20000, '2012-03-14', '2012-05-31', true, '2012-03-14 08:51:20.219544-04:30', NULL, '2012121');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (6, 6, 1, 'PRIMERA COSECHA', NULL, NULL, NULL, NULL, NULL, true, '2012-03-15 11:58:11.560369-04:30', NULL, '2012011');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (7, 7, 2, 'PRIMERA COSECHA DE ARROZ', 123123, NULL, NULL, NULL, NULL, true, '2012-03-15 12:00:34.702275-04:30', NULL, '2012021');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (8, 7, 2, 'SEGUNDA COSECHA ARROZ', NULL, NULL, NULL, NULL, NULL, true, '2012-03-15 12:00:34.702275-04:30', NULL, '2012022');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (9, 8, 11, 'COSECHA DE MAIZ 2012 1', 100000, NULL, 500, '2012-03-15', '2012-05-15', true, '2012-03-15 14:26:29.738337-04:30', '2012-03-16 10:18:21.621684-04:30', '2012111');
INSERT INTO si_cosecha (id, id_programa, id_cultivo, nombre, proyectado, observacion, area_siembra, fecha_inicio, fecha_fin, estatus, creado, modificado, codigo) VALUES (10, 8, 11, 'COSECHA DE MAIZ 2012 2', NULL, NULL, NULL, NULL, NULL, true, '2012-03-16 10:18:41.518728-04:30', NULL, '2012112');


--
-- TOC entry 2423 (class 0 OID 26319)
-- Dependencies: 165
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 2, false, NULL, NULL, 2);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 3, true, NULL, NULL, 3);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 4, false, NULL, NULL, 4);
INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, asociado, creado, modificado, id) VALUES (2, 2, 5, true, NULL, NULL, 5);


--
-- TOC entry 2456 (class 0 OID 27169)
-- Dependencies: 232
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cosecha_silo (id, id_cosecha, id_silo, id_cultivo) VALUES (1, 2, 2, 1);
INSERT INTO si_cosecha_silo (id, id_cosecha, id_silo, id_cultivo) VALUES (2, 2, 2, 2);


--
-- TOC entry 2458 (class 0 OID 27327)
-- Dependencies: 236
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2424 (class 0 OID 26331)
-- Dependencies: 168
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (10, 1, '10              ', 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (11, 1, '11              ', 'MAIZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (12, 1, '12              ', 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (13, 1, '13              ', 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (14, 1, '14              ', 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (15, 1, '15              ', 'MAIZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (16, 1, '16              ', 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (17, 1, '17              ', 'MAIZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (18, 1, '68              ', 'GRADO POR MUESTRA MAIZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (19, 1, '92              ', 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (20, 1, '93              ', 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (21, 1, '94              ', 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (1, 1, '01              ', 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (2, 1, '02              ', 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (3, 1, '03              ', 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (4, 1, '04              ', 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (5, 1, '05              ', 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (6, 1, '06              ', 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (7, 1, '07              ', 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (8, 1, '08              ', 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (9, 1, '09              ', 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (22, 1, '95              ', 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (23, 1, '96              ', 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (24, 1, '97              ', 'MAIZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (25, 1, '98              ', 'PICO DE MAIZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);
INSERT INTO si_cultivo (id, id_org, codigo, nombre, tipificado, ciclo, creado, modificado) VALUES (26, 1, '99              ', 'IMPUREZAS DE MAIZ', false, 0, '2012-02-18 00:00:00-04:30', NULL);


--
-- TOC entry 2460 (class 0 OID 27366)
-- Dependencies: 240
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2425 (class 0 OID 26339)
-- Dependencies: 170
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2426 (class 0 OID 26343)
-- Dependencies: 171
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2427 (class 0 OID 26350)
-- Dependencies: 174
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2428 (class 0 OID 26357)
-- Dependencies: 176
-- Data for Name: si_estado; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_estado (id, id_pais, nombre) VALUES (1, 1, 'Distrito Capital');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (2, 1, 'Amazonas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (3, 1, 'Anzoategui');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (4, 1, 'Apure');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (5, 1, 'Aragua');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (6, 1, 'Barinas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (7, 1, 'Bolivar');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (8, 1, 'Carabobo');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (9, 1, 'Cojedes');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (10, 1, 'Delta Amacuro');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (11, 1, 'Falcon');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (12, 1, 'Guarico');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (13, 1, 'Lara');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (14, 1, 'Merida');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (15, 1, 'Miranda');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (16, 1, 'Monagas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (17, 1, 'Nueva Esparta');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (18, 1, 'Portuguesa');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (19, 1, 'Sucre');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (20, 1, 'Tachira');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (21, 1, 'Trujillo');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (22, 1, 'Vargas');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (23, 1, 'Yaracuy');
INSERT INTO si_estado (id, id_pais, nombre) VALUES (24, 1, 'Zulia');


--
-- TOC entry 2429 (class 0 OID 26361)
-- Dependencies: 177
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2430 (class 0 OID 26370)
-- Dependencies: 179
-- Data for Name: si_formulas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (1, 1, 1, 2, '(PL1+PL2)', 'PL12', 0, 2, NULL, NULL, NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (2, 1, 1, 2, '(PV1+PV2)', 'PV12', 0, 2, NULL, NULL, NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (3, 1, 1, 2, '((PL1+PL2)-(PV1+PV2))', 'PN', 0, 2, NULL, NULL, NULL, NULL);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (4, 1, 2, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_01', 1, 1, '16 < 17', '2012-03-13 12:04:04.880697-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (5, 1, 2, 2, '((2/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_01', 1, 1, '17 < 18', '2012-03-13 12:04:04.909254-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (6, 1, 2, 2, '((1/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_01', 1, 1, '18 < 19', '2012-03-13 12:04:04.925909-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (7, 1, 2, 2, '((0.500/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_01', 1, 1, '19 < 20', '2012-03-13 12:04:04.94272-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (8, 1, 2, 2, '((0/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_01', 1, 1, '20 < 25', '2012-03-13 12:04:04.959253-04:30', NULL, 1);
INSERT INTO si_formulas (id, id_org, id_centro_acopio, id_cultivo, formula, codigo, id_mov, tipo_for, condicion, creado, modificado, id_analisis) VALUES (9, 1, 1, 2, '((4/(100-0)))*((PL1+PL2)-(PV1+PV2))', 'HUM_GRAL', 1, 1, '16 < 17', '2012-03-13 00:00:00-04:30', NULL, 1);


--
-- TOC entry 2431 (class 0 OID 26375)
-- Dependencies: 181
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (3, NULL, NULL, 4, 1234214, 150000, NULL, NULL, 'V15610226       ', '2012-02-22 00:00:00-04:30', 'P', NULL, NULL, 'PEDRO PEREZ                                                                                                                                                                                                                                                    ', '2012-02-29 16:14:01.338074-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (4, NULL, NULL, 4, 3452345, 15000, NULL, NULL, 'V13654987       ', '2012-02-29 00:00:00-04:30', 'N', NULL, NULL, 'MARTIN RODRIGUEZ                                                                                                                                                                                                                                               ', '2012-02-29 16:17:14.272529-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (5, NULL, NULL, 4, 987654, 110000, NULL, NULL, 'V13852963       ', '2012-03-22 00:00:00-04:30', 'P', NULL, NULL, 'MARCOS PEREZ                                                                                                                                                                                                                                                   ', '2012-03-01 08:08:37.409028-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (6, NULL, NULL, 4, 963852, 20000, NULL, NULL, 'V13852963       ', '2012-03-15 00:00:00-04:30', 'P', NULL, NULL, 'MARCOS PEREZ                                                                                                                                                                                                                                                   ', '2012-03-01 08:10:00.987249-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (8, NULL, NULL, 4, 987321, 150000, NULL, NULL, 'V15610226       ', '2012-03-13 00:00:00-04:30', 'P', NULL, NULL, 'PEDRO PEREZ                                                                                                                                                                                                                                                    ', '2012-03-13 08:49:12.369649-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (2, NULL, NULL, 4, 12312, 180000, NULL, NULL, 'V15610226       ', '2012-02-20 00:00:00-04:30', 'P', NULL, NULL, 'PEDRO PEREZ                                                                                                                                                                                                                                                    ', '2012-02-29 16:12:27.158984-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (10, NULL, NULL, 4, 12121221, 120000, NULL, NULL, 'V12312312       ', '2012-03-13 00:00:00-04:30', 'P', NULL, NULL, 'ASDASDAS                                                                                                                                                                                                                                                       ', '2012-03-13 09:18:57.44785-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (11, NULL, NULL, 4, 123, 10000, NULL, NULL, 'V123123         ', '2012-03-13 00:00:00-04:30', 'P', NULL, NULL, 'ASDASD                                                                                                                                                                                                                                                         ', '2012-03-13 09:24:09.271226-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (9, NULL, NULL, 4, 123123123, 12000, NULL, NULL, 'V12312312       ', '2012-03-13 00:00:00-04:30', 'P', NULL, NULL, 'ASDASDAS                                                                                                                                                                                                                                                       ', '2012-03-13 09:01:29.807015-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (12, NULL, NULL, 4, 78978976, 120000, NULL, NULL, 'V12345678       ', '2012-03-13 00:00:00-04:30', 'P', NULL, NULL, 'ASDASDAS                                                                                                                                                                                                                                                       ', '2012-03-13 09:38:11.605574-04:30', NULL);
INSERT INTO si_guiarec (id, id_agencia, id_cultivo, id_usuario, numero_guia, kilogramos, placa_remolque, placa_vehiculo, cedula_chofer, fecha_emision, estatus, cedula_asociado, contrato, nombre_chofer, creado, modificado) VALUES (13, NULL, NULL, 4, 123456, 15000, NULL, NULL, 'V10999888       ', '2012-03-12 00:00:00-04:30', 'P', NULL, NULL, 'PRODUCTOR PRUEBA                                                                                                                                                                                                                                               ', '2012-03-14 08:33:15.16074-04:30', NULL);


--
-- TOC entry 2432 (class 0 OID 26380)
-- Dependencies: 182
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (4, 11, '123123          ', '2012-03-14 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (5, 11, '321321          ', '2012-03-15 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (6, 12, '634565          ', '2012-03-14 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (7, 12, '3645345345      ', '2012-03-15 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (8, 13, '12345           ', '2012-03-06 00:00:00-04:30', '');
INSERT INTO si_guiarec_det (id, id_guiarec, subguia, fecha, descripcion) VALUES (9, 13, '12346           ', '2012-03-07 00:00:00-04:30', '');


--
-- TOC entry 2433 (class 0 OID 26389)
-- Dependencies: 186
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos (log_codigo_id, log_codigo_nombre_es, log_codigo_critico, log_codigo_tipo) VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2434 (class 0 OID 26395)
-- Dependencies: 188
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2435 (class 0 OID 26410)
-- Dependencies: 190
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (1, 'M_Maestros', 0, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (5, 'M_Cuenta', 0, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (12, 'M_Despacho', 2, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (6, 'M_CentrosA', 1, 'admin/centros_acopio_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (14, 'M_Cosecha', 3, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (15, 'M_Cultivo', 3, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (16, 'M_Productores', 3, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (13, 'M_Programas', 3, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (17, 'M_Recepciones', 3, NULL, true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (18, 'M_Despacho', 3, NULL, true, 6, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (19, 'M_Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (22, 'M_Configuracion', 4, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (23, 'M_ConfigCta', 5, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (24, 'M_Organizacion', 1, 'admin/organizacion_listado.php', true, 1, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (25, 'M_Almacenes', 1, 'admin/almacen_listado.php', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (26, 'M_MenuUsuario', 4, 'admin/menu_usuario.php', true, 5, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (27, 'M_AnalisisRec', 2, 'admin/analisis_recepcion_listado.php?estatus=1', true, 3, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (28, 'M_Cuarentenas', 2, 'admin/cuarentena_listado.php', true, NULL, NULL, NULL);
INSERT INTO si_menu (id, nombre, id_padre, url, estatus, orden, creado, modificado) VALUES (21, 'M_Formulas', 4, 'admin/formulacion_listado.php', true, 3, NULL, NULL);


--
-- TOC entry 2436 (class 0 OID 26415)
-- Dependencies: 191
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (1, 1, 1);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (3, 1, 2);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (4, 1, 3);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (5, 1, 4);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (24, 1, 5);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (6, 1, 6);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (7, 1, 7);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (8, 1, 8);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (9, 1, 9);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (13, 1, 10);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (14, 1, 11);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (15, 1, 12);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (16, 1, 13);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (17, 1, 14);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (18, 1, 15);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (19, 1, 16);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (20, 1, 17);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (21, 1, 18);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (22, 1, 19);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (23, 1, 20);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (1, 2, 21);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (7, 2, 22);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (8, 2, 23);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (9, 2, 24);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (10, 2, 25);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (25, 1, 26);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (25, 2, 27);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (26, 1, 28);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (2, 3, 29);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (27, 3, 30);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (2, 4, 31);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (11, 4, 32);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (4, 2, 33);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (21, 2, 34);
INSERT INTO si_menu_usuario (id_menu, id_usuario, id) VALUES (28, 3, 35);


--
-- TOC entry 2437 (class 0 OID 26422)
-- Dependencies: 194
-- Data for Name: si_municipio; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_municipio (id, id_estado, nombre) VALUES (1, 1, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (2, 2, 'Alto Orinoco         ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (3, 2, 'Atabapo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (4, 2, 'Atures');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (5, 2, 'Autana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (6, 2, 'Manapiare');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (7, 2, 'Maroa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (8, 2, 'Rio Negro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (9, 3, 'Anaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (10, 3, 'Aragua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (11, 3, 'Bolivar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (12, 3, 'Bruzual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (13, 3, 'Cajigal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (14, 3, 'Carvajal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (15, 3, 'Diego Bautista Urbaneja');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (16, 3, 'Freites');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (17, 3, 'Guanipa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (18, 3, 'Guanta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (19, 3, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (20, 3, 'Libertad');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (21, 3, 'McGregor');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (22, 3, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (23, 3, 'Monagas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (24, 3, 'Penalver');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (25, 3, 'Piritu');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (26, 3, 'San Juan de Capistrano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (27, 3, 'Santa Ana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (28, 3, 'Simon Rodriguez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (29, 3, 'Sotillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (30, 4, 'Achaguas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (31, 4, 'Biruaca');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (32, 4, 'Munoz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (33, 4, 'Paez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (34, 4, 'Pedro Camejo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (35, 4, 'Romulo Gallegos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (36, 4, 'San Fernando');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (37, 5, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (38, 5, 'Camatagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (39, 5, 'Francisco Linares Alcántara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (40, 5, 'Girardot');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (41, 5, 'José Angel Lamas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (42, 5, 'José Félix Ribas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (43, 5, 'José Rafael Revenga');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (44, 5, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (45, 5, 'Mario Briceño Iragorry');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (46, 5, 'Ocumare de la Costa de Oro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (47, 5, 'San Casimiro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (48, 5, 'San Sebastián');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (49, 5, 'Santiago Mariño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (50, 5, 'Santos Michelena');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (51, 5, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (52, 5, 'Tovar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (53, 5, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (54, 5, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (55, 6, 'Alberto Arvelo Torrealba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (56, 6, 'Andrés Eloy Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (57, 6, 'Antonio José de Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (58, 6, 'Arismendi');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (59, 6, 'Barinas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (60, 6, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (61, 6, 'Cruz Paredes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (62, 6, 'Ezequiel Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (63, 6, 'Obispos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (64, 6, 'Pedraza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (65, 6, 'Rojas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (66, 6, 'Sosa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (67, 7, 'Caroní');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (68, 7, 'Cedeño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (69, 7, 'El Callao');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (70, 7, 'Gran Sabana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (71, 7, 'Heres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (72, 7, 'Piar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (73, 7, 'Raúl Leoni');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (74, 7, 'Roscio');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (75, 7, 'Sifontes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (76, 7, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (77, 7, 'Padre Pedro Chien');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (78, 8, 'Bejuma');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (79, 8, 'Carlos Arvelo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (80, 8, 'Diego Ibarra');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (81, 8, 'Guacara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (82, 8, 'Juan José Mora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (83, 8, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (84, 8, 'Los Guayos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (85, 8, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (86, 8, 'Montalbán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (87, 8, 'Naguanagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (88, 8, 'Puerto Cabello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (89, 8, 'San Diego');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (90, 8, 'San Joaquín');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (91, 8, 'Valencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (92, 9, 'Anzoátegui');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (93, 9, 'Falcón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (94, 9, 'Girardot');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (95, 9, 'Lima Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (96, 9, 'Pao de San Juan Bautista');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (97, 9, 'Ricaurte');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (98, 9, 'Rómulo Gallegos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (99, 9, 'San Carlos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (100, 9, 'Tinaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (101, 10, 'Antonio Díaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (102, 10, 'Casacoima');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (103, 10, 'Pedernales');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (104, 10, 'Tucupita');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (105, 10, 'Antonio Diaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (106, 10, 'Casacoima');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (107, 10, 'Pedernales');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (108, 10, 'Tucupita');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (109, 11, 'Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (110, 11, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (111, 11, 'Buchivacoa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (112, 11, 'Cacique Manaure');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (113, 11, 'Carirubana');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (114, 11, 'Colina');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (115, 11, 'Dabajuro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (116, 11, 'Democracia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (117, 11, 'Falcón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (118, 11, 'Federación');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (119, 11, 'Jacura');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (120, 11, 'Los Taques');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (121, 11, 'Mauroa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (122, 11, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (123, 11, 'Monseñor Iturriza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (124, 11, 'Palmasola');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (125, 11, 'Petit');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (126, 11, 'Píritu');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (127, 11, 'San Francisco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (128, 11, 'Silva');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (129, 11, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (130, 11, 'Tocópero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (131, 11, 'Unión');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (132, 11, 'Urumaco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (133, 11, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (134, 12, 'Camaguán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (135, 12, 'Chaguaramas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (136, 12, 'El Socorro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (137, 12, 'Sebastian Francisco de Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (138, 12, 'José Félix Ribas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (139, 12, 'José Tadeo Monagas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (140, 12, 'Juan Germán Roscio');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (141, 12, 'Julián Mellado');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (142, 12, 'Las Mercedes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (143, 12, 'Leonardo Infante');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (144, 12, 'Pedro Zaraza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (145, 12, 'Ortiz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (146, 12, 'San Gerónimo de Guayabal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (147, 12, 'San José de Guaribe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (148, 12, 'Santa María de Ipire');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (149, 13, 'Andrés Eloy Blanco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (150, 13, 'Crespo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (151, 13, 'Iribarren');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (152, 13, 'Jiménez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (153, 13, 'Morán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (154, 13, 'Palavecino');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (213, 16, 'Sotillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (214, 16, 'Uracoa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (215, 17, 'Antolín del Campo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (216, 17, 'Arismendi ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (217, 17, 'Díaz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (218, 17, 'García');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (219, 17, 'Gómez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (220, 17, 'Maneiro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (221, 17, 'Marcano ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (222, 17, 'Mariño ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (223, 17, 'Península de Macanao ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (224, 17, 'Tubores ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (225, 17, 'Villalba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (226, 18, 'Agua Blanca');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (227, 18, 'Araure ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (228, 18, 'Esteller ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (229, 18, 'Guanare ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (230, 18, 'Guanarito');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (231, 18, 'Monseñor José Vicente de Unda ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (232, 18, 'Ospino ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (233, 18, 'Páez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (234, 18, 'Papelón ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (235, 18, 'San Genaro de Boconoíto');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (236, 18, 'San Rafael de Onoto');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (237, 18, 'Santa Rosalía ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (238, 18, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (239, 18, 'Turén');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (240, 19, 'Andrés Eloy Blanco ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (241, 19, 'Andrés Mata');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (242, 19, 'Arismendi ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (243, 19, 'Benítez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (244, 19, 'Bermúdez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (245, 19, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (246, 19, 'Cajigal ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (247, 19, 'Cruz Salmerón Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (248, 19, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (249, 19, 'Mariño ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (250, 19, 'Mejía ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (251, 19, 'Montes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (252, 19, 'Ribero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (253, 19, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (254, 19, 'Valdez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (255, 20, 'Andrés Bello ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (256, 20, 'Antonio Rómulo Costa');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (257, 20, 'Ayacucho ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (258, 20, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (259, 20, 'Cárdenas ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (260, 20, 'Córdoba (Santa Ana de Táchira)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (261, 20, 'Fernández Feo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (262, 20, 'Francisco de Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (156, 13, 'Torres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (157, 13, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (158, 14, 'Alberto Adriani');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (159, 14, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (160, 14, 'Antonio Pinto Salinas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (161, 14, 'Aricagua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (162, 14, 'Arzobispo Chacón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (163, 14, 'Campo Elías');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (164, 14, 'Caracciolo Parra Olmedo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (165, 14, 'Cardenal Quintero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (166, 14, 'Guaraque');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (167, 14, 'Julio César Salas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (168, 14, 'Justo Briceño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (169, 14, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (170, 14, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (171, 14, 'Obispo Ramos de Lora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (172, 14, 'Padre Noguera');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (173, 14, 'Pueblo Llano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (174, 14, 'Rangel');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (175, 14, 'Rivas Dávila');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (176, 14, 'Santos Marquina');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (177, 14, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (178, 14, 'Tovar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (179, 14, 'Tulio Febres Cordero');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (180, 14, 'Zea');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (181, 15, 'Acevedo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (182, 15, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (183, 15, 'Baruta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (184, 15, 'Brión');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (185, 15, 'Buroz');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (186, 15, 'Carrizal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (187, 15, 'Chacao');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (188, 15, 'Cristóbal Rojas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (189, 15, 'El Hatillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (190, 15, 'Guaicaipuro');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (191, 15, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (192, 15, 'Lander');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (193, 15, 'Los Salias');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (194, 15, 'Páez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (195, 15, 'Paz Castillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (196, 15, 'Pedro Gual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (197, 15, 'Plaza');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (198, 15, 'Simón Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (199, 15, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (200, 15, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (201, 15, 'Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (202, 16, 'Acosta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (203, 16, 'Aguasay');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (204, 16, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (205, 16, 'Caripe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (206, 16, 'Cedeño');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (207, 16, 'Ezequiel Zamora');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (208, 16, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (209, 16, 'Maturín');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (210, 16, 'Piar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (211, 16, 'Punceres');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (212, 16, 'Santa Bárbara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (263, 20, 'García de Hevia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (264, 20, 'Guásimos');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (265, 20, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (266, 20, 'Jáuregui ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (267, 20, 'José María Vargas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (268, 20, 'Junín ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (269, 20, 'Libertad (Capacho Viejo)');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (270, 20, 'Libertador');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (271, 20, 'Lobatera ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (272, 20, 'Michelena');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (273, 20, 'Panamericano');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (274, 20, 'Pedro María Ureña');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (275, 20, 'Rafael Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (276, 20, 'Samuel Darío Maldonado');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (277, 20, 'San Cristóbal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (278, 20, 'Seboruco');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (279, 20, 'Simón Rodríguez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (280, 20, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (281, 20, 'Torbes ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (282, 20, 'Uribante');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (283, 20, 'San Judas Tadeo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (284, 21, 'Andrés Bello');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (285, 21, 'Boconó');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (286, 21, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (287, 21, 'Candelaria');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (288, 21, 'Carache');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (289, 21, 'Escuque');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (290, 21, 'José Felipe Márquez Cañizalez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (291, 21, 'Juan Vicente Campos Elías');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (292, 21, 'La Ceiba');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (293, 21, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (294, 21, 'Monte Carmelo ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (295, 21, 'Motatán ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (296, 21, 'Pampán');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (297, 21, 'Pampanito ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (298, 21, 'Rafael Rangel');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (299, 21, 'San Rafael de Carvajal');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (300, 21, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (301, 21, 'Trujillo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (302, 21, 'Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (303, 21, 'Valera');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (304, 22, 'Vargas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (305, 23, 'Arístides Bastidas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (306, 23, 'Bolívar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (307, 23, 'Bruzual');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (308, 23, 'Cocorote');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (309, 23, 'Independencia');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (310, 23, 'José Antonio Páez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (311, 23, 'La Trinidad');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (312, 23, 'Manuel Monge');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (313, 23, 'Nirgua');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (314, 23, 'Peña');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (315, 23, 'San Felipe');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (316, 23, 'Sucre');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (317, 23, 'Urachiche');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (318, 23, 'Veroes');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (319, 24, 'Almirante Padilla');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (320, 24, 'Baralt');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (321, 24, 'Cabimas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (322, 24, 'Catatumbo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (323, 24, 'Colón');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (324, 24, 'Francisco Javier Pulgar');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (325, 24, 'Jesús Enrique Losada ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (326, 24, 'Jesús María Semprún ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (327, 24, 'Cañada de Urdaneta');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (328, 24, 'Lagunillas');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (329, 24, 'Machiques de Perijá');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (330, 24, 'Mara');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (331, 24, 'Maracaibo');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (332, 24, 'Miranda');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (333, 24, 'Páez');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (334, 24, 'Rosario de Perijá');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (335, 24, 'San Francisco ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (336, 24, 'Santa Rita ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (337, 24, 'Simón Bolívar ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (338, 24, 'Sucre ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (339, 24, 'Valmore Rodríguez ');
INSERT INTO si_municipio (id, id_estado, nombre) VALUES (155, 13, 'Simón Planas');


--
-- TOC entry 2438 (class 0 OID 26428)
-- Dependencies: 196
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2439 (class 0 OID 26435)
-- Dependencies: 198
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion (id, nombre, descripcion, rif, telefono, email, direccion, fax, id_pais, id_estado, id_municipio, creado, modificado, estatus, codigo) VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-02-19 14:45:27.722-04:30', true, 'AGR');


--
-- TOC entry 2440 (class 0 OID 26444)
-- Dependencies: 200
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais (id, nombre) VALUES (1, 'Venezuela');


--
-- TOC entry 2441 (class 0 OID 26450)
-- Dependencies: 202
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
-- TOC entry 2442 (class 0 OID 26459)
-- Dependencies: 204
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (1, 'GERENTE GENERAL', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (2, 'GERENTE', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (3, 'ADMINISTRADOR', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (4, 'CALIDAD', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (5, 'ROMANERO', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (6, 'RECEPCION', '2012-02-07 00:00:00-04:30', NULL);
INSERT INTO si_perfiles (id, nombre_perfil, creado, modificado) VALUES (7, 'DESPACHO', '2012-02-07 00:00:00-04:30', NULL);


--
-- TOC entry 2443 (class 0 OID 26463)
-- Dependencies: 205
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
-- TOC entry 2457 (class 0 OID 27194)
-- Dependencies: 234
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto (id, id_org, codigo, nombre, presentacion, dosis, estatus, creado, modificado) VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2444 (class 0 OID 26475)
-- Dependencies: 208
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (3, NULL, NULL, 'V17247200       ', NULL, 'ENDER HIGUERA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (4, NULL, NULL, 'V15610226       ', NULL, 'RONALD BANCO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-01 08:08:37.409028-04:30', '2012-03-01 08:10:00.987249-04:30');
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (2, NULL, NULL, 'V18264065       ', NULL, 'JESUS RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', '2012-03-13 09:38:11.605574-04:30');
INSERT INTO si_productor (id, id_org, id_sap, ced_rif, cod_ref, nombre, telefono, fax, email, edo_civil, nacionalidad, direccion, id_pais, id_estado, id_municipio, coordenadas_utm, estatus, ced_legal, legal_nombre, cod_ag_dir_fis, contacto1_nombre, contacto1_telefono, contacto1_email, contacto2_nombre, contacto2_telefono, contacto2_email, contacto3_nombre, contacto3_telefono, contacto3_email, creado, modificado) VALUES (5, NULL, NULL, 'V10999888       ', NULL, 'PRODUCTOR PRUEBA', '0414555666', NULL, 'JJSOSJOJSOJS@HOTMAIL.COM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-14 08:33:15.16074-04:30', NULL);


--
-- TOC entry 2445 (class 0 OID 26484)
-- Dependencies: 210
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (2, 2, 'PRIMER PROGRAMA', NULL, '2012-02-23 13:13:17.94223-04:30', NULL, true, 'PR1', NULL, NULL, 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (3, 2, 'SEGUNDO PROGRAMA', NULL, '2012-02-27 13:32:56.323501-04:30', NULL, true, 'PR2', NULL, NULL, 3);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (4, 2, 'PROGAMA DE GIRASOL 2012', 'PROGRAMA DE GIRASOL ', '2012-03-14 08:51:20.219544-04:30', NULL, true, '201212', '2012-03-13', '2012-03-15', 12);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (6, 2, 'PRIMER PROGRAMA', NULL, '2012-03-15 11:58:11.560369-04:30', NULL, true, '20121', '2012-03-15', '2013-03-15', 1);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (7, 2, 'SEGUNDO PROGRAMA', NULL, '2012-03-15 12:00:34.702275-04:30', NULL, true, '201202', '2012-03-15', '2013-03-15', 2);
INSERT INTO si_programa (id, id_centro_acopio, nombre, observacion, creado, modificado, estatus, codigo, fecha_inicio, fecha_fin, id_cultivo) VALUES (8, 2, 'PROG. DE MAIZ 1', NULL, '2012-03-15 14:26:29.738337-04:30', '2012-03-16 10:26:30.62589-04:30', true, '201211', '2012-03-15', '2013-03-15', 11);


--
-- TOC entry 2462 (class 0 OID 27387)
-- Dependencies: 244
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2446 (class 0 OID 26499)
-- Dependencies: 211
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2447 (class 0 OID 26507)
-- Dependencies: 213
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (8, 2, 2, 2, 2, NULL, 8, 4, 1, '2012-03-13 08:49:12.369649-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-13 08:49:12.369649-04:30', NULL, 2, 7);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (9, 2, 2, 2, 2, NULL, 12, 4, 2, '2012-03-13 09:38:11.605574-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-13 09:38:11.605574-04:30', NULL, 2, 8);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (3, 2, 2, 2, 2, NULL, 3, 4, 2, '2012-02-29 16:14:01.338074-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:14:01.338074-04:30', '2012-03-14 09:53:49.780345', 2, 3);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (4, 2, 2, 2, 3, 2, 4, 4, 3, '2012-02-29 16:17:14.272529-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', '2012-03-14 10:17:21.422376', 2, 4);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (5, 2, 2, 2, 4, NULL, 5, 4, 1, '2012-03-01 08:08:37.409028-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-01 08:08:37.409028-04:30', '2012-03-14 10:39:17.951289', 2, 5);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (6, 2, 2, 2, 4, NULL, 6, 4, 2, '2012-03-01 08:10:00.987249-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-01 08:10:00.987249-04:30', '2012-03-14 10:56:32.430537', 2, 6);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (2, 2, 2, 2, 2, NULL, 2, 4, 1, '2012-02-29 16:12:27.158984-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', '2012-03-14 11:56:14.889533', 2, 2);
INSERT INTO si_recepcion (id, id_centro_acopio, id_cosecha, id_silo, id_productor, id_asociado, id_guia, id_usuario, numero, fecha_recepcion, carril, estatus_rec, fecha_pel, peso_01l, peso_02l, tolva, fecha_v, peso_01v, peso_02v, humedad, impureza, humedad_des, impureza_des, creado, modificado, cant_muestras, id_vehiculo) VALUES (10, 2, 2, 2, 5, 3, 13, 4, 1, '2012-03-14 08:33:15.16074-04:30', 1, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-14 08:33:15.16074-04:30', '2012-03-14 14:31:00.929526', 2, 9);


--
-- TOC entry 2461 (class 0 OID 27374)
-- Dependencies: 242
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2448 (class 0 OID 26513)
-- Dependencies: 215
-- Data for Name: si_recursos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (2, 'Index', 'pages', 'index.php', 0, '2012-03-06 09:37:24.898959-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (1, 'Global', NULL, NULL, 0, '2012-03-06 09:19:38.843861-04:30', NULL);
INSERT INTO si_recursos (id, nombre, localizacion, nombre_archivo, autentificacion, creado, modificado) VALUES (3, 'Analisis de Resultados', 'admin', 'analisis_recepcion.php', 1, '2012-03-06 00:00:00-04:30', NULL);


--
-- TOC entry 2449 (class 0 OID 26520)
-- Dependencies: 216
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
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (15, 1, 'M_CtrolProcesos', 'Ctrol de Procesos', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
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
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (37, 1, 'M_MenuUsuario', 'Menu - Usuario', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (39, 1, 'M_Cuarentenas', 'Cuarentenas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (32, 1, 'M_Formulas', 'F&oacute;rmulas', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (40, 3, 'E_FueraNorma', 'El valor indicado está fuera de norma.!!!', 0, '2012-03-06 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (38, 1, 'M_AnalisisRec', 'Resultados de Lab.', 1, '2012-03-06 10:43:26.712496-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (41, 3, 'M_Rechazo', 'La Muestra  rechazada. Desea emitir boleta de Rechazo? !!!', 0, '2012-03-14 00:00:00-04:30', NULL);
INSERT INTO si_recursos_etiquetas (id, id_recurso, nombre, valor, global, creado, modificado) VALUES (42, 3, 'E_40TNA', 'El valor indicado está fuera de norma. Desea enviar a Cuarentena? !!!', 0, '2012-03-14 00:00:00-04:30', NULL);


--
-- TOC entry 2450 (class 0 OID 26533)
-- Dependencies: 220
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
-- TOC entry 2451 (class 0 OID 26544)
-- Dependencies: 222
-- Data for Name: si_tolcarom; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2452 (class 0 OID 26550)
-- Dependencies: 223
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2453 (class 0 OID 26560)
-- Dependencies: 226
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (2, 'JESUS', 'SILVA', '9668397', '1970-09-01', 'M', 'JSILVA                          ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'jesussilva@agropatria.co.ve', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 0, NULL, '2012-03-16 10:43:30.714079-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (4, 'JESUS', 'RODRIGUEZ', '18264065', NULL, 'M', 'JRODRIGUEZ                      ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Cagua', NULL, 'jesusrodriguez@agropatria.co.ve', '2012-02-13 00:00:00-04:30', '2012-02-13 00:00:00-04:30', true, 1, 'ht3u59657ji7gvr8ggu1jaab42', '2012-03-16 10:55:53.086692-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (5, 'Mariely', 'Coronado', '16000000', NULL, 'F', 'MCORONADO                       ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'La Villa', NULL, 'marielycoronado@agropatria.co.ve', '2012-02-13 00:00:00-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (6, 'Yelitza', 'Guzman', '13000000', NULL, 'F', 'YGUZMAN                         ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'yelitzaguzman@agropatria.co.ve', '2012-02-13 00:00:00-04:30', NULL, true, 0, NULL, NULL);
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (3, 'JUAN', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'juantaborda@agropatria.co.ve', '2012-02-13 00:00:00-04:30', '2012-02-17 00:00:00-04:30', true, 1, 'blrevot01orsbnhm86a49r4i94', '2012-03-16 10:32:59.866523-04:30');
INSERT INTO si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, usuario, contrasena, direccion, telefono, email, creado, modificado, estatus, conectado, sesion, ultimo_acceso) VALUES (1, 'JOSE', 'PELUZZO', '1234567', '2012-02-12', 'M', 'JPELUZZO                        ', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Maracay', NULL, 'josepeluzzo@agropatria.co.ve', '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, '2012-03-16 10:38:48.525318-04:30');


--
-- TOC entry 2454 (class 0 OID 26571)
-- Dependencies: 228
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (1, 1, 1, 1, '2012-02-13 00:00:00-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (3, 3, 2, 4, '2012-02-13 15:00:02.192211-04:30', '2012-02-17 11:06:46.723921-04:30');
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (4, 4, 2, 6, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (5, 5, 2, 5, '2012-02-13 16:15:23.105604-04:30', NULL);
INSERT INTO si_usuarios_perfiles (id, id_usuario, id_almacen, id_perfil, creado, modificado) VALUES (6, 6, 2, 7, '2012-02-13 00:00:00-04:30', NULL);


--
-- TOC entry 2455 (class 0 OID 26575)
-- Dependencies: 229
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (2, 'ASD-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:12:27.158984-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (3, 'ASD-123         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:14:01.338074-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (4, 'QWE-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-02-29 16:17:14.272529-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (5, 'QWE-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-01 08:08:37.409028-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (6, 'ASD-ASD         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-01 08:10:00.987249-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (7, 'ASD-DSA         ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-13 08:49:12.369649-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (8, 'AASDAS          ', NULL, NULL, NULL, NULL, NULL, NULL, '2012-03-13 09:38:11.605574-04:30', NULL);
INSERT INTO si_vehiculos (id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques, creado, modificado) VALUES (9, 'AA3356SK        ', 'MACK', NULL, NULL, NULL, NULL, 'AA3357SK        ', '2012-03-14 08:33:15.16074-04:30', NULL);


--
-- TOC entry 2204 (class 2606 OID 26603)
-- Dependencies: 152 152
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2236 (class 2606 OID 26605)
-- Dependencies: 186 186
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2192 (class 2606 OID 26607)
-- Dependencies: 141 141
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2198 (class 2606 OID 26609)
-- Dependencies: 144 144
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2200 (class 2606 OID 26611)
-- Dependencies: 146 146
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2194 (class 2606 OID 26613)
-- Dependencies: 143 143 143
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2196 (class 2606 OID 26615)
-- Dependencies: 143 143
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2202 (class 2606 OID 26617)
-- Dependencies: 150 150
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2206 (class 2606 OID 26619)
-- Dependencies: 154 154
-- Name: si_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);


--
-- TOC entry 2208 (class 2606 OID 26621)
-- Dependencies: 156 156
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 2606 OID 26623)
-- Dependencies: 158 158
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 26625)
-- Dependencies: 160 160
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2292 (class 2606 OID 27379)
-- Dependencies: 238 238
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 26627)
-- Dependencies: 162 162
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 26629)
-- Dependencies: 164 164
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2284 (class 2606 OID 27191)
-- Dependencies: 232 232 232 232
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2286 (class 2606 OID 27174)
-- Dependencies: 232 232
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 27332)
-- Dependencies: 236 236
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 26633)
-- Dependencies: 168 168
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 27417)
-- Dependencies: 240 240
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2220 (class 2606 OID 26635)
-- Dependencies: 170 170
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 26637)
-- Dependencies: 171 171
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2224 (class 2606 OID 26639)
-- Dependencies: 174 174
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2606 OID 26641)
-- Dependencies: 176 176
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 26643)
-- Dependencies: 177 177
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 26645)
-- Dependencies: 179 179
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 26647)
-- Dependencies: 181 181
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 26649)
-- Dependencies: 182 182
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 26651)
-- Dependencies: 188 188
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2240 (class 2606 OID 26653)
-- Dependencies: 190 190
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 26655)
-- Dependencies: 191 191 191
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2244 (class 2606 OID 26657)
-- Dependencies: 194 194
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 26659)
-- Dependencies: 196 196
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 26661)
-- Dependencies: 198 198
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 26663)
-- Dependencies: 200 200
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 26665)
-- Dependencies: 202 202
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 26667)
-- Dependencies: 204 204
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 26669)
-- Dependencies: 205 205
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 27199)
-- Dependencies: 234 234
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 26673)
-- Dependencies: 208 208
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 26675)
-- Dependencies: 210 210
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 27395)
-- Dependencies: 244 244
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 26679)
-- Dependencies: 211 211
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 27434)
-- Dependencies: 242 242
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2264 (class 2606 OID 26681)
-- Dependencies: 213 213
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2268 (class 2606 OID 26683)
-- Dependencies: 216 216
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 26685)
-- Dependencies: 215 215
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 26687)
-- Dependencies: 220 220
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2272 (class 2606 OID 26689)
-- Dependencies: 222 222
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 26691)
-- Dependencies: 223 223
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 26693)
-- Dependencies: 228 228
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2276 (class 2606 OID 26695)
-- Dependencies: 226 226
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2278 (class 2606 OID 26697)
-- Dependencies: 226 226
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2282 (class 2606 OID 26699)
-- Dependencies: 229 229
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 26700)
-- Dependencies: 2211 141 160
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2300 (class 2606 OID 26705)
-- Dependencies: 141 2225 176
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2301 (class 2606 OID 26710)
-- Dependencies: 2243 141 194
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2302 (class 2606 OID 26715)
-- Dependencies: 141 200 2249
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2304 (class 2606 OID 26720)
-- Dependencies: 144 2195 143
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2305 (class 2606 OID 26725)
-- Dependencies: 2211 160 144
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2306 (class 2606 OID 26730)
-- Dependencies: 143 146 2195
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2307 (class 2606 OID 26735)
-- Dependencies: 2247 146 198
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2308 (class 2606 OID 26740)
-- Dependencies: 148 143 2195
-- Name: si_analisis_des_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2309 (class 2606 OID 26745)
-- Dependencies: 148 198 2247
-- Name: si_analisis_des_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2303 (class 2606 OID 26750)
-- Dependencies: 143 2247 198
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2310 (class 2606 OID 26755)
-- Dependencies: 150 143 2195
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2311 (class 2606 OID 26760)
-- Dependencies: 2221 171 150
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2312 (class 2606 OID 26765)
-- Dependencies: 2263 150 213
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2313 (class 2606 OID 26770)
-- Dependencies: 150 2275 226
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2314 (class 2606 OID 26775)
-- Dependencies: 2225 176 154
-- Name: si_asociado_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2315 (class 2606 OID 26780)
-- Dependencies: 194 154 2243
-- Name: si_asociado_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2316 (class 2606 OID 26785)
-- Dependencies: 2249 154 200
-- Name: si_asociado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2317 (class 2606 OID 26790)
-- Dependencies: 154 208 2257
-- Name: si_asociado_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2318 (class 2606 OID 26795)
-- Dependencies: 2191 156 141
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2319 (class 2606 OID 26800)
-- Dependencies: 156 158 2209
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2320 (class 2606 OID 26805)
-- Dependencies: 226 156 2275
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2321 (class 2606 OID 26810)
-- Dependencies: 160 2225 176
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2322 (class 2606 OID 26815)
-- Dependencies: 2243 194 160
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2323 (class 2606 OID 26820)
-- Dependencies: 2247 198 160
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2324 (class 2606 OID 26825)
-- Dependencies: 160 200 2249
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2399 (class 2606 OID 27380)
-- Dependencies: 238 2247 198
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2325 (class 2606 OID 26830)
-- Dependencies: 2247 198 162
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2326 (class 2606 OID 26835)
-- Dependencies: 2217 168 164
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2327 (class 2606 OID 26840)
-- Dependencies: 210 164 2259
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2328 (class 2606 OID 26845)
-- Dependencies: 160 2211 165
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2329 (class 2606 OID 26850)
-- Dependencies: 165 164 2215
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2330 (class 2606 OID 26855)
-- Dependencies: 208 165 2257
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2390 (class 2606 OID 27175)
-- Dependencies: 164 2215 232
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2392 (class 2606 OID 27185)
-- Dependencies: 168 2217 232
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2391 (class 2606 OID 27180)
-- Dependencies: 2269 232 220
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2395 (class 2606 OID 27338)
-- Dependencies: 2195 143 236
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2394 (class 2606 OID 27333)
-- Dependencies: 160 2211 236
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2396 (class 2606 OID 27343)
-- Dependencies: 2217 236 168
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2397 (class 2606 OID 27348)
-- Dependencies: 2263 236 213
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2398 (class 2606 OID 27353)
-- Dependencies: 226 236 2275
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2331 (class 2606 OID 26860)
-- Dependencies: 198 168 2247
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2402 (class 2606 OID 27428)
-- Dependencies: 240 143 2195
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2400 (class 2606 OID 27418)
-- Dependencies: 2211 160 240
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2401 (class 2606 OID 27423)
-- Dependencies: 240 2217 168
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2332 (class 2606 OID 26865)
-- Dependencies: 2217 168 170
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2333 (class 2606 OID 26870)
-- Dependencies: 170 198 2247
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2334 (class 2606 OID 26875)
-- Dependencies: 171 160 2211
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2335 (class 2606 OID 26880)
-- Dependencies: 171 168 2217
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2336 (class 2606 OID 26885)
-- Dependencies: 196 2245 171
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2337 (class 2606 OID 26890)
-- Dependencies: 171 2257 208
-- Name: si_despacho_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2338 (class 2606 OID 26895)
-- Dependencies: 2261 171 211
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2339 (class 2606 OID 26900)
-- Dependencies: 2269 171 220
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2340 (class 2606 OID 26905)
-- Dependencies: 171 2273 223
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2341 (class 2606 OID 26910)
-- Dependencies: 2275 226 171
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2342 (class 2606 OID 26915)
-- Dependencies: 2281 229 171
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2343 (class 2606 OID 26920)
-- Dependencies: 174 198 2247
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2344 (class 2606 OID 26925)
-- Dependencies: 176 200 2249
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2345 (class 2606 OID 26930)
-- Dependencies: 2225 176 177
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2346 (class 2606 OID 26935)
-- Dependencies: 194 177 2243
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2347 (class 2606 OID 26940)
-- Dependencies: 177 2247 198
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2348 (class 2606 OID 26945)
-- Dependencies: 177 2249 200
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2349 (class 2606 OID 26950)
-- Dependencies: 208 2257 177
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2350 (class 2606 OID 26955)
-- Dependencies: 160 2211 179
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2351 (class 2606 OID 26960)
-- Dependencies: 168 179 2217
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2352 (class 2606 OID 26965)
-- Dependencies: 2247 179 198
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2353 (class 2606 OID 26970)
-- Dependencies: 2275 181 226
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2354 (class 2606 OID 26975)
-- Dependencies: 182 2231 181
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2355 (class 2606 OID 26980)
-- Dependencies: 2235 186 188
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2356 (class 2606 OID 26985)
-- Dependencies: 2239 190 191
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2357 (class 2606 OID 26990)
-- Dependencies: 2275 191 226
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2358 (class 2606 OID 26995)
-- Dependencies: 176 2225 194
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2359 (class 2606 OID 27000)
-- Dependencies: 160 196 2211
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2360 (class 2606 OID 27005)
-- Dependencies: 196 162 2213
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2361 (class 2606 OID 27010)
-- Dependencies: 168 196 2217
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2362 (class 2606 OID 27015)
-- Dependencies: 2225 176 198
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2363 (class 2606 OID 27020)
-- Dependencies: 2243 194 198
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2364 (class 2606 OID 27025)
-- Dependencies: 198 2249 200
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2365 (class 2606 OID 27030)
-- Dependencies: 198 205 2247
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2393 (class 2606 OID 27200)
-- Dependencies: 198 234 2247
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2366 (class 2606 OID 27040)
-- Dependencies: 2225 208 176
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2367 (class 2606 OID 27045)
-- Dependencies: 194 208 2243
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2368 (class 2606 OID 27050)
-- Dependencies: 198 208 2247
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2369 (class 2606 OID 27055)
-- Dependencies: 200 208 2249
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2370 (class 2606 OID 27060)
-- Dependencies: 2211 210 160
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2408 (class 2606 OID 27406)
-- Dependencies: 244 176 2225
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2409 (class 2606 OID 27411)
-- Dependencies: 244 2243 194
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2406 (class 2606 OID 27396)
-- Dependencies: 2247 198 244
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2407 (class 2606 OID 27401)
-- Dependencies: 200 2249 244
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2371 (class 2606 OID 27065)
-- Dependencies: 211 2213 162
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2372 (class 2606 OID 27070)
-- Dependencies: 176 211 2225
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2373 (class 2606 OID 27075)
-- Dependencies: 2243 194 211
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2374 (class 2606 OID 27080)
-- Dependencies: 200 2249 211
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2404 (class 2606 OID 27440)
-- Dependencies: 2211 160 242
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2405 (class 2606 OID 27445)
-- Dependencies: 2217 242 168
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2403 (class 2606 OID 27435)
-- Dependencies: 213 2263 242
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2375 (class 2606 OID 27085)
-- Dependencies: 213 154 2205
-- Name: si_recepcion_id_asociado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);


--
-- TOC entry 2376 (class 2606 OID 27090)
-- Dependencies: 213 2211 160
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2377 (class 2606 OID 27095)
-- Dependencies: 164 2215 213
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2378 (class 2606 OID 27100)
-- Dependencies: 2231 213 181
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2379 (class 2606 OID 27105)
-- Dependencies: 208 213 2257
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2380 (class 2606 OID 27110)
-- Dependencies: 213 220 2269
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2381 (class 2606 OID 27115)
-- Dependencies: 226 213 2275
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2382 (class 2606 OID 27120)
-- Dependencies: 2265 216 215
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2383 (class 2606 OID 27125)
-- Dependencies: 141 2191 220
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2384 (class 2606 OID 27130)
-- Dependencies: 160 2211 220
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2385 (class 2606 OID 27135)
-- Dependencies: 160 222 2211
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2386 (class 2606 OID 27140)
-- Dependencies: 2211 160 223
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2387 (class 2606 OID 27145)
-- Dependencies: 141 228 2191
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2388 (class 2606 OID 27150)
-- Dependencies: 2253 228 204
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2389 (class 2606 OID 27155)
-- Dependencies: 226 228 2275
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-03-16 11:05:55 VET

--
-- PostgreSQL database dump complete
--

