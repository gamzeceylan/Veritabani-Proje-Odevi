--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Hastane; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Hastane" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';


ALTER DATABASE "Hastane" OWNER TO postgres;

\connect "Hastane"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: doktor_dondur(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.doktor_dondur(prmt character varying) RETURNS TABLE(doktortcno character varying, doktorad character varying, doktorsoyad character varying, doktorbolum character varying)
    LANGUAGE plpgsql
    AS $$
begin
		return query
		select
		tcno,
		ad,
		soyad,
		bolum
FROM doktor
WHERE ad like prmt;
end; $$;


ALTER FUNCTION public.doktor_dondur(prmt character varying) OWNER TO postgres;

--
-- Name: ekledoktor(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ekledoktor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into calisan (id, tcno, calisanadi, calisansoyadi, konum)
	values (new.doktorid, new.tcno, new.ad, new.soyad,'Doktor');
return new;
end;
$$;


ALTER FUNCTION public.ekledoktor() OWNER TO postgres;

--
-- Name: eklehemsire(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.eklehemsire() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
/*declare 
	@id integer;
	@htcno varchar;
	@calisanadi varchar;
	@calisansoyadi varchar;
	@konum varchar; */
begin

/*select 
	hemsireid ,
	 tcno ,
	 hemsireadi ,
	hemsiresoyadi 
	from hemsire order by hemsireid desc limit 1;
	
/*	id= hemsireid;
	htcno =  tcno ;
	calisanadi =  hemsireadi;
	calisansoyadi = hemsiresoyadi; 
	konum = ('Hemşire'); */
	*/
insert into calisan (id, tcno, calisanadi, calisansoyadi, konum)
	values (new.hemsireid, new.tcno, new.hemsireadi, new.hemsiresoyadi,'Hemşire');
return new;
end;
$$;


ALTER FUNCTION public.eklehemsire() OWNER TO postgres;

--
-- Name: eklepersonel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.eklepersonel() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into calisan (id, tcno, calisanadi, calisansoyadi, konum)
	values (new.personelid, new.tcno, new.personeladi, new.personemsoyadi,'Personel');
return new;
end;
$$;


ALTER FUNCTION public.eklepersonel() OWNER TO postgres;

--
-- Name: hasta_dondur(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hasta_dondur(prmt character varying) RETURNS TABLE(hastatcno character varying, hastaad character varying, hastasoyad character varying, hastatelefon character varying, hastadres character varying)
    LANGUAGE plpgsql
    AS $$
begin
		return query
		select
		tcno,
		ad,
		soyad,
		telefon,
		adres
FROM hasta
WHERE ad like prmt;
end; $$;


ALTER FUNCTION public.hasta_dondur(prmt character varying) OWNER TO postgres;

--
-- Name: hemsire_dondur(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hemsire_dondur(prmt character varying) RETURNS TABLE(hemsitetcno character varying, hemsiread character varying, hemsiresoyad character varying, hemsirebolum character varying)
    LANGUAGE plpgsql
    AS $$
begin
		return query
		select
		tcno,
		hemsireadi,
		hemsiresoyadi,
		bolumadi
		
FROM hemsire
WHERE hemsireadi like prmt;
end; $$;


ALTER FUNCTION public.hemsire_dondur(prmt character varying) OWNER TO postgres;

--
-- Name: personel_dondur(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personel_dondur(prmt character varying) RETURNS TABLE(personeltcno character varying, departman integer, ad character varying, soyad character varying)
    LANGUAGE plpgsql
    AS $$
begin
		return query
		select
		tcno,
		departmanid,
		personeladi,
		personemsoyadi
FROM personel
WHERE personeladi like prmt;
end; $$;


ALTER FUNCTION public.personel_dondur(prmt character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bolum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bolum (
    bolumid integer NOT NULL,
    bolumadi character varying(50)
);


ALTER TABLE public.bolum OWNER TO postgres;

--
-- Name: bolum_bolumid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bolum_bolumid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bolum_bolumid_seq OWNER TO postgres;

--
-- Name: bolum_bolumid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bolum_bolumid_seq OWNED BY public.bolum.bolumid;


--
-- Name: calisan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calisan (
    id integer NOT NULL,
    tcno character varying(11),
    calisanadi character varying(10),
    calisansoyadi character varying(15),
    konum character varying(20)
);


ALTER TABLE public.calisan OWNER TO postgres;

--
-- Name: departman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departman (
    departmanid integer NOT NULL,
    departmanadi character varying(45)
);


ALTER TABLE public.departman OWNER TO postgres;

--
-- Name: departman_departmanid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departman_departmanid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departman_departmanid_seq OWNER TO postgres;

--
-- Name: departman_departmanid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departman_departmanid_seq OWNED BY public.departman.departmanid;


--
-- Name: doktor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doktor (
    doktorid integer NOT NULL,
    tcno character varying(11),
    ad character varying(10),
    soyad character varying(15),
    bolum character varying(45),
    unvan character varying(10),
    sifre character varying(10)
);


ALTER TABLE public.doktor OWNER TO postgres;

--
-- Name: hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hasta (
    hastaid integer NOT NULL,
    tcno character varying(11),
    ad character varying(10),
    soyad character varying(15),
    telefon character varying(11),
    adres character varying(50)
);


ALTER TABLE public.hasta OWNER TO postgres;

--
-- Name: hastailac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hastailac (
    hastaid integer NOT NULL,
    ilacid integer NOT NULL
);


ALTER TABLE public.hastailac OWNER TO postgres;

--
-- Name: hemsire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hemsire (
    hemsireid integer NOT NULL,
    tcno character varying(11),
    hemsireadi character varying(10),
    hemsiresoyadi character varying(15),
    bolumadi character varying(45)
);


ALTER TABLE public.hemsire OWNER TO postgres;

--
-- Name: ilac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilac (
    ilacid integer NOT NULL,
    ilacadi character varying(20)
);


ALTER TABLE public.ilac OWNER TO postgres;

--
-- Name: ilac_ilacid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilac_ilacid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ilac_ilacid_seq OWNER TO postgres;

--
-- Name: ilac_ilacid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ilac_ilacid_seq OWNED BY public.ilac.ilacid;


--
-- Name: kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kullanici (
    kullaniciid integer NOT NULL,
    tcno character varying(11) NOT NULL,
    sifre character varying(10)
);


ALTER TABLE public.kullanici OWNER TO postgres;

--
-- Name: muayne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muayne (
    muayneid integer NOT NULL,
    randevuid integer,
    aciklama character varying(200)
);


ALTER TABLE public.muayne OWNER TO postgres;

--
-- Name: muayne_muayneid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.muayne_muayneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muayne_muayneid_seq OWNER TO postgres;

--
-- Name: muayne_muayneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.muayne_muayneid_seq OWNED BY public.muayne.muayneid;


--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    personelid integer NOT NULL,
    tcno character varying(11),
    departmanid integer,
    personeladi character varying(10),
    personemsoyadi character varying(15)
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.randevu (
    randevuid integer NOT NULL,
    hasta_id integer,
    bolum character varying(45),
    doktor character varying(20),
    tarih date,
    saat time without time zone,
    doktor_id integer
);


ALTER TABLE public.randevu OWNER TO postgres;

--
-- Name: randevu_randevuid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.randevu_randevuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.randevu_randevuid_seq OWNER TO postgres;

--
-- Name: randevu_randevuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.randevu_randevuid_seq OWNED BY public.randevu.randevuid;


--
-- Name: recete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recete (
    receteid integer NOT NULL,
    hastaid integer,
    ilacid integer,
    doktorid integer
);


ALTER TABLE public.recete OWNER TO postgres;

--
-- Name: recete_receteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recete_receteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recete_receteid_seq OWNER TO postgres;

--
-- Name: recete_receteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recete_receteid_seq OWNED BY public.recete.receteid;


--
-- Name: unvanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unvanlar (
    unvanid integer NOT NULL,
    doktorid integer,
    unvanadi character varying(40)
);


ALTER TABLE public.unvanlar OWNER TO postgres;

--
-- Name: yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yonetici (
    yoneticiid integer NOT NULL,
    tcno character varying(11),
    yoneticiadi character varying(10),
    yoneticisoyadi character varying(15)
);


ALTER TABLE public.yonetici OWNER TO postgres;

--
-- Name: bolum bolumid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolum ALTER COLUMN bolumid SET DEFAULT nextval('public.bolum_bolumid_seq'::regclass);


--
-- Name: departman departmanid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departman ALTER COLUMN departmanid SET DEFAULT nextval('public.departman_departmanid_seq'::regclass);


--
-- Name: ilac ilacid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilac ALTER COLUMN ilacid SET DEFAULT nextval('public.ilac_ilacid_seq'::regclass);


--
-- Name: muayne muayneid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayne ALTER COLUMN muayneid SET DEFAULT nextval('public.muayne_muayneid_seq'::regclass);


--
-- Name: randevu randevuid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu ALTER COLUMN randevuid SET DEFAULT nextval('public.randevu_randevuid_seq'::regclass);


--
-- Name: recete receteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete ALTER COLUMN receteid SET DEFAULT nextval('public.recete_receteid_seq'::regclass);


--
-- Data for Name: bolum; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bolum VALUES
	(1, 'Dahiliye'),
	(2, 'Genel Cerrahi'),
	(3, 'İç Hastalıklar'),
	(4, 'Psikiyatri'),
	(5, 'Üroloji'),
	(6, 'Nörolaji'),
	(7, 'Göğüs Cerrahisi'),
	(8, 'Cildiye'),
	(10, 'Kardiyoloji');


--
-- Data for Name: calisan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.calisan VALUES
	(1, '11111111111', 'Nusret', 'Yılmaz', 'Doktor'),
	(2, '22222222222', 'Beyza', 'Yılmaz', 'Doktor'),
	(3, '33333333333', 'Kerem', 'Yavuz', 'Doktor'),
	(5, '55555555555', 'Zeynep', 'Şanver', 'Yönetici'),
	(6, '66666666666', 'Gamze', 'Ceylan', 'Yönetici'),
	(7, '77777777777', 'Önder', 'Demircan', 'Hemşire'),
	(8, '88888888888', 'Gül', 'Toksöz', 'Hemşire'),
	(9, '99999999999', 'Zeynep', 'Aslan', 'Personel'),
	(10, '12222222222', 'Öznur', 'Tütüncü', 'Personel'),
	(11, '13333333333', 'Sena', 'Atabek', 'Personel'),
	(4, '44444444444', 'Burak', 'Yılmaz', 'Doktor'),
	(20, '12345642109', 'Metin', 'Gür', 'Doktor'),
	(25, '34567089843', 'Rasim', 'Saklı', 'Doktor'),
	(26, '11223344556', 'Melih', 'Yavuz', 'Doktor'),
	(19, '55667788990', 'Melek', 'Güzel', 'Hemşire');


--
-- Data for Name: departman; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departman VALUES
	(1, 'Bilgi İşlem'),
	(2, 'Güvenlik'),
	(3, 'Temizlik'),
	(4, 'Labaratuvar'),
	(5, 'Döner Sermaye'),
	(6, 'Morg Hizmetleri'),
	(7, 'Sağlık');


--
-- Data for Name: doktor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.doktor VALUES
	(1, '11111111111', 'Nusret', 'Yılmaz', 'Dahiliye', 'Uzman', 'aaaa'),
	(2, '22222222222', 'Beyza', 'Yılmaz', 'İç hastalıklar', 'Uzman', 'bbbb'),
	(3, '33333333333', 'Kerem', 'Yavuz', 'Dahiliye', 'Uzman', 'cccc'),
	(4, '44444444444', 'Burak', 'Yılmaz', 'Nöroloji', 'Uzman', 'dddd'),
	(20, '12345642109', 'Metin', 'Gür', 'İç Hastalıklar', 'Uzman', 'asdf'),
	(25, '34567089843', 'Rasim', 'Saklı', 'Genel Cerrahi', 'Uzman', 'asdf'),
	(26, '11223344556', 'Melih', 'Yavuz', 'Genel Cerrahi', 'Uzman', 'asdf');


--
-- Data for Name: hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hasta VALUES
	(13, '15555555555', 'Gürol', 'Müslü', '05455679654', 'Sakarya/Korucuk'),
	(14, '16666666666', 'Gülşah', 'Çetin', '05444369863', 'Sakarya/Kaynarca'),
	(15, '17777777777', 'Nil', 'Yıldız', '05434977843', 'Sakarya/Hendek'),
	(16, '18888888888', 'Rukiye', 'Savaş', '05444767843', 'Sakarya/Arifiye'),
	(17, '19999999999', 'Serdar', 'Bağlı', '05678367843', 'Sakarya/Serdivan'),
	(18, '21111111111', 'Tezcan', 'Kale', '05444367843', 'Sakarya/Korucuk'),
	(12, '14444444444', 'Melih', 'Yılar', '05456789876', 'Sakarya/Serdivan');


--
-- Data for Name: hastailac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hastailac VALUES
	(12, 1),
	(13, 2),
	(14, 1),
	(15, 6);


--
-- Data for Name: hemsire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hemsire VALUES
	(7, '77777777777', 'Önder', 'Demircan', 'Dahiliye'),
	(8, '88888888888', 'Gül', 'Toksöz', 'Dahiliye'),
	(19, '55667788990', 'Melek', 'Güzel', 'İç Hastalıklar');


--
-- Data for Name: ilac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilac VALUES
	(1, 'Madacasol'),
	(2, 'Benical'),
	(3, 'Cleosin'),
	(4, 'Parol'),
	(5, 'Sinecod'),
	(6, 'Brodil');


--
-- Data for Name: kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kullanici VALUES
	(1, '11111111111', 'aaaa'),
	(2, '22222222222', 'bbbb'),
	(3, '33333333333', 'cccc'),
	(5, '55555555555', 'eeee'),
	(6, '66666666666', 'ffff'),
	(7, '77777777777', 'gggg'),
	(8, '88888888888', 'hhhh'),
	(9, '99999999999', 'iiii'),
	(10, '12222222222', 'jjjjj'),
	(11, '13333333333', 'kkkkk'),
	(13, '15555555555', 'aaaa'),
	(14, '16666666666', 'aaaa'),
	(15, '17777777777', 'aaaa'),
	(16, '18888888888', 'aaaa'),
	(17, '19999999999', 'aaaa'),
	(18, '21111111111', 'aaaa'),
	(4, '44444444444', 'dddd'),
	(12, '12343235678', 'asdf'),
	(20, '12345642109', 'asdf'),
	(25, '34567089843', 'asdf'),
	(26, '11223344556', 'asdf');


--
-- Data for Name: muayne; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel VALUES
	(9, '99999999999', 1, 'Zeynep', 'Aslan'),
	(10, '12222222222', 4, 'Öznur', 'Tütüncü'),
	(11, '13333333333', 4, 'Sena', 'Atabek');


--
-- Data for Name: randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.randevu VALUES
	(1, 12, 'Dahiliye', 'Nusret Yılmaz', '2020-10-05', '12:30:00', 2),
	(2, 13, 'İç Hastalıklar', 'Beyza Yılmaz', '2020-10-05', '12:30:00', 3),
	(4, 15, 'Dahiliye', 'Kerem Yavuz', '2020-10-05', '12:30:00', 3),
	(5, 12, 'Dahiliye', 'Nusret Yılmaz', '2020-10-05', NULL, 2),
	(6, 12, 'İç Hastalıklar', 'Beyza Yılmaz', '2020-12-30', NULL, 2);


--
-- Data for Name: recete; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recete VALUES
	(1, 12, 1, 1),
	(2, 13, 2, 3),
	(3, 14, 1, 4),
	(4, 15, 6, 1);


--
-- Data for Name: unvanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unvanlar VALUES
	(1, 1, 'Uzman'),
	(2, 2, 'Uzman'),
	(3, 3, 'Uzman'),
	(4, 4, 'Uzman');


--
-- Data for Name: yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yonetici VALUES
	(5, '55555555555', 'Zeynep', 'Şanver'),
	(6, '66666666666', 'Gamze', 'Ceylan');


--
-- Name: bolum_bolumid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bolum_bolumid_seq', 1, false);


--
-- Name: departman_departmanid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departman_departmanid_seq', 1, false);


--
-- Name: ilac_ilacid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilac_ilacid_seq', 1, false);


--
-- Name: muayne_muayneid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.muayne_muayneid_seq', 1, false);


--
-- Name: randevu_randevuid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.randevu_randevuid_seq', 2, true);


--
-- Name: recete_receteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recete_receteid_seq', 1, false);


--
-- Name: bolum bolum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolum
    ADD CONSTRAINT bolum_pkey PRIMARY KEY (bolumid);


--
-- Name: calisan calisan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calisan
    ADD CONSTRAINT calisan_pkey PRIMARY KEY (id);


--
-- Name: departman departman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departman
    ADD CONSTRAINT departman_pkey PRIMARY KEY (departmanid);


--
-- Name: doktor doktor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doktor
    ADD CONSTRAINT doktor_pkey PRIMARY KEY (doktorid);


--
-- Name: hasta hasta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT hasta_pkey PRIMARY KEY (hastaid);


--
-- Name: hastailac hastailac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hastailac
    ADD CONSTRAINT hastailac_pkey PRIMARY KEY (hastaid, ilacid);


--
-- Name: hemsire hemsire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hemsire
    ADD CONSTRAINT hemsire_pkey PRIMARY KEY (hemsireid);


--
-- Name: ilac ilac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilac
    ADD CONSTRAINT ilac_pkey PRIMARY KEY (ilacid);


--
-- Name: kullanici kullanici_kullaniciid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_kullaniciid_key UNIQUE (kullaniciid);


--
-- Name: kullanici kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_pkey PRIMARY KEY (kullaniciid, tcno);


--
-- Name: kullanici kullanici_tcno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_tcno_key UNIQUE (tcno);


--
-- Name: muayne muayne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayne
    ADD CONSTRAINT muayne_pkey PRIMARY KEY (muayneid);


--
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (personelid);


--
-- Name: randevu randevu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_pkey PRIMARY KEY (randevuid);


--
-- Name: recete recete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_pkey PRIMARY KEY (receteid);


--
-- Name: unvanlar unvanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unvanlar
    ADD CONSTRAINT unvanlar_pkey PRIMARY KEY (unvanid);


--
-- Name: yonetici yonetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_pkey PRIMARY KEY (yoneticiid);


--
-- Name: doktor doktoreklendiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER doktoreklendiginde AFTER INSERT ON public.doktor FOR EACH ROW EXECUTE FUNCTION public.ekledoktor();


--
-- Name: hemsire hemsireeklendiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hemsireeklendiginde AFTER INSERT ON public.hemsire FOR EACH ROW EXECUTE FUNCTION public.eklehemsire();


--
-- Name: personel personeleklendiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER personeleklendiginde AFTER INSERT ON public.personel FOR EACH ROW EXECUTE FUNCTION public.eklepersonel();


--
-- Name: doktor doktor_doktorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doktor
    ADD CONSTRAINT doktor_doktorid_fkey FOREIGN KEY (doktorid) REFERENCES public.kullanici(kullaniciid);


--
-- Name: hasta hasta_hastaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT hasta_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.kullanici(kullaniciid);


--
-- Name: hastailac hastailac_hastaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hastailac
    ADD CONSTRAINT hastailac_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.hasta(hastaid);


--
-- Name: hastailac hastailac_ilacid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hastailac
    ADD CONSTRAINT hastailac_ilacid_fkey FOREIGN KEY (ilacid) REFERENCES public.ilac(ilacid);


--
-- Name: muayne muayne_randevuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayne
    ADD CONSTRAINT muayne_randevuid_fkey FOREIGN KEY (randevuid) REFERENCES public.hasta(hastaid);


--
-- Name: personel personel_departmanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_departmanid_fkey FOREIGN KEY (departmanid) REFERENCES public.departman(departmanid);


--
-- Name: randevu randevu_doktor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_doktor_id_fkey FOREIGN KEY (doktor_id) REFERENCES public.doktor(doktorid);


--
-- Name: randevu randevu_hasta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_hasta_id_fkey FOREIGN KEY (hasta_id) REFERENCES public.hasta(hastaid);


--
-- Name: recete recete_doktorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_doktorid_fkey FOREIGN KEY (doktorid) REFERENCES public.doktor(doktorid);


--
-- Name: recete recete_hastaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.hasta(hastaid);


--
-- Name: recete recete_ilacid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_ilacid_fkey FOREIGN KEY (ilacid) REFERENCES public.ilac(ilacid);


--
-- Name: unvanlar unvanlar_doktorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unvanlar
    ADD CONSTRAINT unvanlar_doktorid_fkey FOREIGN KEY (doktorid) REFERENCES public.doktor(doktorid);


--
-- Name: yonetici yonetici_yoneticiid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_yoneticiid_fkey FOREIGN KEY (yoneticiid) REFERENCES public.kullanici(kullaniciid);


--
-- PostgreSQL database dump complete
--

