PGDMP                         p            sigesi    8.4.10    8.4.10 �   �	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �	           0    0 
   STDSTRINGS 
   STDSTRINGS     )   SET standard_conforming_strings = 'off';
                       false            �	           1262    27468    sigesi    DATABASE     x   CREATE DATABASE sigesi WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_VE.UTF-8' LC_CTYPE = 'es_VE.UTF-8';
    DROP DATABASE sigesi;
             admin    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            �	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6            �            1259    27469    si_almacenes_id_seq    SEQUENCE     u   CREATE SEQUENCE si_almacenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_almacenes_id_seq;
       public       admin    false    6            �	           0    0    si_almacenes_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_almacenes_id_seq', 11, true);
            public       admin    false    140            �            1259    27471    si_almacenes    TABLE     �  CREATE TABLE si_almacenes (
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
     DROP TABLE public.si_almacenes;
       public         admin    false    2101    6            �            1259    27478    si_analisis_id_seq    SEQUENCE     t   CREATE SEQUENCE si_analisis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_analisis_id_seq;
       public       admin    false    6            �	           0    0    si_analisis_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_analisis_id_seq', 1, false);
            public       admin    false    142            �            1259    27480    si_analisis    TABLE     �  CREATE TABLE si_analisis (
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
    DROP TABLE public.si_analisis;
       public         admin    false    2102    2103    2104    6            �	           0    0    TABLE si_analisis    COMMENT     a   COMMENT ON TABLE si_analisis IS 'tipo_analisis
1-Cuantitativo
2-Cualitativo
3-Verdadero/Falso
';
            public       admin    false    143            �            1259    27486    si_analisis_centro_acopio    TABLE     �   CREATE TABLE si_analisis_centro_acopio (
    id bigint NOT NULL,
    id_analisis bigint NOT NULL,
    id_centro_acopio bigint NOT NULL
);
 -   DROP TABLE public.si_analisis_centro_acopio;
       public         admin    false    6            �	           0    0    TABLE si_analisis_centro_acopio    COMMENT     X   COMMENT ON TABLE si_analisis_centro_acopio IS 'Tabla de Analisis por Centro de Acopio';
            public       admin    false    144            �            1259    27489     si_analisis_centro_acopio_id_seq    SEQUENCE     �   CREATE SEQUENCE si_analisis_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 7   DROP SEQUENCE public.si_analisis_centro_acopio_id_seq;
       public       admin    false    6    144            �	           0    0     si_analisis_centro_acopio_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE si_analisis_centro_acopio_id_seq OWNED BY si_analisis_centro_acopio.id;
            public       admin    false    145            �	           0    0     si_analisis_centro_acopio_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('si_analisis_centro_acopio_id_seq', 1, false);
            public       admin    false    145            �            1259    27491    si_analisis_cultivo    TABLE     �  CREATE TABLE si_analisis_cultivo (
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
 '   DROP TABLE public.si_analisis_cultivo;
       public         admin    false    2106    2107    2108    2109    2110    2111    6            �	           0    0    TABLE si_analisis_cultivo    COMMENT     g   COMMENT ON TABLE si_analisis_cultivo IS 'Laboratorio
C->Laboratorio Central
P->Laboratorio de Planta';
            public       admin    false    146            �	           0    0 "   COLUMN si_analisis_cultivo.estatus    COMMENT     M   COMMENT ON COLUMN si_analisis_cultivo.estatus IS 'R->Rechazo
C->Cuarentena';
            public       admin    false    146            �            1259    27500    si_analisis_cultivo_id_seq    SEQUENCE     |   CREATE SEQUENCE si_analisis_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 1   DROP SEQUENCE public.si_analisis_cultivo_id_seq;
       public       admin    false    6    146            �	           0    0    si_analisis_cultivo_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE si_analisis_cultivo_id_seq OWNED BY si_analisis_cultivo.id;
            public       admin    false    147            �	           0    0    si_analisis_cultivo_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('si_analisis_cultivo_id_seq', 63, true);
            public       admin    false    147            �            1259    27502    si_analisis_des    TABLE     0  CREATE TABLE si_analisis_des (
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
 #   DROP TABLE public.si_analisis_des;
       public         admin    false    2113    6            �            1259    27506    si_analisis_des_id_seq    SEQUENCE     x   CREATE SEQUENCE si_analisis_des_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 -   DROP SEQUENCE public.si_analisis_des_id_seq;
       public       admin    false    148    6            �	           0    0    si_analisis_des_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE si_analisis_des_id_seq OWNED BY si_analisis_des.id;
            public       admin    false    149            �	           0    0    si_analisis_des_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('si_analisis_des_id_seq', 1, false);
            public       admin    false    149            �            1259    27508    si_analisis_resultado    TABLE     O  CREATE TABLE si_analisis_resultado (
    id bigint NOT NULL,
    id_recepcion bigint,
    id_despacho bigint,
    id_analisis bigint NOT NULL,
    id_usuario bigint NOT NULL,
    muestra1 character(16),
    muestra2 character(16),
    muestra3 character(16),
    id_centro_acopio bigint NOT NULL,
    tipo_mov character(2) NOT NULL
);
 )   DROP TABLE public.si_analisis_resultado;
       public         admin    false    6            �	           0    0    TABLE si_analisis_resultado    COMMENT     j   COMMENT ON TABLE si_analisis_resultado IS 'Tabla puentre entre Analisis y Proceso (Recepción-Despacho)';
            public       admin    false    150            �            1259    27511    si_analisis_resultado_id_seq    SEQUENCE     ~   CREATE SEQUENCE si_analisis_resultado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 3   DROP SEQUENCE public.si_analisis_resultado_id_seq;
       public       admin    false    6    150            �	           0    0    si_analisis_resultado_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE si_analisis_resultado_id_seq OWNED BY si_analisis_resultado.id;
            public       admin    false    151            �	           0    0    si_analisis_resultado_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('si_analisis_resultado_id_seq', 2902, true);
            public       admin    false    151            �            1259    27513    si_app_error    TABLE     �   CREATE TABLE si_app_error (
    apperror_id character varying(255) NOT NULL,
    apperror_time timestamp with time zone NOT NULL,
    apperror_text text
);
     DROP TABLE public.si_app_error;
       public         admin    false    6            �            1259    27519    si_asociado_id_seq    SEQUENCE     t   CREATE SEQUENCE si_asociado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_asociado_id_seq;
       public       admin    false    6            �	           0    0    si_asociado_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_asociado_id_seq', 4, true);
            public       admin    false    153            �            1259    27521    si_asociado    TABLE     F  CREATE TABLE si_asociado (
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
    DROP TABLE public.si_asociado;
       public         admin    false    2116    6            �            1259    27528    si_cargo_id_seq    SEQUENCE     q   CREATE SEQUENCE si_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 &   DROP SEQUENCE public.si_cargo_id_seq;
       public       admin    false    6            �	           0    0    si_cargo_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('si_cargo_id_seq', 1, false);
            public       admin    false    155            �            1259    27530    si_cargo    TABLE       CREATE TABLE si_cargo (
    id bigint DEFAULT nextval('si_cargo_id_seq'::regclass) NOT NULL,
    id_almacen bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id_cargo_tipo bigint NOT NULL,
    creado timestamp without time zone,
    modificado timestamp without time zone
);
    DROP TABLE public.si_cargo;
       public         admin    false    2117    6            �            1259    27534    si_cargo_tipo_id_seq    SEQUENCE     v   CREATE SEQUENCE si_cargo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 +   DROP SEQUENCE public.si_cargo_tipo_id_seq;
       public       admin    false    6            �	           0    0    si_cargo_tipo_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('si_cargo_tipo_id_seq', 1, false);
            public       admin    false    157            �            1259    27536    si_cargo_tipo    TABLE     �   CREATE TABLE si_cargo_tipo (
    id bigint DEFAULT nextval('si_cargo_tipo_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL,
    nivel smallint DEFAULT 0 NOT NULL
);
 !   DROP TABLE public.si_cargo_tipo;
       public         admin    false    2118    2119    6            �            1259    27541    si_centro_acopio_id_seq    SEQUENCE     y   CREATE SEQUENCE si_centro_acopio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 .   DROP SEQUENCE public.si_centro_acopio_id_seq;
       public       admin    false    6            �	           0    0    si_centro_acopio_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('si_centro_acopio_id_seq', 9, true);
            public       admin    false    159            �            1259    27543    si_centro_acopio    TABLE     8  CREATE TABLE si_centro_acopio (
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
 $   DROP TABLE public.si_centro_acopio;
       public         admin    false    2120    2121    2122    2123    2124    2125    2126    6            �            1259    27556    si_choferes    TABLE     �  CREATE TABLE si_choferes (
    id bigint NOT NULL,
    id_org bigint,
    id_pais bigint,
    id_estado bigint,
    id_municipio bigint,
    ced_rif character(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    celular character varying(32),
    telefono character varying(32),
    direccion character varying(255),
    estatus boolean,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_choferes;
       public         admin    false    6            �            1259    27559    si_choferes_id_seq    SEQUENCE     t   CREATE SEQUENCE si_choferes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_choferes_id_seq;
       public       admin    false    6    161            �	           0    0    si_choferes_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE si_choferes_id_seq OWNED BY si_choferes.id;
            public       admin    false    162            �	           0    0    si_choferes_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_choferes_id_seq', 8, true);
            public       admin    false    162            �            1259    27561    si_cliente_id_seq    SEQUENCE     s   CREATE SEQUENCE si_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 (   DROP SEQUENCE public.si_cliente_id_seq;
       public       admin    false    6            �	           0    0    si_cliente_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_cliente_id_seq', 1, false);
            public       admin    false    163            �            1259    27563 
   si_cliente    TABLE     �  CREATE TABLE si_cliente (
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
    DROP TABLE public.si_cliente;
       public         admin    false    2128    6            �            1259    27570    si_cosecha_id_seq    SEQUENCE     s   CREATE SEQUENCE si_cosecha_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 (   DROP SEQUENCE public.si_cosecha_id_seq;
       public       admin    false    6            �	           0    0    si_cosecha_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_cosecha_id_seq', 12, true);
            public       admin    false    165            �            1259    27572 
   si_cosecha    TABLE     #  CREATE TABLE si_cosecha (
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
    DROP TABLE public.si_cosecha;
       public         admin    false    2129    2130    2131    2132    2133    6            �            1259    27583    si_cosecha_productor    TABLE       CREATE TABLE si_cosecha_productor (
    id_cosecha bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_productor bigint NOT NULL,
    asociado boolean NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone,
    id bigint NOT NULL
);
 (   DROP TABLE public.si_cosecha_productor;
       public         admin    false    6            �            1259    27586    si_cosecha_productor_id_seq    SEQUENCE     }   CREATE SEQUENCE si_cosecha_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 2   DROP SEQUENCE public.si_cosecha_productor_id_seq;
       public       admin    false    6    167            �	           0    0    si_cosecha_productor_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE si_cosecha_productor_id_seq OWNED BY si_cosecha_productor.id;
            public       admin    false    168            �	           0    0    si_cosecha_productor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('si_cosecha_productor_id_seq', 6, true);
            public       admin    false    168            �            1259    27588    si_cosecha_silo    TABLE     �   CREATE TABLE si_cosecha_silo (
    id bigint NOT NULL,
    id_cosecha bigint NOT NULL,
    id_silo bigint NOT NULL,
    id_cultivo bigint NOT NULL
);
 #   DROP TABLE public.si_cosecha_silo;
       public         admin    false    6            �	           0    0    TABLE si_cosecha_silo    COMMENT     N   COMMENT ON TABLE si_cosecha_silo IS 'Planificacion de los Silos por Cosecha';
            public       admin    false    169            �            1259    27591    si_cosecha_silo_id_seq    SEQUENCE     x   CREATE SEQUENCE si_cosecha_silo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 -   DROP SEQUENCE public.si_cosecha_silo_id_seq;
       public       admin    false    169    6            �	           0    0    si_cosecha_silo_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE si_cosecha_silo_id_seq OWNED BY si_cosecha_silo.id;
            public       admin    false    170            �	           0    0    si_cosecha_silo_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('si_cosecha_silo_id_seq', 14, true);
            public       admin    false    170            �            1259    27593    si_cuarentena    TABLE     �  CREATE TABLE si_cuarentena (
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
 !   DROP TABLE public.si_cuarentena;
       public         admin    false    6            �	           0    0    TABLE si_cuarentena    COMMENT     �   COMMENT ON TABLE si_cuarentena IS 'Tabla de Control de Cuarentenas
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
            public       admin    false    171            �            1259    27596    si_cuarentena_id_seq    SEQUENCE     v   CREATE SEQUENCE si_cuarentena_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 +   DROP SEQUENCE public.si_cuarentena_id_seq;
       public       admin    false    171    6            �	           0    0    si_cuarentena_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE si_cuarentena_id_seq OWNED BY si_cuarentena.id;
            public       admin    false    172            �	           0    0    si_cuarentena_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_cuarentena_id_seq', 3, true);
            public       admin    false    172            �            1259    27598    si_cultivo_id_seq    SEQUENCE     s   CREATE SEQUENCE si_cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 (   DROP SEQUENCE public.si_cultivo_id_seq;
       public       admin    false    6            �	           0    0    si_cultivo_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_cultivo_id_seq', 26, true);
            public       admin    false    173            �            1259    27600 
   si_cultivo    TABLE     _  CREATE TABLE si_cultivo (
    id bigint DEFAULT nextval('si_cultivo_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    codigo character(16) NOT NULL,
    nombre character varying(255) NOT NULL,
    tipificado boolean DEFAULT false,
    ciclo integer DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_cultivo;
       public         admin    false    2137    2138    2139    6            �            1259    27606    si_cultivo_tipo    TABLE       CREATE TABLE si_cultivo_tipo (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    id_analisis bigint NOT NULL,
    tipo character(2) NOT NULL,
    min numeric(10,2) DEFAULT 0.0 NOT NULL,
    max numeric(10,2) DEFAULT 0.0 NOT NULL
);
 #   DROP TABLE public.si_cultivo_tipo;
       public         admin    false    2140    2141    6            �            1259    27611    si_cultivo_tipo_id_seq    SEQUENCE     x   CREATE SEQUENCE si_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 -   DROP SEQUENCE public.si_cultivo_tipo_id_seq;
       public       admin    false    175    6            �	           0    0    si_cultivo_tipo_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE si_cultivo_tipo_id_seq OWNED BY si_cultivo_tipo.id;
            public       admin    false    176            �	           0    0    si_cultivo_tipo_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('si_cultivo_tipo_id_seq', 1, false);
            public       admin    false    176            �            1259    27613    si_denom_tip_id_seq    SEQUENCE     u   CREATE SEQUENCE si_denom_tip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_denom_tip_id_seq;
       public       admin    false    6            �	           0    0    si_denom_tip_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_denom_tip_id_seq', 1, false);
            public       admin    false    177            �            1259    27615    si_denom_tip    TABLE       CREATE TABLE si_denom_tip (
    id bigint DEFAULT nextval('si_denom_tip_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    nombre_tipo_clase character varying(255) NOT NULL,
    valor integer NOT NULL,
    estatus boolean
);
     DROP TABLE public.si_denom_tip;
       public         admin    false    2143    6            �            1259    27619    si_despacho    TABLE     w  CREATE TABLE si_despacho (
    id bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cosecha bigint NOT NULL,
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
    estatus character(1),
    cant_muestras smallint DEFAULT 0,
    carril integer,
    romana_ent integer,
    romana_sal integer,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_despacho;
       public         admin    false    2145    6            �	           0    0    TABLE si_despacho    COMMENT     �   COMMENT ON TABLE si_despacho IS 'Tabla de Recepción

Estatus:
1.- Romana Vacio
2.- Laboratorio
3.- Romana Lleno
4.- Rechazado
5.- Despachado';
            public       admin    false    179            �            1259    27622    si_despacho_id_seq    SEQUENCE     t   CREATE SEQUENCE si_despacho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_despacho_id_seq;
       public       admin    false    179    6            �	           0    0    si_despacho_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE si_despacho_id_seq OWNED BY si_despacho.id;
            public       admin    false    180            �	           0    0    si_despacho_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_despacho_id_seq', 1, false);
            public       admin    false    180            �            1259    27624    si_ejes_id_seq    SEQUENCE     p   CREATE SEQUENCE si_ejes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 %   DROP SEQUENCE public.si_ejes_id_seq;
       public       admin    false    6            �	           0    0    si_ejes_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('si_ejes_id_seq', 1, false);
            public       admin    false    181            �            1259    27626    si_ejes    TABLE     �   CREATE TABLE si_ejes (
    id bigint DEFAULT nextval('si_ejes_id_seq'::regclass) NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    capacidad integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.si_ejes;
       public         admin    false    2146    2147    6            �            1259    27631    si_estado_id_seq    SEQUENCE     r   CREATE SEQUENCE si_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 '   DROP SEQUENCE public.si_estado_id_seq;
       public       admin    false    6            �	           0    0    si_estado_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('si_estado_id_seq', 1, false);
            public       admin    false    183            �            1259    27633 	   si_estado    TABLE     �   CREATE TABLE si_estado (
    id bigint DEFAULT nextval('si_estado_id_seq'::regclass) NOT NULL,
    id_pais bigint NOT NULL,
    nombre character varying(255) NOT NULL
);
    DROP TABLE public.si_estado;
       public         admin    false    2148    6            �            1259    27637    si_finca    TABLE     �  CREATE TABLE si_finca (
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
    DROP TABLE public.si_finca;
       public         admin    false    2149    6            �            1259    27644    si_finca_id_seq    SEQUENCE     q   CREATE SEQUENCE si_finca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 &   DROP SEQUENCE public.si_finca_id_seq;
       public       admin    false    6    185            �	           0    0    si_finca_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE si_finca_id_seq OWNED BY si_finca.id;
            public       admin    false    186            �	           0    0    si_finca_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('si_finca_id_seq', 1, false);
            public       admin    false    186            �            1259    27646    si_formulas    TABLE     �  CREATE TABLE si_formulas (
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
    DROP TABLE public.si_formulas;
       public         admin    false    6            �            1259    27649    si_formulas_id_seq    SEQUENCE     t   CREATE SEQUENCE si_formulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_formulas_id_seq;
       public       admin    false    187    6            �	           0    0    si_formulas_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE si_formulas_id_seq OWNED BY si_formulas.id;
            public       admin    false    188            �	           0    0    si_formulas_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_formulas_id_seq', 12, true);
            public       admin    false    188            �            1259    27651 
   si_guiarec    TABLE        CREATE TABLE si_guiarec (
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
    DROP TABLE public.si_guiarec;
       public         admin    false    2152    2153    6            �	           0    0    TABLE si_guiarec    COMMENT     P   COMMENT ON TABLE si_guiarec IS 'Estatus
P = Procesada
N = Nueva
R = Rechazada';
            public       admin    false    189            �            1259    27656    si_guiarec_det    TABLE     �   CREATE TABLE si_guiarec_det (
    id bigint NOT NULL,
    id_guiarec bigint NOT NULL,
    subguia character(16),
    fecha timestamp with time zone,
    descripcion character varying(255)
);
 "   DROP TABLE public.si_guiarec_det;
       public         admin    false    6            �            1259    27659    si_guiarec_det_id_seq    SEQUENCE     w   CREATE SEQUENCE si_guiarec_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.si_guiarec_det_id_seq;
       public       admin    false    6    190            �	           0    0    si_guiarec_det_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE si_guiarec_det_id_seq OWNED BY si_guiarec_det.id;
            public       admin    false    191            �	           0    0    si_guiarec_det_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('si_guiarec_det_id_seq', 10, true);
            public       admin    false    191            �            1259    27661    si_guiarec_id_seq    SEQUENCE     s   CREATE SEQUENCE si_guiarec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 (   DROP SEQUENCE public.si_guiarec_id_seq;
       public       admin    false    6    189            �	           0    0    si_guiarec_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE si_guiarec_id_seq OWNED BY si_guiarec.id;
            public       admin    false    192            �	           0    0    si_guiarec_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_guiarec_id_seq', 14, true);
            public       admin    false    192            �            1259    27663     si_log_codigos_log_codigo_id_seq    SEQUENCE     �   CREATE SEQUENCE si_log_codigos_log_codigo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 7   DROP SEQUENCE public.si_log_codigos_log_codigo_id_seq;
       public       admin    false    6            �	           0    0     si_log_codigos_log_codigo_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('si_log_codigos_log_codigo_id_seq', 1, false);
            public       admin    false    193            �            1259    27665    si_log_codigos    TABLE       CREATE TABLE si_log_codigos (
    log_codigo_id bigint DEFAULT nextval('si_log_codigos_log_codigo_id_seq'::regclass) NOT NULL,
    log_codigo_nombre_es character varying(255) NOT NULL,
    log_codigo_critico smallint NOT NULL,
    log_codigo_tipo character varying(45) NOT NULL
);
 "   DROP TABLE public.si_log_codigos;
       public         admin    false    2156    6            �            1259    27669    si_log_consultas_log_id_seq    SEQUENCE     }   CREATE SEQUENCE si_log_consultas_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 2   DROP SEQUENCE public.si_log_consultas_log_id_seq;
       public       admin    false    6            �	           0    0    si_log_consultas_log_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('si_log_consultas_log_id_seq', 1, true);
            public       admin    false    195            �            1259    27671    si_log_consultas    TABLE     .  CREATE TABLE si_log_consultas (
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
 $   DROP TABLE public.si_log_consultas;
       public         admin    false    2157    6            �            1259    27678    si_menu_id_seq    SEQUENCE     p   CREATE SEQUENCE si_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 %   DROP SEQUENCE public.si_menu_id_seq;
       public       admin    false    6            �	           0    0    si_menu_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('si_menu_id_seq', 31, true);
            public       admin    false    197            �            1259    27680    si_menu    TABLE     I  CREATE TABLE si_menu (
    id bigint DEFAULT nextval('si_menu_id_seq'::regclass) NOT NULL,
    nombre character varying(32) NOT NULL,
    id_padre bigint NOT NULL,
    url character varying(255),
    estatus boolean DEFAULT true,
    orden integer,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_menu;
       public         admin    false    2158    2159    6            �            1259    27685    si_menu_usuario    TABLE     v   CREATE TABLE si_menu_usuario (
    id_menu bigint NOT NULL,
    id_usuario bigint NOT NULL,
    id bigint NOT NULL
);
 #   DROP TABLE public.si_menu_usuario;
       public         admin    false    6            �            1259    27688    si_menu_usuario_id_seq    SEQUENCE     x   CREATE SEQUENCE si_menu_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 -   DROP SEQUENCE public.si_menu_usuario_id_seq;
       public       admin    false    6    199            �	           0    0    si_menu_usuario_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE si_menu_usuario_id_seq OWNED BY si_menu_usuario.id;
            public       admin    false    200            �	           0    0    si_menu_usuario_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('si_menu_usuario_id_seq', 39, true);
            public       admin    false    200            �            1259    27690    si_municipio_id_seq    SEQUENCE     u   CREATE SEQUENCE si_municipio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_municipio_id_seq;
       public       admin    false    6            �	           0    0    si_municipio_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_municipio_id_seq', 1, false);
            public       admin    false    201            �            1259    27692    si_municipio    TABLE     �   CREATE TABLE si_municipio (
    id bigint DEFAULT nextval('si_municipio_id_seq'::regclass) NOT NULL,
    id_estado bigint NOT NULL,
    nombre character varying(255) NOT NULL
);
     DROP TABLE public.si_municipio;
       public         admin    false    2161    6            �            1259    27696    si_ordenes_id_seq    SEQUENCE     s   CREATE SEQUENCE si_ordenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 (   DROP SEQUENCE public.si_ordenes_id_seq;
       public       admin    false    6            �	           0    0    si_ordenes_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_ordenes_id_seq', 1, false);
            public       admin    false    203            �            1259    27698 
   si_ordenes    TABLE     �  CREATE TABLE si_ordenes (
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
    DROP TABLE public.si_ordenes;
       public         admin    false    2162    2163    6            �            1259    27703    si_organizacion_id_seq    SEQUENCE     x   CREATE SEQUENCE si_organizacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 -   DROP SEQUENCE public.si_organizacion_id_seq;
       public       admin    false    6            �	           0    0    si_organizacion_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('si_organizacion_id_seq', 1, true);
            public       admin    false    205            �            1259    27705    si_organizacion    TABLE     T  CREATE TABLE si_organizacion (
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
 #   DROP TABLE public.si_organizacion;
       public         admin    false    2164    6            �	           0    0    TABLE si_organizacion    COMMENT     C   COMMENT ON TABLE si_organizacion IS 'Tabla de las Organizaciones';
            public       admin    false    206            �            1259    27712    si_pais_id_seq    SEQUENCE     p   CREATE SEQUENCE si_pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 %   DROP SEQUENCE public.si_pais_id_seq;
       public       admin    false    6            �	           0    0    si_pais_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('si_pais_id_seq', 1, false);
            public       admin    false    207            �            1259    27714    si_pais    TABLE     �   CREATE TABLE si_pais (
    id bigint DEFAULT nextval('si_pais_id_seq'::regclass) NOT NULL,
    nombre character varying(255) NOT NULL
);
    DROP TABLE public.si_pais;
       public         admin    false    2165    6            �            1259    27718    si_parametros_id_seq    SEQUENCE     v   CREATE SEQUENCE si_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 +   DROP SEQUENCE public.si_parametros_id_seq;
       public       admin    false    6            �	           0    0    si_parametros_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('si_parametros_id_seq', 11, true);
            public       admin    false    209            �            1259    27720    si_parametros    TABLE     �  CREATE TABLE si_parametros (
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
 !   DROP TABLE public.si_parametros;
       public         admin    false    2166    6            �            1259    27727    si_perfiles_id_seq    SEQUENCE     t   CREATE SEQUENCE si_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_perfiles_id_seq;
       public       admin    false    6            �	           0    0    si_perfiles_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_perfiles_id_seq', 8, true);
            public       admin    false    211            �            1259    27729    si_perfiles    TABLE     �   CREATE TABLE si_perfiles (
    id bigint DEFAULT nextval('si_perfiles_id_seq'::regclass) NOT NULL,
    nombre_perfil character varying(255) NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_perfiles;
       public         admin    false    2167    6            �            1259    27733    si_plaga    TABLE     �   CREATE TABLE si_plaga (
    id bigint NOT NULL,
    id_org bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    estatus boolean,
    creado timestamp without time zone,
    modificado timestamp without time zone
);
    DROP TABLE public.si_plaga;
       public         admin    false    6            �	           0    0    TABLE si_plaga    COMMENT     v   COMMENT ON TABLE si_plaga IS 'Tabla de Plagas en el Cultivo, se ingresa en el momento de la recepcion (laboratorio)';
            public       admin    false    213            �            1259    27736    si_plaga_id_seq    SEQUENCE     q   CREATE SEQUENCE si_plaga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 &   DROP SEQUENCE public.si_plaga_id_seq;
       public       admin    false    213    6            �	           0    0    si_plaga_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE si_plaga_id_seq OWNED BY si_plaga.id;
            public       admin    false    214            �	           0    0    si_plaga_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('si_plaga_id_seq', 9, true);
            public       admin    false    214            �            1259    27738    si_producto    TABLE     B  CREATE TABLE si_producto (
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
    DROP TABLE public.si_producto;
       public         admin    false    6            �	           0    0    TABLE si_producto    COMMENT     R   COMMENT ON TABLE si_producto IS 'Tabla de Productos para Fumigacion de Cultivos';
            public       admin    false    215            �            1259    27741    si_producto_id_seq    SEQUENCE     t   CREATE SEQUENCE si_producto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_producto_id_seq;
       public       admin    false    215    6            �	           0    0    si_producto_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE si_producto_id_seq OWNED BY si_producto.id;
            public       admin    false    216            �	           0    0    si_producto_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_producto_id_seq', 3, true);
            public       admin    false    216            �            1259    27743    si_productor_id_seq    SEQUENCE     u   CREATE SEQUENCE si_productor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_productor_id_seq;
       public       admin    false    6            �	           0    0    si_productor_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_productor_id_seq', 6, true);
            public       admin    false    217            �            1259    27745    si_productor    TABLE     �  CREATE TABLE si_productor (
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
     DROP TABLE public.si_productor;
       public         admin    false    2170    6            �            1259    27752    si_programa_id_seq    SEQUENCE     t   CREATE SEQUENCE si_programa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_programa_id_seq;
       public       admin    false    6            �	           0    0    si_programa_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_programa_id_seq', 10, true);
            public       admin    false    219            �            1259    27754    si_programa    TABLE     �  CREATE TABLE si_programa (
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
    DROP TABLE public.si_programa;
       public         admin    false    2171    6            �            1259    27761    si_proveedor    TABLE     �  CREATE TABLE si_proveedor (
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
     DROP TABLE public.si_proveedor;
       public         admin    false    6            �            1259    27767    si_proveedor_id_seq    SEQUENCE     u   CREATE SEQUENCE si_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_proveedor_id_seq;
       public       admin    false    221    6            �	           0    0    si_proveedor_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE si_proveedor_id_seq OWNED BY si_proveedor.id;
            public       admin    false    222            �	           0    0    si_proveedor_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_proveedor_id_seq', 1, false);
            public       admin    false    222            �            1259    27769    si_punto_entrega    TABLE     �  CREATE TABLE si_punto_entrega (
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
 $   DROP TABLE public.si_punto_entrega;
       public         admin    false    6            �	           0    0    TABLE si_punto_entrega    COMMENT     S   COMMENT ON TABLE si_punto_entrega IS 'Tabla de Punto de Entrega en los Despachos';
            public       admin    false    223            �            1259    27775    si_punto_entrega_id_seq    SEQUENCE     y   CREATE SEQUENCE si_punto_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 .   DROP SEQUENCE public.si_punto_entrega_id_seq;
       public       admin    false    6    223            �	           0    0    si_punto_entrega_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE si_punto_entrega_id_seq OWNED BY si_punto_entrega.id;
            public       admin    false    224            �	           0    0    si_punto_entrega_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('si_punto_entrega_id_seq', 1, false);
            public       admin    false    224            �            1259    27777    si_recepcion    TABLE     s  CREATE TABLE si_recepcion (
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
    id_vehiculo bigint NOT NULL,
    id_chofer bigint,
    romana_ent integer,
    romana_sal integer
);
     DROP TABLE public.si_recepcion;
       public         admin    false    2174    6            �	           0    0    TABLE si_recepcion    COMMENT     �   COMMENT ON TABLE si_recepcion IS 'Tabla de Recepción de Cultivo

Estatus:
1.- LabCentral
2.- Ctna
3.- Romana Lleno
4.- Tolvas
5.- Ctna Tolva
6.- Romana Vacio
7.- Rechazo Central
8.- Rechazo Planta
9.- Recibido';
            public       admin    false    225            �            1259    27781    si_recepcion_cultivo_tipo    TABLE     �   CREATE TABLE si_recepcion_cultivo_tipo (
    id bigint NOT NULL,
    id_recepcion bigint NOT NULL,
    id_centro_acopio bigint NOT NULL,
    id_cultivo bigint NOT NULL,
    laboratorio character(2) NOT NULL,
    tipo character(2) NOT NULL
);
 -   DROP TABLE public.si_recepcion_cultivo_tipo;
       public         admin    false    6            �            1259    27784     si_recepcion_cultivo_tipo_id_seq    SEQUENCE     �   CREATE SEQUENCE si_recepcion_cultivo_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 7   DROP SEQUENCE public.si_recepcion_cultivo_tipo_id_seq;
       public       admin    false    6    226            �	           0    0     si_recepcion_cultivo_tipo_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE si_recepcion_cultivo_tipo_id_seq OWNED BY si_recepcion_cultivo_tipo.id;
            public       admin    false    227            �	           0    0     si_recepcion_cultivo_tipo_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('si_recepcion_cultivo_tipo_id_seq', 1, false);
            public       admin    false    227            �            1259    27786    si_recepcion_id_seq    SEQUENCE     u   CREATE SEQUENCE si_recepcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_recepcion_id_seq;
       public       admin    false    225    6            �	           0    0    si_recepcion_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE si_recepcion_id_seq OWNED BY si_recepcion.id;
            public       admin    false    228            �	           0    0    si_recepcion_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_recepcion_id_seq', 11, true);
            public       admin    false    228            �            1259    27788    si_recursos    TABLE     +  CREATE TABLE si_recursos (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    localizacion character varying(255),
    nombre_archivo character varying(255),
    autentificacion smallint DEFAULT 0,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
    DROP TABLE public.si_recursos;
       public         admin    false    2177    6            �            1259    27795    si_recursos_etiquetas    TABLE     ,  CREATE TABLE si_recursos_etiquetas (
    id bigint NOT NULL,
    id_recurso bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    valor character varying(255) NOT NULL,
    global smallint DEFAULT 0 NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
 )   DROP TABLE public.si_recursos_etiquetas;
       public         admin    false    2179    6            �            1259    27802    si_recursos_etiquetas_id_seq    SEQUENCE     ~   CREATE SEQUENCE si_recursos_etiquetas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 3   DROP SEQUENCE public.si_recursos_etiquetas_id_seq;
       public       admin    false    230    6            �	           0    0    si_recursos_etiquetas_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE si_recursos_etiquetas_id_seq OWNED BY si_recursos_etiquetas.id;
            public       admin    false    231            �	           0    0    si_recursos_etiquetas_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('si_recursos_etiquetas_id_seq', 44, true);
            public       admin    false    231            �            1259    27804    si_recursos_id_seq    SEQUENCE     t   CREATE SEQUENCE si_recursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_recursos_id_seq;
       public       admin    false    6    229            �	           0    0    si_recursos_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE si_recursos_id_seq OWNED BY si_recursos.id;
            public       admin    false    232            �	           0    0    si_recursos_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_recursos_id_seq', 3, true);
            public       admin    false    232            �            1259    27806    si_silos_id_seq    SEQUENCE     q   CREATE SEQUENCE si_silos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 &   DROP SEQUENCE public.si_silos_id_seq;
       public       admin    false    6            �	           0    0    si_silos_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('si_silos_id_seq', 85, true);
            public       admin    false    233            �            1259    27808    si_silos    TABLE     �  CREATE TABLE si_silos (
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
    DROP TABLE public.si_silos;
       public         admin    false    2181    2182    2183    6            �	           0    0    TABLE si_silos    COMMENT     R   COMMENT ON TABLE si_silos IS 'estatus
1.- Activo
2.- Inactivo
3.- Mantenimiento';
            public       admin    false    234            �            1259    27817    si_tolcarom_id_seq    SEQUENCE     t   CREATE SEQUENCE si_tolcarom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_tolcarom_id_seq;
       public       admin    false    6            �	           0    0    si_tolcarom_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('si_tolcarom_id_seq', 48, true);
            public       admin    false    235            �            1259    27819    si_tolcarom    TABLE     f  CREATE TABLE si_tolcarom (
    id bigint DEFAULT nextval('si_tolcarom_id_seq'::regclass) NOT NULL,
    id_centro_acopio bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    numero integer DEFAULT 0 NOT NULL,
    tipo character(1),
    estatus boolean DEFAULT true,
    creado timestamp with time zone,
    modificiado timestamp with time zone
);
    DROP TABLE public.si_tolcarom;
       public         admin    false    2184    2185    2186    6            �	           0    0    TABLE si_tolcarom    COMMENT     I   COMMENT ON TABLE si_tolcarom IS 'Tipos
1.- Tolva
2.- Carril
3.- Romana';
            public       admin    false    236            �            1259    27825    si_transporte    TABLE     �  CREATE TABLE si_transporte (
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
 !   DROP TABLE public.si_transporte;
       public         admin    false    6            �	           0    0    TABLE si_transporte    COMMENT     8   COMMENT ON TABLE si_transporte IS 'Tabla de Trasporte';
            public       admin    false    237            �            1259    27831    si_transporte_id_seq    SEQUENCE     v   CREATE SEQUENCE si_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 +   DROP SEQUENCE public.si_transporte_id_seq;
       public       admin    false    6    237            �	           0    0    si_transporte_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE si_transporte_id_seq OWNED BY si_transporte.id;
            public       admin    false    238            �	           0    0    si_transporte_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('si_transporte_id_seq', 1, false);
            public       admin    false    238            �            1259    27833    si_usuarios_id_seq    SEQUENCE     t   CREATE SEQUENCE si_usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 )   DROP SEQUENCE public.si_usuarios_id_seq;
       public       admin    false    6             
           0    0    si_usuarios_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('si_usuarios_id_seq', 6, true);
            public       admin    false    239            �            1259    27835    si_usuarios    TABLE     �  CREATE TABLE si_usuarios (
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
    DROP TABLE public.si_usuarios;
       public         admin    false    2188    2189    2190    6            �            1259    27844    si_usuarios_perfiles_id_seq    SEQUENCE     }   CREATE SEQUENCE si_usuarios_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 2   DROP SEQUENCE public.si_usuarios_perfiles_id_seq;
       public       admin    false    6            
           0    0    si_usuarios_perfiles_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('si_usuarios_perfiles_id_seq', 6, true);
            public       admin    false    241            �            1259    27846    si_usuarios_perfiles    TABLE     $  CREATE TABLE si_usuarios_perfiles (
    id bigint DEFAULT nextval('si_usuarios_perfiles_id_seq'::regclass) NOT NULL,
    id_usuario bigint NOT NULL,
    id_almacen bigint NOT NULL,
    id_perfil bigint NOT NULL,
    creado timestamp with time zone,
    modificado timestamp with time zone
);
 (   DROP TABLE public.si_usuarios_perfiles;
       public         admin    false    2191    6            �            1259    27850    si_vehiculos    TABLE     G  CREATE TABLE si_vehiculos (
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
     DROP TABLE public.si_vehiculos;
       public         admin    false    6            �            1259    27853    si_vehiculos_id_seq    SEQUENCE     u   CREATE SEQUENCE si_vehiculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 *   DROP SEQUENCE public.si_vehiculos_id_seq;
       public       admin    false    243    6            
           0    0    si_vehiculos_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE si_vehiculos_id_seq OWNED BY si_vehiculos.id;
            public       admin    false    244            
           0    0    si_vehiculos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('si_vehiculos_id_seq', 10, true);
            public       admin    false    244            9           2604    27855    id    DEFAULT     y   ALTER TABLE si_analisis_centro_acopio ALTER COLUMN id SET DEFAULT nextval('si_analisis_centro_acopio_id_seq'::regclass);
 K   ALTER TABLE public.si_analisis_centro_acopio ALTER COLUMN id DROP DEFAULT;
       public       admin    false    145    144            @           2604    27856    id    DEFAULT     m   ALTER TABLE si_analisis_cultivo ALTER COLUMN id SET DEFAULT nextval('si_analisis_cultivo_id_seq'::regclass);
 E   ALTER TABLE public.si_analisis_cultivo ALTER COLUMN id DROP DEFAULT;
       public       admin    false    147    146            B           2604    27857    id    DEFAULT     e   ALTER TABLE si_analisis_des ALTER COLUMN id SET DEFAULT nextval('si_analisis_des_id_seq'::regclass);
 A   ALTER TABLE public.si_analisis_des ALTER COLUMN id DROP DEFAULT;
       public       admin    false    149    148            C           2604    27858    id    DEFAULT     q   ALTER TABLE si_analisis_resultado ALTER COLUMN id SET DEFAULT nextval('si_analisis_resultado_id_seq'::regclass);
 G   ALTER TABLE public.si_analisis_resultado ALTER COLUMN id DROP DEFAULT;
       public       admin    false    151    150            O           2604    27859    id    DEFAULT     ]   ALTER TABLE si_choferes ALTER COLUMN id SET DEFAULT nextval('si_choferes_id_seq'::regclass);
 =   ALTER TABLE public.si_choferes ALTER COLUMN id DROP DEFAULT;
       public       admin    false    162    161            V           2604    27860    id    DEFAULT     o   ALTER TABLE si_cosecha_productor ALTER COLUMN id SET DEFAULT nextval('si_cosecha_productor_id_seq'::regclass);
 F   ALTER TABLE public.si_cosecha_productor ALTER COLUMN id DROP DEFAULT;
       public       admin    false    168    167            W           2604    27861    id    DEFAULT     e   ALTER TABLE si_cosecha_silo ALTER COLUMN id SET DEFAULT nextval('si_cosecha_silo_id_seq'::regclass);
 A   ALTER TABLE public.si_cosecha_silo ALTER COLUMN id DROP DEFAULT;
       public       admin    false    170    169            X           2604    27862    id    DEFAULT     a   ALTER TABLE si_cuarentena ALTER COLUMN id SET DEFAULT nextval('si_cuarentena_id_seq'::regclass);
 ?   ALTER TABLE public.si_cuarentena ALTER COLUMN id DROP DEFAULT;
       public       admin    false    172    171            ^           2604    27863    id    DEFAULT     e   ALTER TABLE si_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_cultivo_tipo_id_seq'::regclass);
 A   ALTER TABLE public.si_cultivo_tipo ALTER COLUMN id DROP DEFAULT;
       public       admin    false    176    175            `           2604    27864    id    DEFAULT     ]   ALTER TABLE si_despacho ALTER COLUMN id SET DEFAULT nextval('si_despacho_id_seq'::regclass);
 =   ALTER TABLE public.si_despacho ALTER COLUMN id DROP DEFAULT;
       public       admin    false    180    179            f           2604    27865    id    DEFAULT     W   ALTER TABLE si_finca ALTER COLUMN id SET DEFAULT nextval('si_finca_id_seq'::regclass);
 :   ALTER TABLE public.si_finca ALTER COLUMN id DROP DEFAULT;
       public       admin    false    186    185            g           2604    27866    id    DEFAULT     ]   ALTER TABLE si_formulas ALTER COLUMN id SET DEFAULT nextval('si_formulas_id_seq'::regclass);
 =   ALTER TABLE public.si_formulas ALTER COLUMN id DROP DEFAULT;
       public       admin    false    188    187            j           2604    27867    id    DEFAULT     [   ALTER TABLE si_guiarec ALTER COLUMN id SET DEFAULT nextval('si_guiarec_id_seq'::regclass);
 <   ALTER TABLE public.si_guiarec ALTER COLUMN id DROP DEFAULT;
       public       admin    false    192    189            k           2604    27868    id    DEFAULT     c   ALTER TABLE si_guiarec_det ALTER COLUMN id SET DEFAULT nextval('si_guiarec_det_id_seq'::regclass);
 @   ALTER TABLE public.si_guiarec_det ALTER COLUMN id DROP DEFAULT;
       public       admin    false    191    190            p           2604    27869    id    DEFAULT     e   ALTER TABLE si_menu_usuario ALTER COLUMN id SET DEFAULT nextval('si_menu_usuario_id_seq'::regclass);
 A   ALTER TABLE public.si_menu_usuario ALTER COLUMN id DROP DEFAULT;
       public       admin    false    200    199            x           2604    27870    id    DEFAULT     W   ALTER TABLE si_plaga ALTER COLUMN id SET DEFAULT nextval('si_plaga_id_seq'::regclass);
 :   ALTER TABLE public.si_plaga ALTER COLUMN id DROP DEFAULT;
       public       admin    false    214    213            y           2604    27871    id    DEFAULT     ]   ALTER TABLE si_producto ALTER COLUMN id SET DEFAULT nextval('si_producto_id_seq'::regclass);
 =   ALTER TABLE public.si_producto ALTER COLUMN id DROP DEFAULT;
       public       admin    false    216    215            |           2604    27872    id    DEFAULT     _   ALTER TABLE si_proveedor ALTER COLUMN id SET DEFAULT nextval('si_proveedor_id_seq'::regclass);
 >   ALTER TABLE public.si_proveedor ALTER COLUMN id DROP DEFAULT;
       public       admin    false    222    221            }           2604    27873    id    DEFAULT     g   ALTER TABLE si_punto_entrega ALTER COLUMN id SET DEFAULT nextval('si_punto_entrega_id_seq'::regclass);
 B   ALTER TABLE public.si_punto_entrega ALTER COLUMN id DROP DEFAULT;
       public       admin    false    224    223                       2604    27874    id    DEFAULT     _   ALTER TABLE si_recepcion ALTER COLUMN id SET DEFAULT nextval('si_recepcion_id_seq'::regclass);
 >   ALTER TABLE public.si_recepcion ALTER COLUMN id DROP DEFAULT;
       public       admin    false    228    225            �           2604    27875    id    DEFAULT     y   ALTER TABLE si_recepcion_cultivo_tipo ALTER COLUMN id SET DEFAULT nextval('si_recepcion_cultivo_tipo_id_seq'::regclass);
 K   ALTER TABLE public.si_recepcion_cultivo_tipo ALTER COLUMN id DROP DEFAULT;
       public       admin    false    227    226            �           2604    27876    id    DEFAULT     ]   ALTER TABLE si_recursos ALTER COLUMN id SET DEFAULT nextval('si_recursos_id_seq'::regclass);
 =   ALTER TABLE public.si_recursos ALTER COLUMN id DROP DEFAULT;
       public       admin    false    232    229            �           2604    27877    id    DEFAULT     q   ALTER TABLE si_recursos_etiquetas ALTER COLUMN id SET DEFAULT nextval('si_recursos_etiquetas_id_seq'::regclass);
 G   ALTER TABLE public.si_recursos_etiquetas ALTER COLUMN id DROP DEFAULT;
       public       admin    false    231    230            �           2604    27878    id    DEFAULT     a   ALTER TABLE si_transporte ALTER COLUMN id SET DEFAULT nextval('si_transporte_id_seq'::regclass);
 ?   ALTER TABLE public.si_transporte ALTER COLUMN id DROP DEFAULT;
       public       admin    false    238    237            �           2604    27879    id    DEFAULT     _   ALTER TABLE si_vehiculos ALTER COLUMN id SET DEFAULT nextval('si_vehiculos_id_seq'::regclass);
 >   ALTER TABLE public.si_vehiculos ALTER COLUMN id DROP DEFAULT;
       public       admin    false    244    243            l	          0    27471    si_almacenes 
   TABLE DATA                     public       admin    false    141   @7      m	          0    27480    si_analisis 
   TABLE DATA                     public       admin    false    143   9      n	          0    27486    si_analisis_centro_acopio 
   TABLE DATA                     public       admin    false    144   ;      o	          0    27491    si_analisis_cultivo 
   TABLE DATA                     public       admin    false    146   8;      p	          0    27502    si_analisis_des 
   TABLE DATA                     public       admin    false    148   y=      q	          0    27508    si_analisis_resultado 
   TABLE DATA                     public       admin    false    150   �=      r	          0    27513    si_app_error 
   TABLE DATA                     public       admin    false    152   �@      s	          0    27521    si_asociado 
   TABLE DATA                     public       admin    false    154   D      t	          0    27530    si_cargo 
   TABLE DATA                     public       admin    false    156   iE      u	          0    27536    si_cargo_tipo 
   TABLE DATA                     public       admin    false    158   �E      v	          0    27543    si_centro_acopio 
   TABLE DATA                     public       admin    false    160   �E      w	          0    27556    si_choferes 
   TABLE DATA                     public       admin    false    161   �G      x	          0    27563 
   si_cliente 
   TABLE DATA                     public       admin    false    164   �I      y	          0    27572 
   si_cosecha 
   TABLE DATA                     public       admin    false    166   �I      z	          0    27583    si_cosecha_productor 
   TABLE DATA                     public       admin    false    167   L      {	          0    27588    si_cosecha_silo 
   TABLE DATA                     public       admin    false    169   �L      |	          0    27593    si_cuarentena 
   TABLE DATA                     public       admin    false    171   6M      }	          0    27600 
   si_cultivo 
   TABLE DATA                     public       admin    false    174   oN      ~	          0    27606    si_cultivo_tipo 
   TABLE DATA                     public       admin    false    175   �P      	          0    27615    si_denom_tip 
   TABLE DATA                     public       admin    false    178   �P      �	          0    27619    si_despacho 
   TABLE DATA                     public       admin    false    179   �P      �	          0    27626    si_ejes 
   TABLE DATA                     public       admin    false    182   Q      �	          0    27633 	   si_estado 
   TABLE DATA                     public       admin    false    184   3Q      �	          0    27637    si_finca 
   TABLE DATA                     public       admin    false    185   sR      �	          0    27646    si_formulas 
   TABLE DATA                     public       admin    false    187   �R      �	          0    27651 
   si_guiarec 
   TABLE DATA                     public       admin    false    189   �T      �	          0    27656    si_guiarec_det 
   TABLE DATA                     public       admin    false    190   �V      �	          0    27665    si_log_codigos 
   TABLE DATA                     public       admin    false    194   yW      �	          0    27671    si_log_consultas 
   TABLE DATA                     public       admin    false    196   GX      �	          0    27680    si_menu 
   TABLE DATA                     public       admin    false    198   aX      �	          0    27685    si_menu_usuario 
   TABLE DATA                     public       admin    false    199   �Z      �	          0    27692    si_municipio 
   TABLE DATA                     public       admin    false    202   �[      �	          0    27698 
   si_ordenes 
   TABLE DATA                     public       admin    false    204    j      �	          0    27705    si_organizacion 
   TABLE DATA                     public       admin    false    206   j      �	          0    27714    si_pais 
   TABLE DATA                     public       admin    false    208   k      �	          0    27720    si_parametros 
   TABLE DATA                     public       admin    false    210   ak      �	          0    27729    si_perfiles 
   TABLE DATA                     public       admin    false    212   �m      �	          0    27733    si_plaga 
   TABLE DATA                     public       admin    false    213   vn      �	          0    27738    si_producto 
   TABLE DATA                     public       admin    false    215   �o      �	          0    27745    si_productor 
   TABLE DATA                     public       admin    false    218   lp      �	          0    27754    si_programa 
   TABLE DATA                     public       admin    false    220   �r      �	          0    27761    si_proveedor 
   TABLE DATA                     public       admin    false    221   vt      �	          0    27769    si_punto_entrega 
   TABLE DATA                     public       admin    false    223   �t      �	          0    27777    si_recepcion 
   TABLE DATA                     public       admin    false    225   �t      �	          0    27781    si_recepcion_cultivo_tipo 
   TABLE DATA                     public       admin    false    226   fw      �	          0    27788    si_recursos 
   TABLE DATA                     public       admin    false    229   �w      �	          0    27795    si_recursos_etiquetas 
   TABLE DATA                     public       admin    false    230   �x      �	          0    27808    si_silos 
   TABLE DATA                     public       admin    false    234   �|      �	          0    27819    si_tolcarom 
   TABLE DATA                     public       admin    false    236   !�      �	          0    27825    si_transporte 
   TABLE DATA                     public       admin    false    237   |�      �	          0    27835    si_usuarios 
   TABLE DATA                     public       admin    false    240   ��      �	          0    27846    si_usuarios_perfiles 
   TABLE DATA                     public       admin    false    242   g�      �	          0    27850    si_vehiculos 
   TABLE DATA                     public       admin    false    243   ��      �           2606    27881    app_error_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY si_app_error
    ADD CONSTRAINT app_error_pkey PRIMARY KEY (apperror_id);
 E   ALTER TABLE ONLY public.si_app_error DROP CONSTRAINT app_error_pkey;
       public         admin    false    152    152            �           2606    27883    log_codigos_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY si_log_codigos
    ADD CONSTRAINT log_codigos_pkey PRIMARY KEY (log_codigo_id);
 I   ALTER TABLE ONLY public.si_log_codigos DROP CONSTRAINT log_codigos_pkey;
       public         admin    false    194    194            �           2606    27885    si_alamacenes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_alamacenes_pkey PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.si_almacenes DROP CONSTRAINT si_alamacenes_pkey;
       public         admin    false    141    141            �           2606    27887    si_analisis_centro_acopio_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.si_analisis_centro_acopio DROP CONSTRAINT si_analisis_centro_acopio_pkey;
       public         admin    false    144    144            �           2606    27889    si_analisis_cultivo_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.si_analisis_cultivo DROP CONSTRAINT si_analisis_cultivo_pkey;
       public         admin    false    146    146            �           2606    27891    si_analisis_id_key 
   CONSTRAINT     _   ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_key UNIQUE (id, tipo_analisis);
 H   ALTER TABLE ONLY public.si_analisis DROP CONSTRAINT si_analisis_id_key;
       public         admin    false    143    143    143            �           2606    27893    si_analisis_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_analisis DROP CONSTRAINT si_analisis_pkey;
       public         admin    false    143    143            �           2606    27895    si_analisis_resultado_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.si_analisis_resultado DROP CONSTRAINT si_analisis_resultado_pkey;
       public         admin    false    150    150            �           2606    27897    si_asociado_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_asociado DROP CONSTRAINT si_asociado_pkey;
       public         admin    false    154    154            �           2606    27899    si_cargo_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.si_cargo DROP CONSTRAINT si_cargo_pkey;
       public         admin    false    156    156            �           2606    27901    si_cargo_tipo_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY si_cargo_tipo
    ADD CONSTRAINT si_cargo_tipo_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.si_cargo_tipo DROP CONSTRAINT si_cargo_tipo_pkey;
       public         admin    false    158    158            �           2606    27903    si_centro_acopio_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.si_centro_acopio DROP CONSTRAINT si_centro_acopio_pkey;
       public         admin    false    160    160            �           2606    27905    si_choferes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_choferes DROP CONSTRAINT si_choferes_pkey;
       public         admin    false    161    161            �           2606    27907    si_cliente_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.si_cliente DROP CONSTRAINT si_cliente_pkey;
       public         admin    false    164    164            �           2606    27909    si_cosecha_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.si_cosecha DROP CONSTRAINT si_cosecha_pkey;
       public         admin    false    166    166            �           2606    27911    si_cosecha_silo_id_cosecha_key 
   CONSTRAINT     }   ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_key UNIQUE (id_cosecha, id_silo, id_cultivo);
 X   ALTER TABLE ONLY public.si_cosecha_silo DROP CONSTRAINT si_cosecha_silo_id_cosecha_key;
       public         admin    false    169    169    169    169            �           2606    27913    si_cosecha_silo_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.si_cosecha_silo DROP CONSTRAINT si_cosecha_silo_pkey;
       public         admin    false    169    169            �           2606    27915    si_cuarentena_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_pkey;
       public         admin    false    171    171            �           2606    27917    si_cultivo_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.si_cultivo DROP CONSTRAINT si_cultivo_pkey;
       public         admin    false    174    174            �           2606    27919    si_cultivo_tipo_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.si_cultivo_tipo DROP CONSTRAINT si_cultivo_tipo_pkey;
       public         admin    false    175    175            �           2606    27921    si_denom_tip_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_denom_tip DROP CONSTRAINT si_denom_tip_pkey;
       public         admin    false    178    178            �           2606    27923    si_despacho_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_pkey;
       public         admin    false    179    179            �           2606    27925    si_ejes_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.si_ejes DROP CONSTRAINT si_ejes_pkey;
       public         admin    false    182    182            �           2606    27927    si_estado_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.si_estado DROP CONSTRAINT si_estado_pkey;
       public         admin    false    184    184            �           2606    27929    si_finca_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_pkey;
       public         admin    false    185    185            �           2606    27931    si_formulas_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_formulas DROP CONSTRAINT si_formulas_pkey;
       public         admin    false    187    187            �           2606    27933    si_guia_rec_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.si_guiarec DROP CONSTRAINT si_guia_rec_pkey;
       public         admin    false    189    189            �           2606    27935    si_guiarec_det_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.si_guiarec_det DROP CONSTRAINT si_guiarec_det_pkey;
       public         admin    false    190    190            �           2606    27937    si_log_consultas_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_pkey PRIMARY KEY (log_id);
 P   ALTER TABLE ONLY public.si_log_consultas DROP CONSTRAINT si_log_consultas_pkey;
       public         admin    false    196    196            �           2606    27939    si_menu_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY si_menu
    ADD CONSTRAINT si_menu_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.si_menu DROP CONSTRAINT si_menu_pkey;
       public         admin    false    198    198            �           2606    27941    si_menu_usuario_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_pkey PRIMARY KEY (id_menu, id_usuario);
 N   ALTER TABLE ONLY public.si_menu_usuario DROP CONSTRAINT si_menu_usuario_pkey;
       public         admin    false    199    199    199            �           2606    27943    si_municipio_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_municipio DROP CONSTRAINT si_municipio_pkey;
       public         admin    false    202    202            �           2606    27945    si_ordenes_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.si_ordenes DROP CONSTRAINT si_ordenes_pkey;
       public         admin    false    204    204            �           2606    27947    si_org_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_org_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.si_organizacion DROP CONSTRAINT si_org_pkey;
       public         admin    false    206    206            �           2606    27949    si_pais_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY si_pais
    ADD CONSTRAINT si_pais_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.si_pais DROP CONSTRAINT si_pais_pkey;
       public         admin    false    208    208            �           2606    27951    si_parametros_pkey1 
   CONSTRAINT     X   ALTER TABLE ONLY si_parametros
    ADD CONSTRAINT si_parametros_pkey1 PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.si_parametros DROP CONSTRAINT si_parametros_pkey1;
       public         admin    false    210    210            �           2606    27953    si_perfiles_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_perfiles
    ADD CONSTRAINT si_perfiles_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_perfiles DROP CONSTRAINT si_perfiles_pkey;
       public         admin    false    212    212            �           2606    27955    si_plaga_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.si_plaga DROP CONSTRAINT si_plaga_pkey;
       public         admin    false    213    213            �           2606    27957    si_producto_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_producto DROP CONSTRAINT si_producto_pkey;
       public         admin    false    215    215            �           2606    27959    si_productor_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_productor DROP CONSTRAINT si_productor_pkey;
       public         admin    false    218    218            �           2606    27961    si_programa_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_programa DROP CONSTRAINT si_programa_pkey;
       public         admin    false    220    220            �           2606    27963    si_proveedor_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_proveedor DROP CONSTRAINT si_proveedor_pkey;
       public         admin    false    221    221            �           2606    27965    si_punto_entrega_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.si_punto_entrega DROP CONSTRAINT si_punto_entrega_pkey;
       public         admin    false    223    223            �           2606    27967    si_recepcion_cultivo_tipo_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.si_recepcion_cultivo_tipo DROP CONSTRAINT si_recepcion_cultivo_tipo_pkey;
       public         admin    false    226    226            �           2606    27969    si_recepcion_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_pkey;
       public         admin    false    225    225            �           2606    27971    si_recursos_etiquetas_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.si_recursos_etiquetas DROP CONSTRAINT si_recursos_etiquetas_pkey;
       public         admin    false    230    230            �           2606    27973    si_recursos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_recursos
    ADD CONSTRAINT si_recursos_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_recursos DROP CONSTRAINT si_recursos_pkey;
       public         admin    false    229    229            �           2606    27975    si_silos_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.si_silos DROP CONSTRAINT si_silos_pkey;
       public         admin    false    234    234            �           2606    27977    si_tolcarom_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_tolcarom DROP CONSTRAINT si_tolcarom_pkey;
       public         admin    false    236    236            �           2606    27979    si_transporte_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.si_transporte DROP CONSTRAINT si_transporte_pkey;
       public         admin    false    237    237            �           2606    27981    si_usuarios_perfiles_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.si_usuarios_perfiles DROP CONSTRAINT si_usuarios_perfiles_pkey;
       public         admin    false    242    242            �           2606    27983    si_usuarios_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.si_usuarios DROP CONSTRAINT si_usuarios_pkey;
       public         admin    false    240    240            �           2606    27985    si_usuarios_usuario_key 
   CONSTRAINT     Z   ALTER TABLE ONLY si_usuarios
    ADD CONSTRAINT si_usuarios_usuario_key UNIQUE (usuario);
 M   ALTER TABLE ONLY public.si_usuarios DROP CONSTRAINT si_usuarios_usuario_key;
       public         admin    false    240    240            �           2606    27987    si_vehiculos_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY si_vehiculos
    ADD CONSTRAINT si_vehiculos_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.si_vehiculos DROP CONSTRAINT si_vehiculos_pkey;
       public         admin    false    243    243            �           2606    27988 "   si_almacenes_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 Y   ALTER TABLE ONLY public.si_almacenes DROP CONSTRAINT si_almacenes_id_centro_acopio_fkey;
       public       admin    false    141    2213    160            �           2606    27993    si_almacenes_id_estado_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 R   ALTER TABLE ONLY public.si_almacenes DROP CONSTRAINT si_almacenes_id_estado_fkey;
       public       admin    false    184    2237    141            �           2606    27998    si_almacenes_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 U   ALTER TABLE ONLY public.si_almacenes DROP CONSTRAINT si_almacenes_id_municipio_fkey;
       public       admin    false    202    2255    141             	           2606    28003    si_almacenes_id_pais_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY si_almacenes
    ADD CONSTRAINT si_almacenes_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 P   ALTER TABLE ONLY public.si_almacenes DROP CONSTRAINT si_almacenes_id_pais_fkey;
       public       admin    false    141    2261    208            	           2606    28008 *   si_analisis_centro_acopio_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 n   ALTER TABLE ONLY public.si_analisis_centro_acopio DROP CONSTRAINT si_analisis_centro_acopio_id_analisis_fkey;
       public       admin    false    2197    143    144            	           2606    28013 /   si_analisis_centro_acopio_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_centro_acopio
    ADD CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 s   ALTER TABLE ONLY public.si_analisis_centro_acopio DROP CONSTRAINT si_analisis_centro_acopio_id_centro_acopio_fkey;
       public       admin    false    2213    144    160            	           2606    28018 $   si_analisis_cultivo_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 b   ALTER TABLE ONLY public.si_analisis_cultivo DROP CONSTRAINT si_analisis_cultivo_id_analisis_fkey;
       public       admin    false    143    2197    146            	           2606    28023    si_analisis_cultivo_id_org_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_cultivo
    ADD CONSTRAINT si_analisis_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 ]   ALTER TABLE ONLY public.si_analisis_cultivo DROP CONSTRAINT si_analisis_cultivo_id_org_fkey;
       public       admin    false    146    2259    206            	           2606    28028     si_analisis_des_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 Z   ALTER TABLE ONLY public.si_analisis_des DROP CONSTRAINT si_analisis_des_id_analisis_fkey;
       public       admin    false    2197    148    143            	           2606    28033    si_analisis_des_id_org_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_des
    ADD CONSTRAINT si_analisis_des_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 U   ALTER TABLE ONLY public.si_analisis_des DROP CONSTRAINT si_analisis_des_id_org_fkey;
       public       admin    false    206    148    2259            	           2606    28038    si_analisis_id_org_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY si_analisis
    ADD CONSTRAINT si_analisis_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 M   ALTER TABLE ONLY public.si_analisis DROP CONSTRAINT si_analisis_id_org_fkey;
       public       admin    false    143    2259    206            	           2606    28043 &   si_analisis_resultado_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 f   ALTER TABLE ONLY public.si_analisis_resultado DROP CONSTRAINT si_analisis_resultado_id_analisis_fkey;
       public       admin    false    150    143    2197            		           2606    28048 &   si_analisis_resultado_id_despacho_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES si_despacho(id);
 f   ALTER TABLE ONLY public.si_analisis_resultado DROP CONSTRAINT si_analisis_resultado_id_despacho_fkey;
       public       admin    false    150    179    2233            
	           2606    28053 '   si_analisis_resultado_id_recepcion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);
 g   ALTER TABLE ONLY public.si_analisis_resultado DROP CONSTRAINT si_analisis_resultado_id_recepcion_fkey;
       public       admin    false    150    225    2279            	           2606    28058 %   si_analisis_resultado_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_analisis_resultado
    ADD CONSTRAINT si_analisis_resultado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 e   ALTER TABLE ONLY public.si_analisis_resultado DROP CONSTRAINT si_analisis_resultado_id_usuario_fkey;
       public       admin    false    2293    240    150            	           2606    28063    si_asociado_id_estado_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 P   ALTER TABLE ONLY public.si_asociado DROP CONSTRAINT si_asociado_id_estado_fkey;
       public       admin    false    184    2237    154            	           2606    28068    si_asociado_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 S   ALTER TABLE ONLY public.si_asociado DROP CONSTRAINT si_asociado_id_municipio_fkey;
       public       admin    false    154    202    2255            	           2606    28073    si_asociado_id_pais_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 N   ALTER TABLE ONLY public.si_asociado DROP CONSTRAINT si_asociado_id_pais_fkey;
       public       admin    false    154    208    2261            	           2606    28078    si_asociado_id_productor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_asociado
    ADD CONSTRAINT si_asociado_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);
 S   ALTER TABLE ONLY public.si_asociado DROP CONSTRAINT si_asociado_id_productor_fkey;
       public       admin    false    218    154    2271            	           2606    28083    si_cargo_id_almacen_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);
 K   ALTER TABLE ONLY public.si_cargo DROP CONSTRAINT si_cargo_id_almacen_fkey;
       public       admin    false    156    141    2193            	           2606    28088    si_cargo_id_cargo_tipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_cargo_tipo_fkey FOREIGN KEY (id_cargo_tipo) REFERENCES si_cargo_tipo(id);
 N   ALTER TABLE ONLY public.si_cargo DROP CONSTRAINT si_cargo_id_cargo_tipo_fkey;
       public       admin    false    156    158    2211            	           2606    28093    si_cargo_id_usuario_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY si_cargo
    ADD CONSTRAINT si_cargo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 K   ALTER TABLE ONLY public.si_cargo DROP CONSTRAINT si_cargo_id_usuario_fkey;
       public       admin    false    156    240    2293            	           2606    28098    si_centro_acopio_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 Z   ALTER TABLE ONLY public.si_centro_acopio DROP CONSTRAINT si_centro_acopio_id_estado_fkey;
       public       admin    false    160    184    2237            	           2606    28103 "   si_centro_acopio_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 ]   ALTER TABLE ONLY public.si_centro_acopio DROP CONSTRAINT si_centro_acopio_id_municipio_fkey;
       public       admin    false    2255    202    160            	           2606    28108    si_centro_acopio_id_org_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 W   ALTER TABLE ONLY public.si_centro_acopio DROP CONSTRAINT si_centro_acopio_id_org_fkey;
       public       admin    false    160    206    2259            	           2606    28113    si_centro_acopio_id_pais_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_centro_acopio
    ADD CONSTRAINT si_centro_acopio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 X   ALTER TABLE ONLY public.si_centro_acopio DROP CONSTRAINT si_centro_acopio_id_pais_fkey;
       public       admin    false    160    208    2261            	           2606    28118    si_choferes_id_org_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY si_choferes
    ADD CONSTRAINT si_choferes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 M   ALTER TABLE ONLY public.si_choferes DROP CONSTRAINT si_choferes_id_org_fkey;
       public       admin    false    161    206    2259            	           2606    28123    si_cliente_id_org_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY si_cliente
    ADD CONSTRAINT si_cliente_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 K   ALTER TABLE ONLY public.si_cliente DROP CONSTRAINT si_cliente_id_org_fkey;
       public       admin    false    206    2259    164            	           2606    28128    si_cosecha_id_cultivo_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 O   ALTER TABLE ONLY public.si_cosecha DROP CONSTRAINT si_cosecha_id_cultivo_fkey;
       public       admin    false    174    166    2227            	           2606    28133    si_cosecha_id_programa_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha
    ADD CONSTRAINT si_cosecha_id_programa_fkey FOREIGN KEY (id_programa) REFERENCES si_programa(id);
 P   ALTER TABLE ONLY public.si_cosecha DROP CONSTRAINT si_cosecha_id_programa_fkey;
       public       admin    false    166    2273    220            	           2606    28138 *   si_cosecha_productor_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 i   ALTER TABLE ONLY public.si_cosecha_productor DROP CONSTRAINT si_cosecha_productor_id_centro_acopio_fkey;
       public       admin    false    2213    167    160            	           2606    28143 $   si_cosecha_productor_id_cosecha_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);
 c   ALTER TABLE ONLY public.si_cosecha_productor DROP CONSTRAINT si_cosecha_productor_id_cosecha_fkey;
       public       admin    false    167    2219    166            	           2606    28148 &   si_cosecha_productor_id_productor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_productor
    ADD CONSTRAINT si_cosecha_productor_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);
 e   ALTER TABLE ONLY public.si_cosecha_productor DROP CONSTRAINT si_cosecha_productor_id_productor_fkey;
       public       admin    false    167    218    2271            	           2606    28153    si_cosecha_silo_id_cosecha_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);
 Y   ALTER TABLE ONLY public.si_cosecha_silo DROP CONSTRAINT si_cosecha_silo_id_cosecha_fkey;
       public       admin    false    2219    166    169            	           2606    28158    si_cosecha_silo_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 Y   ALTER TABLE ONLY public.si_cosecha_silo DROP CONSTRAINT si_cosecha_silo_id_cultivo_fkey;
       public       admin    false    174    169    2227             	           2606    28163    si_cosecha_silo_id_silo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cosecha_silo
    ADD CONSTRAINT si_cosecha_silo_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);
 V   ALTER TABLE ONLY public.si_cosecha_silo DROP CONSTRAINT si_cosecha_silo_id_silo_fkey;
       public       admin    false    169    234    2287            !	           2606    28168    si_cuarentena_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 V   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_id_analisis_fkey;
       public       admin    false    171    2197    143            "	           2606    28173 #   si_cuarentena_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 [   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_id_centro_acopio_fkey;
       public       admin    false    2213    171    160            #	           2606    28178    si_cuarentena_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 U   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_id_cultivo_fkey;
       public       admin    false    171    174    2227            $	           2606    28183    si_cuarentena_id_recepcion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);
 W   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_id_recepcion_fkey;
       public       admin    false    2279    225    171            %	           2606    28188    si_cuarentena_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cuarentena
    ADD CONSTRAINT si_cuarentena_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 U   ALTER TABLE ONLY public.si_cuarentena DROP CONSTRAINT si_cuarentena_id_usuario_fkey;
       public       admin    false    2293    240    171            &	           2606    28193    si_cultivo_id_org_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY si_cultivo
    ADD CONSTRAINT si_cultivo_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 K   ALTER TABLE ONLY public.si_cultivo DROP CONSTRAINT si_cultivo_id_org_fkey;
       public       admin    false    2259    174    206            '	           2606    28198     si_cultivo_tipo_id_analisis_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_analisis_fkey FOREIGN KEY (id_analisis) REFERENCES si_analisis(id);
 Z   ALTER TABLE ONLY public.si_cultivo_tipo DROP CONSTRAINT si_cultivo_tipo_id_analisis_fkey;
       public       admin    false    175    143    2197            (	           2606    28203 %   si_cultivo_tipo_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 _   ALTER TABLE ONLY public.si_cultivo_tipo DROP CONSTRAINT si_cultivo_tipo_id_centro_acopio_fkey;
       public       admin    false    160    2213    175            )	           2606    28208    si_cultivo_tipo_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_cultivo_tipo
    ADD CONSTRAINT si_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 Y   ALTER TABLE ONLY public.si_cultivo_tipo DROP CONSTRAINT si_cultivo_tipo_id_cultivo_fkey;
       public       admin    false    2227    174    175            *	           2606    28213    si_denom_tip_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 S   ALTER TABLE ONLY public.si_denom_tip DROP CONSTRAINT si_denom_tip_id_cultivo_fkey;
       public       admin    false    178    2227    174            +	           2606    28218    si_denom_tip_id_org_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_denom_tip
    ADD CONSTRAINT si_denom_tip_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 O   ALTER TABLE ONLY public.si_denom_tip DROP CONSTRAINT si_denom_tip_id_org_fkey;
       public       admin    false    206    178    2259            ,	           2606    28223 !   si_despacho_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 W   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_centro_acopio_fkey;
       public       admin    false    179    2213    160            -	           2606    28233    si_despacho_id_orden_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES si_ordenes(id);
 O   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_orden_fkey;
       public       admin    false    179    2257    204            .	           2606    28238    si_despacho_id_productor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);
 S   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_productor_fkey;
       public       admin    false    218    179    2271            /	           2606    28243 !   si_despacho_id_punto_entrega_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_punto_entrega_fkey FOREIGN KEY (id_punto_entrega) REFERENCES si_punto_entrega(id);
 W   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_punto_entrega_fkey;
       public       admin    false    2277    223    179            0	           2606    28248    si_despacho_id_silo_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);
 N   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_silo_fkey;
       public       admin    false    179    2287    234            1	           2606    28253    si_despacho_id_transporte_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_transporte_fkey FOREIGN KEY (id_transporte) REFERENCES si_transporte(id);
 T   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_transporte_fkey;
       public       admin    false    237    2291    179            2	           2606    28258    si_despacho_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 Q   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_usuario_fkey;
       public       admin    false    240    2293    179            3	           2606    28263    si_despacho_id_vehiculo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_despacho
    ADD CONSTRAINT si_despacho_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES si_vehiculos(id);
 R   ALTER TABLE ONLY public.si_despacho DROP CONSTRAINT si_despacho_id_vehiculo_fkey;
       public       admin    false    179    243    2299            4	           2606    28268    si_ejes_id_org_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY si_ejes
    ADD CONSTRAINT si_ejes_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 E   ALTER TABLE ONLY public.si_ejes DROP CONSTRAINT si_ejes_id_org_fkey;
       public       admin    false    206    2259    182            5	           2606    28273    si_estado_id_pais_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY si_estado
    ADD CONSTRAINT si_estado_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 J   ALTER TABLE ONLY public.si_estado DROP CONSTRAINT si_estado_id_pais_fkey;
       public       admin    false    2261    208    184            6	           2606    28278    si_finca_id_estado_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 J   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_id_estado_fkey;
       public       admin    false    184    185    2237            7	           2606    28283    si_finca_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 M   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_id_municipio_fkey;
       public       admin    false    2255    202    185            8	           2606    28288    si_finca_id_org_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 G   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_id_org_fkey;
       public       admin    false    185    2259    206            9	           2606    28293    si_finca_id_pais_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 H   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_id_pais_fkey;
       public       admin    false    2261    208    185            :	           2606    28298    si_finca_id_productor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_finca
    ADD CONSTRAINT si_finca_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);
 M   ALTER TABLE ONLY public.si_finca DROP CONSTRAINT si_finca_id_productor_fkey;
       public       admin    false    218    185    2271            ;	           2606    28303 !   si_formulas_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 W   ALTER TABLE ONLY public.si_formulas DROP CONSTRAINT si_formulas_id_centro_acopio_fkey;
       public       admin    false    187    160    2213            <	           2606    28308    si_formulas_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 Q   ALTER TABLE ONLY public.si_formulas DROP CONSTRAINT si_formulas_id_cultivo_fkey;
       public       admin    false    174    2227    187            =	           2606    28313    si_formulas_id_org_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY si_formulas
    ADD CONSTRAINT si_formulas_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 M   ALTER TABLE ONLY public.si_formulas DROP CONSTRAINT si_formulas_id_org_fkey;
       public       admin    false    2259    206    187            >	           2606    28318    si_guia_rec_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_guiarec
    ADD CONSTRAINT si_guia_rec_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 P   ALTER TABLE ONLY public.si_guiarec DROP CONSTRAINT si_guia_rec_id_usuario_fkey;
       public       admin    false    189    240    2293            ?	           2606    28323    si_guiarec_det_id_guiarec_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_guiarec_det
    ADD CONSTRAINT si_guiarec_det_id_guiarec_fkey FOREIGN KEY (id_guiarec) REFERENCES si_guiarec(id);
 W   ALTER TABLE ONLY public.si_guiarec_det DROP CONSTRAINT si_guiarec_det_id_guiarec_fkey;
       public       admin    false    190    189    2243            @	           2606    28328 #   si_log_consultas_log_codigo_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_log_consultas
    ADD CONSTRAINT si_log_consultas_log_codigo_id_fkey FOREIGN KEY (log_codigo_id) REFERENCES si_log_codigos(log_codigo_id);
 ^   ALTER TABLE ONLY public.si_log_consultas DROP CONSTRAINT si_log_consultas_log_codigo_id_fkey;
       public       admin    false    2247    196    194            A	           2606    28333    si_menu_usuario_id_menu_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES si_menu(id);
 V   ALTER TABLE ONLY public.si_menu_usuario DROP CONSTRAINT si_menu_usuario_id_menu_fkey;
       public       admin    false    198    199    2251            B	           2606    28338    si_menu_usuario_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_menu_usuario
    ADD CONSTRAINT si_menu_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 Y   ALTER TABLE ONLY public.si_menu_usuario DROP CONSTRAINT si_menu_usuario_id_usuario_fkey;
       public       admin    false    240    199    2293            C	           2606    28343    si_municipio_id_estado_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_municipio
    ADD CONSTRAINT si_municipio_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 R   ALTER TABLE ONLY public.si_municipio DROP CONSTRAINT si_municipio_id_estado_fkey;
       public       admin    false    184    202    2237            D	           2606    28348     si_ordenes_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 U   ALTER TABLE ONLY public.si_ordenes DROP CONSTRAINT si_ordenes_id_centro_acopio_fkey;
       public       admin    false    160    204    2213            E	           2606    28353    si_ordenes_id_cliente_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);
 O   ALTER TABLE ONLY public.si_ordenes DROP CONSTRAINT si_ordenes_id_cliente_fkey;
       public       admin    false    164    204    2217            F	           2606    28358    si_ordenes_id_cultivo_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY si_ordenes
    ADD CONSTRAINT si_ordenes_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 O   ALTER TABLE ONLY public.si_ordenes DROP CONSTRAINT si_ordenes_id_cultivo_fkey;
       public       admin    false    174    204    2227            G	           2606    28363    si_organizacion_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 X   ALTER TABLE ONLY public.si_organizacion DROP CONSTRAINT si_organizacion_id_estado_fkey;
       public       admin    false    184    2237    206            H	           2606    28368 !   si_organizacion_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 [   ALTER TABLE ONLY public.si_organizacion DROP CONSTRAINT si_organizacion_id_municipio_fkey;
       public       admin    false    2255    206    202            I	           2606    28373    si_organizacion_id_pais_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_organizacion
    ADD CONSTRAINT si_organizacion_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 V   ALTER TABLE ONLY public.si_organizacion DROP CONSTRAINT si_organizacion_id_pais_fkey;
       public       admin    false    2261    206    208            J	           2606    28378    si_plaga_id_org_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY si_plaga
    ADD CONSTRAINT si_plaga_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 G   ALTER TABLE ONLY public.si_plaga DROP CONSTRAINT si_plaga_id_org_fkey;
       public       admin    false    2259    206    213            K	           2606    28383    si_producto_id_org_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY si_producto
    ADD CONSTRAINT si_producto_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 M   ALTER TABLE ONLY public.si_producto DROP CONSTRAINT si_producto_id_org_fkey;
       public       admin    false    206    215    2259            L	           2606    28388    si_productor_id_estado_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 R   ALTER TABLE ONLY public.si_productor DROP CONSTRAINT si_productor_id_estado_fkey;
       public       admin    false    218    2237    184            M	           2606    28393    si_productor_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 U   ALTER TABLE ONLY public.si_productor DROP CONSTRAINT si_productor_id_municipio_fkey;
       public       admin    false    218    202    2255            N	           2606    28398    si_productor_id_org_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 O   ALTER TABLE ONLY public.si_productor DROP CONSTRAINT si_productor_id_org_fkey;
       public       admin    false    2259    218    206            O	           2606    28403    si_productor_id_pais_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY si_productor
    ADD CONSTRAINT si_productor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 P   ALTER TABLE ONLY public.si_productor DROP CONSTRAINT si_productor_id_pais_fkey;
       public       admin    false    208    218    2261            P	           2606    28408 !   si_programa_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_programa
    ADD CONSTRAINT si_programa_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 W   ALTER TABLE ONLY public.si_programa DROP CONSTRAINT si_programa_id_centro_acopio_fkey;
       public       admin    false    220    160    2213            Q	           2606    28413    si_proveedor_id_estado_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 R   ALTER TABLE ONLY public.si_proveedor DROP CONSTRAINT si_proveedor_id_estado_fkey;
       public       admin    false    184    221    2237            R	           2606    28418    si_proveedor_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 U   ALTER TABLE ONLY public.si_proveedor DROP CONSTRAINT si_proveedor_id_municipio_fkey;
       public       admin    false    202    221    2255            S	           2606    28423    si_proveedor_id_org_fkey    FK CONSTRAINT        ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_org_fkey FOREIGN KEY (id_org) REFERENCES si_organizacion(id);
 O   ALTER TABLE ONLY public.si_proveedor DROP CONSTRAINT si_proveedor_id_org_fkey;
       public       admin    false    2259    206    221            T	           2606    28428    si_proveedor_id_pais_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY si_proveedor
    ADD CONSTRAINT si_proveedor_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 P   ALTER TABLE ONLY public.si_proveedor DROP CONSTRAINT si_proveedor_id_pais_fkey;
       public       admin    false    208    221    2261            U	           2606    28433     si_punto_entrega_id_cliente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES si_cliente(id);
 [   ALTER TABLE ONLY public.si_punto_entrega DROP CONSTRAINT si_punto_entrega_id_cliente_fkey;
       public       admin    false    2217    223    164            V	           2606    28438    si_punto_entrega_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES si_estado(id);
 Z   ALTER TABLE ONLY public.si_punto_entrega DROP CONSTRAINT si_punto_entrega_id_estado_fkey;
       public       admin    false    2237    223    184            W	           2606    28443 "   si_punto_entrega_id_municipio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES si_municipio(id);
 ]   ALTER TABLE ONLY public.si_punto_entrega DROP CONSTRAINT si_punto_entrega_id_municipio_fkey;
       public       admin    false    2255    223    202            X	           2606    28448    si_punto_entrega_id_pais_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_punto_entrega
    ADD CONSTRAINT si_punto_entrega_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES si_pais(id);
 X   ALTER TABLE ONLY public.si_punto_entrega DROP CONSTRAINT si_punto_entrega_id_pais_fkey;
       public       admin    false    223    208    2261            a	           2606    28453 /   si_recepcion_cultivo_tipo_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 s   ALTER TABLE ONLY public.si_recepcion_cultivo_tipo DROP CONSTRAINT si_recepcion_cultivo_tipo_id_centro_acopio_fkey;
       public       admin    false    226    160    2213            b	           2606    28458 )   si_recepcion_cultivo_tipo_id_cultivo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES si_cultivo(id);
 m   ALTER TABLE ONLY public.si_recepcion_cultivo_tipo DROP CONSTRAINT si_recepcion_cultivo_tipo_id_cultivo_fkey;
       public       admin    false    174    2227    226            c	           2606    28463 +   si_recepcion_cultivo_tipo_id_recepcion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion_cultivo_tipo
    ADD CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey FOREIGN KEY (id_recepcion) REFERENCES si_recepcion(id);
 o   ALTER TABLE ONLY public.si_recepcion_cultivo_tipo DROP CONSTRAINT si_recepcion_cultivo_tipo_id_recepcion_fkey;
       public       admin    false    225    2279    226            Y	           2606    28468    si_recepcion_id_asociado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_asociado_fkey FOREIGN KEY (id_asociado) REFERENCES si_asociado(id);
 T   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_asociado_fkey;
       public       admin    false    154    225    2207            Z	           2606    28473 "   si_recepcion_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 Y   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_centro_acopio_fkey;
       public       admin    false    2213    225    160            [	           2606    28478    si_recepcion_id_chofer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_chofer_fkey FOREIGN KEY (id_chofer) REFERENCES si_choferes(id);
 R   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_chofer_fkey;
       public       admin    false    225    161    2215            \	           2606    28483    si_recepcion_id_cosecha_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES si_cosecha(id);
 S   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_cosecha_fkey;
       public       admin    false    2219    225    166            ]	           2606    28488    si_recepcion_id_guia_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_guia_fkey FOREIGN KEY (id_guia) REFERENCES si_guiarec(id);
 P   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_guia_fkey;
       public       admin    false    225    2243    189            ^	           2606    28493    si_recepcion_id_productor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_productor_fkey FOREIGN KEY (id_productor) REFERENCES si_productor(id);
 U   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_productor_fkey;
       public       admin    false    2271    218    225            _	           2606    28498    si_recepcion_id_silo_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_silo_fkey FOREIGN KEY (id_silo) REFERENCES si_silos(id);
 P   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_silo_fkey;
       public       admin    false    234    225    2287            `	           2606    28503    si_recepcion_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recepcion
    ADD CONSTRAINT si_recepcion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 S   ALTER TABLE ONLY public.si_recepcion DROP CONSTRAINT si_recepcion_id_usuario_fkey;
       public       admin    false    240    2293    225            d	           2606    28508 %   si_recursos_etiquetas_id_recurso_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_recursos_etiquetas
    ADD CONSTRAINT si_recursos_etiquetas_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES si_recursos(id);
 e   ALTER TABLE ONLY public.si_recursos_etiquetas DROP CONSTRAINT si_recursos_etiquetas_id_recurso_fkey;
       public       admin    false    229    2283    230            e	           2606    28513    si_silos_id_almacen_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);
 K   ALTER TABLE ONLY public.si_silos DROP CONSTRAINT si_silos_id_almacen_fkey;
       public       admin    false    234    2193    141            f	           2606    28518    si_silos_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_silos
    ADD CONSTRAINT si_silos_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 Q   ALTER TABLE ONLY public.si_silos DROP CONSTRAINT si_silos_id_centro_acopio_fkey;
       public       admin    false    160    2213    234            g	           2606    28523 !   si_tolcarom_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_tolcarom
    ADD CONSTRAINT si_tolcarom_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 W   ALTER TABLE ONLY public.si_tolcarom DROP CONSTRAINT si_tolcarom_id_centro_acopio_fkey;
       public       admin    false    160    2213    236            h	           2606    28528 #   si_transporte_id_centro_acopio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_transporte
    ADD CONSTRAINT si_transporte_id_centro_acopio_fkey FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id);
 [   ALTER TABLE ONLY public.si_transporte DROP CONSTRAINT si_transporte_id_centro_acopio_fkey;
       public       admin    false    2213    237    160            i	           2606    28533 $   si_usuarios_perfiles_id_almacen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES si_almacenes(id);
 c   ALTER TABLE ONLY public.si_usuarios_perfiles DROP CONSTRAINT si_usuarios_perfiles_id_almacen_fkey;
       public       admin    false    2193    242    141            j	           2606    28538 #   si_usuarios_perfiles_id_perfil_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES si_perfiles(id);
 b   ALTER TABLE ONLY public.si_usuarios_perfiles DROP CONSTRAINT si_usuarios_perfiles_id_perfil_fkey;
       public       admin    false    2265    212    242            k	           2606    28543 $   si_usuarios_perfiles_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY si_usuarios_perfiles
    ADD CONSTRAINT si_usuarios_perfiles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES si_usuarios(id);
 c   ALTER TABLE ONLY public.si_usuarios_perfiles DROP CONSTRAINT si_usuarios_perfiles_id_usuario_fkey;
       public       admin    false    2293    240    242            l	   �  x�ݖ݋�0���W̛���|���$��	�=Z{����TS�����ړ��BO�S0�1��c23i�M6�y��^��cSV�U=<�����m�̾��I�i>:��֝�*m�qѩ��(�~(k3�͹Օ7���ҡ��@5�>ڇ];���ʘ�VmY���<4v�S�������I�Of��ˮZ�6��+�v��Vl���=~MrX�6��[A��2�6foN#��Н�${�P�$lI%P?�~D��U�Q��e�:O"�w�Y��ɹ�d�|LC��Y�
��,p,��t�Z� x$5�Z_�H�C�V.���gGY�9�̷����px��sNF]����óy�a�I�;��+�o���.�!���f�H6��=M�"����U�1b3h���Dz�s���s�~۽�Um�ύ��LP,�l�-l�j�݊w��]����
*/���8+dD	^��,�N�b��!�      m	   �  x����j�@ ��<Ź�:��{u��t��qՄ%7��O��h� }���NՖ�����&$~���\f��0�V�S��ڪ��j�B�~��G����f�¡�[�ŅM{(G�X5�r]����նZu�]?��m�쏻���2��k|�Y���!ŬP�ɝ��9ڿq�狱'�B���v��7�<���e[�������v��	-�T^�VK��ݰ�|��k.cB������Jc(�t>�N��X.C�I�6����P1/3虩��<���St��7�q��{Scf�S8Ւl�NX����˳M/��mzo��Q�E^|�ўH"����S�별Y(/Y�W�e�V}�#yśr>�ַfRiK��3YZ�ݬ�i�f��,��q(���v���y,#����?�"��L.��	V���,	��re@!��@�0<h1efFP����a��i"��<�:��w.��B��Aa�P̥yh��Nca~��������'��      n	   
   x���          o	   1  x���Mk�@ ��bnV%ϼ���҅�]C�2`�c���Ħ���s��d&	�7~�d}s���7��_f��rWn�>����Kc.Ҧh�ߙ������x@f��SӖ]Ӧ~�֛CU�fW�u��tS��������3�ƃ���q#��+Ǎ�s�]�6EY5R33�W?Vw����L���z���2�����_����q��������q>��kߦA���;��Nڵ��vOۣt{��s��H���sھ�n_pܜ�ֈ_�xH�ז�[�z�;h��8�68r��p�@�9�Ё�t��m�c�jc\;V[;�k�jk�r�Xm����۳��7���ז������<^�y��k3/�xm��i��Fނ�ko�㵉7��c���x�����紑�<��<p�9m�;�i;zNz�������צ�����,��׶������s�L�M=�㵥x�6�"��vޜ�k3oAヶ�<^y9��F�뵑��I�F��������<p�m�K/hK�zQ�z�֋�ֳ�zQ�z�����(n�S<�׉�ǷǒOs?�;}��_pS*�      p	   
   x���          q	   �  x���j�@F�~��9S��]e���8'�!*H,c�}�ʲk>�������J3��rt�����/_�T[��m�V�u��W���PluWof��t3e�+�fۏ6U�+ʟM?����c����Ǫ=�sݳ�=ןYV�þYe�;��w����u�~<,^W���i6Sݲ��b1Sݕ��Sc�i��u�vs������R�g5��>�q����v���ݙ[3p�Nx�3�)��wN���q'���S�M~#l���X"pT6C�l:�!����Y[��f.ڶ|9np�6s�a��Go3���"p47����ܬ�y���c���8�;��; ��vǱp{��[�ՁF3n܂�F�m�[���p�1:����w
�Bc��;n�1Fǝ���1:�act�hlRc�ܠ�I�1:pt6�1F��&5����ڤ�8��|<�mRcc���&5���Qܤ�8����Gs�ct/��'���O7wB�O�vB��n"]���l�&�M�m
�D��f�M�m�D��z���ho���1:46���P٘�Cgcj����1:�6���Pۘ�Cocj�ō�1:47����ܘ��}z�k���EX�O�؟͍�;n"_�)p�π��V}�D��{�&j�> 7Qc��c0�-D�1�QchlL�1��15ƀ���JSchmL�1��15ƀ�F��Fq#j�A��5Ơ�ܤƸ��'�d�S{�o      r	   }  x���r�6��z
/�K�/N:�&j���Q����dt(�()�L&�<Bo�uA�ǎZ{�C;#\�X.����'L����%��]�##^U��Zi�����/�Z����xW������x�z]�/A�y�r/J���RL� {J	X@�C�	�� ���6�3��K��9�����Y�B8��np���v�u�\
��R���Zr��+Y��W�gR���z����^8��%#�ٳ���gg��\��ϭˬ���6�7ͯՍy[��b]f�x6;�1�D�6��z	�r��F�\���B��ԲR(��UV��F����6��k�o�M�]'_����A�'�d�6G�l]�r����mL�Uz��*�Z��g����\.an���2��V`j�!4�K��#]Bws;��V?Nf;��bJ�_Liл�����zdЛ�^L��ƣ��ӛ��`��m�sC/���|+ն�o
3gm�NJ�j:�A�~�O�W'h�h���z�D8�
�ר�8�$# 9���¿�\!S�����6�����YAe�I�V�0�P$���&�;����?�L��S�єxA�y8�R�N}F��(}���ҽV+��V�T霻�V7"����-/y!�4�$R�SG���B��|)��o���e��I�/���RY�7|,$��!J,�f��Ͽw���1"����K��0;?��ɔ�:z���k�r��N�^������t�����׻� !��95H�ͪc/t�'ߟ�^��I�.����c ���r/���r?�x���c27��(����=�����R�qH3��yf�"��}GCpyAt�� �@h% l!�x	q�E����!��]8H� ��'��J��C���	��A      s	   H  x�ݒ;o�0�w~����l�v�(̀��.Q�8�%�Q��&�
U�P'<X������l�8��f�O��e�����\�t]�;S�r0����֜>:��֝�R�����1���:�Ǫ�W����[:���j��ںK:��]Q��VV�NU�z��4����H�p):�Z7ZZ���*)�����9��g�Ǳ�z�%i�8�߭�I���PL���KC ""~Dؒ�����,���2�<[�Olq�Aܱ�e�[�ާ�"~]��u0#�s.�x�����8�</"|I��cfĄ�c\�A��
���Z��(�0Y�L���:�}�,8�      t	   
   x���          u	   
   x���          v	   %  x���Mo�0�{>�o�A~���͢�)%Iv�%�d��H��{0�E[��+�#d,cď?6Q�Y$[��5��C��u�2��ѝ�l����N6Ju�N�F�.~V��*u�Q���.��(�(/�:�(SU��J���TW�ȯ�̴iM�R�0g�ԇ����N���Rf�zh������I�*73p�Q�оG?�j�ؠ;b#(c�b����6��Ż���#y���u��#Z:�tJ(�845�n�p?���I4@�r�܈�u��D����w``P�Z�|jJ�jN���2DH�yȨ�	��xm��v�Bο��N$�Qln���S#+Y���\���������w�~��b; ���d�IM��$4d49�#N��s�l�����t�T*����w|�8c���{N��>��.��A�����;���e��1�G��)V�a�_R��0�"�4bǥ�E��A�L��OT�A���a_�E��o��!)>�������g~>�3��VN�	��k�獸v;;	]�� ��I,�B�;��_C;����"      w	   �  x���Oo�0 �{>Ż����l�K��)��	=�e@6KI�H��簪K4*�[�,x����l����%��2��[���M���wU �Z5�����v�.��u�t��w�{v�W�ժu� ���G[������Xo�M��s*��e�} �$ǓOX�u�m�Tn�J?�S2+��1����Tp��"BBi�;?67S���X��w�b6��ۓ��;J��	S�Hc*CJ+>&<f��݇�����>	��� yL�2���S�~.��E��C*����\X���?�k�I�Z+lL��}c2�D�n�D��P�4���k�d0�� �)�	��G��i�^���F�0��݉h�f��K�"�h�SF��&�o����TX����rJ��5��^Lň�B����<(n�Y\H����030�M�f8�:TD�W�>0�!�7�%����Z�����2�0�A\��_3�1"�}4����      x	   
   x���          y	   1  x�ՖMo�@���s#�0ڙ��c{B	J�lSa��\,�q�T�
�H�����Gjׇ@#���>z�Y��4JgOf	4�"��"���]���\.~��k���6�w?��[eæZ�ԅ���"�fK}�zi��-��jcCV٢)]�]�)��7٪�eE�Ͷ�Ɔ\כI�ղ\�y;��������hM�lЁ6L�ѵ���ﳈ!�re�sAćL(άCy[�к�2�{��@�?�~6�6�i�4�<��L�����E��³�Y0$��L�3�8)�:��d؉���k�������(���b�C������2���ꙿ<��_��ca�&�z�H\�M�H1��p<F��n���D��yGN7�_(��?6hPhw��q?�Y��3�a��ϰ���g��"WQ�x���;�;ո�%
}E踄�/��`�|��
W�YDB74�=���3�B�3RhX���)��K&�Dt��5ۀ@E�#�Ǳs@�7yQ5�L튶ZJR8$}�n7��iKڠ��3D�I�BJ��,���h������ƱC^����s)D'���9�����      z	   �   x���=�@��_�Q�&��t�� �v�#wҀm�N��;���������uP7����C�e���b�{*೛�byP�3�O~��c$�����ɚFB��N�~�}�B�
�֨&g4��{O�sTue�������]ypWq��" ��Y���XQ��r�
      {	   W   x���v
Q���W(ΌO�/NM�H�/���W��L�Q�L�	�� 	�`iNIfY��B��O�k������jZsyR�X#��F@c�� �i6      |	   )  x���Ok1��~���%��j�')k�?�.c6j`M�l����j��P�Lޛߛ�j3_oa��~Amrՠ�6h��3S�f�rT�2��A���M}��2��U�Z�Jg۩�	W��\~v�Nx��m=.7���WD�{�18���+"�Y]b�t�B�h+�N����ߨ��o�msB	^S4��+��(���=[���I	�`@5f@sw]z.���D �Y[>�$�O\�K�|DJ�r#�»|JF�}�cB�"A����8�o�H�r�S9~y!�$��T�\Lo��{���!֔�      }	   L  x�՘�n�0��y�sG+��1�bvu�D`)����+7U�*��{��N_�nr:�pv5�B bG������Y�dV(x���ۧ������z�����m����v_��<��뻺�٘kU]m_�������]:�Ϙ�qg>���`�38z͵�Ԙ��eG
2��01Kw7�G�]��!g>1>�g�O��}���`�G,���ٝ�Ir�q ��O4�)M�r(C��"�L�w�� �^���	g|�Sh�P^��e�� �.���e
i�ŴX�tkMe�1$��B2])]��c2%�iWY����G����q\F� ��.�JQ�)�Iaf-�tf�/m��R���G|.S��JXT�Vk8as�����(��Q�<6/�,���8�q��_X�LL��5BC���i��u�����w_b�?��YS�>�P`�.��
��r ���_�ӣ�P `�@�B��4��J̒
��P����%�+���޸&Nq
�b���8y��(��e6��`l�<���EX��O�q��d#�+�*)J��x�ӓs�07?��W
'�N!,����� s��/���W�=� ����      ~	   
   x���          	   
   x���          �	   
   x���          �	   
   x���          �	   0  x��Խn�0��=O�-��P�g��0.���谑��"C����UW�+?پ���3���<����e���4fj�ߗi�������W=�h:�+2�gj�A�ݿnP��3�����Cm$#5� �#H��)�pŹ<��-�@R�eQt�Q�K/e�����xK���T�P)I��<_�7��;���qj�b�b��Ylp��!��
'� �[�p�M�ڵ<�+v���L���8��S�u�$���.j�[Qp��;��^pǁ��'Xp��X1��C>��u<�ny��S���@����b ��m6ҵ��      �	   
   x���          �	   �  x���_o�@ �w?ž-�̰�����\I�Gl��h�MT���7��\iR��ld��1�ϙM���G�����Z?W���&?S��P�ڿ4��iw�W뼨^U�W�6G���6�EU�����mqT�U���ήT��v<�?�%���gU4s�w�F����ty� L����a�45�˲�L3K�:K�r�lųY��������8����z� ��AO �@�pc�ɗ���̗i�q֏Ir�,��"�c	j�p�%� ��Q�]<�%�Y��j!�fT,a�\�<��ii$�4*��'s�
A�"]�A����Lܕ��4�7m$��ͫ�0kƨT�,'I+g�Jڂ�u����P�?Cd7���C��qJN�X��Α��Oh����E'G�%זz��j��y��Z:��9MįV~հ��]�e}oF��K���Z���Q�|��_��h!��q�.���:/���;i�H���!~	��=���&��R�      �	     x�ݗM��0����eW"�3��vO=�!R�Vݏkdo�jZ��;��J-,۬r2Xf�c#=����ۛowl����ٵ�סdWq�����]8���v��O����i}�>��PW���}��jW�C�d��ޗ~S�C��ن����i���'�	���꘱М���yeض{��ME�ݒcYO�?uV�'�jcI�5{�����eW [߯V����������9���ƹ�ۂK'����'��C�ͱ D�gR�y�i�L�%X�vMwT/LT�k�T!S%*ƂS"t�z�'.��'y[�E(�B�.O9�)�"���ۀ�8���,�(mxThSũ8�)��s*��b��q㨉"��r4���C�ZEYu2w��iB���B�lp������#Rd��0��tq�1)��^��������I�8�T�!ڝ}�^�Z��OY�t��WKJO�;�9K�@v^*�p�4����N3Ux����Ak��	��$Ն�D�=A:K�A����&�Vj#�_���/�H��      �	   �   x���M�0�⹩0a�t��A���Rj�K���o��A�B�6����gQ����8�B��K��U�gE�KT1��ͩ=#8��UoEY�z��~�����,��&�L>��3�	u0s��.����i�����k%:1�FjՏKƅKw��&�`]������7|T͗˹4�H#�4�\�5��H��}��r��$�      �	   �   x����
�@�O17<�ѩ��)Ժʶ;Ȁz�D��Ў��?f��������P�p]IVT��*R|E����
ͬ��$y��tc.���~���h�Ġ
4������h�;+Y��{®�?m��HJ4�X�/O��˃��e�H��oNϚ(����C�uA�7(n�%�˱�'��!�      �	   
   x���          �	   S  x�ŗMo�0�����Jh7@��=Eٮ)I���+��X�l�a��hc����A���y�o�����^��iI�=�,D+/���fiYw��"DD4д"D�g�
�2��e4�X^?�����������3LA��!:�w�5��/��������Y"Ų�w�DYf�e#A�ϓ3��(�#�o��%��2��iI��G��ϖ�LZ0�1eU�:6����w�G�շ:��"-��DԀo,�ӓy-t�dѤ�ցʄ���0�)K*_�1+m>I������3Tǜ�����6�Jcm�NH��xR�'Z0Pt'�OC���2A𭳑d��3t\2��Fɇ�Jƛ���6X���j����`|�@d+l6^��"9�8�a��[����(����`� m>=(N�6j���XD�/�
�ӧ�o���bz�Ֆ�.J���'�ҧ��z���wiX�辕y�6�c���b�l�������Kmv��	��2r�|���Y��]���3�y�K��ҖC!�ǖ>�G�.�l �u��
$!��.X����?�RR�G=JK�NK*)Ǔs��,��Z�>��Y���]�'���1�7      �	     x��ֻ�@�ឧ�RfFbeaAb4��-(�D������$����t���xN��|H���z��������f��/,R>�.���t��.�S��"��|]tTǼ�tg��;�w�tG�������;�wj��x��;�wZ�#$%_�+�@���_x� ��޶ ��D����dㅫ���iJϕ|��k�x�B<�� �%J�o�� ���E|��6�x�^2�w^R�0�����A�߮��4�� ���, 8���せ��(�(���t�      �	     x������6�s?���*���X*v5�����N'�����{y�'���l^G/����]66ڟk���Z����i�E��2�j�~������o��������?T�����/?�����ן������nj�z�ދ�y7��}u��������4���?��@�:3��V�\'�Nj�j�Q��"ɯjR����8�QNC�6ÜŞ�A��j��-{���y�&�c �K$�.{A!"�dsS��2���j�Xud��j.(k�Y(�ag�/�:��7˪*�Nj�W�c4���YAe�6�h�Lf����ZAT���z����7Q&1���%9�����MA��h����[&=�vR�m��@믆�_2�a6άC�������V�κ��,+�vb��MbEm�LzX}��ٳ3��0f�bW3���$�=ۇ���[ja'�걅�ed�~��r�u$�
\�z�@��,m�Q_��?D���lE�k���Md�2���8��p�f{A�~}�0Z<�NQ���"�Dߛ����L�.�����_���_p�cٝ��D�]��}��墇j�u���^�S�/��s��	���X�=��7=]�%�Gp�j�8����>9���7[��"��>a�&�m�	�����-;q�����IX��^��0(��\4�Ր0d��\-i��L�E��7�]���zР�=$u-�#�CR�j���D�ݙ<~�>$�<�т�ځ8M�<�mE��&���b4��7	>���e����:tB������N��x2�|�cB;��i��Eډpx7��*a|a=��L'���I�D���ԑiOf�A_��G;l�	|��g��7MY�>)���
;m/�X�)���"�6DO.��h�.�.�͚:�Y+"�Q��VF'!1PANm��'�t�a�}�٥7��"j1vBMm�`��ݦ�?�39f) {4�vZ��O[}%�CuE��ǉ�/�"1f��w�I{x�Xe��
��h�aKp�#�P�p�'}z�O�m9"�D���$I��/�i?�7q�=�Q�1�b��Y��I�Y�cRG*a?cŒ��j�G��`�%e���I玤����nϫ�x�p���{��W�E��U$��"l0�*��wM���7?�zs!���L��[1k�l�Z.��u�lE�B�.�VS��ȅ��]0v�^�\;���Z�h�ŮN<�8:�U��>W��٠խ��kh�%l
/a[z	�e���3W�ߩ���ۻ+kFE�'��FO�>�L�^����?xЏ\<OTg���+�����a�;S�w�`~Tp�<��h{�P�.�r�%����y�����pb�U�tǅ�az%7=d��H�����(��eA.��	W��;g�,��Y�F���e��z5��&d�Ǽ��z!�6B%2W�@fV�b��rYx6B�Y��c`��AUge�	?����~uVF�\���:۵P�x4�\P��������rz �Zlo�i�L�{qp�S���2{�%��+�w�U���J4	.�G2�x�F�U���{"\�F=
�\w�A-Dt=\M\s�HM+J�8A(: �}YL�>)�"�Yg֭Z�YaK��tޙ1H��t�������hȧ�9�+{|C��k�3��5)\y����*���d��=\p�=��)i0/��xW3n_&�cKp^�fH[���n�{�v��)��'C��;G�2D^m�NP<��\��#C��۱Yb0�9("�PlT�'H�2m�:�=�!�jC�4i�SH��+�\�&~�|%���:�f=��[�NUr^դ`�>�W��+�Pn�`�yF��k���%���8]���1�������/������ά�NB v�] �7�k��x[zr��ǖ���e6�C�*v۳~Ba�S��9Cy�ċ�}���(��������V�Ws�0�}#��G�����YOxB�YK�'�svd�Ǻ�����{4���H������u��L�
�(a�G���3���+U��!�>�ѡo�f��P��U�42]]��"����r���?Y+#�~%Y%��.�!+���u�ꠟ�a�q{��ݝ/�a�6��X����[�[�#���}�?�1����p����d�Q�����;ۓ�޿N۱�^����8�=�kD�5<E�?�n{�y���Y[�b!���d"� +2| xK�0(�g��(�OU�Ί�{�bL�\��:!�_���l���y/%�S�w��G����>pC��<7�C��_�N���t��܂ZY2�h2���3�����	�Ѹ�>pC1�s��pp\I�oE;V9�Y��_���6�B��
9J���*rڵYKi�;5�%���e�6�*��O��5�̚��>��t�\�YS.���,!gnd����͠�m�O��S�u�R��
��,|XO�Y/kP��>qv��t"���1+�I��k�j��M��s���#������<)�Q����#��ܲaށw
n�q�=t�����#�L	n؏0g�u�z"{���	n�X=T�
/X	��@���N�n��:��#��:���(����:vIя�e��\/�����O����Y&������e�����e�,f��T���.ˤ@^d�R$���,��[2�뇩��]���Khvo���Jx��G��o�Yof��6V`�V���#�2��7S��Q�	)V�M��Y2���nt�V�6���SOK�E�Y��ٝ��J��|H9������C����3�O�{�Ӯ/lkr���={ǳsh�1�ZӐjl٢#�)��I׫��9s�5K�z߫Yqn�f�Ղ��v�<��6�Z{R+E����9�Z�v�f�jR���|O\�O�m�V�]���>lVR*`���m�ҢF�eq~`~��l'�V��+}���5��u�|�mUr��:������T��;f!�֝��c����L��X뻏|�g��p��BE��c}��z;m_AZ�J+�Pr�/��YɁ�J����+Б�@�r�hz�=�4��Z�E����H��9��~��	\���?� ��Y���(�HN�_���i�v�q*@�X�]�P����Q�5���
]�ʣ /�h����cˮ���ɬ��f���첖~ߏV�~�z���۝z��:-p�lKߥ�e��O�RN���X~W���99 ���˲�3�4v�ar��en^�T�,u�z�)�@�y(΂�E�	Y����/\M� xSl�Y��&S�:3���.�9q����9�c��)w�d|�.W�d�	oj�%�(МZ-�R
��"˄�h�L�"妝�K5���؅����:���e�>p9Y5`c�5��26s�:�[�A�h���&��g��X3(�ޚ���f��f?\��GK����9��vQ��A̓&��X�8�����<t��琲,�	� J ��'���˚Y�|�?쬝�n��޽�Q��w�^Tu�U�裮���*d]gM�_�]�kd9��B
p�����B̊
����CU�f��²f�'�%�[&#�����σJ]��}�KD�      �	   
   x���          �	   �   x�eN]k�0}�W�7[�#�vR��C��ھ�,��BM$*�����`p��{>.�jN�����0�պ�0�#$ZT���&��$��A�aO`�w�[c	�A��G�i��� ��(p
DO�P6�a1(qD�I��:X�=���������n�R���	6�@\���ϲk�2&М��k,�_�iƟ���;����'�'��E@B�"��_s,+�]���g`v�~�oߢ(���Z�      �	   D   x���v
Q���W(Ό/H�,V��L�Q���M*J�Ts�	uV�0�QPs�s�
u�qT״��� %by      �	   +  x��]��0@��}ҙD�����*��e���'R�j3@�����wG�fv6�4��p{)�s�wL�`���t�
��b/�,ЅH��5�Ҕm�qǆ�R�QX�u,d~��dQ*�Xq��6�d""��<^�H�F��"�D3��Ef�<�G84$S���]&���Y��*�}ƕDY�����$T�_�� ]4K�3������_#��꽃��,�z'9	ٷ���C:�|��N/۞���;t�Kji2�+����u
W�ES������gN�_�۷5S���6���۷�%N$�,o��In��qNq��N�\��E~5���<f��t���������)pg��wO����U�{x�ϫU��Ea�i��G��ذ��t�?�NdÌL����v,��Y^��%���B�)H*0!�P��
b= 񉡹}^HDR�Kt��ӌWq}����nu��ѯkt��|�<'��8;<�,!�O�د(g�
�����x8����@�z~���f�J�Lz@L�\*VJ%�;��IF�W�U����x3�"����       �	   �   x���M�0��~Enn0����SY�,�V�ͫ�6��N���^=H�Brx^H�.�V ue����n8�sw�е1\��q�����;�}��u'�P���K�FZ�B�-W#�,Iǌj�e��i6a�ԵR�*�?J�~x�'�q��Z����X���8�9nsi�g{��͆�ōgzI��r��ozJ\Ε\���g�_�A� .      �	      x���Ok�0������0�����K�d{�^J�dŰ.#���\�.�������H[�H;S�~������0�|�ױ�O���5	؍}�C��.����K�K��,9ӬHy����F&og�W�o]<t^���ᘖF���D�PK���_'��׍3J���,�}E!�7	U�3�8�4��R��D�+ژ&~��dj�T� d�K ?<�1z�ӂ��mpl*�R�D%�����Ɂ(�O�E���0�      �	   �   x����J1��>�k9do��]K d��z-�$��)I�����MC�`>�t�h �������m�XG�>�#��.#�O��	��g?�ц8��C&�e��M~t5}�[���~�'.�Nc��Z�-����[��C��k#���ef���bw���4�#� �ۿ�m��2֟�w�䆃1���/ve�?0:);����͗Ԛ~�h��H�M      �	     x���n�0��y
��J��6?�L��i�*]t�<؉,%82��C��:�&R��.>���ǕgQ&K0��1�U��������P"�պ�k��@!E^���iD���*i�Fn�J��+��r���LB���ʒJ�|�7���d���;��NȺ�Bwr�/U�vJ���JȒ^��fkҚe;~�g#�����PN[_�f�|��.t�ps.�i�!r*�����=��mN��|as��Jv��j�V�0���Y��;�Q�X��+r1q1������4L���g&�ῶ��"<�x�}�X�� ��bI���j���W�%�aI���I�S�8�&�%R� ���6�>�ޑʳ5ھg~��7f��Y�c�Ì@F{���4KAO����]"��f��ڈz�G��"@?p��f�R�ܰ�6li[����y=l_��d'�%����0�J)c���4N��鏧x�<�-�I������%m�u� Q1���:�e=l1�����t�����DL�l�0��s ����(�      �	   �  x�͔�n�0��y��K+��s�)���H��l"JH�R�>��%Mz]"Y�s1��Q��%D�2�F�����v\�z�΋���u�WO����v�uaAu��s�몴 ��l�w�Fou~�/�6k�MW�]b[����.u��h���K���~���.���\��ߦ�<L�6M�i0�ī٬+G�p�� �,��6��p[	�7���8<���׿F� ����E8]�7�W�]�]��$$���Ӆx1X�Ώ�]LP���Bd����?�n��ѿ���>�ܟYሃ�J���D���ox�`yx��H�nB��_��q؊E>s�'���8�8�������@o��w�k�'Z�5�2�����bH~w�}����*�LJW�W�%�w��1�Wc���I��2#g|	�P:k���0qF�K�~�1�Ƈ���c��9}�6{lz��)�y�H�F���0P      �	   
   x���          �	   
   x���          �	   �  x���n�0��}
��Jy�?���z�Tu�m�Wd� %!���>�S(!I��ݔQ�a��3��w��ߟ����7R�q�%�.ɋ-��Ӏ�i�d�}Y�6)vy�j�*KV��U�n���H�d_���VE�۴����[㺪m���7Y�/�8�>�ز��ɪ���Us���eN�˪"��K�}�~���ko�K褕s��fB�]]f�l��ӬzW�gI���7E��䉗��Ǜ�V����5[�I�6�dU�dn�e��[����+��!?��?�>�k�< ����^v�R�%eK
�*�Pj!�K�����3�Ew������8qB�!gT�h�Cv���7_��f�>)5@
�T(�Ț$sm C&��,Rxk-]���<�3:�:�G�ɦ6��%"�f猷��+���t� �#�. ���0f@� ����9���h_vfn&�<1��`�17�irC!�\*��ak���2i��4B%Ż����Դ���h��g�2� m�Ԭ���L���]G��5��BJ�֪����`�
S����ib��)�بo�쫆K�E�����j�d����F������XW�������#�?��S��<)CuH9UO|�.f���I�z�$����O�6G!���:@
/�餷���ɀYD%��3�RWW�4:8�      �	   
   x���          �	   �   x�ő�j�0E����%�ȏ����"�q!�n�"�̀,�.�_߉q6�!�ܹg���ow���x<9%F筇%����N�����@kn�;q�/e�@1�S\R��rr�]���9n��LCX�F����*xu���S��NY�F,��XYe�U��EY�Oe��*ck�M�z	��O��U�3�3�����yyV��GcgD�14ͣ�`����L��e�fs�����)��v����ZA�ȵ�      �	   O  x��Y�N�:��)�ؕ�n����9���*��Z�[4MXJc��T���>�y�3�'�Eګ��*4v~�����x�\�V�0_�^����ŅTBݳ��[�|�IxR_�@&��:��T�<�b�ib�0��[�����Mw�5|�;@���{~�
�\�Ҩ1�k��]/�z�Ɠp8�z�Ѡ?w�hzt��n��|v4�#��\d�D�2,Qף�,�i���Q���?+����G�z����a G��1�Yj �lA�-��n�M��*g[���W�r~"0.rv��3k�
]XϿ����_���X<�8��܊����\0��DƊ)&w��UO߮���%�`�{Q���a\2� ��i*�LJ![�?�؋ �g�4J9��'�}fR�ޘ��a�3,�'z�X�D/��0"�c��L5��(��aR�U��]�|'�V��J�r�Ni�伹�EZcC+��<~B�E��~2:���n5G���k&;�M��;����1��R���ʤJ����u��.�:}/�1�h}W�@���2�d3E���4���
�&���3�-�ͧ�)L��n��-og��o�Л�߁�W%����d����l�І5�)b�ږ�ڨF�b�B�L�m�o���$ �ao����b�_�>�����'� x��D!
'��7�hDa`)�LE\[NZ�:�)-@��d6Wяw�u�nL'!�[:�(q���؁������sSħ��a෼L�@n����I�A#�1{��&3�����I�6E^0���efJ2k;	:z�"�T)3��ie:�y�X;�y��#L�R�w�)�������C'��?���+C�6CV��n8:ld/{����:G�&\ϓa���y��8����s-1�/v�cg�%�9h�n1f�$�N¶i�eE댨B�=*r��j/����⹬��N��="Uu���-���nѥ�-��D?L���|ө����x��P�F�.x���WUG��&��R.C`[�s	���[��?�OϏM/��i���Z�l�]yL���(I�Y�Nm��[4�j�r2����$�9��-�)���y����D�FH���Wg?z�I_�#��M�U+�M�ζ�޻�?:� ��+      �	   -  x�՜�N#9��<Eߘ�B�*W������i�2Iv	�Q����m�pͅv_�$5	A�(����27w_�����}��N����y8u��Uw�=m��o��i�~�����&���^��������q���6������s�͏�����_2|?��������m����^��������0~���ϟ�o׷�_�Oa��q\>���wp������1?_�g��9���oo�[�����+:�+�W�;��q�q�(x���]N������>���q&��slӪ�q��{{�a~�1���#o��3�c1?`�}�d��;��43�şT���K�|3�!��8��_O�����AN}�;��vХFoI��у�%/p�޲�G�3�c��iK�S���`g��T����	=�t��۳\A�uj�o������/v�	���J?-� F;�b����{a��v�u��K�9
�Iy��d�1/�a" �)p���'>���@��Pa�Ʊp��г�\�j�e���Dǆ�ZP>N;���#Pf�I�8��%�����:�7ӗT�B@;�W�^8��&ݧ����w���v�I�)b2Oʼk�/�O�6vB���'���l����k��S�]L�{�S+z��� lYA����ǔG@��Ğ��y��S�#)��r����K�����R'���?%�<۱s �'�^f&=���u�k����B;�'��^3}Iz�N씹"u�k�/I�Bd;��k�Ef�B�♡G_뾝~�=E�T�Z���E������H�u�L_t/Dގ�qn�y�����L�9C�7H����'��d�ڡX뾙��#;;+��Z���E�ѥh'���O3u��"׺o��ts�c��R��f����v�-I����S`�S퀨KN�zf)?0��AQ�Z�'����ةV�v����q��W����D���׍�����lUd�
����nUl�/7\g�?�����e�{p��ǉ�Yt��l�dv�.V����G�ԲT���2�)���xu��xf��M?9;^'����e��`�����1�<�������������yu��톙G-��c�~9wv�����mz�L�[<x�3�Y9��K��Տ�ݯW�'h�f:�r��f��� ����PC�W�j�gz_"$���O�������|�e'�y������L�G"X������/W�f��%׾������
μ��$٩~H��@�ώ3�q���_���W��7����n��������C��`S���~cq�fr��vk����0�{ߵxT�"�$y��?/(�]..�'ʣa      �	   K  x���Mk�0��{>�ni�ңw�4F��A��<�C��矆�f�H���H�C��x�yz>����\��<��f�П*ҟ�mw���ش�[?V�2ߧ��oC7��ܿ�mw���v�H;u��O��ѷ�<�o�w�O/�W*�>���������<��)��8l�� #\���((i��0Y�ܿ�v��V����%�a�-�K3M���R�Gj�j.�4�(����}���U`>�Cs�{Y��P����ZG���Ʈ6��hi�-Xɛ�.�w��:� ԜE씄�`���h
6D씈�`{�̪����e�r�N�
�
ꌎ�`눝�l�A��;�#(����:b�sڔ|��D'e�tNE�!R'E�ZuNC�e�NJ�'댂�9�8[��R}?!H�&����m#��� a��N��`�~F���ښ��pA��LU�R��j�A��;�#(�*�3:���#vJGP����u�P%�q%�v�N��蜊�WK��"�@̓:�!����@ퟎ.�  �f��G�T�$�ZuFCP�u�N�
�	쌊�`ۈ���٫�/�U��      �	   
   x���          �	   �  x���o�0���W�����8Ώ�4@�R��
?$x��ĥ� av����s-l�iS�E���ޝu��)�`$#F1��]-k&�R��<k��\��l��<+[ �Y�`-���GvW�4_漨ԉ��Ժ�W²���P�,<M�h��/�CY(_�|�t��&���<�6��j����{�K�^T���ci�e�	L�h����7~��\��8�~/nlD�~�=G���7�7/p�i4vz"��б�]�B�2���߷�V���:� ��"L�(�wi��y�s�_%�?JB����$h�0D�q� BO�mH<��6� !�`ϴD���WM%j���l�O���ӀJU�A�fMUϯƳ����N7�#@���w��.��2�4��8�� d���'V5���aS�aM4V�R�tm�յU��6D���r�uG������N�n��ga#����W� ����� �����&������W�`�9;�H��Y�Y��>�uWu��<~Ⲗ��D>���%��r�*�3#-�5�Cڇ7��R�t.Q�����W�V��/(B�����-Á�A���7������8����mS�$�W�[�?���/E�ށ�>��h��f�cBE'���ޯ���A4��6\�$�*�M����H3�R�}�t)�*]��\��4~sb��k�L�{\�����a�5�t3�,נ�%��0?;���$H      �	   
  x��ұj�0�=Oq[���$�ju��`\h����������(Mڴ�vr��ç�+���iE�z�!l�ñ��aؼv�6�f���K��ݾn�����������?�a������\/�0Cי�B�e�A)�&S�k5P��r~?)�@iqH��E�M(��!^m�^�7,�.���&������G<i�ʲ2�Ҫ`��������UC^;�ll>r���p�ˍ~�\�ӷ��dJ���t�^oY�!k�G��$���O<��X#      �	   `  x����K�0 ����ܺA^>�/O��06'�M�#��::�M��Mg'�AaLI���J~��e�H'�K4],oѾ\��2;V��<D��f6D[۴]VWu�:��Y�[�~��]�]S�����Pw!�����ػ����[��y�Tfn<B�|5Iѐ�(H�q�nt��-V��oπ�ЈjD�!�P�I���pà{��j0�W#댄��Fn�`�Hό����q�y�����1�~��FA��kLb���(z��g#����{�G��ir����ȵ+;�	-|3���I�z�a.��c�j�>�E:�dn������5���ۼ2fH������v�U w���Y��P�|Go�kK     