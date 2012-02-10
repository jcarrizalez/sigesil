--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-02-09 23:07:05

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 187 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2003 (class 0 OID 0)
-- Dependencies: 187
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 25853)
-- Dependencies: 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id character varying(20) NOT NULL,
    apperror_time date NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 162 (class 1259 OID 25859)
-- Dependencies: 6 161
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
-- TOC entry 2004 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_app_error_apperror_id_seq OWNED BY si_app_error.apperror_id;


--
-- TOC entry 2005 (class 0 OID 0)
-- Dependencies: 162
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_app_error_apperror_id_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 25861)
-- Dependencies: 1929 1930 1931 1932 1933 6
-- Name: si_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_centro_acopio (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    rif character varying(16) DEFAULT NULL::character varying,
    telefono character varying(32) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    ubicacion character varying(255) DEFAULT NULL::character varying,
    codigo character varying(5) NOT NULL,
    coordenadas character varying(32) DEFAULT NULL::character varying,
    id_org bigint,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_centro_acopio OWNER TO admin;

--
-- TOC entry 164 (class 1259 OID 25872)
-- Dependencies: 6 163
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
-- TOC entry 2006 (class 0 OID 0)
-- Dependencies: 164
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_centro_acopio_id_seq OWNED BY si_centro_acopio.id;


--
-- TOC entry 2007 (class 0 OID 0)
-- Dependencies: 164
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 6, true);


--
-- TOC entry 165 (class 1259 OID 25874)
-- Dependencies: 1935 1936 1937 6
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint NOT NULL,
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
-- TOC entry 2008 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN si_cosecha.estado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN si_cosecha.estado IS 'False = Abierto
True = Cerrado';


--
-- TOC entry 166 (class 1259 OID 25883)
-- Dependencies: 6 165
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
-- TOC entry 2009 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_id_seq OWNED BY si_cosecha.id;


--
-- TOC entry 2010 (class 0 OID 0)
-- Dependencies: 166
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 25885)
-- Dependencies: 1939 6
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint NOT NULL,
    id_tipo_cultivo bigint DEFAULT 0 NOT NULL,
    nombre character varying(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 168 (class 1259 OID 25889)
-- Dependencies: 6 167
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
-- TOC entry 2011 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_id_seq OWNED BY si_cultivo.id;


--
-- TOC entry 2012 (class 0 OID 0)
-- Dependencies: 168
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 7, true);


--
-- TOC entry 169 (class 1259 OID 25891)
-- Dependencies: 6
-- Name: si_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo_tipo (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_cultivo_tipo OWNER TO admin;

--
-- TOC entry 170 (class 1259 OID 25894)
-- Dependencies: 6 169
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
-- TOC entry 2013 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 2014 (class 0 OID 0)
-- Dependencies: 170
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 4, true);


--
-- TOC entry 171 (class 1259 OID 25896)
-- Dependencies: 6
-- Name: si_log_codigos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_log_codigos (
    log_codigo_id bigint NOT NULL,
    log_codigo_nombre_es character varying(255) NOT NULL,
    log_codigo_critico smallint NOT NULL,
    log_codigo_tipo character varying(45) NOT NULL
);


ALTER TABLE public.si_log_codigos OWNER TO admin;

--
-- TOC entry 172 (class 1259 OID 25899)
-- Dependencies: 6 171
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
-- TOC entry 2015 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_log_codigos_log_codigo_id_seq OWNED BY si_log_codigos.log_codigo_id;


--
-- TOC entry 2016 (class 0 OID 0)
-- Dependencies: 172
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 25901)
-- Dependencies: 6
-- Name: si_log_consultas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_log_consultas (
    log_id bigint NOT NULL,
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
-- TOC entry 174 (class 1259 OID 25907)
-- Dependencies: 173 6
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
-- TOC entry 2017 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_log_consultas_log_id_seq OWNED BY si_log_consultas.log_id;


--
-- TOC entry 2018 (class 0 OID 0)
-- Dependencies: 174
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 91, true);


--
-- TOC entry 175 (class 1259 OID 25909)
-- Dependencies: 6
-- Name: si_parametros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_parametros (
    id bigint NOT NULL,
    parametro_llave character varying(255) NOT NULL,
    parametro_valor character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    parametro_mostrar smallint NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_parametros OWNER TO admin;

--
-- TOC entry 176 (class 1259 OID 25915)
-- Dependencies: 6 175
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
-- TOC entry 2019 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_parametros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_parametros_id_seq OWNED BY si_parametros.id;


--
-- TOC entry 2020 (class 0 OID 0)
-- Dependencies: 176
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 3, true);


--
-- TOC entry 177 (class 1259 OID 25917)
-- Dependencies: 6
-- Name: si_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_perfiles (
    id bigint NOT NULL,
    nombre_perfil character varying(255) NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_perfiles OWNER TO admin;

--
-- TOC entry 178 (class 1259 OID 25920)
-- Dependencies: 177 6
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
-- TOC entry 2021 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_perfiles_id_seq OWNED BY si_perfiles.id;


--
-- TOC entry 2022 (class 0 OID 0)
-- Dependencies: 178
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 6, true);


--
-- TOC entry 179 (class 1259 OID 25922)
-- Dependencies: 6
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero integer,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 180 (class 1259 OID 25928)
-- Dependencies: 179 6
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
-- TOC entry 2023 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_programa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_programa_id_seq OWNED BY si_programa.id;


--
-- TOC entry 2024 (class 0 OID 0)
-- Dependencies: 180
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 25930)
-- Dependencies: 1947 1948 6
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    coordenada character varying(255),
    numero integer DEFAULT 0 NOT NULL,
    capacidad integer DEFAULT 0,
    observacion character varying(255),
    creado timestamp with time zone,
    modificado timestamp with time zone
);


ALTER TABLE public.si_silos OWNER TO admin;

--
-- TOC entry 182 (class 1259 OID 25938)
-- Dependencies: 6 181
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
-- TOC entry 2025 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_silos_id_seq OWNED BY si_silos.id;


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 182
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 6, true);


--
-- TOC entry 183 (class 1259 OID 25940)
-- Dependencies: 6
-- Name: si_usuarios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL,
    cedula character varying(255) NOT NULL,
    fecha_nacimiento date,
    sexo character varying(2),
    contrasena character varying(255) NOT NULL,
    ubicacion character varying(255),
    telefono character varying(32),
    email character varying(255),
    creado date,
    modificado date
);


ALTER TABLE public.si_usuarios OWNER TO admin;

--
-- TOC entry 184 (class 1259 OID 25946)
-- Dependencies: 6 183
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
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_id_seq OWNED BY si_usuarios.id;


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 184
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 3, true);


--
-- TOC entry 185 (class 1259 OID 25948)
-- Dependencies: 6
-- Name: si_usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios_perfiles (
    id bigint NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_acopio integer NOT NULL,
    id_perfil integer NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_usuarios_perfiles OWNER TO admin;

--
-- TOC entry 186 (class 1259 OID 25951)
-- Dependencies: 185 6
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
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_perfiles_id_seq OWNED BY si_usuarios_perfiles.id;


--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 186
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 2, true);


--
-- TOC entry 1928 (class 2604 OID 26030)
-- Dependencies: 162 161
-- Name: apperror_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_app_error ALTER COLUMN apperror_id SET DEFAULT nextval('si_app_error_apperror_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 25954)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_centro_acopio_id_seq'::regclass);


--
-- TOC entry 1938 (class 2604 OID 25955)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha ALTER COLUMN id SET DEFAULT nextval('si_cosecha_id_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 25956)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_id_seq'::regclass);


--
-- TOC entry 1941 (class 2604 OID 25957)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 25958)
-- Dependencies: 172 171
-- Name: log_codigo_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_log_codigos ALTER COLUMN log_codigo_id SET DEFAULT nextval('si_log_codigos_log_codigo_id_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 25959)
-- Dependencies: 174 173
-- Name: log_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_log_consultas ALTER COLUMN log_id SET DEFAULT nextval('si_log_consultas_log_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 25960)
-- Dependencies: 176 175
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_parametros ALTER COLUMN id SET DEFAULT nextval('si_parametros_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 25961)
-- Dependencies: 178 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_perfiles ALTER COLUMN id SET DEFAULT nextval('si_perfiles_id_seq'::regclass);


--
-- TOC entry 1946 (class 2604 OID 25962)
-- Dependencies: 180 179
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_programa ALTER COLUMN id SET DEFAULT nextval('si_programa_id_seq'::regclass);


--
-- TOC entry 1949 (class 2604 OID 25963)
-- Dependencies: 182 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_silos ALTER COLUMN id SET DEFAULT nextval('si_silos_id_seq'::regclass);


--
-- TOC entry 1950 (class 2604 OID 25964)
-- Dependencies: 184 183
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios ALTER COLUMN id SET DEFAULT nextval('si_usuarios_id_seq'::regclass);


--
-- TOC entry 1951 (class 2604 OID 25965)
-- Dependencies: 186 185
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios_perfiles ALTER COLUMN id SET DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass);


--
-- TOC entry 1985 (class 0 OID 25853)
-- Dependencies: 161
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 1986 (class 0 OID 25861)
-- Dependencies: 163
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, nombre, rif, telefono, email, ubicacion, codigo, coordenadas, id_org, creado, modificado) FROM stdin;
0	Todos	Todos	Todos	Todos	Todos	00	\N	\N	\N	\N
1	Araure	J-1234567	0416-1234567	asd@asd.com	Guarico	56	\N	\N	2012-02-07 16:44:22.915676-04:30	2012-02-07 16:49:41.436829-04:30
2	Sabana de Parra	J-9876543	0412-7418529	123@asd.com	Mcy	57	\N	\N	2012-02-07 16:56:18.59822-04:30	2012-02-07 16:56:18.59822-04:30
3	Chaguaramas	ASD	ASD	ASD	ASD	58	\N	\N	2012-02-08 08:27:19.837819-04:30	2012-02-08 08:27:19.837819-04:30
4	Sabaneta	J-182731092	0412-123456789	ASD@asd.com	Cagua	60	\N	\N	2012-02-08 10:29:24.890296-04:30	2012-02-08 10:29:24.890296-04:30
5	Zaraza	J-3456789	\N	\N	Otra	63	\N	\N	2012-02-08 15:28:42.815816-04:30	2012-02-08 15:28:42.815816-04:30
6	Maturin	J-8521479	\N	\N	Sucre	68	\N	\N	2012-02-09 21:19:19.756-04:30	2012-02-09 21:19:19.756-04:30
\.


--
-- TOC entry 1987 (class 0 OID 25874)
-- Dependencies: 165
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, nombre, proyectado, observacion, fecha_inicio, fecha_fin, estado) FROM stdin;
\.


--
-- TOC entry 1988 (class 0 OID 25885)
-- Dependencies: 167
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_tipo_cultivo, nombre, creado, modificado) FROM stdin;
5	1	Arroz	\N	\N
6	1	Trigo	\N	\N
\.


--
-- TOC entry 1989 (class 0 OID 25891)
-- Dependencies: 169
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo_tipo (id, nombre, creado, modificado) FROM stdin;
1	Ninguno	\N	\N
2	Otro	\N	\N
3	Arroz Tipo 1	2012-02-08 10:25:39.047912-04:30	2012-02-08 10:25:39.047912-04:30
4	Arroz Tipo 2	2012-02-08 10:26:04.892642-04:30	2012-02-08 10:26:57.370103-04:30
\.


--
-- TOC entry 1990 (class 0 OID 25896)
-- Dependencies: 171
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
-- TOC entry 1991 (class 0 OID 25901)
-- Dependencies: 173
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
82	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	codigo = '69'<br />nombre =  'Maturin'<br />rif =  'J-0203046'<br />telefono =  null<br />email =  null<br />ubicacion =  'Sucre'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (codigo, nombre, rif, telefono, email, ubicacion, coordenadas, id_org, creado, modificado) VALUES  ('69', 'Maturin', 'J-0203046', null, null, 'Sucre', null, null,now(),now())	
83	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, nombre, coordenada, numero, capacidad, creado, modificado) VALUES  ('6', 'Silo 1', 'Norte', '1', '1000',now(),now())	
84	2012-02-09	202	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6', nombre = 'Silo 2', coordenada = 'Norte', numero = '2', capacidad = '1000', modificado=now()	UPDATE si_silos SET  id_centro_acopio = '6', nombre = 'Silo 2', coordenada = 'Norte', numero = '2', capacidad = '1000', modificado=now() WHERE id=4	
85	2012-02-09	202	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6', nombre = 'Silo 3', coordenada = 'Norte', numero = '3', capacidad = '1000', modificado=now()	UPDATE si_silos SET  id_centro_acopio = '6', nombre = 'Silo 3', coordenada = 'Norte', numero = '3', capacidad = '1000', modificado=now() WHERE id=4	
86	2012-02-09	202	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6', nombre = 'Silo 4', coordenada = 'Norte', numero = '4', capacidad = '1000', modificado=now()	UPDATE si_silos SET  id_centro_acopio = '6', nombre = 'Silo 4', coordenada = 'Norte', numero = '4', capacidad = '1000', modificado=now() WHERE id=4	
87	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_centro_acopio	No data	codigo = '68'<br />nombre =  'Maturin'<br />rif =  'J-8521479'<br />telefono =  null<br />email =  null<br />ubicacion =  'Sucre'<br />coordenadas =  null<br />id_org =  null<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_centro_acopio  (codigo, nombre, rif, telefono, email, ubicacion, coordenadas, id_org, creado, modificado) VALUES  ('68', 'Maturin', 'J-8521479', null, null, 'Sucre', null, null,now(),now())	
88	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />nombre =  'Silo 1'<br />coordenada =  'Norte'<br />numero =  '1'<br />capacidad =  '1000'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, nombre, coordenada, numero, capacidad, creado, modificado) VALUES  ('6', 'Silo 1', 'Norte', '1', '1000',now(),now())	
89	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />nombre =  'Silo 2'<br />coordenada =  'Norte'<br />numero =  '2'<br />capacidad =  '1000'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, nombre, coordenada, numero, capacidad, creado, modificado) VALUES  ('6', 'Silo 2', 'Norte', '2', '1000',now(),now())	
90	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />nombre =  'Silo 3'<br />coordenada =  'Norte'<br />numero =  '3'<br />capacidad =  '1000'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, nombre, coordenada, numero, capacidad, creado, modificado) VALUES  ('6', 'Silo 3', 'Norte', '3', '1000',now(),now())	
91	2012-02-09	201	1	N/A	jesuskateadio@hotmail.com	N/A	6ld9g4kjhm1v846trd5dntuus1	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Windows<br />NT 6.1 (Windows 7)</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 10.0<br />ProductSub: 20100101<br />Engine: Gecko RV: 10.0</p>\t</div>\r\n	si_silos	No data	id_centro_acopio = '6'<br />nombre =  'Silo 4'<br />coordenada =  'Norte'<br />numero =  '4'<br />capacidad =  '1000'<br />creado = now()<br />modificado = now()<br />	INSERT INTO si_silos  (id_centro_acopio, nombre, coordenada, numero, capacidad, creado, modificado) VALUES  ('6', 'Silo 4', 'Norte', '4', '1000',now(),now())	
\.


--
-- TOC entry 1992 (class 0 OID 25909)
-- Dependencies: 175
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
1	SYSTEM_NAME	SIGESI	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
2	MAX_RESULTS_PAG	3	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
\.


--
-- TOC entry 1993 (class 0 OID 25917)
-- Dependencies: 177
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_perfiles (id, nombre_perfil, creado, modificado) FROM stdin;
1	Administrador	2012-02-07	\N
2	Gerente	2012-02-07	\N
3	Calidad	2012-02-07	\N
4	Romanero	2012-02-07	\N
5	Recepcion	2012-02-07	\N
6	Despacho	2012-02-07	\N
\.


--
-- TOC entry 1994 (class 0 OID 25922)
-- Dependencies: 179
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, numero, nombre, observacion, creado, modificado) FROM stdin;
\.


--
-- TOC entry 1995 (class 0 OID 25930)
-- Dependencies: 181
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, nombre, coordenada, numero, capacidad, observacion, creado, modificado) FROM stdin;
1	1	Silo A	Norte	1	20000	\N	2012-02-08 00:00:00-04:30	2012-02-08 14:04:11.794822-04:30
2	1	Silo B	Sur	2	350000	Ninguna	2012-02-08 14:32:05.462218-04:30	2012-02-08 14:32:05.462218-04:30
3	6	Silo 1	Norte	1	1000	\N	2012-02-09 21:19:19.793-04:30	2012-02-09 21:19:19.793-04:30
4	6	Silo 2	Norte	2	1000	\N	2012-02-09 21:19:19.826-04:30	2012-02-09 21:19:19.826-04:30
5	6	Silo 3	Norte	3	1000	\N	2012-02-09 21:19:19.83-04:30	2012-02-09 21:19:19.83-04:30
6	6	Silo 4	Norte	4	1000	\N	2012-02-09 21:19:19.834-04:30	2012-02-09 21:19:19.834-04:30
\.


--
-- TOC entry 1996 (class 0 OID 25940)
-- Dependencies: 183
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, contrasena, ubicacion, telefono, email, creado, modificado) FROM stdin;
1	Jesus E	Rodriguez V	18264065	1988-07-08	M	7c4a8d09ca3762af61e59520943dc26494f8941b	Cagua	0416-2440414	jesuskateadio@hotmail.com	2012-02-07	\N
2	Juan	Taborda	13769341	1977-10-02	M	7c4a8d09ca3762af61e59520943dc26494f8941b	Mcy	0416-9333866	juantaborda@agropatria.co.ve	2012-02-07	\N
\.


--
-- TOC entry 1997 (class 0 OID 25948)
-- Dependencies: 185
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_centro_acopio, id_perfil, creado, modificado) FROM stdin;
1	1	0	1	2012-02-08	\N
2	2	1	2	2012-02-08	\N
\.


--
-- TOC entry 1953 (class 2606 OID 26032)
-- Dependencies: 161 161
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 1977 (class 2606 OID 25969)
-- Dependencies: 185 185
-- Name: id_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT id_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 1963 (class 2606 OID 25971)
-- Dependencies: 171 171
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 1955 (class 2606 OID 25973)
-- Dependencies: 163 163
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 25975)
-- Dependencies: 165 165
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 1959 (class 2606 OID 25977)
-- Dependencies: 167 167
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 1961 (class 2606 OID 25979)
-- Dependencies: 169 169
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 1965 (class 2606 OID 25981)
-- Dependencies: 173 173
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 1967 (class 2606 OID 25983)
-- Dependencies: 175 175
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 1969 (class 2606 OID 25985)
-- Dependencies: 177 177
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 1971 (class 2606 OID 25987)
-- Dependencies: 179 179
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 25989)
-- Dependencies: 181 181
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2606 OID 25991)
-- Dependencies: 183 183
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 1980 (class 2606 OID 25992)
-- Dependencies: 163 1954 179
-- Name: id_centro_acopio; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT id_centro_acopio FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 1982 (class 2606 OID 25997)
-- Dependencies: 185 1974 183
-- Name: id_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT id_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 1978 (class 2606 OID 26002)
-- Dependencies: 179 1970 165
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 1979 (class 2606 OID 26007)
-- Dependencies: 1960 169 167
-- Name: si_cultivo_id_tipo_cultivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_tipo_cultivo_fkey FOREIGN KEY (id_tipo_cultivo) REFERENCES si_cultivo_tipo(id);


--
-- TOC entry 1981 (class 2606 OID 26012)
-- Dependencies: 181 163 1954
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 1983 (class 2606 OID 26017)
-- Dependencies: 163 1954 185
-- Name: si_usuarios_perfiles_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 1984 (class 2606 OID 26022)
-- Dependencies: 177 185 1968
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 2002 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-09 23:07:06

--
-- PostgreSQL database dump complete
--

