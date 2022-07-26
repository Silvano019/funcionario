PGDMP     
    :    
            z         	   teste_wle    10.21    10.21                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    24576 	   teste_wle    DATABASE     �   CREATE DATABASE teste_wle WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';
    DROP DATABASE teste_wle;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    24590    dependentes    TABLE     �   CREATE TABLE public.dependentes (
    id_dependente integer NOT NULL,
    id_reponsavel integer NOT NULL,
    nome character varying(60),
    ativo character varying(3) DEFAULT 'Sim'::character varying
);
    DROP TABLE public.dependentes;
       public         postgres    false    3            �            1259    24586    dependentes_id_dependente_seq    SEQUENCE     �   CREATE SEQUENCE public.dependentes_id_dependente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.dependentes_id_dependente_seq;
       public       postgres    false    3    200                       0    0    dependentes_id_dependente_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.dependentes_id_dependente_seq OWNED BY public.dependentes.id_dependente;
            public       postgres    false    198            �            1259    24588    dependentes_id_reponsavel_seq    SEQUENCE     �   CREATE SEQUENCE public.dependentes_id_reponsavel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.dependentes_id_reponsavel_seq;
       public       postgres    false    200    3                       0    0    dependentes_id_reponsavel_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.dependentes_id_reponsavel_seq OWNED BY public.dependentes.id_reponsavel;
            public       postgres    false    199            �            1259    24579    funcionarios    TABLE       CREATE TABLE public.funcionarios (
    id_funcionario integer NOT NULL,
    nome character varying(60),
    endereco character varying(60),
    cidade character varying(60),
    estado character varying(2),
    ativo character varying(3) DEFAULT 'Sim'::character varying
);
     DROP TABLE public.funcionarios;
       public         postgres    false    3            �            1259    24577    funcionarios_id_funcionario_seq    SEQUENCE     �   CREATE SEQUENCE public.funcionarios_id_funcionario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.funcionarios_id_funcionario_seq;
       public       postgres    false    3    197                       0    0    funcionarios_id_funcionario_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.funcionarios_id_funcionario_seq OWNED BY public.funcionarios.id_funcionario;
            public       postgres    false    196            x
           2604    24593    dependentes id_dependente    DEFAULT     �   ALTER TABLE ONLY public.dependentes ALTER COLUMN id_dependente SET DEFAULT nextval('public.dependentes_id_dependente_seq'::regclass);
 H   ALTER TABLE public.dependentes ALTER COLUMN id_dependente DROP DEFAULT;
       public       postgres    false    198    200    200            y
           2604    24594    dependentes id_reponsavel    DEFAULT     �   ALTER TABLE ONLY public.dependentes ALTER COLUMN id_reponsavel SET DEFAULT nextval('public.dependentes_id_reponsavel_seq'::regclass);
 H   ALTER TABLE public.dependentes ALTER COLUMN id_reponsavel DROP DEFAULT;
       public       postgres    false    199    200    200            v
           2604    24582    funcionarios id_funcionario    DEFAULT     �   ALTER TABLE ONLY public.funcionarios ALTER COLUMN id_funcionario SET DEFAULT nextval('public.funcionarios_id_funcionario_seq'::regclass);
 J   ALTER TABLE public.funcionarios ALTER COLUMN id_funcionario DROP DEFAULT;
       public       postgres    false    197    196    197            �
          0    24590    dependentes 
   TABLE DATA               P   COPY public.dependentes (id_dependente, id_reponsavel, nome, ativo) FROM stdin;
    public       postgres    false    200   �       �
          0    24579    funcionarios 
   TABLE DATA               ]   COPY public.funcionarios (id_funcionario, nome, endereco, cidade, estado, ativo) FROM stdin;
    public       postgres    false    197   X       	           0    0    dependentes_id_dependente_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.dependentes_id_dependente_seq', 10, true);
            public       postgres    false    198            
           0    0    dependentes_id_reponsavel_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.dependentes_id_reponsavel_seq', 1, false);
            public       postgres    false    199                       0    0    funcionarios_id_funcionario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.funcionarios_id_funcionario_seq', 9, true);
            public       postgres    false    196            ~
           2606    24597    dependentes dependentes_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.dependentes
    ADD CONSTRAINT dependentes_pkey PRIMARY KEY (id_dependente);
 F   ALTER TABLE ONLY public.dependentes DROP CONSTRAINT dependentes_pkey;
       public         postgres    false    200            |
           2606    24585    funcionarios funcionarios_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id_funcionario);
 H   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
       public         postgres    false    197            
           2606    24598 *   dependentes dependentes_id_reponsavel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.dependentes
    ADD CONSTRAINT dependentes_id_reponsavel_fkey FOREIGN KEY (id_reponsavel) REFERENCES public.funcionarios(id_funcionario);
 T   ALTER TABLE ONLY public.dependentes DROP CONSTRAINT dependentes_id_reponsavel_fkey;
       public       postgres    false    2684    200    197            �
   �   x�=�M
�@��urq�O�D����M@�Pg"3��ۈ�.<E.f������8��O�[�XX�k������x����`E��5�L(ls�.��j#^����*��!/��/pJr�������,%���te	P�Kp?@��4      �
   �   x�}�MN�0F��S�	���%���R��$$6��jG�4�Yp��z1��������}z���L�·�Oz�2���Ȼo��/��.��9�Y\�;?m�8nJ�:���:4���V�����h,A�_�Bt�к��˘�,�
��q �/�I,����$�T���Նzٳ����x�,�
O�6��ĵ`#����:?T����w�M�)�Zm��ר��-����#��vb��I���     