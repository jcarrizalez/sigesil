--
-- PostgreSQL database dump
--

-- Started on 2012-02-07 12:02:54 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1535 (class 1259 OID 18837)
-- Dependencies: 6
-- Name: si_app_error; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_app_error (
    apperror_id bigint NOT NULL,
    apperror_time date NOT NULL,
    apperror_text text
);


ALTER TABLE public.si_app_error OWNER TO admin;

--
-- TOC entry 1536 (class 1259 OID 18843)
-- Dependencies: 1535 6
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE si_app_error_apperror_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_app_error_apperror_id_seq OWNER TO admin;

--
-- TOC entry 1911 (class 0 OID 0)
-- Dependencies: 1536
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_app_error_apperror_id_seq OWNED BY si_app_error.apperror_id;


--
-- TOC entry 1912 (class 0 OID 0)
-- Dependencies: 1536
-- Name: si_app_error_apperror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_app_error_apperror_id_seq', 1, false);


--
-- TOC entry 1537 (class 1259 OID 18845)
-- Dependencies: 1839 1840 1841 1842 1843 1844 6
-- Name: si_centro_acopio; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_centro_acopio (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    rif character varying(16) DEFAULT NULL::character varying,
    telefono character varying(32) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    ubicacion character varying(255) DEFAULT NULL::character varying,
    id_sap character varying(32) DEFAULT NULL::character varying,
    coordenadas character varying(32) DEFAULT NULL::character varying,
    id_org bigint
);


ALTER TABLE public.si_centro_acopio OWNER TO admin;

--
-- TOC entry 1538 (class 1259 OID 18857)
-- Dependencies: 6 1537
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
-- TOC entry 1913 (class 0 OID 0)
-- Dependencies: 1538
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_centro_acopio_id_seq OWNED BY si_centro_acopio.id;


--
-- TOC entry 1914 (class 0 OID 0)
-- Dependencies: 1538
-- Name: si_centro_acopio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_centro_acopio_id_seq', 1, false);


--
-- TOC entry 1539 (class 1259 OID 18859)
-- Dependencies: 1846 1847 6
-- Name: si_cosecha; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cosecha (
    id bigint NOT NULL,
    id_programa bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    estado smallint,
    proyectado real DEFAULT 0.0,
    observacion character varying(255) DEFAULT NULL::character varying,
    fecha_inicio date,
    fecha_fin date
);


ALTER TABLE public.si_cosecha OWNER TO admin;

--
-- TOC entry 1540 (class 1259 OID 18869)
-- Dependencies: 6 1539
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
-- TOC entry 1915 (class 0 OID 0)
-- Dependencies: 1540
-- Name: si_cosecha_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cosecha_id_seq OWNED BY si_cosecha.id;


--
-- TOC entry 1916 (class 0 OID 0)
-- Dependencies: 1540
-- Name: si_cosecha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cosecha_id_seq', 1, false);


--
-- TOC entry 1541 (class 1259 OID 18871)
-- Dependencies: 6
-- Name: si_cultivo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo (
    id bigint NOT NULL,
    id_tipo_cultivo bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_cultivo OWNER TO admin;

--
-- TOC entry 1542 (class 1259 OID 18874)
-- Dependencies: 1541 6
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
-- TOC entry 1917 (class 0 OID 0)
-- Dependencies: 1542
-- Name: si_cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_id_seq OWNED BY si_cultivo.id;


--
-- TOC entry 1918 (class 0 OID 0)
-- Dependencies: 1542
-- Name: si_cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_id_seq', 1, false);


--
-- TOC entry 1543 (class 1259 OID 18878)
-- Dependencies: 6
-- Name: si_cultivo_tipo; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_cultivo_tipo (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.si_cultivo_tipo OWNER TO admin;

--
-- TOC entry 1544 (class 1259 OID 18881)
-- Dependencies: 1543 6
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
-- TOC entry 1919 (class 0 OID 0)
-- Dependencies: 1544
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;


--
-- TOC entry 1920 (class 0 OID 0)
-- Dependencies: 1544
-- Name: si_cultivo_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 1, false);


--
-- TOC entry 1545 (class 1259 OID 18883)
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
-- TOC entry 1546 (class 1259 OID 18886)
-- Dependencies: 6 1545
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
-- TOC entry 1921 (class 0 OID 0)
-- Dependencies: 1546
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_log_codigos_log_codigo_id_seq OWNED BY si_log_codigos.log_codigo_id;


--
-- TOC entry 1922 (class 0 OID 0)
-- Dependencies: 1546
-- Name: si_log_codigos_log_codigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);


--
-- TOC entry 1547 (class 1259 OID 18888)
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
-- TOC entry 1548 (class 1259 OID 18894)
-- Dependencies: 6 1547
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
-- TOC entry 1923 (class 0 OID 0)
-- Dependencies: 1548
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_log_consultas_log_id_seq OWNED BY si_log_consultas.log_id;


--
-- TOC entry 1924 (class 0 OID 0)
-- Dependencies: 1548
-- Name: si_log_consultas_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 2, true);


--
-- TOC entry 1549 (class 1259 OID 18896)
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
-- TOC entry 1550 (class 1259 OID 18902)
-- Dependencies: 1549 6
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
-- TOC entry 1925 (class 0 OID 0)
-- Dependencies: 1550
-- Name: si_parametros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_parametros_id_seq OWNED BY si_parametros.id;


--
-- TOC entry 1926 (class 0 OID 0)
-- Dependencies: 1550
-- Name: si_parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_parametros_id_seq', 3, true);


--
-- TOC entry 1551 (class 1259 OID 18904)
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
-- TOC entry 1552 (class 1259 OID 18907)
-- Dependencies: 1551 6
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
-- TOC entry 1927 (class 0 OID 0)
-- Dependencies: 1552
-- Name: si_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_perfiles_id_seq OWNED BY si_perfiles.id;


--
-- TOC entry 1928 (class 0 OID 0)
-- Dependencies: 1552
-- Name: si_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_perfiles_id_seq', 2, true);


--
-- TOC entry 1558 (class 1259 OID 19024)
-- Dependencies: 6
-- Name: si_programa; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_programa (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    numero integer,
    nombre character varying(255) NOT NULL,
    observacion character varying(255),
    fecha_inicio date,
    fecha_fin date
);


ALTER TABLE public.si_programa OWNER TO admin;

--
-- TOC entry 1557 (class 1259 OID 19022)
-- Dependencies: 1558 6
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
-- TOC entry 1929 (class 0 OID 0)
-- Dependencies: 1557
-- Name: si_programa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_programa_id_seq OWNED BY si_programa.id;


--
-- TOC entry 1930 (class 0 OID 0)
-- Dependencies: 1557
-- Name: si_programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_programa_id_seq', 1, false);


--
-- TOC entry 1556 (class 1259 OID 19006)
-- Dependencies: 1857 1858 6
-- Name: si_silos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_silos (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    coordenada character varying(255),
    numero integer DEFAULT 0 NOT NULL,
    capacidad integer DEFAULT 0,
    observacion character varying(255)
);


ALTER TABLE public.si_silos OWNER TO admin;

--
-- TOC entry 1555 (class 1259 OID 19004)
-- Dependencies: 6 1556
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
-- TOC entry 1931 (class 0 OID 0)
-- Dependencies: 1555
-- Name: si_silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_silos_id_seq OWNED BY si_silos.id;


--
-- TOC entry 1932 (class 0 OID 0)
-- Dependencies: 1555
-- Name: si_silos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_silos_id_seq', 1, false);


--
-- TOC entry 1560 (class 1259 OID 19045)
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
-- TOC entry 1559 (class 1259 OID 19043)
-- Dependencies: 1560 6
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
-- TOC entry 1933 (class 0 OID 0)
-- Dependencies: 1559
-- Name: si_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_id_seq OWNED BY si_usuarios.id;


--
-- TOC entry 1934 (class 0 OID 0)
-- Dependencies: 1559
-- Name: si_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_id_seq', 3, true);


--
-- TOC entry 1553 (class 1259 OID 18927)
-- Dependencies: 6
-- Name: si_usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE si_usuarios_perfiles (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_perfil bigint NOT NULL,
    creado date,
    modificado date
);


ALTER TABLE public.si_usuarios_perfiles OWNER TO admin;

--
-- TOC entry 1554 (class 1259 OID 18930)
-- Dependencies: 1553 6
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
-- TOC entry 1935 (class 0 OID 0)
-- Dependencies: 1554
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE si_usuarios_perfiles_id_seq OWNED BY si_usuarios_perfiles.id;


--
-- TOC entry 1936 (class 0 OID 0)
-- Dependencies: 1554
-- Name: si_usuarios_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 2, true);


--
-- TOC entry 1838 (class 2604 OID 18992)
-- Dependencies: 1536 1535
-- Name: apperror_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_app_error ALTER COLUMN apperror_id SET DEFAULT nextval('si_app_error_apperror_id_seq'::regclass);


--
-- TOC entry 1845 (class 2604 OID 18933)
-- Dependencies: 1538 1537
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_centro_acopio_id_seq'::regclass);


--
-- TOC entry 1848 (class 2604 OID 18934)
-- Dependencies: 1540 1539
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cosecha ALTER COLUMN id SET DEFAULT nextval('si_cosecha_id_seq'::regclass);


--
-- TOC entry 1849 (class 2604 OID 18935)
-- Dependencies: 1542 1541
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_id_seq'::regclass);


--
-- TOC entry 1850 (class 2604 OID 18936)
-- Dependencies: 1544 1543
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);


--
-- TOC entry 1851 (class 2604 OID 18937)
-- Dependencies: 1546 1545
-- Name: log_codigo_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_log_codigos ALTER COLUMN log_codigo_id SET DEFAULT nextval('si_log_codigos_log_codigo_id_seq'::regclass);


--
-- TOC entry 1852 (class 2604 OID 18938)
-- Dependencies: 1548 1547
-- Name: log_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_log_consultas ALTER COLUMN log_id SET DEFAULT nextval('si_log_consultas_log_id_seq'::regclass);


--
-- TOC entry 1853 (class 2604 OID 18939)
-- Dependencies: 1550 1549
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_parametros ALTER COLUMN id SET DEFAULT nextval('si_parametros_id_seq'::regclass);


--
-- TOC entry 1854 (class 2604 OID 18940)
-- Dependencies: 1552 1551
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_perfiles ALTER COLUMN id SET DEFAULT nextval('si_perfiles_id_seq'::regclass);


--
-- TOC entry 1859 (class 2604 OID 19027)
-- Dependencies: 1557 1558 1558
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_programa ALTER COLUMN id SET DEFAULT nextval('si_programa_id_seq'::regclass);


--
-- TOC entry 1856 (class 2604 OID 19009)
-- Dependencies: 1556 1555 1556
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_silos ALTER COLUMN id SET DEFAULT nextval('si_silos_id_seq'::regclass);


--
-- TOC entry 1860 (class 2604 OID 19048)
-- Dependencies: 1559 1560 1560
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios ALTER COLUMN id SET DEFAULT nextval('si_usuarios_id_seq'::regclass);


--
-- TOC entry 1855 (class 2604 OID 18943)
-- Dependencies: 1554 1553
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE si_usuarios_perfiles ALTER COLUMN id SET DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass);


--
-- TOC entry 1893 (class 0 OID 18837)
-- Dependencies: 1535
-- Data for Name: si_app_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_app_error (apperror_id, apperror_time, apperror_text) FROM stdin;
\.


--
-- TOC entry 1894 (class 0 OID 18845)
-- Dependencies: 1537
-- Data for Name: si_centro_acopio; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_centro_acopio (id, nombre, rif, telefono, email, ubicacion, id_sap, coordenadas, id_org) FROM stdin;
\.


--
-- TOC entry 1895 (class 0 OID 18859)
-- Dependencies: 1539
-- Data for Name: si_cosecha; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cosecha (id, id_programa, nombre, estado, proyectado, observacion, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- TOC entry 1896 (class 0 OID 18871)
-- Dependencies: 1541
-- Data for Name: si_cultivo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo (id, id_tipo_cultivo, nombre) FROM stdin;
\.


--
-- TOC entry 1897 (class 0 OID 18878)
-- Dependencies: 1543
-- Data for Name: si_cultivo_tipo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_cultivo_tipo (id, nombre) FROM stdin;
\.


--
-- TOC entry 1898 (class 0 OID 18883)
-- Dependencies: 1545
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
-- TOC entry 1899 (class 0 OID 18888)
-- Dependencies: 1547
-- Data for Name: si_log_consultas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_log_consultas (log_id, en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, usuario_compania, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) FROM stdin;
1	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
2	2012-02-07	105	0	N/A	N/A	N/A	2st1qupvcvcacvfudlfphvq9h2	127.0.0.1	<div class="float-left-01">\r\n\t\t<h3 class="h-right-bar">User Computer</h3>\r\n\t\t\t<h4 class="right-bar">Operating System:</h4><p class="right-bar">Linux<br /> Distro: Ubuntu</p><h4 class="right-bar">Current Browser / UA:</h4><p class="right-bar">Mozilla/ Firefox 3.6.21<br />ProductSub: 20110830<br />Engine: Gecko RV: 1.9.2.21</p>\t</div>\r\n	No data	No data	No data	SELECT * FROM si_usuarios WHERE cedula = '18264065'	Login Incorrect=18264065
\.


--
-- TOC entry 1900 (class 0 OID 18896)
-- Dependencies: 1549
-- Data for Name: si_parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_parametros (id, parametro_llave, parametro_valor, descripcion, parametro_mostrar, creado, modificado) FROM stdin;
1	SYSTEM_NAME	SIGESI	Nombre de la aplicaci&oacute;n	1	2012-02-07	2012-02-07
2	MAX_RESULTS_PAG	20	N&uacute;mero m&aacute;ximo de registos para paginar	1	2012-02-07	2012-02-07
\.


--
-- TOC entry 1901 (class 0 OID 18904)
-- Dependencies: 1551
-- Data for Name: si_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_perfiles (id, nombre_perfil, creado, modificado) FROM stdin;
1	Administrador	2012-02-07	\N
2	Usuario	2012-02-07	\N
\.


--
-- TOC entry 1904 (class 0 OID 19024)
-- Dependencies: 1558
-- Data for Name: si_programa; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_programa (id, id_centro_acopio, numero, nombre, observacion, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- TOC entry 1903 (class 0 OID 19006)
-- Dependencies: 1556
-- Data for Name: si_silos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_silos (id, id_centro_acopio, nombre, coordenada, numero, capacidad, observacion) FROM stdin;
\.


--
-- TOC entry 1905 (class 0 OID 19045)
-- Dependencies: 1560
-- Data for Name: si_usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios (id, nombre, apellido, cedula, fecha_nacimiento, sexo, contrasena, ubicacion, telefono, email, creado, modificado) FROM stdin;
1	Jesus E	Rodriguez V	18264065	1988-07-08	M	7c4a8d09ca3762af61e59520943dc26494f8941b	Cagua	0416-2440414	jesuskateadio@hotmail.com	2012-02-07	\N
2	Juan	Taborda	13769341	1977-10-02	M	7c4a8d09ca3762af61e59520943dc26494f8941b	Mcy	0416-9333866	juantaborda@agropatria.co.ve	2012-02-07	\N
\.


--
-- TOC entry 1902 (class 0 OID 18927)
-- Dependencies: 1553
-- Data for Name: si_usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY si_usuarios_perfiles (id, id_usuario, id_perfil, creado, modificado) FROM stdin;
1	1	1	2012-02-07	\N
2	2	2	2012-02-07	\N
\.


--
-- TOC entry 1862 (class 2606 OID 18945)
-- Dependencies: 1535 1535
-- Name: app_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);


--
-- TOC entry 1872 (class 2606 OID 18947)
-- Dependencies: 1545 1545
-- Name: log_codigos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);


--
-- TOC entry 1864 (class 2606 OID 18949)
-- Dependencies: 1537 1537
-- Name: si_centro_acopio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);


--
-- TOC entry 1866 (class 2606 OID 18951)
-- Dependencies: 1539 1539
-- Name: si_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);


--
-- TOC entry 1868 (class 2606 OID 18953)
-- Dependencies: 1541 1541
-- Name: si_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 1870 (class 2606 OID 18955)
-- Dependencies: 1543 1543
-- Name: si_cultivo_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 1874 (class 2606 OID 18957)
-- Dependencies: 1547 1547
-- Name: si_log_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);


--
-- TOC entry 1876 (class 2606 OID 18959)
-- Dependencies: 1549 1549
-- Name: si_parametros_pkey1; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);


--
-- TOC entry 1878 (class 2606 OID 18961)
-- Dependencies: 1551 1551
-- Name: si_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 1884 (class 2606 OID 19032)
-- Dependencies: 1558 1558
-- Name: si_programa_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);


--
-- TOC entry 1882 (class 2606 OID 19016)
-- Dependencies: 1556 1556
-- Name: si_silos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);


--
-- TOC entry 1880 (class 2606 OID 19062)
-- Dependencies: 1553 1553
-- Name: si_usuarios_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 1886 (class 2606 OID 19053)
-- Dependencies: 1560 1560
-- Name: si_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 1892 (class 2606 OID 19033)
-- Dependencies: 1537 1863 1558
-- Name: id_centro_acopio; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_programa
    ADD CONSTRAINT id_centro_acopio FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 1888 (class 2606 OID 18973)
-- Dependencies: 1541 1543 1869
-- Name: id_cultivo_tipo; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT id_cultivo_tipo FOREIGN KEY (id_tipo_cultivo) REFERENCES si_cultivo_tipo(id);


--
-- TOC entry 1887 (class 2606 OID 19038)
-- Dependencies: 1539 1883 1558
-- Name: si_cosecha_id_programa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);


--
-- TOC entry 1891 (class 2606 OID 19017)
-- Dependencies: 1556 1863 1537
-- Name: si_silos_id_centro_acopio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);


--
-- TOC entry 1890 (class 2606 OID 19078)
-- Dependencies: 1877 1553 1551
-- Name: si_usuarios_perfiles_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);


--
-- TOC entry 1889 (class 2606 OID 19073)
-- Dependencies: 1560 1885 1553
-- Name: si_usuarios_perfiles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);


--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-02-07 12:02:54 VET

--
-- PostgreSQL database dump complete
--

