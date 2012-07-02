--
-- PostgreSQL database dump
--

-- Started on 2012-07-02 15:48:02 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 258 (class 1255 OID 34313)
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
-- TOC entry 140 (class 1259 OID 34314)
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
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 140
-- Name: si_almacenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_almacenes_id_seq', 9, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 141 (class 1259 OID 34316)
-- Dependencies: 2106 6
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
-- TOC entry 142 (class 1259 OID 34323)
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
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 142
-- Name: si_analisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_id_seq', 39, true);


--
-- TOC entry 143 (class 1259 OID 34325)
-- Dependencies: 2107 2108 2109 6
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
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 143
-- Name: TABLE si_analisis; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';


--
-- TOC entry 144 (class 1259 OID 34331)
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
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE si_analisis_centro_acopio; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';


--
-- TOC entry 145 (class 1259 OID 34334)
-- Dependencies: 6 144
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
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;


--
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 145
-- Name: si_analisis_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);


--
-- TOC entry 146 (class 1259 OID 34336)
-- Dependencies: 2111 2112 2113 2114 2115 2116 6
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
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE si_analisis_cultivo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';


--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN si_analisis_cultivo.estatus; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';


--
-- TOC entry 147 (class 1259 OID 34345)
-- Dependencies: 146 6
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_analisis_cultivo_id_seq OWNER TO admin;

--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;


--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 147
-- Name: si_analisis_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 2286, true);


--
-- TOC entry 148 (class 1259 OID 34347)
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
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE si_analisis_resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';


--
-- TOC entry 149 (class 1259 OID 34350)
-- Dependencies: 6 148
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_analisis_resultado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_analisis_resultado_id_seq OWNER TO admin;

--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 149
-- Name: si_analisis_resultado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 68, true);


--
-- TOC entry 150 (class 1259 OID 34352)
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
-- TOC entry 151 (class 1259 OID 34358)
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
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 151
-- Name: si_asociado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_asociado_id_seq', 1, false);


--
-- TOC entry 152 (class 1259 OID 34360)
-- Dependencies: 6
-- Name: si_cargo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cargo_id_seq OWNER TO admin;

--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 152
-- Name: si_cargo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_id_seq', 0, true);


--
-- TOC entry 153 (class 1259 OID 34362)
-- Dependencies: 2119 6
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
-- TOC entry 154 (class 1259 OID 34366)
-- Dependencies: 6
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cargo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cargo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 154
-- Name: si_cargo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 0, true);


--
-- TOC entry 155 (class 1259 OID 34368)
-- Dependencies: 2120 2121 6
-- Name: si_cargo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.si_cargo_tipo OWNER TO admin;

--
-- TOC entry 156 (class 1259 OID 34373)
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
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 156
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);


--
-- TOC entry 157 (class 1259 OID 34375)
-- Dependencies: 2122 2123 2124 2125 2126 2127 2128 6
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
-- TOC entry 158 (class 1259 OID 34388)
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
-- TOC entry 159 (class 1259 OID 34391)
-- Dependencies: 158 6
-- Name: si_choferes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_choferes_id_seq OWNER TO admin;

--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_choferes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 159
-- Name: si_choferes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_choferes_id_seq', 0, true);


--
-- TOC entry 160 (class 1259 OID 34393)
-- Dependencies: 6
-- Name: si_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cliente_id_seq OWNER TO admin;

--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 160
-- Name: si_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cliente_id_seq', 0, true);


--
-- TOC entry 161 (class 1259 OID 34395)
-- Dependencies: 2130 6
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
-- TOC entry 162 (class 1259 OID 34402)
-- Dependencies: 6
-- Name: si_cosecha_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cosecha_id_seq OWNER TO admin;

--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 0, true);


--
-- TOC entry 163 (class 1259 OID 34404)
-- Dependencies: 2131 2132 2133 2134 2135 6
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
-- TOC entry 164 (class 1259 OID 34415)
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
-- TOC entry 165 (class 1259 OID 34418)
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
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE si_cosecha_silo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';


--
-- TOC entry 166 (class 1259 OID 34421)
-- Dependencies: 165 6
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cosecha_silo_id_seq OWNER TO admin;

--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;


--
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_silo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 0, true);


--
-- TOC entry 167 (class 1259 OID 34423)
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
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 167
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
-- TOC entry 168 (class 1259 OID 34426)
-- Dependencies: 167 6
-- Name: si_cuarentena_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cuarentena_id_seq OWNER TO admin;

--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_cuarentena_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_cuarentena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_id_seq', 0, true);


--
-- TOC entry 169 (class 1259 OID 34428)
-- Dependencies: 2138 6
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
-- TOC entry 170 (class 1259 OID 34432)
-- Dependencies: 169 6
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cuarentena_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cuarentena_plaga_id_seq OWNER TO admin;

--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cuarentena_plaga_id_seq OWNED BY si_cuarentena_plaga.id;


--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_cuarentena_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cuarentena_plaga_id_seq', 0, true);


--
-- TOC entry 171 (class 1259 OID 34434)
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
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 171
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);


--
-- TOC entry 172 (class 1259 OID 34436)
-- Dependencies: 2140 2141 2142 6
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
    codigo bigint
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 173 (class 1259 OID 34442)
-- Dependencies: 2143 2144 6
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
-- TOC entry 174 (class 1259 OID 34447)
-- Dependencies: 6 173
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 0, true);


--
-- TOC entry 175 (class 1259 OID 34449)
-- Dependencies: 6
-- Name: si_denom_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_denom_tip_id_seq OWNER TO admin;

--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 175
-- Name: si_denom_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_denom_tip_id_seq', 0, true);


--
-- TOC entry 176 (class 1259 OID 34451)
-- Dependencies: 2146 6
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
-- TOC entry 177 (class 1259 OID 34455)
-- Dependencies: 2147 6
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
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 177
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
-- TOC entry 178 (class 1259 OID 34459)
-- Dependencies: 177 6
-- Name: si_despacho_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_despacho_id_seq OWNER TO admin;

--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_despacho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_despacho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_despacho_id_seq', 0, true);


--
-- TOC entry 179 (class 1259 OID 34461)
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
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 179
-- Name: si_ejes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ejes_id_seq', 5, true);


--
-- TOC entry 180 (class 1259 OID 34463)
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
-- TOC entry 181 (class 1259 OID 34468)
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
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 181
-- Name: si_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_estado_id_seq', 1, false);


--
-- TOC entry 182 (class 1259 OID 34470)
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
-- TOC entry 183 (class 1259 OID 34474)
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
-- TOC entry 184 (class 1259 OID 34481)
-- Dependencies: 183 6
-- Name: si_finca_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_finca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_finca_id_seq OWNER TO admin;

--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_finca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;


--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_finca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_finca_id_seq', 0, true);


--
-- TOC entry 185 (class 1259 OID 34483)
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
-- TOC entry 186 (class 1259 OID 34489)
-- Dependencies: 185 6
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
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_formulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_formulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_formulas_id_seq', 48, true);


--
-- TOC entry 187 (class 1259 OID 34491)
-- Dependencies: 2155 2156 6
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
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE si_guiarec; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';


--
-- TOC entry 188 (class 1259 OID 34496)
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
-- TOC entry 189 (class 1259 OID 34499)
-- Dependencies: 188 6
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_guiarec_det_id_seq OWNER TO admin;

--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;


--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 189
-- Name: si_guiarec_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_det_id_seq', 0, true);


--
-- TOC entry 190 (class 1259 OID 34501)
-- Dependencies: 187 6
-- Name: si_guiarec_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_guiarec_id_seq OWNER TO admin;

--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_guiarec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;


--
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 190
-- Name: si_guiarec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_guiarec_id_seq', 0, true);


--
-- TOC entry 191 (class 1259 OID 34503)
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
-- TOC entry 192 (class 1259 OID 34506)
-- Dependencies: 191 6
-- Name: si_impresora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_impresora_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_impresora_id_seq OWNER TO admin;

--
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_impresora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_impresora_id_seq OWNED BY si_impresora.id;


--
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 192
-- Name: si_impresora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_impresora_id_seq', 2, true);


--
-- TOC entry 193 (class 1259 OID 34508)
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
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 193
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 194 (class 1259 OID 34510)
-- Dependencies: 2160 6
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
-- TOC entry 195 (class 1259 OID 34514)
-- Dependencies: 6
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_log_consultas_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_log_consultas_log_id_seq OWNER TO admin;

--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 195
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 0, true);


--
-- TOC entry 196 (class 1259 OID 34516)
-- Dependencies: 2161 6
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
-- TOC entry 197 (class 1259 OID 34523)
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
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 197
-- Name: si_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_menu_id_seq', 47, true);


--
-- TOC entry 198 (class 1259 OID 34525)
-- Dependencies: 2162 2163 6
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
-- TOC entry 199 (class 1259 OID 34530)
-- Dependencies: 2164 2165 2166 2167 6
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
-- TOC entry 200 (class 1259 OID 34537)
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
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 200
-- Name: si_municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);


--
-- TOC entry 201 (class 1259 OID 34539)
-- Dependencies: 2168 6
-- Name: si_municipio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_municipio OWNER TO admin;

--
-- TOC entry 202 (class 1259 OID 34543)
-- Dependencies: 6
-- Name: si_ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_ordenes_id_seq OWNER TO admin;

--
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 202
-- Name: si_ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_id_seq', 0, true);


--
-- TOC entry 203 (class 1259 OID 34545)
-- Dependencies: 2169 2170 6
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
-- TOC entry 204 (class 1259 OID 34553)
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
-- TOC entry 205 (class 1259 OID 34556)
-- Dependencies: 204 6
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_ordenes_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_ordenes_det_id_seq OWNER TO admin;

--
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_ordenes_det_id_seq OWNED BY si_ordenes_det.id;


--
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 205
-- Name: si_ordenes_det_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_ordenes_det_id_seq', 0, true);


--
-- TOC entry 206 (class 1259 OID 34558)
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
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 206
-- Name: si_organizacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);


--
-- TOC entry 207 (class 1259 OID 34560)
-- Dependencies: 2172 6
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
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE si_organizacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';


--
-- TOC entry 208 (class 1259 OID 34567)
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
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 208
-- Name: si_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_pais_id_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 34569)
-- Dependencies: 2173 6
-- Name: si_pais; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_pais OWNER TO admin;

--
-- TOC entry 210 (class 1259 OID 34573)
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
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 210
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);


--
-- TOC entry 211 (class 1259 OID 34575)
-- Dependencies: 2174 6
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
-- TOC entry 212 (class 1259 OID 34582)
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
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 212
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 7, true);


--
-- TOC entry 213 (class 1259 OID 34584)
-- Dependencies: 2175 6
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
-- TOC entry 214 (class 1259 OID 34588)
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
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE si_plaga; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';


--
-- TOC entry 215 (class 1259 OID 34591)
-- Dependencies: 214 6
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
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_plaga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;


--
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 215
-- Name: si_plaga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);


--
-- TOC entry 216 (class 1259 OID 34593)
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
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE si_producto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';


--
-- TOC entry 217 (class 1259 OID 34596)
-- Dependencies: 6 216
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
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 217
-- Name: si_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_producto_id_seq', 3, true);


--
-- TOC entry 218 (class 1259 OID 34598)
-- Dependencies: 6
-- Name: si_productor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_productor_id_seq OWNER TO admin;

--
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 218
-- Name: si_productor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_productor_id_seq', 0, true);


--
-- TOC entry 219 (class 1259 OID 34600)
-- Dependencies: 2178 6
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
-- TOC entry 220 (class 1259 OID 34607)
-- Dependencies: 6
-- Name: si_programa_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_programa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_programa_id_seq OWNER TO admin;

--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 220
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 0, true);


--
-- TOC entry 221 (class 1259 OID 34609)
-- Dependencies: 2179 6
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
-- TOC entry 222 (class 1259 OID 34616)
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
-- TOC entry 223 (class 1259 OID 34622)
-- Dependencies: 6 222
-- Name: si_proveedor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_proveedor_id_seq OWNER TO admin;

--
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 223
-- Name: si_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 223
-- Name: si_proveedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_proveedor_id_seq', 0, true);


--
-- TOC entry 224 (class 1259 OID 34624)
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE si_punto_entrega; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';


--
-- TOC entry 225 (class 1259 OID 34630)
-- Dependencies: 6 224
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_punto_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_punto_entrega_id_seq OWNER TO admin;

--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 225
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;


--
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 225
-- Name: si_punto_entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_punto_entrega_id_seq', 0, true);


--
-- TOC entry 226 (class 1259 OID 34632)
-- Dependencies: 2182 2183 2184 2185 6
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
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 226
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
-- TOC entry 227 (class 1259 OID 34639)
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
-- TOC entry 228 (class 1259 OID 34642)
-- Dependencies: 227 6
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_recepcion_cultivo_tipo_id_seq OWNER TO admin;

--
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 228
-- Name: si_recepcion_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 0, true);


--
-- TOC entry 229 (class 1259 OID 34644)
-- Dependencies: 6 226
-- Name: si_recepcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_recepcion_id_seq OWNER TO admin;

--
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_recepcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;


--
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 229
-- Name: si_recepcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recepcion_id_seq', 0, true);


--
-- TOC entry 230 (class 1259 OID 34646)
-- Dependencies: 2188 6
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
-- TOC entry 231 (class 1259 OID 34653)
-- Dependencies: 2190 6
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
-- TOC entry 232 (class 1259 OID 34660)
-- Dependencies: 6 231
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
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;


--
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 232
-- Name: si_recursos_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 57, true);


--
-- TOC entry 233 (class 1259 OID 34662)
-- Dependencies: 230 6
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
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;


--
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 233
-- Name: si_recursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_recursos_id_seq', 79, true);


--
-- TOC entry 234 (class 1259 OID 34664)
-- Dependencies: 6
-- Name: si_silos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_silos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_silos_id_seq OWNER TO admin;

--
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 234
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 79, true);


--
-- TOC entry 235 (class 1259 OID 34666)
-- Dependencies: 2192 2193 6
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
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE si_silos; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';


--
-- TOC entry 236 (class 1259 OID 34674)
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
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 236
-- Name: si_tolcarom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);


--
-- TOC entry 237 (class 1259 OID 34676)
-- Dependencies: 2194 2195 2196 6
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
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE si_tolcarom; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';


--
-- TOC entry 238 (class 1259 OID 34682)
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
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE si_transporte; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';


--
-- TOC entry 239 (class 1259 OID 34688)
-- Dependencies: 238 6
-- Name: si_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_transporte_id_seq OWNER TO admin;

--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;


--
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 239
-- Name: si_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_transporte_id_seq', 0, true);


--
-- TOC entry 240 (class 1259 OID 34690)
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
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 240
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 13, true);


--
-- TOC entry 241 (class 1259 OID 34692)
-- Dependencies: 2198 2199 2200 6
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
-- TOC entry 242 (class 1259 OID 34701)
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
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 242
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 13, true);


--
-- TOC entry 243 (class 1259 OID 34703)
-- Dependencies: 2201 6
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
-- TOC entry 244 (class 1259 OID 34707)
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
-- TOC entry 245 (class 1259 OID 34710)
-- Dependencies: 6 244
-- Name: si_vehiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_vehiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.si_vehiculos_id_seq OWNER TO admin;

--
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_vehiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;


--
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 245
-- Name: si_vehiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_vehiculos_id_seq', 0, true);


--
-- TOC entry 2110 (class 2604 OID 34712)
-- Dependencies: 145 144
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);


--
-- TOC entry 2117 (class 2604 OID 34713)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);


--
-- TOC entry 2118 (class 2604 OID 34714)
-- Dependencies: 149 148
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);


--
-- TOC entry 2129 (class 2604 OID 34715)
-- Dependencies: 159 158
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);


--
-- TOC entry 2136 (class 2604 OID 34716)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);


--
-- TOC entry 2137 (class 2604 OID 34717)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);


--
-- TOC entry 2139 (class 2604 OID 34718)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_plaga_id_seq'::regclass);


--
-- TOC entry 2145 (class 2604 OID 34719)
-- Dependencies: 174 173
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2148 (class 2604 OID 34720)
-- Dependencies: 178 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);


--
-- TOC entry 2153 (class 2604 OID 34721)
-- Dependencies: 184 183
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);


--
-- TOC entry 2154 (class 2604 OID 34722)
-- Dependencies: 186 185
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);


--
-- TOC entry 2157 (class 2604 OID 34723)
-- Dependencies: 190 187
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);


--
-- TOC entry 2158 (class 2604 OID 34724)
-- Dependencies: 189 188
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);


--
-- TOC entry 2159 (class 2604 OID 34725)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_impresora ALTER COLUMN id SET DEFAULT nextval('si_impresora_id_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 34726)
-- Dependencies: 205 204
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det ALTER COLUMN id SET DEFAULT nextval('si_ordenes_det_id_seq'::regclass);


--
-- TOC entry 2176 (class 2604 OID 34727)
-- Dependencies: 215 214
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 34728)
-- Dependencies: 217 216
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);


--
-- TOC entry 2180 (class 2604 OID 34729)
-- Dependencies: 223 222
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 34730)
-- Dependencies: 225 224
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 34731)
-- Dependencies: 229 226
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 34732)
-- Dependencies: 228 227
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 2189 (class 2604 OID 34733)
-- Dependencies: 233 230
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 34734)
-- Dependencies: 232 231
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 34735)
-- Dependencies: 239 238
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 34736)
-- Dependencies: 245 244
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);


--
-- TOC entry 2435 (class 0 OID 34316)
-- Dependencies: 141
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
INSERT INTO si_almacenes VALUES (2, 2, 'ALMACEN - SILOS', NULL, 1, 18, 227, NULL, NULL, NULL, true, NULL, '2012-02-13 11:01:40.114191', '2012-02-23 11:49:10.809611', 2, '1');


--
-- TOC entry 2436 (class 0 OID 34325)
-- Dependencies: 143
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
-- TOC entry 2437 (class 0 OID 34331)
-- Dependencies: 144
-- Data for Name: si_analisis_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2438 (class 0 OID 34336)
-- Dependencies: 146
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
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 18, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 19, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 20, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 21, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 22, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 23, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 24, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 26, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 27, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 28, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 39, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 40, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 41, 12.000, 24.000, 12.000, 12.900, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 42, 0.000, 10.000, 0.000, 5.100, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 43, 0.000, 2.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 44, 0.000, 1.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 45, 0.600, 0.760, 0.600, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 46, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 48, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 49, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 50, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 51, 11.000, 22.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 52, 0.000, 11.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 53, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 54, 0.000, 8.000, 0.000, 5.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 55, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 56, 0.680, 0.730, 0.680, 0.730, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 57, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 59, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 60, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 61, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 62, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 73, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 74, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 75, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 76, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 77, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 78, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 79, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 81, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 82, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 83, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 84, 0.000, 0.000, 0.000, 0.000, 2);
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
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 98, 715.000, 0.790, 715.000, 0.760, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 99, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 100, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 101, 12.500, 15.000, 12.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 102, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 104, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 105, 0.000, 4.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 106, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 107, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 108, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 109, 0.000, 13.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 110, 0.000, 26.000, 0.000, 26.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 111, 0.000, 3.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 112, 12.000, 24.000, 12.000, 24.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 113, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 114, 0.000, 40.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 116, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 117, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 118, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 119, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 120, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 121, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 122, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 123, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 124, 0.000, 50.000, 0.000, 50.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 125, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 126, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 127, 0.000, 8.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 128, 40.000, 60.000, 45.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 129, 65.000, 70.000, 65.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 130, 25.000, 39.000, 30.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 131, 16.000, 28.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 132, 0.000, 11.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 133, 0.000, 100.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 135, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 136, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 137, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 138, 0.000, 0.000, 0.000, 4.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 139, 0.000, 5.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 140, 0.000, 4.000, 0.000, 8.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 141, 0.000, 11.000, 0.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 142, 0.000, 15.000, 0.000, 18.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 143, 0.000, 26.000, 0.000, 25.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 144, 0.000, 11.000, 0.000, 4.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 145, 0.000, 20.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 146, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 147, 40.000, 999.000, 46.000, 65.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 148, 59.000, 999.000, 50.000, 70.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 149, 22.000, 46.000, 20.000, 39.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 150, 8.000, 19.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 151, 0.000, 8.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 152, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 153, 12.000, 26.000, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 154, 0.000, 5.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 155, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 156, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 157, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 158, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 159, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 160, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 161, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 162, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 163, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 164, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 165, 0.710, 0.790, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 166, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 167, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 168, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 170, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 171, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 172, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 173, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 174, 6.000, 24.000, 6.000, 9.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 175, 0.000, 20.000, 0.000, 7.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 176, 0.330, 0.480, 0.330, 0.480, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 178, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 179, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 180, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 181, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 184, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 185, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 186, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 187, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 188, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 189, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 190, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 191, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 192, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 193, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 194, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 195, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 196, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 197, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 198, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 199, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 201, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 202, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 203, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 204, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 206, 12.000, 13.900, 12.000, 13.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 207, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 208, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 209, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 210, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 211, 0.000, 11.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 212, 0.000, 11.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 213, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 214, 0.000, 7.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 215, 0.000, 0.200, 0.000, 0.200, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 216, 0.000, 10.000, 0.000, 11.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 217, 0.000, 3.000, 0.000, 3.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 218, 0.730, 0.760, 0.710, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 219, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 220, 0.000, 20.000, 0.000, 20.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 221, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 223, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 224, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 225, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 226, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 227, 12.000, 30.000, 11.000, 14.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 228, 0.000, 5.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 229, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 230, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 231, 0.000, 3.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 232, 0.000, 11.000, 0.000, 30.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 233, 0.000, 11.000, 0.000, 60.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 234, 0.000, 7.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 235, 0.000, 15.000, 0.000, 15.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 236, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 237, 0.000, 10.000, 0.000, 10.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 238, 0.000, 6.000, 0.000, 6.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 239, 715.000, 0.790, 715.000, 0.790, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 240, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 241, 0.000, 20.000, 0.000, 40.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 242, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 244, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 245, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 246, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 247, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 248, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 249, 0.000, 0.000, 0.000, 0.500, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 250, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 251, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 252, 0.000, 2.000, 0.000, 2.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 253, 1.000, 2.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 254, 0.000, 1.000, 0.000, 1.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 17, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 25, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 47, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 58, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 80, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 103, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 115, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 134, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 169, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 177, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 182, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 183, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 200, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 205, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 222, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 243, 0.000, 0.000, 0.000, 0.000, 2);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 352, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 509, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 510, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 511, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 512, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 513, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 514, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 515, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 516, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 517, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 518, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 519, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 520, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 521, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 522, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 523, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 524, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 525, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 526, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 527, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 528, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 529, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 530, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 531, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 532, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 533, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 534, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 535, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 536, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 537, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 538, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 539, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 540, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 541, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 542, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 543, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 544, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 545, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 546, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 547, 12.000, 24.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 548, 0.000, 10.000, 0.000, 5.100, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 549, 0.000, 2.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 550, 0.000, 1.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 255, 12.000, 26.000, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 256, 0.000, 5.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 257, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 258, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 259, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 260, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 261, 0.000, 11.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 262, 0.000, 7.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 263, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 264, 0.000, 0.200, 0.000, 0.200, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 265, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 266, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 267, 0.710, 0.790, 0.710, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 268, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 269, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 270, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 271, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 272, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 273, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 274, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 275, 16.000, 28.000, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 276, 0.000, 11.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 277, 0.000, 100.000, 0.000, 40.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 278, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 279, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 280, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 281, 0.000, 0.000, 0.000, 4.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 282, 0.000, 5.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 283, 0.000, 4.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 284, 0.000, 11.000, 0.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 285, 0.000, 15.000, 0.000, 18.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 286, 0.000, 26.000, 0.000, 25.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 287, 0.000, 11.000, 0.000, 4.500, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 288, 0.000, 20.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 289, 0.000, 5.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 290, 40.000, 999.000, 46.000, 65.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 291, 59.000, 999.000, 50.000, 70.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 292, 22.000, 46.000, 20.000, 39.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 293, 12.000, 24.000, 12.000, 12.900, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 294, 0.000, 10.000, 0.000, 5.100, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 295, 0.000, 2.000, 0.000, 4.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 296, 0.000, 1.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 297, 0.600, 0.760, 0.600, 0.760, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 298, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 299, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 300, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 301, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 302, 11.000, 22.000, 11.000, 14.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 303, 0.000, 11.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 304, 0.000, 8.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 305, 0.000, 8.000, 0.000, 5.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 306, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 307, 0.680, 0.730, 0.680, 0.730, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 308, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 309, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 310, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 311, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 312, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 313, 0.000, 5.000, 0.000, 5.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 314, 0.000, 5.000, 0.000, 5.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 315, 12.000, 26.000, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 316, 0.000, 5.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 317, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 318, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 319, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 320, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 321, 0.000, 11.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 322, 0.000, 7.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 323, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 324, 0.000, 0.200, 0.000, 0.200, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 325, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 326, 0.710, 0.790, 0.710, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 327, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 328, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 329, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 330, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 331, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 332, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 333, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 334, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 335, 10.000, 26.000, 12.000, 12.900, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 336, 0.000, 7.000, 0.000, 7.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 337, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 338, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 339, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 340, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 341, 0.000, 17.000, 0.000, 17.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 342, 0.000, 10.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 343, 0.000, 30.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 344, 0.000, 20.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 345, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 346, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 347, 715.000, 0.790, 715.000, 0.760, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 348, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 349, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 350, 12.500, 15.000, 12.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 351, 0.000, 8.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 353, 0.000, 4.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 354, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 355, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 356, 0.000, 13.000, 0.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 357, 0.000, 13.000, 0.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 358, 0.000, 26.000, 0.000, 26.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 359, 0.000, 3.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 360, 12.000, 24.000, 12.000, 24.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 361, 0.000, 8.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 362, 0.000, 40.000, 0.000, 40.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 363, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 364, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 365, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 366, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 367, 0.000, 6.000, 0.000, 6.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 368, 0.000, 50.000, 0.000, 50.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 369, 0.000, 50.000, 0.000, 50.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 370, 0.000, 50.000, 0.000, 50.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 371, 0.000, 50.000, 0.000, 50.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 372, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 373, 0.000, 8.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 374, 0.000, 8.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 375, 40.000, 60.000, 45.000, 60.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 376, 65.000, 70.000, 65.000, 70.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 377, 25.000, 39.000, 30.000, 39.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 378, 16.000, 28.000, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 379, 0.000, 11.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 380, 0.000, 100.000, 0.000, 40.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 381, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 382, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 383, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 384, 0.000, 0.000, 0.000, 4.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 385, 0.000, 5.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 386, 0.000, 4.000, 0.000, 8.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 387, 0.000, 11.000, 0.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 388, 0.000, 15.000, 0.000, 18.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 389, 0.000, 26.000, 0.000, 25.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 390, 0.000, 11.000, 0.000, 4.500, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 391, 0.000, 20.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 392, 0.000, 5.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 393, 40.000, 999.000, 46.000, 65.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 394, 59.000, 999.000, 50.000, 70.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 395, 22.000, 46.000, 20.000, 39.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 396, 8.000, 19.000, 6.000, 9.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 397, 0.000, 8.000, 0.000, 7.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 398, 0.330, 0.480, 0.330, 0.480, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 399, 12.000, 26.000, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 400, 0.000, 5.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 401, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 402, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 403, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 404, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 405, 0.000, 11.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 406, 0.000, 7.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 407, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 408, 0.000, 0.200, 0.000, 0.200, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 409, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 410, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 411, 0.710, 0.790, 0.710, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 412, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 413, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 414, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 415, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 416, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 417, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 418, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 419, 6.000, 24.000, 6.000, 9.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 420, 0.000, 20.000, 0.000, 7.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 421, 0.330, 0.480, 0.330, 0.480, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 422, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 423, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 424, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 425, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 426, 12.000, 13.900, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 427, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 428, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 429, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 430, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 431, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 432, 0.000, 11.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 433, 0.000, 10.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 434, 0.000, 7.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 435, 0.000, 0.200, 0.000, 0.200, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 436, 0.000, 10.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 437, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 438, 0.730, 0.760, 0.710, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 439, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 440, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 441, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 442, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 443, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 444, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 445, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 446, 12.000, 13.900, 12.000, 13.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 447, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 448, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 449, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 450, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 451, 0.000, 11.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 452, 0.000, 11.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 453, 0.000, 10.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 454, 0.000, 7.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 455, 0.000, 0.200, 0.000, 0.200, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 456, 0.000, 10.000, 0.000, 11.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 457, 0.000, 3.000, 0.000, 3.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 458, 0.730, 0.760, 0.710, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 459, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 460, 0.000, 20.000, 0.000, 20.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 461, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 462, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 463, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 464, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 465, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 466, 12.000, 30.000, 11.000, 14.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 467, 0.000, 5.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 468, 0.000, 11.000, 0.000, 30.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 469, 0.000, 11.000, 0.000, 30.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 470, 0.000, 3.000, 0.000, 30.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 471, 0.000, 11.000, 0.000, 30.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 472, 0.000, 11.000, 0.000, 60.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 473, 0.000, 7.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 474, 0.000, 15.000, 0.000, 15.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 475, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 476, 0.000, 10.000, 0.000, 10.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 477, 0.000, 6.000, 0.000, 6.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 478, 715.000, 0.790, 715.000, 0.790, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 479, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 480, 0.000, 20.000, 0.000, 40.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 481, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 482, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 483, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 484, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 485, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 486, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 487, 0.000, 0.000, 0.000, 0.500, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 488, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 489, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 490, 0.000, 2.000, 0.000, 2.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 491, 1.000, 2.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 492, 0.000, 1.000, 0.000, 1.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 493, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 494, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 495, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 496, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 497, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 498, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 499, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 500, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 501, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 502, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 503, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 504, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 505, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 506, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 507, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 508, 0.000, 0.000, 0.000, 0.000, 3);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 551, 0.600, 0.760, 0.600, 0.760, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 552, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 553, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 554, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 555, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 556, 11.000, 22.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 557, 0.000, 11.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 558, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 559, 0.000, 8.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 560, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 561, 0.680, 0.730, 0.680, 0.730, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 562, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 563, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 564, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 565, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 566, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 567, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 568, 0.000, 5.000, 0.000, 5.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 569, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 570, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 571, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 572, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 573, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 574, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 575, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 576, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 577, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 578, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 579, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 580, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 581, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 582, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 583, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 584, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 585, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 586, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 587, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 588, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 589, 10.000, 26.000, 12.000, 12.900, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 590, 0.000, 7.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 591, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 592, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 593, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 594, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 595, 0.000, 17.000, 0.000, 17.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 596, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 597, 0.000, 30.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 598, 0.000, 20.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 599, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 600, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 601, 715.000, 0.790, 715.000, 0.760, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 602, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 603, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 604, 12.500, 15.000, 12.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 605, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 606, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 607, 0.000, 4.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 608, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 609, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 610, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 611, 0.000, 13.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 612, 0.000, 26.000, 0.000, 26.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 613, 0.000, 3.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 614, 12.000, 24.000, 12.000, 24.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 615, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 616, 0.000, 40.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 617, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 618, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 619, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 620, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 621, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 622, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 623, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 624, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 625, 0.000, 50.000, 0.000, 50.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 626, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 627, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 628, 0.000, 8.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 629, 40.000, 60.000, 45.000, 60.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 630, 65.000, 70.000, 65.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 631, 25.000, 39.000, 30.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 632, 16.000, 28.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 633, 0.000, 11.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 634, 0.000, 100.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 635, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 636, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 637, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 638, 0.000, 0.000, 0.000, 4.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 639, 0.000, 5.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 640, 0.000, 4.000, 0.000, 8.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 641, 0.000, 11.000, 0.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 642, 0.000, 15.000, 0.000, 18.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 643, 0.000, 26.000, 0.000, 25.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 644, 0.000, 11.000, 0.000, 4.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 645, 0.000, 20.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 646, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 647, 40.000, 999.000, 46.000, 65.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 648, 59.000, 999.000, 50.000, 70.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 649, 22.000, 46.000, 20.000, 39.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 650, 8.000, 19.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 651, 0.000, 8.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 652, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 653, 12.000, 26.000, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 654, 0.000, 5.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 655, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 656, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 657, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 658, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 659, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 660, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 661, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 662, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 663, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 664, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 665, 0.710, 0.790, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 666, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 667, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 668, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 669, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 670, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 671, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 672, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 673, 6.000, 24.000, 6.000, 9.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 674, 0.000, 20.000, 0.000, 7.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 675, 0.330, 0.480, 0.330, 0.480, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 676, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 677, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 678, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 679, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 680, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 681, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 682, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 683, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 684, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 685, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 686, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 687, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 688, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 689, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 690, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 691, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 692, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 693, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 694, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 695, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 696, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 697, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 698, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 699, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 700, 12.000, 13.900, 12.000, 13.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 701, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 702, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 703, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 704, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 705, 0.000, 11.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 706, 0.000, 11.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 707, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 708, 0.000, 7.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 709, 0.000, 0.200, 0.000, 0.200, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 710, 0.000, 10.000, 0.000, 11.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 711, 0.000, 3.000, 0.000, 3.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 712, 0.730, 0.760, 0.710, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 713, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 714, 0.000, 20.000, 0.000, 20.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 715, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 716, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 717, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 718, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 719, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 720, 12.000, 30.000, 11.000, 14.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 721, 0.000, 5.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 722, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 723, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 724, 0.000, 3.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 725, 0.000, 11.000, 0.000, 30.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 726, 0.000, 11.000, 0.000, 60.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 727, 0.000, 7.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 728, 0.000, 15.000, 0.000, 15.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 729, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 730, 0.000, 10.000, 0.000, 10.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 731, 0.000, 6.000, 0.000, 6.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 732, 715.000, 0.790, 715.000, 0.790, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 733, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 734, 0.000, 20.000, 0.000, 40.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 735, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 736, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 737, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 738, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 739, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 740, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 741, 0.000, 0.000, 0.000, 0.500, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 742, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 743, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 744, 0.000, 2.000, 0.000, 2.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 745, 1.000, 2.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 746, 0.000, 1.000, 0.000, 1.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 747, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 748, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 749, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 750, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 751, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 752, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 753, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 754, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 755, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 756, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 757, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 758, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 759, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 760, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 761, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 762, 0.000, 0.000, 0.000, 0.000, 4);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 763, 12.000, 26.000, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 764, 0.000, 5.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 765, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 766, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 767, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 768, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 769, 0.000, 11.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 770, 0.000, 7.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 771, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 772, 0.000, 0.200, 0.000, 0.200, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 773, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 774, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 775, 0.710, 0.790, 0.710, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 776, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 777, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 778, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 779, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 780, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 781, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 782, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 783, 16.000, 28.000, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 784, 0.000, 11.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 785, 0.000, 100.000, 0.000, 40.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 786, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 787, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 788, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 789, 0.000, 0.000, 0.000, 4.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 790, 0.000, 5.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 791, 0.000, 4.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 792, 0.000, 11.000, 0.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 793, 0.000, 15.000, 0.000, 18.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 794, 0.000, 26.000, 0.000, 25.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 795, 0.000, 11.000, 0.000, 4.500, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 796, 0.000, 20.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 797, 0.000, 5.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 798, 40.000, 999.000, 46.000, 65.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 799, 59.000, 999.000, 50.000, 70.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 800, 22.000, 46.000, 20.000, 39.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 801, 12.000, 24.000, 12.000, 12.900, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 802, 0.000, 10.000, 0.000, 5.100, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 803, 0.000, 2.000, 0.000, 4.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 804, 0.000, 1.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 805, 0.600, 0.760, 0.600, 0.760, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 806, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 807, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 808, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 809, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 810, 11.000, 22.000, 11.000, 14.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 811, 0.000, 11.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 812, 0.000, 8.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 813, 0.000, 8.000, 0.000, 5.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 814, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 815, 0.680, 0.730, 0.680, 0.730, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 816, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 817, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 818, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 819, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 820, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 821, 0.000, 5.000, 0.000, 5.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 822, 0.000, 5.000, 0.000, 5.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 823, 12.000, 26.000, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 824, 0.000, 5.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 825, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 826, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 827, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 828, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 829, 0.000, 11.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 830, 0.000, 7.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 831, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 832, 0.000, 0.200, 0.000, 0.200, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 833, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 834, 0.710, 0.790, 0.710, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 835, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 836, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 837, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 838, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 839, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 840, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 841, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 842, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 843, 10.000, 26.000, 12.000, 12.900, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 844, 0.000, 7.000, 0.000, 7.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 845, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 846, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 847, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 848, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 849, 0.000, 17.000, 0.000, 17.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 850, 0.000, 10.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 851, 0.000, 30.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 852, 0.000, 20.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 853, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 854, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 855, 715.000, 0.790, 715.000, 0.760, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 856, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 857, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 858, 12.500, 15.000, 12.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 859, 0.000, 8.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 860, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 861, 0.000, 4.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 862, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 863, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 864, 0.000, 13.000, 0.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 865, 0.000, 13.000, 0.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 866, 0.000, 26.000, 0.000, 26.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 867, 0.000, 3.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 868, 12.000, 24.000, 12.000, 24.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 869, 0.000, 8.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 870, 0.000, 40.000, 0.000, 40.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 871, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 872, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 873, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 874, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 875, 0.000, 6.000, 0.000, 6.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 876, 0.000, 50.000, 0.000, 50.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 877, 0.000, 50.000, 0.000, 50.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 878, 0.000, 50.000, 0.000, 50.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 879, 0.000, 50.000, 0.000, 50.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 880, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 881, 0.000, 8.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 882, 0.000, 8.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 883, 40.000, 60.000, 45.000, 60.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 884, 65.000, 70.000, 65.000, 70.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 885, 25.000, 39.000, 30.000, 39.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 886, 16.000, 28.000, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 887, 0.000, 11.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 888, 0.000, 100.000, 0.000, 40.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 889, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 890, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 891, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 892, 0.000, 0.000, 0.000, 4.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 893, 0.000, 5.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 894, 0.000, 4.000, 0.000, 8.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 895, 0.000, 11.000, 0.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 896, 0.000, 15.000, 0.000, 18.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 897, 0.000, 26.000, 0.000, 25.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 898, 0.000, 11.000, 0.000, 4.500, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 899, 0.000, 20.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 900, 0.000, 5.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 901, 40.000, 999.000, 46.000, 65.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 902, 59.000, 999.000, 50.000, 70.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 903, 22.000, 46.000, 20.000, 39.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 904, 8.000, 19.000, 6.000, 9.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 905, 0.000, 8.000, 0.000, 7.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 906, 0.330, 0.480, 0.330, 0.480, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 907, 12.000, 26.000, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 908, 0.000, 5.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 909, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 910, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 911, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 912, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 913, 0.000, 11.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 914, 0.000, 7.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 915, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 916, 0.000, 0.200, 0.000, 0.200, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 917, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 918, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 919, 0.710, 0.790, 0.710, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 920, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 921, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 922, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 923, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 924, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 925, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 926, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 927, 6.000, 24.000, 6.000, 9.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 928, 0.000, 20.000, 0.000, 7.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 929, 0.330, 0.480, 0.330, 0.480, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 930, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 931, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 932, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 933, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 934, 12.000, 13.900, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 935, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 936, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 937, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 938, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 939, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 940, 0.000, 11.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 941, 0.000, 10.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 942, 0.000, 7.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 943, 0.000, 0.200, 0.000, 0.200, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 944, 0.000, 10.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 945, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 946, 0.730, 0.760, 0.710, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 947, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 948, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 949, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 950, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 951, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 952, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 953, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 954, 12.000, 13.900, 12.000, 13.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 955, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 956, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 957, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 958, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 959, 0.000, 11.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 960, 0.000, 11.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 961, 0.000, 10.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 962, 0.000, 7.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 963, 0.000, 0.200, 0.000, 0.200, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 964, 0.000, 10.000, 0.000, 11.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 965, 0.000, 3.000, 0.000, 3.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 966, 0.730, 0.760, 0.710, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 967, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 968, 0.000, 20.000, 0.000, 20.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 969, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 970, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 971, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 972, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 973, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 974, 12.000, 30.000, 11.000, 14.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 975, 0.000, 5.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 976, 0.000, 11.000, 0.000, 30.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 977, 0.000, 11.000, 0.000, 30.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 978, 0.000, 3.000, 0.000, 30.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 979, 0.000, 11.000, 0.000, 30.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 980, 0.000, 11.000, 0.000, 60.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 981, 0.000, 7.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 982, 0.000, 15.000, 0.000, 15.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 983, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 984, 0.000, 10.000, 0.000, 10.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 985, 0.000, 6.000, 0.000, 6.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 986, 715.000, 0.790, 715.000, 0.790, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 987, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 988, 0.000, 20.000, 0.000, 40.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 989, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 990, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 991, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 992, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 993, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 994, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 995, 0.000, 0.000, 0.000, 0.500, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 996, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 997, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 998, 0.000, 2.000, 0.000, 2.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 999, 1.000, 2.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1000, 0.000, 1.000, 0.000, 1.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1001, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1002, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1003, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1004, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1005, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1006, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1007, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1008, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1009, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1010, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1011, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1012, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1013, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1014, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1015, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1016, 0.000, 0.000, 0.000, 0.000, 5);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1525, 12.000, 26.000, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1526, 0.000, 5.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1527, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1528, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1529, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1530, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1531, 0.000, 11.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1532, 0.000, 7.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1533, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1534, 0.000, 0.200, 0.000, 0.200, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1535, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1536, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1537, 0.710, 0.790, 0.710, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1538, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1539, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1540, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1541, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1542, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1543, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1544, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1545, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1546, 16.000, 28.000, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1547, 0.000, 11.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1548, 0.000, 100.000, 0.000, 40.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1549, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1550, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1551, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1552, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1553, 0.000, 0.000, 0.000, 4.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1554, 0.000, 5.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1555, 0.000, 4.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1556, 0.000, 11.000, 0.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1557, 0.000, 15.000, 0.000, 18.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1558, 0.000, 26.000, 0.000, 25.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1559, 0.000, 11.000, 0.000, 4.500, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1560, 0.000, 20.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1561, 0.000, 5.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1562, 40.000, 999.000, 46.000, 65.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1563, 59.000, 999.000, 50.000, 70.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1564, 22.000, 46.000, 20.000, 39.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1565, 12.000, 24.000, 12.000, 12.900, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1566, 0.000, 10.000, 0.000, 5.100, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1567, 0.000, 2.000, 0.000, 4.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1568, 0.000, 1.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1569, 0.600, 0.760, 0.600, 0.760, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1570, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1571, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1572, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1573, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1574, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1575, 11.000, 22.000, 11.000, 14.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1576, 0.000, 11.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1577, 0.000, 8.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1578, 0.000, 8.000, 0.000, 5.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1579, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1580, 0.680, 0.730, 0.680, 0.730, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1581, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1582, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1583, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1584, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1585, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1586, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1587, 0.000, 5.000, 0.000, 5.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1588, 0.000, 5.000, 0.000, 5.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1589, 12.000, 26.000, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1590, 0.000, 5.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1591, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1592, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1593, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1594, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1595, 0.000, 11.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1596, 0.000, 7.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1597, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1598, 0.000, 0.200, 0.000, 0.200, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1599, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1600, 0.710, 0.790, 0.710, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1601, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1602, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1603, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1604, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1605, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1606, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1607, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1608, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1609, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1610, 10.000, 26.000, 12.000, 12.900, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1611, 0.000, 7.000, 0.000, 7.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1612, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1613, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1614, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1615, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1616, 0.000, 17.000, 0.000, 17.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1617, 0.000, 10.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1618, 0.000, 30.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1619, 0.000, 20.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1620, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1621, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1622, 715.000, 0.790, 715.000, 0.760, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1623, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1624, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1625, 12.500, 15.000, 12.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1626, 0.000, 8.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1627, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1628, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1629, 0.000, 4.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1630, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1631, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1632, 0.000, 13.000, 0.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1633, 0.000, 13.000, 0.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1634, 0.000, 26.000, 0.000, 26.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1635, 0.000, 3.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1636, 12.000, 24.000, 12.000, 24.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1637, 0.000, 8.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1638, 0.000, 40.000, 0.000, 40.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1639, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1640, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1641, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1642, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1643, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1644, 0.000, 6.000, 0.000, 6.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1645, 0.000, 50.000, 0.000, 50.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1646, 0.000, 50.000, 0.000, 50.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1647, 0.000, 50.000, 0.000, 50.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1648, 0.000, 50.000, 0.000, 50.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1649, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1650, 0.000, 8.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1651, 0.000, 8.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1652, 40.000, 60.000, 45.000, 60.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1653, 65.000, 70.000, 65.000, 70.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1654, 25.000, 39.000, 30.000, 39.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1655, 16.000, 28.000, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1656, 0.000, 11.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1657, 0.000, 100.000, 0.000, 40.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1658, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1659, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1660, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1661, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1662, 0.000, 0.000, 0.000, 4.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1663, 0.000, 5.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1664, 0.000, 4.000, 0.000, 8.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1665, 0.000, 11.000, 0.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1666, 0.000, 15.000, 0.000, 18.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1667, 0.000, 26.000, 0.000, 25.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1668, 0.000, 11.000, 0.000, 4.500, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1669, 0.000, 20.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1670, 0.000, 5.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1671, 40.000, 999.000, 46.000, 65.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1672, 59.000, 999.000, 50.000, 70.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1673, 22.000, 46.000, 20.000, 39.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1674, 8.000, 19.000, 6.000, 9.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1675, 0.000, 8.000, 0.000, 7.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1676, 0.330, 0.480, 0.330, 0.480, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1677, 12.000, 26.000, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1678, 0.000, 5.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1679, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1680, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1681, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1682, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1683, 0.000, 11.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1684, 0.000, 7.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1685, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1686, 0.000, 0.200, 0.000, 0.200, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1687, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1688, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1689, 0.710, 0.790, 0.710, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1690, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1691, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1692, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1693, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1694, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1695, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1696, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1697, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1698, 6.000, 24.000, 6.000, 9.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1699, 0.000, 20.000, 0.000, 7.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1700, 0.330, 0.480, 0.330, 0.480, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1701, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1702, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1703, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1704, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1705, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1706, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1707, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1708, 12.000, 13.900, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1709, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1710, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1711, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1712, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1713, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1714, 0.000, 11.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1715, 0.000, 10.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1716, 0.000, 7.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1717, 0.000, 0.200, 0.000, 0.200, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1718, 0.000, 10.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1719, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1720, 0.730, 0.760, 0.710, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1721, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1722, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1723, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1724, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1725, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1726, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1727, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1728, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1729, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1730, 12.000, 13.900, 12.000, 13.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1731, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1732, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1733, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1734, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1735, 0.000, 11.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1736, 0.000, 11.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1737, 0.000, 10.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1738, 0.000, 7.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1739, 0.000, 0.200, 0.000, 0.200, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1740, 0.000, 10.000, 0.000, 11.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1741, 0.000, 3.000, 0.000, 3.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1742, 0.730, 0.760, 0.710, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1743, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1744, 0.000, 20.000, 0.000, 20.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1745, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1746, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1747, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1748, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1749, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1750, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1751, 12.000, 30.000, 11.000, 14.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1752, 0.000, 5.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1753, 0.000, 11.000, 0.000, 30.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1754, 0.000, 11.000, 0.000, 30.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1755, 0.000, 3.000, 0.000, 30.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1756, 0.000, 11.000, 0.000, 30.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1757, 0.000, 11.000, 0.000, 60.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1758, 0.000, 7.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1759, 0.000, 15.000, 0.000, 15.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1760, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1761, 0.000, 10.000, 0.000, 10.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1762, 0.000, 6.000, 0.000, 6.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1763, 715.000, 0.790, 715.000, 0.790, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1764, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1765, 0.000, 20.000, 0.000, 40.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1766, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1767, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1768, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1769, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1770, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1771, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1772, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1773, 0.000, 0.000, 0.000, 0.500, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1774, 0.000, 0.000, 0.000, 0.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1775, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1776, 0.000, 2.000, 0.000, 2.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1777, 1.000, 2.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1017, 12.000, 26.000, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1018, 0.000, 5.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1019, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1020, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1021, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1022, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1023, 0.000, 11.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1024, 0.000, 7.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1025, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1026, 0.000, 0.200, 0.000, 0.200, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1027, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1028, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1029, 0.710, 0.790, 0.710, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1030, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1031, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1032, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1033, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1034, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1035, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1036, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1037, 16.000, 28.000, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1038, 0.000, 11.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1039, 0.000, 100.000, 0.000, 40.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1040, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1041, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1042, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1043, 0.000, 0.000, 0.000, 4.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1044, 0.000, 5.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1045, 0.000, 4.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1046, 0.000, 11.000, 0.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1047, 0.000, 15.000, 0.000, 18.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1048, 0.000, 26.000, 0.000, 25.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1049, 0.000, 11.000, 0.000, 4.500, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1050, 0.000, 20.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1051, 0.000, 5.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1052, 40.000, 999.000, 46.000, 65.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1053, 59.000, 999.000, 50.000, 70.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1054, 22.000, 46.000, 20.000, 39.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1055, 12.000, 24.000, 12.000, 12.900, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1056, 0.000, 10.000, 0.000, 5.100, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1057, 0.000, 2.000, 0.000, 4.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1058, 0.000, 1.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1059, 0.600, 0.760, 0.600, 0.760, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1060, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1061, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1062, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1063, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1064, 11.000, 22.000, 11.000, 14.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1065, 0.000, 11.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1066, 0.000, 8.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1067, 0.000, 8.000, 0.000, 5.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1068, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1069, 0.680, 0.730, 0.680, 0.730, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1070, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1071, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1072, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1073, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1074, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1075, 0.000, 5.000, 0.000, 5.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1076, 0.000, 5.000, 0.000, 5.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1077, 12.000, 26.000, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1078, 0.000, 5.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1079, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1080, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1081, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1082, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1083, 0.000, 11.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1084, 0.000, 7.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1085, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1086, 0.000, 0.200, 0.000, 0.200, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1087, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1088, 0.710, 0.790, 0.710, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1089, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1090, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1091, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1092, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1093, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1094, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1095, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1096, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1097, 10.000, 26.000, 12.000, 12.900, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1098, 0.000, 7.000, 0.000, 7.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1099, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1100, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1101, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1102, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1103, 0.000, 17.000, 0.000, 17.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1104, 0.000, 10.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1105, 0.000, 30.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1106, 0.000, 20.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1107, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1108, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1109, 715.000, 0.790, 715.000, 0.760, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1110, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1111, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1112, 12.500, 15.000, 12.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1113, 0.000, 8.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1114, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1115, 0.000, 4.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1116, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1117, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1118, 0.000, 13.000, 0.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1119, 0.000, 13.000, 0.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1120, 0.000, 26.000, 0.000, 26.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1121, 0.000, 3.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1122, 12.000, 24.000, 12.000, 24.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1123, 0.000, 8.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1124, 0.000, 40.000, 0.000, 40.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1125, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1126, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1127, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1128, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1129, 0.000, 6.000, 0.000, 6.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1130, 0.000, 50.000, 0.000, 50.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1131, 0.000, 50.000, 0.000, 50.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1132, 0.000, 50.000, 0.000, 50.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1133, 0.000, 50.000, 0.000, 50.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1134, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1135, 0.000, 8.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1136, 0.000, 8.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1137, 40.000, 60.000, 45.000, 60.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1138, 65.000, 70.000, 65.000, 70.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1139, 25.000, 39.000, 30.000, 39.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1140, 16.000, 28.000, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1141, 0.000, 11.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1142, 0.000, 100.000, 0.000, 40.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1143, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1144, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1145, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1146, 0.000, 0.000, 0.000, 4.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1147, 0.000, 5.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1148, 0.000, 4.000, 0.000, 8.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1149, 0.000, 11.000, 0.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1150, 0.000, 15.000, 0.000, 18.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1151, 0.000, 26.000, 0.000, 25.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1152, 0.000, 11.000, 0.000, 4.500, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1153, 0.000, 20.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1154, 0.000, 5.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1155, 40.000, 999.000, 46.000, 65.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1156, 59.000, 999.000, 50.000, 70.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1157, 22.000, 46.000, 20.000, 39.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1158, 8.000, 19.000, 6.000, 9.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1159, 0.000, 8.000, 0.000, 7.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1160, 0.330, 0.480, 0.330, 0.480, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1161, 12.000, 26.000, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1162, 0.000, 5.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1163, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1164, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1165, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1166, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1167, 0.000, 11.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1168, 0.000, 7.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1169, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1170, 0.000, 0.200, 0.000, 0.200, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1171, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1172, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1173, 0.710, 0.790, 0.710, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1174, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1175, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1176, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1177, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1178, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1179, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1180, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1181, 6.000, 24.000, 6.000, 9.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1182, 0.000, 20.000, 0.000, 7.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1183, 0.330, 0.480, 0.330, 0.480, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1184, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1185, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1186, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1187, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1188, 12.000, 13.900, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1189, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1190, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1191, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1192, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1193, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1194, 0.000, 11.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1195, 0.000, 10.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1196, 0.000, 7.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1197, 0.000, 0.200, 0.000, 0.200, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1198, 0.000, 10.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1199, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1200, 0.730, 0.760, 0.710, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1201, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1202, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1203, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1204, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1205, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1206, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1207, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1208, 12.000, 13.900, 12.000, 13.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1209, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1210, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1211, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1212, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1213, 0.000, 11.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1214, 0.000, 11.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1215, 0.000, 10.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1216, 0.000, 7.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1217, 0.000, 0.200, 0.000, 0.200, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1218, 0.000, 10.000, 0.000, 11.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1219, 0.000, 3.000, 0.000, 3.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1220, 0.730, 0.760, 0.710, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1221, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1222, 0.000, 20.000, 0.000, 20.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1223, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1224, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1225, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1226, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1227, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1228, 12.000, 30.000, 11.000, 14.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1229, 0.000, 5.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1230, 0.000, 11.000, 0.000, 30.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1231, 0.000, 11.000, 0.000, 30.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1232, 0.000, 3.000, 0.000, 30.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1233, 0.000, 11.000, 0.000, 30.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1234, 0.000, 11.000, 0.000, 60.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1235, 0.000, 7.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1236, 0.000, 15.000, 0.000, 15.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1237, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1238, 0.000, 10.000, 0.000, 10.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1239, 0.000, 6.000, 0.000, 6.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1240, 715.000, 0.790, 715.000, 0.790, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1241, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1242, 0.000, 20.000, 0.000, 40.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1243, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1244, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1245, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1246, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1247, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1248, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1249, 0.000, 0.000, 0.000, 0.500, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1250, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1251, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1252, 0.000, 2.000, 0.000, 2.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1253, 1.000, 2.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1254, 0.000, 1.000, 0.000, 1.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1255, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1256, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1257, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1258, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1259, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1260, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1261, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1262, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1263, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1264, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1265, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1266, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1267, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1268, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1269, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1270, 0.000, 0.000, 0.000, 0.000, 6);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1778, 0.000, 1.000, 0.000, 1.000, 8);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1271, 12.000, 26.000, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1272, 0.000, 5.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1273, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1274, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1275, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1276, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1277, 0.000, 11.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1278, 0.000, 7.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1279, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1280, 0.000, 0.200, 0.000, 0.200, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1281, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1282, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1283, 0.710, 0.790, 0.710, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1284, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1285, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1286, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1287, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1288, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1289, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1290, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1291, 16.000, 28.000, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1292, 0.000, 11.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1293, 0.000, 100.000, 0.000, 40.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1294, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1295, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1296, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1297, 0.000, 0.000, 0.000, 4.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1298, 0.000, 5.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1299, 0.000, 4.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1300, 0.000, 11.000, 0.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1301, 0.000, 15.000, 0.000, 18.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1302, 0.000, 26.000, 0.000, 25.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1303, 0.000, 11.000, 0.000, 4.500, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1304, 0.000, 20.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1305, 0.000, 5.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1306, 40.000, 999.000, 46.000, 65.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1307, 59.000, 999.000, 50.000, 70.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1308, 22.000, 46.000, 20.000, 39.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1309, 12.000, 24.000, 12.000, 12.900, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1310, 0.000, 10.000, 0.000, 5.100, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1311, 0.000, 2.000, 0.000, 4.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1312, 0.000, 1.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1313, 0.600, 0.760, 0.600, 0.760, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1314, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1315, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1316, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1317, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1318, 11.000, 22.000, 11.000, 14.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1319, 0.000, 11.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1320, 0.000, 8.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1321, 0.000, 8.000, 0.000, 5.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1322, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1323, 0.680, 0.730, 0.680, 0.730, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1324, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1325, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1326, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1327, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1328, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1329, 0.000, 5.000, 0.000, 5.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1330, 0.000, 5.000, 0.000, 5.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1331, 12.000, 26.000, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1332, 0.000, 5.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1333, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1334, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1335, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1336, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1337, 0.000, 11.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1338, 0.000, 7.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1339, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1340, 0.000, 0.200, 0.000, 0.200, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1341, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1342, 0.710, 0.790, 0.710, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1343, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1344, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1345, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1346, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1347, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1348, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1349, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1350, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1351, 10.000, 26.000, 12.000, 12.900, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1352, 0.000, 7.000, 0.000, 7.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1353, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1354, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1355, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1356, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1357, 0.000, 17.000, 0.000, 17.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1358, 0.000, 10.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1359, 0.000, 30.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1360, 0.000, 20.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1361, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1362, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1363, 715.000, 0.790, 715.000, 0.760, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1364, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1365, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1366, 12.500, 15.000, 12.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1367, 0.000, 8.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1368, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1369, 0.000, 4.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1370, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1371, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1372, 0.000, 13.000, 0.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1373, 0.000, 13.000, 0.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1374, 0.000, 26.000, 0.000, 26.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1375, 0.000, 3.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1376, 12.000, 24.000, 12.000, 24.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1377, 0.000, 8.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1378, 0.000, 40.000, 0.000, 40.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1379, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1380, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1381, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1382, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1383, 0.000, 6.000, 0.000, 6.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1384, 0.000, 50.000, 0.000, 50.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1385, 0.000, 50.000, 0.000, 50.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1386, 0.000, 50.000, 0.000, 50.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1387, 0.000, 50.000, 0.000, 50.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1388, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1389, 0.000, 8.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1390, 0.000, 8.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1391, 40.000, 60.000, 45.000, 60.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1392, 65.000, 70.000, 65.000, 70.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1393, 25.000, 39.000, 30.000, 39.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1394, 16.000, 28.000, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1395, 0.000, 11.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1396, 0.000, 100.000, 0.000, 40.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1397, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1398, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1399, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1400, 0.000, 0.000, 0.000, 4.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1401, 0.000, 5.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1402, 0.000, 4.000, 0.000, 8.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1403, 0.000, 11.000, 0.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1404, 0.000, 15.000, 0.000, 18.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1405, 0.000, 26.000, 0.000, 25.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1406, 0.000, 11.000, 0.000, 4.500, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1407, 0.000, 20.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1408, 0.000, 5.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1409, 40.000, 999.000, 46.000, 65.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1410, 59.000, 999.000, 50.000, 70.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1411, 22.000, 46.000, 20.000, 39.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1412, 8.000, 19.000, 6.000, 9.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1413, 0.000, 8.000, 0.000, 7.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1414, 0.330, 0.480, 0.330, 0.480, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1415, 12.000, 26.000, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1416, 0.000, 5.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1417, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1418, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1419, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1420, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1421, 0.000, 11.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1422, 0.000, 7.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1423, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1424, 0.000, 0.200, 0.000, 0.200, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1425, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1426, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1427, 0.710, 0.790, 0.710, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1428, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1429, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1430, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1431, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1432, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1433, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1434, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1435, 6.000, 24.000, 6.000, 9.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1436, 0.000, 20.000, 0.000, 7.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1437, 0.330, 0.480, 0.330, 0.480, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1438, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1439, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1440, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1441, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1442, 12.000, 13.900, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1443, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1444, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1445, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1446, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1447, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1448, 0.000, 11.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1449, 0.000, 10.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1450, 0.000, 7.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1451, 0.000, 0.200, 0.000, 0.200, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1452, 0.000, 10.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1453, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1454, 0.730, 0.760, 0.710, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1455, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1456, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1457, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1458, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1459, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1460, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1461, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1462, 12.000, 13.900, 12.000, 13.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1463, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1464, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1465, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1466, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1467, 0.000, 11.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1468, 0.000, 11.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1469, 0.000, 10.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1470, 0.000, 7.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1471, 0.000, 0.200, 0.000, 0.200, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1472, 0.000, 10.000, 0.000, 11.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1473, 0.000, 3.000, 0.000, 3.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1474, 0.730, 0.760, 0.710, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1475, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1476, 0.000, 20.000, 0.000, 20.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1477, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 1478, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 1479, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 1480, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 1481, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 1482, 12.000, 30.000, 11.000, 14.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 1483, 0.000, 5.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 1484, 0.000, 11.000, 0.000, 30.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 1485, 0.000, 11.000, 0.000, 30.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 1486, 0.000, 3.000, 0.000, 30.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 1487, 0.000, 11.000, 0.000, 30.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 1488, 0.000, 11.000, 0.000, 60.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 1489, 0.000, 7.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 1490, 0.000, 15.000, 0.000, 15.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 1491, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 1492, 0.000, 10.000, 0.000, 10.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 1493, 0.000, 6.000, 0.000, 6.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 1494, 715.000, 0.790, 715.000, 0.790, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 1495, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 1496, 0.000, 20.000, 0.000, 40.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 1497, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 1498, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 1499, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 1500, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 1501, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 1502, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 1503, 0.000, 0.000, 0.000, 0.500, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 1504, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 1505, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 1506, 0.000, 2.000, 0.000, 2.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 1507, 1.000, 2.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 1508, 0.000, 1.000, 0.000, 1.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1509, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1510, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1511, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1512, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1513, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1514, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1515, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1516, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1517, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1518, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1519, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1520, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1521, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1522, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 1523, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 1524, 0.000, 0.000, 0.000, 0.000, 7);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 1779, 12.000, 26.000, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 1780, 0.000, 5.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 1781, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 1782, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 1783, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 1784, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 1785, 0.000, 11.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 1786, 0.000, 7.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 1787, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 1788, 0.000, 0.200, 0.000, 0.200, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 1789, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 1790, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 1791, 0.710, 0.790, 0.710, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 1792, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 1793, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 1794, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 1795, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 1796, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 1797, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 1798, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 1799, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 1800, 16.000, 28.000, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 1801, 0.000, 11.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 1802, 0.000, 100.000, 0.000, 40.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 1803, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 1804, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 1805, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 1806, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 1807, 0.000, 0.000, 0.000, 4.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 1808, 0.000, 5.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 1809, 0.000, 4.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 1810, 0.000, 11.000, 0.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 1811, 0.000, 15.000, 0.000, 18.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 1812, 0.000, 26.000, 0.000, 25.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 1813, 0.000, 11.000, 0.000, 4.500, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 1814, 0.000, 20.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 1815, 0.000, 5.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 1816, 40.000, 999.000, 46.000, 65.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 1817, 59.000, 999.000, 50.000, 70.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 1818, 22.000, 46.000, 20.000, 39.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 1819, 12.000, 24.000, 12.000, 12.900, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 1820, 0.000, 10.000, 0.000, 5.100, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 1821, 0.000, 2.000, 0.000, 4.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 1822, 0.000, 1.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 1823, 0.600, 0.760, 0.600, 0.760, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 1824, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 1825, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 1826, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 1827, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 1828, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 1829, 11.000, 22.000, 11.000, 14.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 1830, 0.000, 11.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 1831, 0.000, 8.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 1832, 0.000, 8.000, 0.000, 5.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 1833, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 1834, 0.680, 0.730, 0.680, 0.730, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 1835, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 1836, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 1837, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 1838, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 1839, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 1840, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 1841, 0.000, 5.000, 0.000, 5.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 1842, 0.000, 5.000, 0.000, 5.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 1843, 12.000, 26.000, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 1844, 0.000, 5.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 1845, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 1846, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 1847, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 1848, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 1849, 0.000, 11.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 1850, 0.000, 7.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 1851, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 1852, 0.000, 0.200, 0.000, 0.200, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 1853, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 1854, 0.710, 0.790, 0.710, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 1855, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 1856, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 1857, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 1858, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 1859, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 1860, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 1861, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 1862, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 1863, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 1864, 10.000, 26.000, 12.000, 12.900, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 1865, 0.000, 7.000, 0.000, 7.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 1866, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 1867, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 1868, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 1869, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 1870, 0.000, 17.000, 0.000, 17.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 1871, 0.000, 10.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 1872, 0.000, 30.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 1873, 0.000, 20.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 1874, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 1875, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 1876, 715.000, 0.790, 715.000, 0.760, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 1877, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 1878, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 1879, 12.500, 15.000, 12.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 1880, 0.000, 8.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 1881, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 1882, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 1883, 0.000, 4.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 1884, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 1885, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 1886, 0.000, 13.000, 0.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 1887, 0.000, 13.000, 0.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 1888, 0.000, 26.000, 0.000, 26.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 1889, 0.000, 3.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 1890, 12.000, 24.000, 12.000, 24.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 1891, 0.000, 8.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 1892, 0.000, 40.000, 0.000, 40.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 1893, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 1894, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 1895, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 1896, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 1897, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 1898, 0.000, 6.000, 0.000, 6.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 1899, 0.000, 50.000, 0.000, 50.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 1900, 0.000, 50.000, 0.000, 50.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 1901, 0.000, 50.000, 0.000, 50.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 1902, 0.000, 50.000, 0.000, 50.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 1903, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 1904, 0.000, 8.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 1905, 0.000, 8.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 1906, 40.000, 60.000, 45.000, 60.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 1907, 65.000, 70.000, 65.000, 70.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 1908, 25.000, 39.000, 30.000, 39.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 1909, 16.000, 28.000, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 1910, 0.000, 11.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 1911, 0.000, 100.000, 0.000, 40.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 1912, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 1913, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 1914, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 1915, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 1916, 0.000, 0.000, 0.000, 4.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 1917, 0.000, 5.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 1918, 0.000, 4.000, 0.000, 8.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 1919, 0.000, 11.000, 0.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 1920, 0.000, 15.000, 0.000, 18.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 1921, 0.000, 26.000, 0.000, 25.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 1922, 0.000, 11.000, 0.000, 4.500, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 1923, 0.000, 20.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 1924, 0.000, 5.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 1925, 40.000, 999.000, 46.000, 65.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 1926, 59.000, 999.000, 50.000, 70.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 1927, 22.000, 46.000, 20.000, 39.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 1928, 8.000, 19.000, 6.000, 9.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 1929, 0.000, 8.000, 0.000, 7.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 1930, 0.330, 0.480, 0.330, 0.480, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 1931, 12.000, 26.000, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 1932, 0.000, 5.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 1933, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 1934, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 1935, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 1936, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 1937, 0.000, 11.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 1938, 0.000, 7.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 1939, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 1940, 0.000, 0.200, 0.000, 0.200, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 1941, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 1942, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 1943, 0.710, 0.790, 0.710, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 1944, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 1945, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 1946, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 1947, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 1948, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 1949, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 1950, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 1951, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 1952, 6.000, 24.000, 6.000, 9.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 1953, 0.000, 20.000, 0.000, 7.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 1954, 0.330, 0.480, 0.330, 0.480, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 1955, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 1956, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 1957, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 1958, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 1959, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 1960, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 1961, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 1962, 12.000, 13.900, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 1963, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 1964, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 1965, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 1966, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 1967, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 1968, 0.000, 11.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 1969, 0.000, 10.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 1970, 0.000, 7.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 1971, 0.000, 0.200, 0.000, 0.200, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 1972, 0.000, 10.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 1973, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 1974, 0.730, 0.760, 0.710, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 1975, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 1976, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 1977, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 1978, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 1979, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 1980, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 1981, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 1982, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 1983, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 1984, 12.000, 13.900, 12.000, 13.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 1985, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 1986, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 1987, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 1988, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 1989, 0.000, 11.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 1990, 0.000, 11.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 1991, 0.000, 10.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 1992, 0.000, 7.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 1993, 0.000, 0.200, 0.000, 0.200, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 1994, 0.000, 10.000, 0.000, 11.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 1995, 0.000, 3.000, 0.000, 3.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 1996, 0.730, 0.760, 0.710, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 1997, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 1998, 0.000, 20.000, 0.000, 20.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 1999, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 2000, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 2001, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 2002, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 2003, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 2004, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 2005, 12.000, 30.000, 11.000, 14.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 2006, 0.000, 5.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 2007, 0.000, 11.000, 0.000, 30.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 2008, 0.000, 11.000, 0.000, 30.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 2009, 0.000, 3.000, 0.000, 30.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 2010, 0.000, 11.000, 0.000, 30.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 2011, 0.000, 11.000, 0.000, 60.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 2012, 0.000, 7.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 2013, 0.000, 15.000, 0.000, 15.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 2014, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 2015, 0.000, 10.000, 0.000, 10.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 2016, 0.000, 6.000, 0.000, 6.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 2017, 715.000, 0.790, 715.000, 0.790, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 2018, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 2019, 0.000, 20.000, 0.000, 40.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 2020, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 2021, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 2022, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 2023, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 2024, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 2025, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 2026, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 2027, 0.000, 0.000, 0.000, 0.500, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 2028, 0.000, 0.000, 0.000, 0.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 2029, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 2030, 0.000, 2.000, 0.000, 2.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 2031, 1.000, 2.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 2032, 0.000, 1.000, 0.000, 1.000, 9);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 1, 'C', 12.000, 12.000, 'R', 2033, 12.000, 26.000, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 1, 'C', 0.000, 0.000, 'R', 2034, 0.000, 5.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 1, 'C', 0.000, 0.000, 'R', 2035, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 1, 'C', 0.000, 0.000, 'R', 2036, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 1, 'C', 0.000, 0.000, 'R', 2037, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 1, 'C', 0.000, 0.000, 'R', 2038, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 1, 'C', 0.000, 0.000, 'R', 2039, 0.000, 11.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 1, 'C', 0.000, 0.000, 'R', 2040, 0.000, 7.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 1, 'C', 0.000, 0.000, 'R', 2041, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 1, 'C', 0.000, 0.000, 'R', 2042, 0.000, 0.200, 0.000, 0.200, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 1, 'C', 0.000, 0.000, 'R', 2043, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 1, 'C', 0.000, 0.000, 'R', 2044, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 1, 'C', 0.000, 0.000, 'R', 2045, 0.710, 0.790, 0.710, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 1, 'C', 0.000, 0.000, 'R', 2046, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 1, 'C', 0.000, 0.000, 'R', 2047, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 1, 'A', 0.000, 0.000, 'R', 2048, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 1, 'A', 0.000, 0.000, 'C', 2049, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 1, 'A', 0.000, 0.000, 'R', 2050, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 1, 'A', 0.000, 0.000, 'R', 2051, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 1, 'A', 0.000, 0.000, 'R', 2052, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 1, 'A', 0.000, 0.000, 'R', 2053, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 2, 'C', 12.000, 12.000, 'R', 2054, 16.000, 28.000, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 2, 'C', 4.000, 0.000, 'R', 2055, 0.000, 11.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 2, 'C', 0.000, 0.000, 'R', 2056, 0.000, 100.000, 0.000, 40.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 2, 'A', 0.000, 0.000, 'C', 2057, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 2, 'A', 0.000, 0.000, 'R', 2058, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 2, 'A', 0.000, 0.000, 'R', 2059, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 2, 'A', 0.000, 0.000, 'R', 2060, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 2, 'A', 0.000, 0.000, 'R', 2061, 0.000, 0.000, 0.000, 4.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 2, 'C', 0.000, 0.000, 'R', 2062, 0.000, 5.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 2, 'C', 0.000, 0.000, 'R', 2063, 0.000, 4.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 2, 'C', 0.000, 0.000, 'R', 2064, 0.000, 11.000, 0.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 2, 'C', 0.000, 0.000, 'R', 2065, 0.000, 15.000, 0.000, 18.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 2, 'C', 0.000, 0.000, 'R', 2066, 0.000, 26.000, 0.000, 25.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 2, 'C', 0.000, 0.000, 'R', 2067, 0.000, 11.000, 0.000, 4.500, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 2, 'C', 0.000, 0.000, 'R', 2068, 0.000, 20.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 2, 'C', 0.000, 0.000, 'R', 2069, 0.000, 5.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 2, 'C', 0.000, 0.000, 'R', 2070, 40.000, 999.000, 46.000, 65.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 2, 'C', 0.000, 0.000, 'R', 2071, 59.000, 999.000, 50.000, 70.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 2, 'A', 0.000, 0.000, 'R', 2072, 22.000, 46.000, 20.000, 39.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 3, 'C', 12.000, 12.000, 'R', 2073, 12.000, 24.000, 12.000, 12.900, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 3, 'C', 2.000, 2.000, 'R', 2074, 0.000, 10.000, 0.000, 5.100, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 3, 'C', 0.000, 0.000, 'R', 2075, 0.000, 2.000, 0.000, 4.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 3, 'C', 0.000, 0.000, 'R', 2076, 0.000, 1.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 3, 'C', 0.000, 0.000, 'R', 2077, 0.600, 0.760, 0.600, 0.760, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 3, 'C', 0.000, 0.000, 'R', 2078, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 3, 'A', 0.000, 0.000, 'C', 2079, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 3, 'A', 0.000, 0.000, 'R', 2080, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 3, 'A', 0.000, 0.000, 'R', 2081, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 3, 'A', 0.000, 0.000, 'R', 2082, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 4, 'C', 11.000, 11.000, 'R', 2083, 11.000, 22.000, 11.000, 14.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 4, 'C', 1.000, 1.000, 'R', 2084, 0.000, 11.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 4, 'C', 0.000, 0.000, 'R', 2085, 0.000, 8.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 4, 'C', 0.000, 0.000, 'R', 2086, 0.000, 8.000, 0.000, 5.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 4, 'C', 0.000, 0.000, 'R', 2087, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 4, 'C', 0.000, 0.000, 'R', 2088, 0.680, 0.730, 0.680, 0.730, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 4, 'C', 0.000, 0.000, 'R', 2089, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 4, 'A', 0.000, 0.000, 'C', 2090, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 4, 'A', 0.000, 0.000, 'R', 2091, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 4, 'A', 0.000, 0.000, 'R', 2092, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 4, 'A', 0.000, 0.000, 'R', 2093, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 4, 'A', 0.000, 0.000, 'R', 2094, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 4, 'C', 0.000, 0.000, 'R', 2095, 0.000, 5.000, 0.000, 5.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 4, 'C', 0.000, 0.000, 'R', 2096, 0.000, 5.000, 0.000, 5.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 5, 'C', 12.000, 12.000, 'R', 2097, 12.000, 26.000, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 5, 'C', 0.000, 0.000, 'R', 2098, 0.000, 5.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 5, 'C', 0.000, 0.000, 'R', 2099, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 5, 'C', 0.000, 0.000, 'R', 2100, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 5, 'C', 0.000, 0.000, 'R', 2101, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 5, 'C', 0.000, 0.000, 'R', 2102, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 5, 'C', 0.000, 0.000, 'R', 2103, 0.000, 11.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 5, 'C', 0.000, 0.000, 'R', 2104, 0.000, 7.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 5, 'C', 0.000, 0.000, 'R', 2105, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 5, 'C', 0.000, 0.000, 'R', 2106, 0.000, 0.200, 0.000, 0.200, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 5, 'C', 0.000, 0.000, 'R', 2107, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 5, 'C', 0.000, 0.000, 'R', 2108, 0.710, 0.790, 0.710, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 5, 'C', 0.000, 0.000, 'R', 2109, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 5, 'C', 0.000, 0.000, 'R', 2110, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 5, 'A', 0.000, 0.000, 'R', 2111, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 5, 'A', 0.000, 0.000, 'C', 2112, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 5, 'A', 0.000, 0.000, 'R', 2113, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 5, 'A', 0.000, 0.000, 'R', 2114, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 5, 'A', 0.000, 0.000, 'R', 2115, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 5, 'A', 0.000, 0.000, 'R', 2116, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 39, 5, 'C', 0.000, 0.000, 'R', 2117, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 6, 'C', 12.000, 12.000, 'R', 2118, 10.000, 26.000, 12.000, 12.900, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 6, 'C', 0.000, 0.000, 'R', 2119, 0.000, 7.000, 0.000, 7.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 6, 'C', 0.000, 0.000, 'R', 2120, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 6, 'C', 0.000, 0.000, 'R', 2121, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 6, 'C', 0.000, 0.000, 'R', 2122, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 6, 'C', 0.000, 0.000, 'R', 2123, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 6, 'C', 0.000, 0.000, 'R', 2124, 0.000, 17.000, 0.000, 17.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 6, 'C', 0.000, 0.000, 'R', 2125, 0.000, 10.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 6, 'C', 0.000, 0.000, 'R', 2126, 0.000, 30.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 6, 'C', 0.000, 0.000, 'R', 2127, 0.000, 20.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 6, 'C', 0.000, 0.000, 'R', 2128, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 6, 'C', 0.000, 0.000, 'R', 2129, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 6, 'C', 0.000, 0.000, 'R', 2130, 715.000, 0.790, 715.000, 0.760, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 6, 'C', 0.000, 0.000, 'R', 2131, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 6, 'C', 0.000, 0.000, 'R', 2132, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 7, 'C', 12.500, 14.000, 'R', 2133, 12.500, 15.000, 12.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 7, 'C', 4.000, 4.000, 'R', 2134, 0.000, 8.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 7, 'A', 0.000, 0.000, 'C', 2135, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 7, 'A', 0.000, 0.000, 'R', 2136, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 7, 'A', 0.000, 0.000, 'R', 2137, 0.000, 4.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 7, 'C', 0.000, 0.000, 'R', 2138, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 7, 'C', 0.000, 0.000, 'R', 2139, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 7, 'C', 0.000, 0.000, 'R', 2140, 0.000, 13.000, 0.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 7, 'C', 0.000, 0.000, 'R', 2141, 0.000, 13.000, 0.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 7, 'C', 0.000, 0.000, 'R', 2142, 0.000, 26.000, 0.000, 26.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 7, 'C', 0.000, 0.000, 'R', 2143, 0.000, 3.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 8, 'C', 12.000, 12.000, 'R', 2144, 12.000, 24.000, 12.000, 24.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 8, 'C', 0.000, 0.000, 'R', 2145, 0.000, 8.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 8, 'C', 0.000, 0.000, 'R', 2146, 0.000, 40.000, 0.000, 40.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 8, 'C', 0.000, 0.000, 'C', 2147, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 8, 'C', 0.000, 0.000, 'R', 2148, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 8, 'C', 0.000, 0.000, 'R', 2149, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 8, 'A', 0.000, 0.000, 'R', 2150, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 8, 'C', 0.000, 0.000, 'R', 2151, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 8, 'C', 0.000, 0.000, 'R', 2152, 0.000, 6.000, 0.000, 6.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 8, 'C', 0.000, 0.000, 'R', 2153, 0.000, 50.000, 0.000, 50.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 8, 'C', 0.000, 0.000, 'R', 2154, 0.000, 50.000, 0.000, 50.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 8, 'C', 0.000, 0.000, 'R', 2155, 0.000, 50.000, 0.000, 50.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 8, 'C', 0.000, 0.000, 'R', 2156, 0.000, 50.000, 0.000, 50.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 8, 'C', 0.000, 0.000, 'R', 2157, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 8, 'C', 0.000, 0.000, 'R', 2158, 0.000, 8.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 8, 'C', 0.000, 0.000, 'R', 2159, 0.000, 8.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 8, 'C', 0.000, 0.000, 'R', 2160, 40.000, 60.000, 45.000, 60.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 8, 'C', 0.000, 0.000, 'R', 2161, 65.000, 70.000, 65.000, 70.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 8, 'C', 0.000, 0.000, 'R', 2162, 25.000, 39.000, 30.000, 39.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 9, 'C', 12.000, 12.000, 'R', 2163, 16.000, 28.000, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 9, 'C', 4.000, 0.000, 'R', 2164, 0.000, 11.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 9, 'C', 0.000, 0.000, 'R', 2165, 0.000, 100.000, 0.000, 40.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 9, 'A', 0.000, 0.000, 'C', 2166, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 9, 'A', 0.000, 0.000, 'R', 2167, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 9, 'A', 0.000, 0.000, 'R', 2168, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 9, 'A', 0.000, 0.000, 'R', 2169, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 25, 9, 'A', 0.000, 0.000, 'R', 2170, 0.000, 0.000, 0.000, 4.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 26, 9, 'C', 0.000, 0.000, 'R', 2171, 0.000, 5.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 27, 9, 'C', 0.000, 0.000, 'R', 2172, 0.000, 4.000, 0.000, 8.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 28, 9, 'C', 0.000, 0.000, 'R', 2173, 0.000, 11.000, 0.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 29, 9, 'C', 0.000, 0.000, 'R', 2174, 0.000, 15.000, 0.000, 18.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 30, 9, 'C', 0.000, 0.000, 'R', 2175, 0.000, 26.000, 0.000, 25.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 31, 9, 'C', 0.000, 0.000, 'R', 2176, 0.000, 11.000, 0.000, 4.500, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 32, 9, 'C', 0.000, 0.000, 'R', 2177, 0.000, 20.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 33, 9, 'C', 0.000, 0.000, 'R', 2178, 0.000, 5.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 36, 9, 'C', 0.000, 0.000, 'R', 2179, 40.000, 999.000, 46.000, 65.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 37, 9, 'C', 0.000, 0.000, 'R', 2180, 59.000, 999.000, 50.000, 70.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 9, 'A', 0.000, 0.000, 'R', 2181, 22.000, 46.000, 20.000, 39.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 10, 'C', 7.000, 7.000, 'R', 2182, 8.000, 19.000, 6.000, 9.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 10, 'C', 1.000, 1.000, 'R', 2183, 0.000, 8.000, 0.000, 7.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 10, 'C', 0.000, 0.000, 'R', 2184, 0.330, 0.480, 0.330, 0.480, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 11, 'C', 12.000, 12.000, 'R', 2185, 12.000, 26.000, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 11, 'C', 0.000, 0.000, 'R', 2186, 0.000, 5.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 11, 'C', 0.000, 0.000, 'R', 2187, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 11, 'C', 0.000, 0.000, 'R', 2188, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 11, 'C', 0.000, 0.000, 'R', 2189, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 11, 'C', 0.000, 0.000, 'R', 2190, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 11, 'C', 0.000, 0.000, 'R', 2191, 0.000, 11.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 11, 'C', 0.000, 0.000, 'R', 2192, 0.000, 7.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 11, 'C', 0.000, 0.000, 'R', 2193, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 11, 'C', 0.000, 0.000, 'R', 2194, 0.000, 0.200, 0.000, 0.200, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 11, 'C', 0.000, 0.000, 'R', 2195, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 11, 'C', 0.000, 0.000, 'R', 2196, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 11, 'C', 0.000, 0.000, 'R', 2197, 0.710, 0.790, 0.710, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 11, 'C', 0.000, 0.000, 'R', 2198, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 11, 'C', 0.000, 0.000, 'R', 2199, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 11, 'A', 0.000, 0.000, 'R', 2200, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 11, 'A', 0.000, 0.000, 'C', 2201, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 11, 'A', 0.000, 0.000, 'R', 2202, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 11, 'A', 0.000, 0.000, 'R', 2203, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 11, 'A', 0.000, 0.000, 'R', 2204, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 11, 'A', 0.000, 0.000, 'R', 2205, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 12, 'C', 7.000, 7.000, 'R', 2206, 6.000, 24.000, 6.000, 9.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 12, 'C', 1.000, 1.000, 'R', 2207, 0.000, 20.000, 0.000, 7.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 12, 'C', 0.000, 0.000, 'R', 2208, 0.330, 0.480, 0.330, 0.480, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 12, 'A', 0.000, 0.000, 'C', 2209, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 12, 'A', 0.000, 0.000, 'R', 2210, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 12, 'A', 0.000, 0.000, 'R', 2211, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 12, 'A', 0.000, 0.000, 'R', 2212, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 38, 12, 'A', 0.000, 0.000, 'R', 2213, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 13, 'A', 0.000, 0.000, 'C', 2214, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 14, 'A', 0.000, 0.000, 'C', 2215, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 15, 'C', 12.000, 12.000, 'R', 2216, 12.000, 13.900, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 15, 'C', 0.000, 0.000, 'R', 2217, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 15, 'C', 0.000, 0.000, 'R', 2218, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 15, 'C', 0.000, 0.000, 'R', 2219, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 15, 'C', 0.000, 0.000, 'R', 2220, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 15, 'C', 0.000, 0.000, 'R', 2221, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 15, 'C', 0.000, 0.000, 'R', 2222, 0.000, 11.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 15, 'C', 0.000, 0.000, 'R', 2223, 0.000, 10.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 15, 'C', 0.000, 0.000, 'R', 2224, 0.000, 7.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 15, 'C', 0.000, 0.000, 'R', 2225, 0.000, 0.200, 0.000, 0.200, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 15, 'C', 0.000, 0.000, 'R', 2226, 0.000, 10.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 15, 'C', 0.000, 0.000, 'R', 2227, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 15, 'C', 0.000, 0.000, 'R', 2228, 0.730, 0.760, 0.710, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 15, 'C', 0.000, 0.000, 'R', 2229, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 15, 'C', 0.000, 0.000, 'R', 2230, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 15, 'A', 0.000, 0.000, 'R', 2231, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 15, 'A', 0.000, 0.000, 'C', 2232, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 15, 'A', 0.000, 0.000, 'R', 2233, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 15, 'A', 0.000, 0.000, 'R', 2234, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 15, 'A', 0.000, 0.000, 'R', 2235, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 15, 'A', 0.000, 0.000, 'R', 2236, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 16, 'A', 0.000, 0.000, 'C', 2237, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 17, 'C', 12.000, 12.000, 'R', 2238, 12.000, 13.900, 12.000, 13.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 17, 'C', 0.000, 0.000, 'R', 2239, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 17, 'C', 0.000, 0.000, 'R', 2240, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 17, 'C', 0.000, 0.000, 'R', 2241, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 17, 'C', 0.000, 0.000, 'R', 2242, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 17, 'C', 0.000, 0.000, 'R', 2243, 0.000, 11.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 17, 'C', 0.000, 0.000, 'R', 2244, 0.000, 11.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 17, 'C', 0.000, 0.000, 'R', 2245, 0.000, 10.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 17, 'C', 0.000, 0.000, 'R', 2246, 0.000, 7.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 17, 'C', 0.000, 0.000, 'R', 2247, 0.000, 0.200, 0.000, 0.200, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 17, 'C', 0.000, 0.000, 'R', 2248, 0.000, 10.000, 0.000, 11.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 17, 'C', 0.000, 0.000, 'R', 2249, 0.000, 3.000, 0.000, 3.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 17, 'C', 0.000, 0.000, 'R', 2250, 0.730, 0.760, 0.710, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 17, 'C', 0.000, 0.000, 'R', 2251, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 17, 'C', 0.000, 0.000, 'R', 2252, 0.000, 20.000, 0.000, 20.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 17, 'A', 0.000, 0.000, 'R', 2253, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 17, 'A', 0.000, 0.000, 'C', 2254, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 17, 'A', 0.000, 0.000, 'R', 2255, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 17, 'A', 0.000, 0.000, 'R', 2256, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 17, 'A', 0.000, 0.000, 'R', 2257, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 17, 'A', 0.000, 0.000, 'R', 2258, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 1, 18, 'C', 12.000, 12.000, 'R', 2259, 12.000, 30.000, 11.000, 14.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 2, 18, 'C', 0.000, 0.000, 'R', 2260, 0.000, 5.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 3, 18, 'C', 0.000, 0.000, 'R', 2261, 0.000, 11.000, 0.000, 30.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 4, 18, 'C', 0.000, 0.000, 'R', 2262, 0.000, 11.000, 0.000, 30.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 5, 18, 'C', 0.000, 0.000, 'R', 2263, 0.000, 3.000, 0.000, 30.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 6, 18, 'C', 0.000, 0.000, 'R', 2264, 0.000, 11.000, 0.000, 30.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 7, 18, 'C', 0.000, 0.000, 'R', 2265, 0.000, 11.000, 0.000, 60.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 8, 18, 'C', 0.000, 0.000, 'R', 2266, 0.000, 7.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 9, 18, 'C', 0.000, 0.000, 'R', 2267, 0.000, 15.000, 0.000, 15.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 10, 18, 'C', 0.000, 0.000, 'R', 2268, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 11, 18, 'C', 0.000, 0.000, 'R', 2269, 0.000, 10.000, 0.000, 10.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 12, 18, 'C', 0.000, 0.000, 'R', 2270, 0.000, 6.000, 0.000, 6.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 13, 18, 'C', 0.000, 0.000, 'R', 2271, 715.000, 0.790, 715.000, 0.790, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 14, 18, 'C', 0.000, 0.000, 'R', 2272, 0.000, 1.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 15, 18, 'C', 0.000, 0.000, 'R', 2273, 0.000, 20.000, 0.000, 40.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 19, 18, 'A', 0.000, 0.000, 'R', 2274, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 20, 18, 'A', 0.000, 0.000, 'C', 2275, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 18, 'A', 0.000, 0.000, 'R', 2276, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 22, 18, 'A', 0.000, 0.000, 'R', 2277, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 23, 18, 'A', 0.000, 0.000, 'R', 2278, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 24, 18, 'A', 0.000, 0.000, 'R', 2279, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 21, 19, 'A', 0.000, 0.000, 'R', 2280, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 20, 'C', 0.000, 0.000, 'R', 2281, 0.000, 0.000, 0.000, 0.500, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 35, 21, 'C', 0.000, 0.000, 'R', 2282, 0.000, 0.000, 0.000, 0.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 34, 22, 'C', 0.000, 0.000, 'R', 2283, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 23, 'C', 0.000, 0.000, 'R', 2284, 0.000, 2.000, 0.000, 2.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 25, 'C', 0.000, 0.000, 'R', 2285, 1.000, 2.000, 0.000, 1.000, 10);
INSERT INTO si_analisis_cultivo VALUES (1, 16, 26, 'C', 0.000, 0.000, 'R', 2286, 0.000, 1.000, 0.000, 1.000, 10);


--
-- TOC entry 2439 (class 0 OID 34347)
-- Dependencies: 148
-- Data for Name: si_analisis_resultado; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2440 (class 0 OID 34352)
-- Dependencies: 150
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2441 (class 0 OID 34362)
-- Dependencies: 153
-- Data for Name: si_cargo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2442 (class 0 OID 34368)
-- Dependencies: 155
-- Data for Name: si_cargo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2443 (class 0 OID 34375)
-- Dependencies: 157
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
-- TOC entry 2444 (class 0 OID 34388)
-- Dependencies: 158
-- Data for Name: si_choferes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2445 (class 0 OID 34395)
-- Dependencies: 161
-- Data for Name: si_cliente; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2446 (class 0 OID 34404)
-- Dependencies: 163
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2447 (class 0 OID 34415)
-- Dependencies: 164
-- Data for Name: si_cosecha_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2448 (class 0 OID 34418)
-- Dependencies: 165
-- Data for Name: si_cosecha_silo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2449 (class 0 OID 34423)
-- Dependencies: 167
-- Data for Name: si_cuarentena; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2450 (class 0 OID 34428)
-- Dependencies: 169
-- Data for Name: si_cuarentena_plaga; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2451 (class 0 OID 34436)
-- Dependencies: 172
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_cultivo VALUES (2, 1, 'ARROZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 2);
INSERT INTO si_cultivo VALUES (3, 1, 'SORGO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 3);
INSERT INTO si_cultivo VALUES (4, 1, 'SOYA HÚMEDA NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 4);
INSERT INTO si_cultivo VALUES (5, 1, 'MAÍZ AMARILLO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 5);
INSERT INTO si_cultivo VALUES (6, 1, 'MAÍZ BLANCO SECO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 6);
INSERT INTO si_cultivo VALUES (7, 1, 'ARROZ BLANCO TOTAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 7);
INSERT INTO si_cultivo VALUES (8, 1, 'ARROZ PADDY ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 8);
INSERT INTO si_cultivo VALUES (9, 1, 'TOMATE NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 9);
INSERT INTO si_cultivo VALUES (10, 1, 'GIRASOL HUMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 10);
INSERT INTO si_cultivo VALUES (11, 1, 'MAÍZ AICA 11 HUMEDO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 11);
INSERT INTO si_cultivo VALUES (12, 1, 'GIRASOL NACIONAL CARGILL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 12);
INSERT INTO si_cultivo VALUES (13, 1, 'TRIGO CWRS', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 13);
INSERT INTO si_cultivo VALUES (14, 1, 'TRIGO DURUM MEXICANO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 14);
INSERT INTO si_cultivo VALUES (15, 1, 'MAÍZ BLANCO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 15);
INSERT INTO si_cultivo VALUES (16, 1, 'TRIGO HRW CANADIENSE', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 16);
INSERT INTO si_cultivo VALUES (17, 1, 'MAÍZ AMARILLO IMPORTADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 17);
INSERT INTO si_cultivo VALUES (1, 1, 'MAÍZ BLANCO HÚMEDO NACIONAL', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, true, 1);
INSERT INTO si_cultivo VALUES (18, 1, 'GRADO POR MUESTRA MAÍZ AMARILLO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, 68);
INSERT INTO si_cultivo VALUES (19, 1, 'ARROZ GRADO POR MUESTRA', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, 92);
INSERT INTO si_cultivo VALUES (20, 1, 'PICO SECO ACONDICIONADO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, 93);
INSERT INTO si_cultivo VALUES (21, 1, 'IMPUREZA DE SORGO', false, 0, '2012-02-18 15:22:10.224543-04:30', NULL, false, 94);
INSERT INTO si_cultivo VALUES (22, 1, 'IMPUREZA DE ARROZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, 95);
INSERT INTO si_cultivo VALUES (23, 1, 'PICO SECO', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, 96);
INSERT INTO si_cultivo VALUES (24, 1, 'MAÍZ MOLTURADO', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, 97);
INSERT INTO si_cultivo VALUES (25, 1, 'PICO DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, 98);
INSERT INTO si_cultivo VALUES (26, 1, 'IMPUREZAS DE MAÍZ', false, 0, '2012-02-18 00:00:00-04:30', NULL, false, 99);


--
-- TOC entry 2452 (class 0 OID 34442)
-- Dependencies: 173
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2453 (class 0 OID 34451)
-- Dependencies: 176
-- Data for Name: si_denom_tip; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2454 (class 0 OID 34455)
-- Dependencies: 177
-- Data for Name: si_despacho; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2455 (class 0 OID 34463)
-- Dependencies: 180
-- Data for Name: si_ejes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_ejes VALUES (1, 1, '2 Ejes', 19000);
INSERT INTO si_ejes VALUES (2, 1, '3 Ejes', 26000);
INSERT INTO si_ejes VALUES (3, 1, '4 Ejes', 39000);
INSERT INTO si_ejes VALUES (4, 1, '5 Ejes', 46000);
INSERT INTO si_ejes VALUES (5, 1, '6 Ejes', 48000);


--
-- TOC entry 2456 (class 0 OID 34470)
-- Dependencies: 182
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
-- TOC entry 2457 (class 0 OID 34474)
-- Dependencies: 183
-- Data for Name: si_finca; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2458 (class 0 OID 34483)
-- Dependencies: 185
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
INSERT INTO si_formulas VALUES (32, 1, 1, 5, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H05', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (34, 1, 1, 6, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H06', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (36, 1, 1, 11, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H011', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (38, 1, 1, 15, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H015', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (40, 1, 1, 17, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H017', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (42, 1, 1, 3, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H03', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (44, 1, 1, 4, '(((HUML-12)/1)/(100-12))*((PL1+PL2)-(PV1+PV2))', 'H04', 3, 1, NULL, '2012-03-22 10:20:49.079385-04:30', NULL, 1);
INSERT INTO si_formulas VALUES (31, 1, 1, 1, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I01', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (35, 1, 1, 6, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I06', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (39, 1, 1, 15, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I015', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (37, 1, 1, 11, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I011', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (41, 1, 1, 17, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I017', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (43, 1, 1, 3, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I03', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (45, 1, 1, 4, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I04', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (33, 1, 1, 5, '((((PL1+PL2)-(PV1+PV2))-HUML)/100)*(IMPL-0)', 'I05', 3, 1, NULL, '2012-03-22 10:25:26.378209-04:30', NULL, 2);
INSERT INTO si_formulas VALUES (46, 1, 1, 10, '((((PL1+PL2)-(PV1+PV2))*(1-(IMPL-2)/98))*(1-(HUML-8)/92))', 'GIRPA', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-05-07 09:34:03.159576-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (47, 1, 1, 10, '(((PL1+PL2)-(PV1+PV2))-((PL1+PL2)-(PV1+PV2))*((HUML+IMPL)-14)/100)', 'GIRPAL', 3, 2, 'HUML+IMPL = 14 < 9999999', '2012-03-21 15:53:26.542432-04:30', NULL, NULL);
INSERT INTO si_formulas VALUES (48, 1, 1, NULL, '(((PL1+PL2)-(PV1+PV2))-(PHUM+PIMP))', 'PA', 3, 2, NULL, '2012-03-22 00:00:00-04:30', NULL, NULL);


--
-- TOC entry 2459 (class 0 OID 34491)
-- Dependencies: 187
-- Data for Name: si_guiarec; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2460 (class 0 OID 34496)
-- Dependencies: 188
-- Data for Name: si_guiarec_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2461 (class 0 OID 34503)
-- Dependencies: 191
-- Data for Name: si_impresora; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_impresora VALUES (2, 2, 9, 'impresoraB', NULL, NULL, NULL);
INSERT INTO si_impresora VALUES (1, 2, 1, 'FX-890', NULL, NULL, NULL);


--
-- TOC entry 2462 (class 0 OID 34510)
-- Dependencies: 194
-- Data for Name: si_log_codigos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_log_codigos VALUES (101, 'Inicio de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (102, 'Cierre de Sesion', 0, 'OK');
INSERT INTO si_log_codigos VALUES (105, 'Acceso Denegado', 0, 'ERR');
INSERT INTO si_log_codigos VALUES (201, 'Data Nueva', 0, 'OK');
INSERT INTO si_log_codigos VALUES (202, 'Data Actualizada', 0, 'OK');
INSERT INTO si_log_codigos VALUES (203, 'Data Eliminada', 0, 'OK');


--
-- TOC entry 2463 (class 0 OID 34516)
-- Dependencies: 196
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2464 (class 0 OID 34525)
-- Dependencies: 198
-- Data for Name: si_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu VALUES (2, 'M_Procesos', 0, NULL, true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (4, 'M_CtrolProcesos', 0, NULL, true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (3, 'M_Reportes', 0, NULL, true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (11, 'M_Recepcion', 2, 'admin/recepcion.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (7, 'M_Cultivo', 1, 'admin/cultivo_listado.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (8, 'M_Programas', 1, 'admin/programa_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (9, 'M_Silos', 1, 'admin/silos_listado.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (19, 'M_Silos', 4, NULL, true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (20, 'M_Usuarios', 4, 'admin/usuarios_listado.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (23, 'M_ConfigCta', 5, NULL, true, 1, NULL, NULL);
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
INSERT INTO si_menu VALUES (39, 'M_GerenteRecepcion', 3, 'reportes/gerente_recepcion.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (40, 'M_GerenteDespacho', 3, 'reportes/gerente_despacho.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (5, 'M_Cuenta', 0, NULL, false, 5, NULL, NULL);
INSERT INTO si_menu VALUES (45, 'M_GranosVerdes', 3, 'reportes/granos_verdes.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (42, 'M_UtilitarioRecepciones', 4, 'admin/utilitario_recepcion_listado.php', true, 8, NULL, NULL);
INSERT INTO si_menu VALUES (44, 'M_UtilitarioDespachos', 4, 'admin/utilitario_despacho_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (10, 'M_Productor', 1, 'admin/productor_listado.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (38, 'M_CuarentenaPendiente', 2, 'admin/cuarentena_pendiente_listado.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (28, 'M_Romana', 2, 'admin/romana_movimiento.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (13, 'M_Programas', 3, 'reportes/programas.php', true, 1, NULL, NULL);
INSERT INTO si_menu VALUES (14, 'M_Cosecha', 3, 'reportes/cosechas.php', true, 2, NULL, NULL);
INSERT INTO si_menu VALUES (15, 'M_Cultivo', 3, 'reportes/cultivos.php', true, 3, NULL, NULL);
INSERT INTO si_menu VALUES (16, 'M_Productores', 3, 'reportes/productores.php', true, 4, NULL, NULL);
INSERT INTO si_menu VALUES (17, 'M_Recepciones', 3, 'reportes/recepcion.php', true, 5, NULL, NULL);
INSERT INTO si_menu VALUES (18, 'M_Despacho', 3, 'reportes/despacho.php', true, 6, NULL, NULL);
INSERT INTO si_menu VALUES (35, 'M_Auditoria', 3, 'reportes/actividad.php', true, 7, NULL, NULL);
INSERT INTO si_menu VALUES (46, 'M_CargaProductor', 4, 'admin/productor_carga.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (29, 'M_Chofer', 1, 'admin/chofer_listado.php', true, 9, NULL, NULL);
INSERT INTO si_menu VALUES (32, 'M_Ordenes', 1, 'admin/ordenes_listado.php', true, 10, NULL, NULL);
INSERT INTO si_menu VALUES (47, 'M_Cliente', 1, 'admin/cliente_listado.php', true, 8, NULL, NULL);


--
-- TOC entry 2465 (class 0 OID 34530)
-- Dependencies: 199
-- Data for Name: si_menu_usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_menu_usuario VALUES (31, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 7, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 7, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 8, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 8, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 8, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 8, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 8, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 8, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (28, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 5, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 5, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 10, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 10, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 10, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 10, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 10, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 10, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 6, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 6, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 6, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 6, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 6, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 6, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 9, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 9, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 9, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 9, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 9, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 9, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (24, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (6, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (25, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (9, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (8, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (7, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (47, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (29, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (32, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 1, 0, 0, 0, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 12, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 12, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 12, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 12, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 12, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 12, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 12, 0, 0, 0, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 11, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 1, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 1, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 1, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 1, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 1, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 11, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 11, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 11, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 11, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 11, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 11, 0, 0, 0, 0);
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
INSERT INTO si_menu_usuario VALUES (2, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (31, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (38, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (3, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (13, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (14, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (15, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (16, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (17, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (18, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (35, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 13, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 13, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 13, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 13, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 13, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 13, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 13, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (44, 13, 0, 1, 0, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 3, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 3, 1, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 3, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (22, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (26, 3, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 3, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 2, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 2, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 2, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 2, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 2, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 2, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 4, 1, 1, 1, 0);
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
INSERT INTO si_menu_usuario VALUES (35, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (39, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (40, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (45, 4, 0, 0, 0, 1);
INSERT INTO si_menu_usuario VALUES (4, 4, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (20, 4, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (26, 4, 0, 1, 0, 0);
INSERT INTO si_menu_usuario VALUES (34, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (36, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (42, 4, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 5, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 5, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (27, 5, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (1, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (25, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (9, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (8, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (7, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (10, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (47, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (29, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (32, 7, 1, 1, 1, 0);
INSERT INTO si_menu_usuario VALUES (2, 7, 2, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (11, 7, 0, 0, 0, 0);
INSERT INTO si_menu_usuario VALUES (12, 7, 0, 0, 0, 0);


--
-- TOC entry 2466 (class 0 OID 34539)
-- Dependencies: 201
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
-- TOC entry 2467 (class 0 OID 34545)
-- Dependencies: 203
-- Data for Name: si_ordenes; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2468 (class 0 OID 34553)
-- Dependencies: 204
-- Data for Name: si_ordenes_det; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2469 (class 0 OID 34560)
-- Dependencies: 207
-- Data for Name: si_organizacion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_organizacion VALUES (1, 'AGROPATRIA', NULL, 'J13769342', NULL, NULL, NULL, NULL, 1, 5, 51, '2012-02-12 00:00:00-04:30', '2012-04-17 10:18:03.007361-04:30', true, 'AGR');


--
-- TOC entry 2470 (class 0 OID 34569)
-- Dependencies: 209
-- Data for Name: si_pais; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_pais VALUES (1, 'VENEZUELA');


--
-- TOC entry 2471 (class 0 OID 34575)
-- Dependencies: 211
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
-- TOC entry 2472 (class 0 OID 34584)
-- Dependencies: 213
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
-- TOC entry 2473 (class 0 OID 34588)
-- Dependencies: 214
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
-- TOC entry 2474 (class 0 OID 34593)
-- Dependencies: 216
-- Data for Name: si_producto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_producto VALUES (1, 1, 'AG0001          ', 'FOSCAN PASTILLAS', 'TUBO 30 P       ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (2, 1, 'AG0003          ', 'FOSCAN PASTILLAS', 'LATA 333 P      ', 4, true, NULL, NULL);
INSERT INTO si_producto VALUES (3, 1, 'AG0013          ', 'FOSCAN PELLETS', 'UNIDAD          ', 20, true, NULL, NULL);


--
-- TOC entry 2475 (class 0 OID 34600)
-- Dependencies: 219
-- Data for Name: si_productor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2476 (class 0 OID 34609)
-- Dependencies: 221
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2477 (class 0 OID 34616)
-- Dependencies: 222
-- Data for Name: si_proveedor; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2478 (class 0 OID 34624)
-- Dependencies: 224
-- Data for Name: si_punto_entrega; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2479 (class 0 OID 34632)
-- Dependencies: 226
-- Data for Name: si_recepcion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2480 (class 0 OID 34639)
-- Dependencies: 227
-- Data for Name: si_recepcion_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2481 (class 0 OID 34646)
-- Dependencies: 230
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


--
-- TOC entry 2482 (class 0 OID 34653)
-- Dependencies: 231
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


--
-- TOC entry 2483 (class 0 OID 34666)
-- Dependencies: 235
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
-- TOC entry 2484 (class 0 OID 34676)
-- Dependencies: 237
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
INSERT INTO si_tolcarom VALUES (17, 4, 'Romana 1', 1, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.74:9600');
INSERT INTO si_tolcarom VALUES (18, 4, 'Romana 2', 2, '3', true, '2012-03-20 15:50:52.664404-04:30', NULL, 'http://192.168.58.74:9600');


--
-- TOC entry 2485 (class 0 OID 34682)
-- Dependencies: 238
-- Data for Name: si_transporte; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2486 (class 0 OID 34692)
-- Dependencies: 241
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO si_usuarios VALUES (7, 'JESUS', 'MACHUCA', '10123456', NULL, 'M', 'JMACHUCA', 'AE14A76B811E68F055D9B4ACFED84125EF89E02F', NULL, NULL, NULL, '2012-06-11 11:15:08.878579-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:15:08.878579-04:30');
INSERT INTO si_usuarios VALUES (3, 'MARIA MATILDE', 'SOSA RUIZ', '10123452', NULL, 'F', 'MMATILDE', '944F61B851E2C9689695C84EC79B85323337DD3C', NULL, NULL, NULL, '2012-06-11 10:56:19.826174-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 10:56:19.826174-04:30');
INSERT INTO si_usuarios VALUES (4, 'RONNY', 'SOSA', '10123453', NULL, 'M', 'RSOSA', '7E2CBA22918EC12DEA4FB70B96C04308F2B5CC66', NULL, NULL, NULL, '2012-06-11 11:13:08.796151-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:13:08.796151-04:30');
INSERT INTO si_usuarios VALUES (5, 'LUIS', 'BLANCHARD', '10123454', NULL, 'M', 'LBLANCHARD', '99E991EADED1B70853A249972B4A3219514C944A', NULL, NULL, NULL, '2012-06-11 11:13:49.203357-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:13:49.203357-04:30');
INSERT INTO si_usuarios VALUES (6, 'TEDDY', 'MRKIC', '10123455', NULL, 'M', 'TMRKIC', 'D968B0E240A1AA578FBF6D183037ED733253E496', NULL, NULL, NULL, '2012-06-11 11:14:34.207801-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:14:34.207801-04:30');
INSERT INTO si_usuarios VALUES (8, 'CARMEN', 'MORENO', '10123457', NULL, 'F', 'CMORENO', '8598CE4987C1195D19CF3E1E66DE1B1107AF0858', NULL, NULL, NULL, '2012-06-11 11:15:36.22558-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:15:36.22558-04:30');
INSERT INTO si_usuarios VALUES (9, 'ROSNELL', 'JASPE', '10123458', NULL, 'M', 'RJASPE', '00C4968E225C1390F8F183513872DFDC1B9C7F1C', NULL, NULL, NULL, '2012-06-11 11:16:08.958747-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:16:08.958747-04:30');
INSERT INTO si_usuarios VALUES (10, 'YESLEY', 'REYES', '10123459', NULL, 'M', 'YREYES', 'A21F63194A89DA6CA8CD5A93DC55DF507C1FE28E', NULL, NULL, NULL, '2012-06-11 11:16:44.137759-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 11:16:44.137759-04:30');
INSERT INTO si_usuarios VALUES (11, 'JOSE', 'PELUZZO', '10123460', NULL, 'M', 'JPELUZZO', 'BEA59914A3F4776602DBF491D08507A27D8AC7B5', NULL, NULL, NULL, '2012-06-11 13:38:17.68568-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 13:38:17.68568-04:30');
INSERT INTO si_usuarios VALUES (12, 'JESUS E', 'RODRIGUEZ V', '18264065', NULL, 'M', 'JRODRIGUEZ', '6233D5CC6E30761AB74ACD66B48F943DF6F82C89', NULL, NULL, NULL, '2012-06-11 13:38:46.329242-04:30', NULL, true, 0, NULL, NULL, '2012-06-21 10:07:14.317605-04:30');
INSERT INTO si_usuarios VALUES (2, 'LUIS', 'ESTRADA', '10123451', NULL, 'M', 'LESTRADA', '13D37B196E0D8B25B8F43BC303F84C6ECC4D604C', NULL, NULL, NULL, '2012-06-11 11:10:02.113171-04:30', NULL, true, 0, NULL, NULL, '2012-06-21 10:07:37.084702-04:30');
INSERT INTO si_usuarios VALUES (13, 'JUAN C', 'TABORDA', '13769341', NULL, 'M', 'JTABORDA', '6E3AAF42AB888C78CE85DAF51E27D1E472D13166', NULL, NULL, NULL, '2012-06-11 13:39:42.787984-04:30', NULL, true, 0, NULL, NULL, '2012-06-11 13:39:42.787984-04:30');
INSERT INTO si_usuarios VALUES (1, 'ADMINISTRADOR', 'ADMINISTRADOR', '11111111', '1980-01-01', 'M', 'ADMIN', 'FE6268C04422554898E72C424D645519C2EFBE2D', NULL, NULL, NULL, '2012-02-12 00:00:00-04:30', NULL, true, 0, NULL, NULL, '2012-06-21 10:05:05.121892-04:30');


--
-- TOC entry 2487 (class 0 OID 34703)
-- Dependencies: 243
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
INSERT INTO si_usuarios_perfiles VALUES (12, 12, 1, 1, '2012-06-11 13:38:46.361-04:30', '2012-06-21 10:07:14.356858-04:30');
INSERT INTO si_usuarios_perfiles VALUES (2, 2, 2, 2, '2012-02-13 11:34:56.142546-04:30', '2012-06-21 10:07:37.117918-04:30');


--
-- TOC entry 2488 (class 0 OID 34707)
-- Dependencies: 244
-- Data for Name: si_vehiculos; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2216 (class 2606 OID 34738)
-- Dependencies: 150 150
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 2264 (class 2606 OID 34740)
-- Dependencies: 194 194
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 2204 (class 2606 OID 34742)
-- Dependencies: 141 141
-- Name: si_alamacenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 2606 OID 34744)
-- Dependencies: 144 144
-- Name: si_analisis_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 34746)
-- Dependencies: 146 146
-- Name: si_analisis_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2206 (class 2606 OID 34748)
-- Dependencies: 143 143 143
-- Name: si_analisis_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);


--
-- TOC entry 2208 (class 2606 OID 34750)
-- Dependencies: 143 143
-- Name: si_analisis_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 34752)
-- Dependencies: 148 148
-- Name: si_analisis_resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 34754)
-- Dependencies: 153 153
-- Name: si_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);


--
-- TOC entry 2220 (class 2606 OID 34756)
-- Dependencies: 155 155
-- Name: si_cargo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 34758)
-- Dependencies: 157 157
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 2224 (class 2606 OID 34760)
-- Dependencies: 158 158
-- Name: si_choferes_ced_rif_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_ced_rif_key UNIQUE (ced_rif);


--
-- TOC entry 2226 (class 2606 OID 34762)
-- Dependencies: 158 158
-- Name: si_choferes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 34764)
-- Dependencies: 161 161
-- Name: si_cliente_ced_rif_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_ced_rif_key UNIQUE (ced_rif);


--
-- TOC entry 2230 (class 2606 OID 34766)
-- Dependencies: 161 161
-- Name: si_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 34768)
-- Dependencies: 163 163
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 34770)
-- Dependencies: 165 165 165 165
-- Name: si_cosecha_silo_id_cosecha_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);


--
-- TOC entry 2236 (class 2606 OID 34772)
-- Dependencies: 165 165
-- Name: si_cosecha_silo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 34774)
-- Dependencies: 167 167
-- Name: si_cuarentena_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 34776)
-- Dependencies: 169 169
-- Name: si_cuarentena_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2242 (class 2606 OID 34778)
-- Dependencies: 172 172
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 34780)
-- Dependencies: 173 173
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2246 (class 2606 OID 34782)
-- Dependencies: 176 176
-- Name: si_denom_tip_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 34784)
-- Dependencies: 177 177
-- Name: si_despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 34786)
-- Dependencies: 180 180
-- Name: si_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 34788)
-- Dependencies: 182 182
-- Name: si_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 34790)
-- Dependencies: 183 183
-- Name: si_finca_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 34792)
-- Dependencies: 185 185
-- Name: si_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 34794)
-- Dependencies: 187 187
-- Name: si_guia_rec_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 34796)
-- Dependencies: 188 188
-- Name: si_guiarec_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 34798)
-- Dependencies: 191 191
-- Name: si_impresora_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 34800)
-- Dependencies: 196 196
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2268 (class 2606 OID 34802)
-- Dependencies: 198 198
-- Name: si_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 34804)
-- Dependencies: 199 199 199
-- Name: si_menu_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);


--
-- TOC entry 2272 (class 2606 OID 34806)
-- Dependencies: 201 201
-- Name: si_municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2276 (class 2606 OID 34808)
-- Dependencies: 204 204
-- Name: si_ordenes_det_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 34810)
-- Dependencies: 203 203
-- Name: si_ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);


--
-- TOC entry 2278 (class 2606 OID 34812)
-- Dependencies: 207 207
-- Name: si_org_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);


--
-- TOC entry 2280 (class 2606 OID 34814)
-- Dependencies: 209 209
-- Name: si_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2282 (class 2606 OID 34816)
-- Dependencies: 211 211
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2284 (class 2606 OID 34818)
-- Dependencies: 213 213
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2286 (class 2606 OID 34820)
-- Dependencies: 214 214
-- Name: si_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 34822)
-- Dependencies: 216 216
-- Name: si_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2290 (class 2606 OID 34824)
-- Dependencies: 219 219
-- Name: si_productor_ced_rif_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_ced_rif_key UNIQUE (ced_rif);


--
-- TOC entry 2292 (class 2606 OID 34826)
-- Dependencies: 219 219
-- Name: si_productor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);


--
-- TOC entry 2294 (class 2606 OID 34828)
-- Dependencies: 221 221
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 34830)
-- Dependencies: 222 222
-- Name: si_proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 34832)
-- Dependencies: 224 224
-- Name: si_punto_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 34834)
-- Dependencies: 227 227
-- Name: si_recepcion_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 2300 (class 2606 OID 34836)
-- Dependencies: 226 226
-- Name: si_recepcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2306 (class 2606 OID 34838)
-- Dependencies: 231 231
-- Name: si_recursos_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);


--
-- TOC entry 2304 (class 2606 OID 34840)
-- Dependencies: 230 230
-- Name: si_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);


--
-- TOC entry 2308 (class 2606 OID 34842)
-- Dependencies: 235 235
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 34844)
-- Dependencies: 237 237
-- Name: si_tolcarom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);


--
-- TOC entry 2312 (class 2606 OID 34846)
-- Dependencies: 238 238
-- Name: si_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 2314 (class 2606 OID 34848)
-- Dependencies: 241 241
-- Name: si_usuarios_cedula_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_cedula_key UNIQUE (cedula);


--
-- TOC entry 2320 (class 2606 OID 34850)
-- Dependencies: 243 243
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 34852)
-- Dependencies: 241 241
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2318 (class 2606 OID 34854)
-- Dependencies: 241 241
-- Name: si_usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 2322 (class 2606 OID 34856)
-- Dependencies: 244 244
-- Name: si_vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 2324 (class 2606 OID 34858)
-- Dependencies: 244 244
-- Name: si_vehiculos_placa_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_placa_key UNIQUE (placa);


--
-- TOC entry 2325 (class 2606 OID 34859)
-- Dependencies: 2221 141 157
-- Name: si_almacenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2326 (class 2606 OID 34864)
-- Dependencies: 141 2251 182
-- Name: si_almacenes_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2327 (class 2606 OID 34869)
-- Dependencies: 2271 201 141
-- Name: si_almacenes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2328 (class 2606 OID 34874)
-- Dependencies: 141 2279 209
-- Name: si_almacenes_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2330 (class 2606 OID 34879)
-- Dependencies: 2207 144 143
-- Name: si_analisis_centro_acopio_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2331 (class 2606 OID 34884)
-- Dependencies: 144 157 2221
-- Name: si_analisis_centro_acopio_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2332 (class 2606 OID 34889)
-- Dependencies: 146 2207 143
-- Name: si_analisis_cultivo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2333 (class 2606 OID 34894)
-- Dependencies: 2277 146 207
-- Name: si_analisis_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2329 (class 2606 OID 34899)
-- Dependencies: 2277 143 207
-- Name: si_analisis_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2334 (class 2606 OID 34904)
-- Dependencies: 148 143 2207
-- Name: si_analisis_resultado_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2335 (class 2606 OID 34909)
-- Dependencies: 148 177 2247
-- Name: si_analisis_resultado_id_despacho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);


--
-- TOC entry 2336 (class 2606 OID 34914)
-- Dependencies: 148 226 2299
-- Name: si_analisis_resultado_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2337 (class 2606 OID 34919)
-- Dependencies: 2315 148 241
-- Name: si_analisis_resultado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2338 (class 2606 OID 34924)
-- Dependencies: 2203 141 153
-- Name: si_cargo_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2339 (class 2606 OID 34929)
-- Dependencies: 2219 155 153
-- Name: si_cargo_id_cargo_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);


--
-- TOC entry 2340 (class 2606 OID 34934)
-- Dependencies: 241 153 2315
-- Name: si_cargo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2341 (class 2606 OID 34939)
-- Dependencies: 182 157 2251
-- Name: si_centro_acopio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2342 (class 2606 OID 34944)
-- Dependencies: 157 201 2271
-- Name: si_centro_acopio_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2343 (class 2606 OID 34949)
-- Dependencies: 2277 207 157
-- Name: si_centro_acopio_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2344 (class 2606 OID 34954)
-- Dependencies: 157 2279 209
-- Name: si_centro_acopio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2345 (class 2606 OID 34959)
-- Dependencies: 2277 207 158
-- Name: si_choferes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2346 (class 2606 OID 34964)
-- Dependencies: 207 2277 161
-- Name: si_cliente_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2347 (class 2606 OID 34969)
-- Dependencies: 172 163 2241
-- Name: si_cosecha_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2348 (class 2606 OID 34974)
-- Dependencies: 163 221 2293
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 2349 (class 2606 OID 34979)
-- Dependencies: 164 157 2221
-- Name: si_cosecha_productor_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2350 (class 2606 OID 34984)
-- Dependencies: 164 163 2231
-- Name: si_cosecha_productor_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2351 (class 2606 OID 34989)
-- Dependencies: 164 2291 219
-- Name: si_cosecha_productor_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2352 (class 2606 OID 34994)
-- Dependencies: 163 165 2231
-- Name: si_cosecha_silo_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2353 (class 2606 OID 34999)
-- Dependencies: 172 165 2241
-- Name: si_cosecha_silo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2354 (class 2606 OID 35004)
-- Dependencies: 235 165 2307
-- Name: si_cosecha_silo_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2355 (class 2606 OID 35009)
-- Dependencies: 2207 143 167
-- Name: si_cuarentena_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2356 (class 2606 OID 35014)
-- Dependencies: 2221 157 167
-- Name: si_cuarentena_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2357 (class 2606 OID 35019)
-- Dependencies: 172 167 2241
-- Name: si_cuarentena_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2358 (class 2606 OID 35024)
-- Dependencies: 167 2299 226
-- Name: si_cuarentena_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2359 (class 2606 OID 35029)
-- Dependencies: 167 2315 241
-- Name: si_cuarentena_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2360 (class 2606 OID 35034)
-- Dependencies: 2237 169 167
-- Name: si_cuarentena_plaga_id_cuarentena_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cuarentena_plaga
    ADD CONSTRAINT si_cuarentena_plaga_id_cuarentena_fkey FOREIGN KEY (id_cuarentena) REFERENCES si_cuarentena(id);


--
-- TOC entry 2361 (class 2606 OID 35039)
-- Dependencies: 207 172 2277
-- Name: si_cultivo_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2362 (class 2606 OID 35044)
-- Dependencies: 173 143 2207
-- Name: si_cultivo_tipo_id_analisis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);


--
-- TOC entry 2363 (class 2606 OID 35049)
-- Dependencies: 173 2221 157
-- Name: si_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2364 (class 2606 OID 35054)
-- Dependencies: 2241 172 173
-- Name: si_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2365 (class 2606 OID 35059)
-- Dependencies: 2241 176 172
-- Name: si_denom_tip_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2366 (class 2606 OID 35064)
-- Dependencies: 2277 176 207
-- Name: si_denom_tip_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2367 (class 2606 OID 35069)
-- Dependencies: 157 177 2221
-- Name: si_despacho_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2368 (class 2606 OID 35074)
-- Dependencies: 2229 161 177
-- Name: si_despacho_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2369 (class 2606 OID 35079)
-- Dependencies: 172 177 2241
-- Name: si_despacho_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2370 (class 2606 OID 35084)
-- Dependencies: 203 177 2273
-- Name: si_despacho_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2371 (class 2606 OID 35089)
-- Dependencies: 177 224 2297
-- Name: si_despacho_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2372 (class 2606 OID 35094)
-- Dependencies: 177 235 2307
-- Name: si_despacho_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2373 (class 2606 OID 35099)
-- Dependencies: 2311 238 177
-- Name: si_despacho_id_transporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);


--
-- TOC entry 2374 (class 2606 OID 35104)
-- Dependencies: 241 2315 177
-- Name: si_despacho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2375 (class 2606 OID 35109)
-- Dependencies: 177 244 2321
-- Name: si_despacho_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);


--
-- TOC entry 2376 (class 2606 OID 35114)
-- Dependencies: 180 2277 207
-- Name: si_ejes_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2377 (class 2606 OID 35119)
-- Dependencies: 182 2279 209
-- Name: si_estado_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2378 (class 2606 OID 35124)
-- Dependencies: 2251 183 182
-- Name: si_finca_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2379 (class 2606 OID 35129)
-- Dependencies: 183 2271 201
-- Name: si_finca_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2380 (class 2606 OID 35134)
-- Dependencies: 2277 207 183
-- Name: si_finca_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2381 (class 2606 OID 35139)
-- Dependencies: 209 183 2279
-- Name: si_finca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2382 (class 2606 OID 35144)
-- Dependencies: 183 219 2291
-- Name: si_finca_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2383 (class 2606 OID 35149)
-- Dependencies: 185 157 2221
-- Name: si_formulas_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2384 (class 2606 OID 35154)
-- Dependencies: 172 2241 185
-- Name: si_formulas_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2385 (class 2606 OID 35159)
-- Dependencies: 2277 207 185
-- Name: si_formulas_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2386 (class 2606 OID 35164)
-- Dependencies: 187 241 2315
-- Name: si_guia_rec_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2387 (class 2606 OID 35169)
-- Dependencies: 188 2257 187
-- Name: si_guiarec_det_id_guiarec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);


--
-- TOC entry 2388 (class 2606 OID 35174)
-- Dependencies: 191 157 2221
-- Name: si_impresora_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_impresora
    ADD CONSTRAINT si_impresora_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2389 (class 2606 OID 35179)
-- Dependencies: 196 194 2263
-- Name: si_log_consultas_log_codigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);


--
-- TOC entry 2390 (class 2606 OID 35184)
-- Dependencies: 198 199 2267
-- Name: si_menu_usuario_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);


--
-- TOC entry 2391 (class 2606 OID 35189)
-- Dependencies: 241 199 2315
-- Name: si_menu_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2392 (class 2606 OID 35194)
-- Dependencies: 2251 182 201
-- Name: si_municipio_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2397 (class 2606 OID 35199)
-- Dependencies: 2273 204 203
-- Name: si_ordenes_det_id_orden_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes_det
    ADD CONSTRAINT si_ordenes_det_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);


--
-- TOC entry 2393 (class 2606 OID 35204)
-- Dependencies: 157 2221 203
-- Name: si_ordenes_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2394 (class 2606 OID 35209)
-- Dependencies: 203 2229 161
-- Name: si_ordenes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2395 (class 2606 OID 35214)
-- Dependencies: 172 2241 203
-- Name: si_ordenes_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2396 (class 2606 OID 35219)
-- Dependencies: 203 2297 224
-- Name: si_ordenes_id_punto_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);


--
-- TOC entry 2398 (class 2606 OID 35224)
-- Dependencies: 207 182 2251
-- Name: si_organizacion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2399 (class 2606 OID 35229)
-- Dependencies: 201 207 2271
-- Name: si_organizacion_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2400 (class 2606 OID 35234)
-- Dependencies: 209 2279 207
-- Name: si_organizacion_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2401 (class 2606 OID 35239)
-- Dependencies: 214 2277 207
-- Name: si_plaga_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2402 (class 2606 OID 35244)
-- Dependencies: 207 216 2277
-- Name: si_producto_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2403 (class 2606 OID 35249)
-- Dependencies: 182 219 2251
-- Name: si_productor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2404 (class 2606 OID 35254)
-- Dependencies: 219 201 2271
-- Name: si_productor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2405 (class 2606 OID 35259)
-- Dependencies: 2277 207 219
-- Name: si_productor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2406 (class 2606 OID 35264)
-- Dependencies: 2279 209 219
-- Name: si_productor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2407 (class 2606 OID 35269)
-- Dependencies: 2221 221 157
-- Name: si_programa_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2408 (class 2606 OID 35274)
-- Dependencies: 182 222 2251
-- Name: si_proveedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2409 (class 2606 OID 35279)
-- Dependencies: 2271 201 222
-- Name: si_proveedor_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2410 (class 2606 OID 35284)
-- Dependencies: 2277 222 207
-- Name: si_proveedor_id_org_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);


--
-- TOC entry 2411 (class 2606 OID 35289)
-- Dependencies: 222 209 2279
-- Name: si_proveedor_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2412 (class 2606 OID 35294)
-- Dependencies: 157 2221 224
-- Name: si_punto_entrega_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2413 (class 2606 OID 35299)
-- Dependencies: 224 2229 161
-- Name: si_punto_entrega_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);


--
-- TOC entry 2414 (class 2606 OID 35304)
-- Dependencies: 224 2251 182
-- Name: si_punto_entrega_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);


--
-- TOC entry 2415 (class 2606 OID 35309)
-- Dependencies: 201 224 2271
-- Name: si_punto_entrega_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);


--
-- TOC entry 2416 (class 2606 OID 35314)
-- Dependencies: 224 2279 209
-- Name: si_punto_entrega_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);


--
-- TOC entry 2424 (class 2606 OID 35319)
-- Dependencies: 157 2221 227
-- Name: si_recepcion_cultivo_tipo_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2425 (class 2606 OID 35324)
-- Dependencies: 2241 172 227
-- Name: si_recepcion_cultivo_tipo_id_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);


--
-- TOC entry 2426 (class 2606 OID 35329)
-- Dependencies: 227 2299 226
-- Name: si_recepcion_cultivo_tipo_id_recepcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);


--
-- TOC entry 2417 (class 2606 OID 35334)
-- Dependencies: 2221 157 226
-- Name: si_recepcion_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2418 (class 2606 OID 35339)
-- Dependencies: 158 226 2225
-- Name: si_recepcion_id_chofer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);


--
-- TOC entry 2419 (class 2606 OID 35344)
-- Dependencies: 163 2231 226
-- Name: si_recepcion_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);


--
-- TOC entry 2420 (class 2606 OID 35349)
-- Dependencies: 187 2257 226
-- Name: si_recepcion_id_guia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);


--
-- TOC entry 2421 (class 2606 OID 35354)
-- Dependencies: 2291 226 219
-- Name: si_recepcion_id_productor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);


--
-- TOC entry 2422 (class 2606 OID 35359)
-- Dependencies: 235 226 2307
-- Name: si_recepcion_id_silo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);


--
-- TOC entry 2423 (class 2606 OID 35364)
-- Dependencies: 241 226 2315
-- Name: si_recepcion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2427 (class 2606 OID 35369)
-- Dependencies: 231 2303 230
-- Name: si_recursos_etiquetas_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);


--
-- TOC entry 2428 (class 2606 OID 35374)
-- Dependencies: 2203 141 235
-- Name: si_silos_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2429 (class 2606 OID 35379)
-- Dependencies: 235 2221 157
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2430 (class 2606 OID 35384)
-- Dependencies: 157 237 2221
-- Name: si_tolcarom_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2431 (class 2606 OID 35389)
-- Dependencies: 2221 238 157
-- Name: si_transporte_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 2432 (class 2606 OID 35394)
-- Dependencies: 243 2203 141
-- Name: si_usuarios_perfiles_id_almacen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);


--
-- TOC entry 2433 (class 2606 OID 35399)
-- Dependencies: 2283 213 243
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2434 (class 2606 OID 35404)
-- Dependencies: 241 243 2315
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-07-02 15:48:03 VET

--
-- PostgreSQL database dump complete
--

